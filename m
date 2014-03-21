From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 11/12] t0001: drop useless subshells
Date: Fri, 21 Mar 2014 16:27:55 -0400
Message-ID: <CAPig+cQs7N3yfTdQWaYudfTeYEJYB9rCY==68c1rdRTE9qokcA@mail.gmail.com>
References: <20140320231159.GA7774@sigill.intra.peff.net>
	<20140320232125.GK8479@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	David Tran <unsignedzero@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 21:28:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR62r-0007NX-GJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 21:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbaCUU15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 16:27:57 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:55532 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaCUU14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 16:27:56 -0400
Received: by mail-yk0-f172.google.com with SMTP id 200so7589552ykr.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EZ5YeqNxbkIVlDeAKmzNsxJfeaZY6MHFz457A3EUeIo=;
        b=MXjJiEbUzlBUYaO+Ofc9iJa/v18O0joJ5HCkxGRAUdQ6PrWGeJO8cs7EMIkLTi8V0I
         f8L9Ktp59u9Xg2a0CBlMqoXY36PcoOSU8MQK7BYiaI4OhIUK3V6/jT1Fi5tAl0CegXI9
         Ue9fRlGWWtB4cA6BKRxc1HCbP++/PJesstMLOUtf+xp2Qd1/NIDFaSS7q4La80+x+8j0
         H1SkHI2pb3y7mVaOCSL8mS5gVI5eK1qnJ1ggjI3toQ/hZ6XA2bL/FyT1mgoQWOjvelBZ
         il74UDiOwUdKofBdoEreio0QL+2dF7V9z9bQYohXJazaEybOjOCYWSXWMmNYHqFCRlnt
         Rn8g==
X-Received: by 10.236.138.73 with SMTP id z49mr3665576yhi.152.1395433676009;
 Fri, 21 Mar 2014 13:27:56 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Fri, 21 Mar 2014 13:27:55 -0700 (PDT)
In-Reply-To: <20140320232125.GK8479@sigill.intra.peff.net>
X-Google-Sender-Auth: Wu30NvGBOQ8lLmvHi94li4QvuU8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244734>

On Thu, Mar 20, 2014 at 7:21 PM, Jeff King <peff@peff.net> wrote:
> Many tests use subshells, but don't actually change the
> shell environment. They were probably cargo-culted from
> earlier tests which did need subshells. Drop the useless
> ones.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> These ones should produce no behavior change at all; they're purely
> mechanical "(foo && bar)" to "foo && bar" (though of course I did them
> by hand, because you need to know that "foo" and "bar" do not affect the
> environment).
>
>  t/t0001-init.sh | 61 +++++++++++++++++++++------------------------------------
>  1 file changed, 22 insertions(+), 39 deletions(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 4560bba..55a68bc 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -297,30 +286,24 @@ test_expect_success POSIXPERM 'init creates a new deep directory (umask vs. shar
>
>  test_expect_success 'init notices EEXIST (2)' '
>         rm -fr newdir &&
> -       (
> -               mkdir newdir &&
> -               >newdir/a
> -               test_must_fail git init newdir/a/b &&
> -               test_path_is_file newdir/a
> -       )
> +       mkdir newdir &&
> +       >newdir/a

Broken &&-chain (though, not introduced by this patch).

> +       test_must_fail git init newdir/a/b &&
> +       test_path_is_file newdir/a
>  '
>
>  test_expect_success POSIXPERM,SANITY 'init notices EPERM' '
>         rm -fr newdir &&
> -       (
> -               mkdir newdir &&
> -               chmod -w newdir &&
> -               test_must_fail git init newdir/a/b
> -       )
> +       mkdir newdir &&
> +       chmod -w newdir &&
> +       test_must_fail git init newdir/a/b
>  '
>
>  test_expect_success 'init creates a new bare directory with global --bare' '
> --
> 1.9.0.560.g01ceb46
