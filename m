From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 14:39:51 -0700
Message-ID: <7vhck7gdzs.fsf@gitster.siamese.dyndns.org>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
	<20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0710312111170.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:40:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InLIS-0001L3-Uy
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbXJaVkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755386AbXJaVkG
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:40:06 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:55299 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233AbXJaVkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:40:05 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 77108310;
	Wed, 31 Oct 2007 17:40:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EEF4B90A4F;
	Wed, 31 Oct 2007 17:40:22 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710312111170.4362@racer.site> (Johannes
	Schindelin's message of "Wed, 31 Oct 2007 21:12:06 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62883>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 31 Oct 2007, Sergei Organov wrote:
>
>> Yes, and that's the problem. Why 'git --continue' didn't just skip this 
>> patch that *already became no-op* after conflict resolution and forced 
>> me to explicitly use 'git --skip' instead?
>
> Isn't that obvious?  To prevent you from accidentally losing a commit.

In case it is not obvious...

A rebase conflict resolution that results in emptiness is a
rather rare event (especially because rebase drops upfront the
identical changes from the set of commits to be replayed), but
it does happen.  One could argue that "rebase --continue" can
notice that the resolved index is identical to the tree of the
HEAD commit and skip it automatically.

Given an index that is identical to HEAD, however, it is not
easy to safely determine if that is because the patch did not
apply at all, or the patch was applied with conflicts _and_ the
user decided to make the patch a no-op by resolving.  The
automatic droppage of the commit needs to happen only on the
latter and never on the former.
