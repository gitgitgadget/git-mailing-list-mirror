From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 03/15] t5520: style fixes
Date: Fri, 1 May 2015 16:35:54 +0800
Message-ID: <CACRoPnR+OHp1ho-az=C8tE=bczX5h1yEvSozGXVTShB09q1-dg@mail.gmail.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
	<1430342973-30344-1-git-send-email-gitster@pobox.com>
	<1430342973-30344-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 10:36:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yo6QW-0005yR-3n
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 10:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbbEAIf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 04:35:59 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:33814 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbbEAIf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 04:35:56 -0400
Received: by laat2 with SMTP id t2so60856300laa.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nTwI8BuWIbuQrJgAjmpeHHMaiyYv5aNaQ7s+736R6DE=;
        b=x2roEqdzSpeamUC2JqlCdmQFFEsG/kzH6LBf4b/tpexM51qtJp6mb+6T0CCck2uBLz
         m2jpr1lq5C1Havw8ERjEKDdhZ+XMvTcdnkOnEUkhgGSlnpxZQm8uO83FssBDMWWVuqyY
         +H5S5WPrjml0vYTuD1rp24z66ha6yIea0TyQ1ME33IC4l45jp4gzsMMs4W24mP3UItJf
         KHS7a174zRq8kpNBE3VeBPo+zd2XkOy8CMZ1p27apyOPCDhdzFJHt+BqFlM0els8aVdo
         eCYZEvYlR4oebQ5sku1GrhPQaQVQ2v7B8cqtivqKYhfQsG7hum+/gKGC08ppftd13QND
         Qm6g==
X-Received: by 10.152.4.72 with SMTP id i8mr7630441lai.32.1430469354405; Fri,
 01 May 2015 01:35:54 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 1 May 2015 01:35:54 -0700 (PDT)
In-Reply-To: <1430342973-30344-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268111>

Hi Junio,

On Thu, Apr 30, 2015 at 5:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Fix style funnies in early part of this test script that checks "git
> pull" into an unborn branch.  The primary change is that 'chdir' to
> a newly created empty test repository is now protected by being done
> in a subshell to make it more robust without having to chdir back to
> the original place.
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 227d293..5195a21 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
>  test_expect_success 'pulling into void' '
> -       mkdir cloned &&
> -       cd cloned &&
> -       git init &&
> -       git pull ..
> -'
> -
> -cd "$D"
> -
> -test_expect_success 'checking the results' '
> +       git init cloned &&
> +       (
> +               cd cloned &&
> +               git pull ..
> +       ) &&
>         test -f file &&
>         test -f cloned/file &&
>         test_cmp file cloned/file
>  '
>
>  test_expect_success 'pulling into void using master:master' '
> -       mkdir cloned-uho &&
> +       git init cloned-uho &&
>         (
>                 cd cloned-uho &&
> -               git init &&
>                 git pull .. master:master
>         ) &&
>         test -f file &&
> @@ -71,7 +62,6 @@ test_expect_success 'pulling into void does not overwrite staged files' '
>         )

I'm currently studying the t5520 tests in order to improve test
coverage of git-pull.sh, and I find it hard to understand whenever
tests depend on the tests before them in subtle ways.

Just wondering, would it be good to clean up the created repos in the
above tests to make it clear that they won't be used anymore?
Something like:

    git init cloned &&
    test_when_finished "rm -rf cloned" &&
    ...

Thanks,
Paul
