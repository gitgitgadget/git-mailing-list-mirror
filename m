From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH] Add new testcases for format-patch root commits
Date: Sat, 10 Jan 2009 21:33:39 +0300
Message-ID: <20090110183339.GA30548@myhost>
References: <20090110113903.GB25723@myhost> <1231605577-26148-1-git-send-email-aspotashev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 19:35:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLifn-0004ky-Au
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 19:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbZAJSdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 13:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbZAJSdi
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 13:33:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:25267 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbZAJSdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 13:33:38 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3657024fgg.17
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 10:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=kHssdT4gg7O2wXsUmiUHlrGjpVuP73AW35pBhic20E0=;
        b=pUglM8McxOswmibp4YbJnx6Ti0VHisndKrUYT6Ml8AvGvjSmuKp5ZDHYF6R44fgcrv
         JSSnXEMeJPSocnB6jxNZxsT6jjTAAHfDXZy5XjtBYiymIscdHqG/Gwqc3Yic4lMhtqhy
         VsJZ8rJpm6DgdUEj8BOQmERi5m+PsR8CQ/Ajw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fNIGcn5TASrwn0LQ8LFjssWBKjF7gjai3BDoI+qJb+mR7fvX3KYCDvfGJPZ+JNFjEz
         YtiqTCSk94l88DGJszs8iTxlOm5okYJNSTlXrONAqypJiLmHeHS+/rjcA3R8CXtC2y+0
         D3/5HRr2dJhSYDOiWFL+yYj3H9QGj0fi4kr4U=
Received: by 10.86.31.18 with SMTP id e18mr15640237fge.72.1231612416106;
        Sat, 10 Jan 2009 10:33:36 -0800 (PST)
Received: from smtp.gmail.com (ppp83-237-189-185.pppoe.mtu-net.ru [83.237.189.185])
        by mx.google.com with ESMTPS id 3sm4787840fge.37.2009.01.10.10.33.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 10:33:35 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Sat, 10 Jan 2009 21:33:39 +0300
Content-Disposition: inline
In-Reply-To: <1231605577-26148-1-git-send-email-aspotashev@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105137>

On 19:39 Sat 10 Jan     , Alexander Potashev wrote:
> 1. format-patch'ing root commit shouldn't create empty patches
> 2. With --root it should create a patch for the root commit
> 3. Similar testcases with two commits in the tree
> 
> Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
> ---
> 
> git format-patch lacks a '--no-root' option, so I used
> 'git config log.showroot false' to emulate it.

Sorry, --root option has nothing in common with log.showroot, but the
testcases are still valid.

> 
> 
> 
>  t/t4033-format-patch-root-commit.sh |   52 +++++++++++++++++++++++++++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)
>  create mode 100755 t/t4033-format-patch-root-commit.sh
> 
> diff --git a/t/t4033-format-patch-root-commit.sh b/t/t4033-format-patch-root-commit.sh
> new file mode 100755
> index 0000000..846c11c
> --- /dev/null
> +++ b/t/t4033-format-patch-root-commit.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +test_description='Format-patch root commit skipping/allowing'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	git config log.showroot false
> +	git config format.numbered false
> +	echo A > file &&
> +	git add file &&
> +	git commit -m First
> +'
> +
> +test_patch_count() {
> +	cnt=$(grep "^Subject: \[PATCH\]" $1 | wc -l) &&
> +	test $cnt = $2
> +}
> +
> +test_patch_is_single() {
> +	cnt=$(grep "^Subject: \[PATCH\] $2" $1 | wc -l) &&
> +	test $cnt = 1
> +}
> +
> +test_expect_success 'format-patch root commit with showroot = false' '
> +	git format-patch -1 &&
> +	test_must_fail cat 0001-First.patch
> +'
> +
> +test_expect_success 'format-patch root commit' '
> +	git format-patch --root --stdout -5 >root-only.patch &&
> +	test_patch_count root-only.patch 1 &&
> +	test_patch_is_single root-only.patch First
> +'
> +
> +test_expect_success 'format-patch 2 commits without root' '
> +	echo B > file &&
> +	git commit -a -m Second &&
> +
> +	git format-patch --stdout -2 >two-except-root.patch &&
> +	test_patch_count two-except-root.patch 1 &&
> +	test_patch_is_single two-except-root.patch Second
> +'
> +
> +test_expect_success 'format-patch 2 commits including root' '
> +	git format-patch --root --stdout -2 >two-with-root.patch &&
> +	test_patch_count two-with-root.patch 2 &&
> +	test_patch_is_single two-with-root.patch First &&
> +	test_patch_is_single two-with-root.patch Second
> +'
> +
> +test_done
> -- 
> 1.6.1.81.g61cf1
> 
