From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] am: teach mercurial patch parser how to read from stdin
Date: Mon, 8 Jun 2015 10:13:33 -0700
Message-ID: <CAGZ79kY15b19w5qK7=zXYOEqNBo8iBMwNprEM8kK4DpQ8u6J=g@mail.gmail.com>
References: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
	<1433778531-18260-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Chris Packham <judge.packham@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:13:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20cG-0003bf-8W
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbbFHRNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:13:36 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:33030 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbbFHRNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:13:34 -0400
Received: by yhpn97 with SMTP id n97so42781890yhp.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aDS6eQSFz/C+pWNp/3qmEa5+9pPhTtbF2BB/NwPgAcA=;
        b=F2sLH3X+lzK0aDzVqLktc62aYcDnMcilXjxyM+fsKVeJkPpLaQ+CYVrteaQBarmcdT
         toULSm7iqeOOSQDFQEyqc3DhR9T4UHk/NUaIjy3R95G/oFVsvJ6nh7X/8h7lfHTNZqFY
         yej2/3b8yxXvo8b2/H7wLzoSPIj7CQ8gfqdaZeq1BfRcM0p9E3PPcg9apY+GnLhUj599
         xaNe82SVoNrIwRTGJn8TlJdPaEFijl1bH4hRdqWHn8O+vcW2JP3W5X5sinc+fAaiP5rX
         EzzFr5Md6wG1aOK1kA/RM4Utog4dtfWCXdq6rAfD5WC6w8fJrLnyM3QRnb7bY2V04HJc
         EBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aDS6eQSFz/C+pWNp/3qmEa5+9pPhTtbF2BB/NwPgAcA=;
        b=PhQRQlucWnAv2jAew2tXx5Xwi67XmqYDUDIGzkVtUtVtNP5/zMuwiW1QSAmfvN2nh7
         qtZh326dwTDBGBzlDgELaYCDHyewPUsgRradKU0LJVS+BMidj111EaB/cxnVzc6bEwBC
         JK7F3IGWI93N7Q6lHb6OzEKUhF1IQ12tlxLwoMsSy94IfcqHoEjA16oy1hL7gCjIQlfe
         le0jJKyyRJ6ktLmIZSLVkXUhFAgKnS0uIVU6EO5FE87YcVIikSgsnZOr+tHLcCWWTLuI
         DjSiEAsz1zlrnK1SdVc9hwarlY77KOLNMdUsne4o3/kdEZRqJlI6/8ENPryr1L93/hdF
         6HIw==
X-Gm-Message-State: ALoCoQl8ee2cwoq0Cv4XsXGGIDy6JCaBPC7OQzVi81+5SBRmq6cBDyqtFc0GmsXbmbEZvW8En5eV
X-Received: by 10.170.43.16 with SMTP id 16mr19789761ykl.119.1433783613396;
 Mon, 08 Jun 2015 10:13:33 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Mon, 8 Jun 2015 10:13:33 -0700 (PDT)
In-Reply-To: <1433778531-18260-6-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271086>

On Mon, Jun 8, 2015 at 8:48 AM, Paul Tan <pyokagan@gmail.com> wrote:
> git-mailsplit, which splits mbox patches, will read the patch from stdin
> when the filename is "-" or there are no files listed on the
> command-line.
>
> To be consistent with this behavior, teach the mercurial patch parser to
> read from stdin if the filename is "-" or no files are listed on the
> command-line.
>
> Based-on-patch-by: Chris Packham <judge.packham@gmail.com>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>

The whole series looks good to me.
Thanks,
Stefan

> ---
>  git-am.sh     |  4 +++-
>  t/t4150-am.sh | 10 ++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index d97da85..0a40d46 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -327,6 +327,7 @@ split_patches () {
>                 ;;
>         hg)
>                 this=0
> +               test 0 -eq "$#" && set -- -
>                 for hg in "$@"
>                 do
>                         this=$(( $this + 1 ))
> @@ -338,6 +339,7 @@ split_patches () {
>                         # Since we cannot guarantee that the commit message is in
>                         # git-friendly format, we put no Subject: line and just consume
>                         # all of the message as the body
> +                       cat "$hg" |
>                         LANG=C LC_ALL=C @@PERL@@ -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
>                                 if ($subject) { print ; }
>                                 elsif (/^\# User /) { s/\# User/From:/ ; print ; }
> @@ -353,7 +355,7 @@ split_patches () {
>                                         print "\n", $_ ;
>                                         $subject = 1;
>                                 }
> -                       ' <"$hg" >"$dotest/$msgnum" || clean_abort
> +                       ' >"$dotest/$msgnum" || clean_abort
>                 done
>                 echo "$this" >"$dotest/last"
>                 this=
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 4beb4b3..3ebafd9 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -259,6 +259,16 @@ test_expect_success 'am applies hg patch' '
>         test_cmp_rev second^ HEAD^
>  '
>
> +test_expect_success 'am --patch-format=hg applies hg patch' '
> +       rm -fr .git/rebase-apply &&
> +       git checkout -f first &&
> +       git am --patch-format=hg <patch1-hg.eml &&
> +       test_path_is_missing .git/rebase-apply &&
> +       git diff --exit-code second &&
> +       test_cmp_rev second HEAD &&
> +       test_cmp_rev second^ HEAD^
> +'
> +
>  test_expect_success 'setup: new author and committer' '
>         GIT_AUTHOR_NAME="Another Thor" &&
>         GIT_AUTHOR_EMAIL="a.thor@example.com" &&
> --
> 2.1.4
>
