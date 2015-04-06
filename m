From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 11/25] list-files: add --color
Date: Mon, 6 Apr 2015 17:33:36 -0400
Message-ID: <CAPig+cRwHu+OznoCNcXLM-+YZmiYNtXKs2PF6Lm+So1TdkoJ4g@mail.gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
	<1428328354-14897-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:33:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfEeM-00056R-83
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 23:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbbDFVdi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 17:33:38 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:35104 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbDFVdh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 17:33:37 -0400
Received: by labbd9 with SMTP id bd9so17259620lab.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 14:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=qngzGWYOe2ZpvCnYFkIfnWU2mtP1Nck5Eu87h6i3CNk=;
        b=dtBPjC/WAcheID6wnzl5s/XeRE6ssm15f1tiZnvkYdi6ruD85///J6tfUTj7VAxAcd
         l+PzR/x+Z47/s6TRPYIipeE7DPRVoW9mIIp/AqGpPFl+QL1jefOg+RHuCcFdlKvXiny2
         YxJB5sLA8/xzQ8MMhywIGoHWBDn3q+ui6HlQtmLfqUPq1ZUaSTeuEEWJoO9EsTamig49
         MVMOG42WDcoDbzufDYGD4TzHdHJQtghLymCVM3kx2ZmpXwsoeSxKT8Q0BJz8ncEhY01P
         kHE/xio872+5F2404pnIleDQsb/9XjXAXv3HjP06pJ6KQDvnPEel1qcd8cxZP/34r3Jv
         oinw==
X-Received: by 10.152.26.169 with SMTP id m9mr15263177lag.45.1428356016275;
 Mon, 06 Apr 2015 14:33:36 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 14:33:36 -0700 (PDT)
In-Reply-To: <1428328354-14897-12-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: oONr035Io4qQH9lHFrt6DAnrtKE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266882>

On Mon, Apr 6, 2015 at 9:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
> index a4916d8..cdbc34a 100755
> --- a/t/t7013-list-files.sh
> +++ b/t/t7013-list-files.sh
> @@ -110,4 +110,48 @@ test_expect_success 'list-files from subdir (2)'=
 '
>         )
>  '
>
> +test_expect_success 'setup 2' '
> +       git init 2 &&
> +       (
> +       cd 2 &&
> +       mkdir dir &&
> +       touch file dir/file &&
> +       git init gitlink &&
> +       ( cd gitlink && test_commit foo ) &&
> +       git add file dir/file gitlink &&
> +       git commit -qm1

Minor: Why -q?

> +       )
> +'
> +
> +test_expect_success 'LS_COLORS env variable' '
> +       (
> +       cd 2 &&
> +       LS_COLORS=3D"rs=3D0:fi=3D31:di=3D32" &&
> +       export LS_COLORS &&
> +       git list-files --color=3Dalways | test_decode_color | \
> +               grep -v gitlink >actual &&
> +       cat >expected <<-\EOF &&
> +       <GREEN>dir<RESET>
> +       <RED>file<RESET>
> +       EOF
> +       test_cmp expected actual
> +       )
> +'
> +
> +test_expect_success 'color.ls.*' '
> +       (
> +       cd 2 &&
> +       test_config color.ls.file red &&
> +       test_config color.ls.directory green &&
> +       test_config color.ls.submodule yellow &&
> +       git list-files --color=3Dalways | test_decode_color >actual &=
&
> +       cat >expected <<-\EOF &&
> +       <GREEN>dir<RESET>
> +       <RED>file<RESET>
> +       <YELLOW>gitlink<RESET>
> +       EOF
> +       test_cmp expected actual
> +       )
> +'
> +
>  test_done
> --
> 2.3.0.rc1.137.g477eb31
