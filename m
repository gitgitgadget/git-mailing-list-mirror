From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 3/3] diffstat generation in hooks--update was passing 
 "^baserev" to git-diff-tree
Date: Tue, 13 Feb 2007 16:37:59 +0100
Organization: eudaptics software gmbh
Message-ID: <45D1DB57.65433549@eudaptics.com>
References: <200702131424.21665.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 16:36:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGzhu-0000oz-3g
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 16:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbXBMPga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 10:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbXBMPga
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 10:36:30 -0500
Received: from main.gmane.org ([80.91.229.2]:53634 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbXBMPg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 10:36:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HGzhf-0005U2-AF
	for git@vger.kernel.org; Tue, 13 Feb 2007 16:36:23 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 16:36:23 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 16:36:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39535>

Andy Parkins wrote:
> -                       echo "Diffstat:"
> -                       git-diff-tree --no-color --stat -M -C --find-copies-harder $newrev ^$baserev
> +                       echo "Diffstat against $baserev:"
> +                       git-diff-tree --no-color --stat -M -C --find-copies-harder $newrev $baserev

Shouldn't that be "... $baserev $newrev"? But read on.

I cannot entirely follow the reasoning of the comment above this part,
which says:

# Now the problem is for cases like this:
#   * --- * --- * --- * (oldrev)
#          \
#           * --- * --- * (newrev)
# i.e. there is no guarantee that newrev is a strict subset
# of oldrev - (would have required a force, but that's allowed).
# So, we can't simply say rev-list $oldrev..$newrev.  Instead
# we find the common base of the two revs and list from there

git rev-list $oldrev..$newrev

is exactly what you want in this case. The stunt with $baserev is not
necessary, and it may even be wrong if there is more than one
merge-base. $oldrev..$newrev will be correct even in this case.

You still need to derive a merge-base, but only to detect the forced
update and to format the message. Then you should use --not $baserev
instead of ^$baserev just in case there is more than one merge-base.

-- Hannes
