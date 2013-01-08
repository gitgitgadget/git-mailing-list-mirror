From: =?UTF-8?B?6YOR5paH6L6JKFRlY2hsaXZlIFpoZW5nKQ==?= 
	<techlivezheng@gmail.com>
Subject: Re: [PATCH 2/7] contrib/subtree: Use %B for Split Subject/Body
Date: Wed, 9 Jan 2013 07:21:27 +0800
Message-ID: <CAPYzjrQ1ngfOwBuzq+Da1Ynd18Vwt8=LCyu2yhE6dX8vivwReg@mail.gmail.com>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org> <1357646997-28675-3-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 00:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsiV4-0007sI-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 00:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab3AHXWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 18:22:09 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:56946 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab3AHXWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 18:22:08 -0500
Received: by mail-vc0-f178.google.com with SMTP id l6so1008591vcl.9
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 15:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w8hWPiMDbe8/7XZD3iLeNjTdJbwA0GyruSKVvWnT/oM=;
        b=yHH1SH8WAJf0YDuEHUPh7FUm7TKpdnXfWCkgpagXfoiImJ7bTNW8r1K01VdZAjWXgq
         SmKgA1Nsgyp0hjYwTndO+iyzjAg2pJiQ/ZZUwvkRXHn4Hyzzrt3rE+oejp4hadsy3mue
         6VWeAwIMUDyT3bvaX4OqM++j9x3SXuTzxpK46eL85ZrIeaz5lapOAg/u/RZjiHmNJRDT
         Lm8ZADWhkXTrU15XHTSfQf99G+qnUtJP7N7rskEBnwoCjNSTqH4vhZqNEjgEG1rbx5io
         00GV6xXTjCw2iPlXIYShX9Jv42ASsjsNWmRnlu/J0K2f4bHuU/ouMxsjj2t5d6vi9aBb
         ErAg==
Received: by 10.220.115.20 with SMTP id g20mr88237737vcq.31.1357687327717;
 Tue, 08 Jan 2013 15:22:07 -0800 (PST)
Received: by 10.58.106.48 with HTTP; Tue, 8 Jan 2013 15:21:27 -0800 (PST)
In-Reply-To: <1357646997-28675-3-git-send-email-greened@obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213013>

2013/1/8 David A. Greene <greened@obbligato.org>:
> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Use %B to format the commit message and body to avoid an extra newline
> if a commit only has a subject line.
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/git-subtree.sh     |    6 +++++-
>  contrib/subtree/t/t7900-subtree.sh |   15 +++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 920c664..5341b36 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -296,7 +296,11 @@ copy_commit()
>         # We're going to set some environment vars here, so
>         # do it in a subshell to get rid of them safely later
>         debug copy_commit "{$1}" "{$2}" "{$3}"
> -       git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
> +       # Use %B rather than %s%n%n%b to handle the special case of a
> +       # commit that only has a subject line.  We don't want to
> +       # introduce a newline after the subject, causing generation of
> +       # a new hash.
> +       git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |
>         (
>                 read GIT_AUTHOR_NAME
>                 read GIT_AUTHOR_EMAIL
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 6cf9fb9..3f17f55 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -74,6 +74,10 @@ test_expect_success 'add sub1' '
>          git branch -m master subproj
>  '
>
> +# Save this hash for testing later.
> +
> +subdir_hash=`git rev-parse HEAD`
> +
>  test_expect_success 'add sub2' '
>          create sub2 &&
>          git commit -m "sub2" &&
> @@ -211,6 +215,17 @@ test_expect_success 'check split with --branch' '
>          check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
>  '
>
> +test_expect_success 'check hash of split' '
> +        spl1=$(git subtree split --prefix subdir) &&
> +        undo &&
> +        git subtree split --prefix subdir --branch splitbr1test &&
> +        check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1"
> +        git checkout splitbr1test &&
> +        new_hash=$(git rev-parse HEAD~2) &&
> +        git checkout mainline &&
> +        check_equal ''"$new_hash"'' "$subdir_hash"
> +'
> +
This test is not test the correct thing, I am currently working on it.
>  test_expect_success 'check split with --branch for an existing branch' '
>          spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
>          undo &&
> --
> 1.7.10.4
>
