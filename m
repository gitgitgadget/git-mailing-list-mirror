From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v2] Make "git-remote rm" delete refs acccording to
 fetch specs
Date: Sat, 31 May 2008 22:29:29 -0700
Message-ID: <7vprr1d8p2.fsf@gitster.siamese.dyndns.org>
References: <20080601042804.GA32293@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 01 07:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2g9w-0002Jc-Vx
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 07:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbYFAF3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 01:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbYFAF3s
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 01:29:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYFAF3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 01:29:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DAF3E38A5;
	Sun,  1 Jun 2008 01:29:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3386738A3; Sun,  1 Jun 2008 01:29:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD08002C-2F9B-11DD-B34D-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83433>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  This is a longer, but better version of this patch.  Instead of
>  blindly deleting the refs we remove them only if this is the last
>  remote that would write to the local tracking ref.

If this is a better version than the previous one, then probably "git
remote prune" patch to unconditionally remove ones that do not exist in
one of the remotes that fetch into the tracking namespace also needs to be
rethought, doesn't it?  Another remote may still have it but you obviously
do not know that until you check.

Admittedly, next fetch from the other remote may or may not resurrect them
and either way it is not a big deal.

I think this is exactly the same issue as this improvement in [3/3] deals
with.  If "git remote rm" of one remote removed the shared tracked refs,
next fetch from the other remote would resurrect them if the other remote
still exists.  It may probably feel better to be extra careful like this
improved patch, but I doubt it would matter in practice.  After all,
people who creates such a configuration would know what they are doing.
