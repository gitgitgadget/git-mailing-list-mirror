From: Junio C Hamano <gitster@pobox.com>
Subject: Re: grafts not appearing in manual pages
Date: Thu, 27 Sep 2007 00:25:39 -0700
Message-ID: <7vmyv8wowc.fsf@gitster.siamese.dyndns.org>
References: <20070926202441.GA31848@glandium.org>
	<20070926210102.GF26099@fieldses.org> <46FB4C23.8010400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 09:26:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iankx-0004Pn-Fx
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 09:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXI0HZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 03:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbXI0HZs
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 03:25:48 -0400
Received: from rune.pobox.com ([208.210.124.79]:34323 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbXI0HZr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 03:25:47 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id D816813CD56;
	Thu, 27 Sep 2007 03:26:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BE4013CD4F;
	Thu, 27 Sep 2007 03:26:02 -0400 (EDT)
In-Reply-To: <46FB4C23.8010400@viscovery.net> (Johannes Sixt's message of
	"Thu, 27 Sep 2007 08:22:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59274>

Johannes Sixt <j.sixt@viscovery.net> writes:

> J. Bruce Fields schrieb:
> ...
>> It could go in Documentation/user-manual.txt, but I don't know where.
>
> IMHO grafts should not be made known to a wide audience until
> send-pack, pack-objects, and prune are fixed so that you cannot
> corrupt your repository when there are grafts.

I mildly have to disagree.

Documenting the current semantics (in short, "grafts are
strictly local matter") and the implications is important.

Here are some of the points you would want to mention:

 - if you graft, prune and fsck will honor that fake ancestry,

 - if you _add_ parent by grafting you will not lose the history
   that is otherwise disconnected, but on the other hand, once
   having pruned that way and you remove that graft, prune will
   discard that discontiguous history away.

 - if you _hide_ parent by grafting, you will be able to lose
   the hidden subbranch away, but you will get complaints from
   fsck if you remove that graft after pruning your history.

 - if you try to fetch/push across repositories with different
   notion of ancestry (because of different grafts), things can
   break in expected ways (and you can keep both halves ;-).
   For example, if the sending side has extra parents to a
   commit compared to the receiving side, and if the receiving
   side claims to have that commit, objects reachable from the
   extra parents might be missing from the reciving end but the
   sender will not be able to notice.

> See http://thread.gmane.org/gmane.comp.version-control.git/37744
> in particular http://article.gmane.org/gmane.comp.version-control.git/37866
> on a sketch how to fix the issues.

IIRC, there discussions were more about what the issues are and
what the potential semantics could be.  First the desired
semantics need to be defined.
