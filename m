From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Digging through old vendor code
Date: Mon, 14 Jan 2008 09:49:30 -0500
Message-ID: <9e4733910801140649u5c2b74cbkcf0d790d0e7bc0a2@mail.gmail.com>
References: <20080113162806.13991.qmail@science.horizon.com>
	 <20080114120807.GB12723@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 15:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEQdZ-0001xa-Sg
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 15:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbYANOtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 09:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbYANOtg
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 09:49:36 -0500
Received: from qb-out-0506.google.com ([72.14.204.224]:26554 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbYANOte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 09:49:34 -0500
Received: by qb-out-0506.google.com with SMTP id e11so270178qbe.15
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 06:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wuAIOJhRz0BjnH96J8O/Ql7cRVcKebWG7qeKIpAHuRs=;
        b=p8EmXxAZc8ouh685Xcv8I48alRdV0PWaAOiIhjsl/RN885qr3jB/Vljgtm38/P7R+TmzACmFklnHdkGxsFBTuAXJ3rUtCvXph0rrkoSJSSA1DzS+MlTD+8XJT53+ooF8Rw2ed2UVp9F+oIMXTPB6UoyJqax2yfMJ4ZpYJlfuM+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M39RDSj6J25OcckSgojV+ES4DIwSGk2bBXnxMyonDMGQQEH8PRJNKrawoOFEWJAyrIp/gW4F1H9sTbTUjdjrBDvVr+VgpHwLJ9glfot+4Km2wVlKM4LkVHolYvlnSHkrr9V4l69ljkKi46rMK+2Kx23mXAGsJM9xNwboiKrS4kQ=
Received: by 10.114.151.13 with SMTP id y13mr2101970wad.60.1200322170951;
        Mon, 14 Jan 2008 06:49:30 -0800 (PST)
Received: by 10.114.200.7 with HTTP; Mon, 14 Jan 2008 06:49:30 -0800 (PST)
In-Reply-To: <20080114120807.GB12723@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70459>

On 1/14/08, Jeff King <peff@peff.net> wrote:
> On Sun, Jan 13, 2008 at 11:28:06AM -0500, linux@horizon.com wrote:
>
> > Maybe a real git wizard will show me how to insert the index entries
> > directly without ever doing anything as pedestrian as extracting, hashing,
> > and then deleting the files, but it's still not that bad.
>
> git-read-tree?  Unfortunately it has no option to insert only a subset
> of the tree. But you can make do with git-ls-tree piped to
> git-update-index.
>
> Using the script below, Jon's sample file seems to be
>
>   v2.6.15-rc6-81-g0b57ee9:drivers/serial/amba-pl010.c
>
> and it runs in about 8 seconds on v2.6.13..v2.6.15. I think it might be
> more intuitive to just diff a temporary index against each tree, but I
> don't think there's a way to say "find copies harder, but use only this
> subset of files as the source" which makes it less efficient.
>
> Jon, you might try playing around with different ranges. I get a
> different answer for v2.6.13..v2.6.16.

That's probably because some of the other drivers in there were also
created via copy and edit. The similarity between drivers is what made
the original base hard to find. amba-pl010.c is probably a copy/edit
from one of the other drivers.

I'm pretty sure 2.6.15/amba-pl010.c is right. I started undoing some
of the obvious changes like renaming the functions and the diffs are
getting pretty small.

Thanks for the help on this. I have enough info now to separate the diffs.

This would probably make a nice command to add to git since I'm sure
other vendors have done copy/edit to make their out of tree drivers. I
doubt if any other SCM has a command like this.

I'm really starting to hate the "port and forget" that goes on in the
embedded world. But I'm beginning to understand why it happens. I've
been working since November to get a patch  into i2c without success -
19 versions. The process is chewing up way too much time relative to
the importance of the patch to my code. So I'm just about ready to
"port and forget" the patch.

>
> -- >8 --
> SRC=drivers/serial
>
> echo >&2 Cleaning up after old runs...
> rm -f tmpindex
> git branch -D tmpbranch
>
> echo >&2 Creating giant source commit...
> for i in `git rev-list v2.6.13..v2.6.15 -- $SRC`; do
>   git ls-tree -r $i -- $SRC |
>     # note the whitespace is a literal tab
>     sed "s,     ,       $i/," |
>     GIT_INDEX_FILE=tmpindex git update-index --index-info
> done
> tree=`GIT_INDEX_FILE=tmpindex git write-tree`
> commit=`echo source | git commit-tree $tree`
> git update-ref refs/heads/tmpbranch $commit
>
> echo >&2 Creating updated index...
> GIT_INDEX_FILE=tmpindex git add candidate.c
> echo >&2 Diffing...
> GIT_INDEX_FILE=tmpindex git diff-index --cached -l0 -M1% -C1% --find-copies-harder tmpbranch
>
> # now you should manually git-describe the winner
>


-- 
Jon Smirl
jonsmirl@gmail.com
