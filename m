From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git svn: make empty directory creation gc-aware
Date: Sat, 19 Dec 2009 23:08:40 -0800
Message-ID: <7vzl5e3yx3.fsf@alter.siamese.dyndns.org>
References: <8BB233FB-4269-4B14-8703-A4FF1E25FB0D@gmail.com>
 <20091217200852.GA5797@dcvr.yhbt.net> <20091219222738.GA20331@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Zeh <robert.a.zeh@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Dec 20 08:09:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMFuj-0005aB-GO
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 08:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbZLTHIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 02:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbZLTHIw
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 02:08:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZLTHIv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 02:08:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CC0589B87;
	Sun, 20 Dec 2009 02:08:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hzG8rB91LBCIj6UMilgHuGQ+Fxc=; b=vIV1/k
	hVJ7F1HW1TK7rb/Csdio7Gq5h939TC+D9U4FhQGe/brYZEfegNTvWFoO9ofytWsz
	s18EkjD9KMATqRkO7RZNHmksPdfQZPtgZaTlSuj1oMcMQkNx/lk1FNzjhpF5OnkU
	/yWjeLC+IiWLVoO0uGVUk6TNabdimQf5GXUio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B4pAQAmK8bOKzIvsGT4vwt/2J6f5j0ca
	LVuaLYrqKHRNQm/+SFZ5E3tHWHhNR5q8YTR7qzYBDdWBV1oeUdOnwIy7UzhzHC81
	dm9BBUi4N6NE5+IeVdbZsNx/TiE+S+6qBkUn7WziPDRNyF+d4OTy/XJ59owk/HCG
	CeDEl/ZDIHI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 164BB89B81;
	Sun, 20 Dec 2009 02:08:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31D3589B80; Sun, 20 Dec
 2009 02:08:42 -0500 (EST)
In-Reply-To: <20091219222738.GA20331@dcvr.yhbt.net> (Eric Wong's message of
 "Sat\, 19 Dec 2009 14\:27\:38 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83A93A80-ED36-11DE-BC3C-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135519>

Eric Wong <normalperson@yhbt.net> writes:

> The "git svn gc" command creates and appends to unhandled.log.gz
> files which should be parsed before the uncompressed
> unhandled.log files.
>
> Reported-by: Robert Zeh
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>   Eric Wong <normalperson@yhbt.net> wrote:
>   > Robert Zeh <robert.a.zeh@gmail.com> wrote:
>   > > It looks like there is a conflict between git svn gc and git svn
>   > > mkdirs.  The git svn mkdirs command only looks at unhandled.log files.
>   > > Shouldn't it also look at any compressed unhandled.log files too?
>   > 
>   > Hi Robert,
>   > 
>   > Yes, an oversight. Does this patch work for you? (Highly untested)
>
>   Test case included and pushed out to git://git.bogomips.org/git-svn
>
>   More pushes hopefully coming as Sam and Andrew work out the mergeinfo
>   performance problems and I look into crossing svn-remote boundaries
>   for parent lookups.

Thanks.

This particular patch should be in 1.6.6 final, because mkdirs first
appeared in 1.6.6-rc0 at 6111b93 (git svn: attempt to create empty dirs on
clone+rebase, 2009-11-15), and 1.6.5.X series does not have the command,
so this seems like a new feature that never existed in any tagged release,
and if we shipped 1.6.6 without this patch, we will be shipping it with a
know breakage, while if we shipped it with this, even if this patch
somehow had an unintended side effect, at worst we'd be exchanging a bug
with some other bug, so it wouldn't be worse.

Is mkdirs the only "noteworthy" feature that should be mentioned in the
Release Notes in your area?  It would be really nice if you can give a
patch to Documentation/RelNotes-1.6.6.txt in a few days to turn a single
liner I have there to something more helpful.  The current shortlog since
1.6.5 indicates there weren't that much activity during this release.



Alex Vandiver (3):
      git-svn: sort svk merge tickets to account for minimal parents
      git-svn: Set svn.authorsfile to an absolute path when cloning
      git-svn: set svn.authorsfile earlier when cloning

Eric Wong (7):
      git svn: fix fetch where glob is on the top-level URL
      git svn: read global+system config for clone+init
      git svn: attempt to create empty dirs on clone+rebase
      git svn: always reuse existing remotes on fetch
      git svn: strip leading path when making empty dirs
      git svn: log removals of empty directories
      git svn: make empty directory creation gc-aware

Greg Price (1):
      git svn: Don't create empty directories whose parents were deleted

Jonathan Nieder (2):
      add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR"
      am -i, git-svn: use "git var GIT_PAGER"

Sam Vilain (2):
      git-svn: convert SVK merge tickets to extra parents
      git-svn: convert SVN 1.5+ / svnmerge.py svn:mergeinfo props to parents

Thomas Rast (1):
      Document git-svn's first-parent rule

Toby Allsopp (1):
      git svn: handle SVN merges from revisions past the tip of the branch
