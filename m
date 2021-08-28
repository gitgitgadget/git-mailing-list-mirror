Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4045BC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2531960E77
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 19:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhH1T5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 15:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1T53 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 15:57:29 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A91C061756
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 12:56:38 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id m19so7344549vsj.10
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h8SNZbIKvEeYGNR5ZgyL3AhXV236xhIgZ+TqVHi5K7I=;
        b=jl880Iv0n9vtZJRfy01DnoKepbu42N5NGtucvr9IKCGAUbbVDeLsI/JnWPc00T3p6F
         1P+y7kkFVhkZNmZrKiA+8Vm+QuCCLgsUtYH5tvbGokzJQvFwsH5UYqkgKznWavrV39Yt
         QlFRMG8AR+mjChfWRDwGH9gZOK+1kW4T7p5kXEn/SWeUM6M72jS+OrZ8JCnbHwA6Xs+5
         0Kwf2qRgNH91zjnssMhsl+KYU7s/J55+h33jjQf8xffw+vJ/NDBUH6LNB/F4TqePql+z
         aspKUraMHMPxD3iP0kRdisB21OFDJK3swv5nwIjdPqKLfODMugQtPR95zuyK7U+FYxko
         nusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h8SNZbIKvEeYGNR5ZgyL3AhXV236xhIgZ+TqVHi5K7I=;
        b=T0qUNTKJ85fMMmpn2cS9xEtcPOOeUgpaOHpQzIV7XIPZvQ8ZrNz0QSJemakORy2hQo
         L2kaJ9A78qZHBBGgKeaf7bRudvjm1msZZrwSvzfL62eSIi/ulosRoU3SffQVuOjnTTH4
         jLl4J9HLiga1n1zPQQBlZaWWB4olMQrfleEBk07t1QxEkPxF9iEO4I0xU3Cldt6DhtIP
         sCgyqOo0QDemGgdq6DjWnosxIpwgGJROz6ztfBxpTE14pp0rcI5+EjGbMQNP5pNiO1+f
         64hjVHXEmMK7d/NDb5gPZS9WBuHrDjbQOM0z3l6x1lNElSinnfdc90qFXeJxEr51RVL2
         ZJEQ==
X-Gm-Message-State: AOAM5314DaTqRzOBETLAf84qVMNlXOM6Zy9EY6smPKZ+6XSnG0UqSL3c
        j+xFIaXG7r9r8IbBo0GZjcCrbK5+CJzyMrgAsOk4CvM1TXQ=
X-Google-Smtp-Source: ABdhPJyrur5c2qeZrX/qb1eh6b+3xkhunkyqD2JJMkQUQqoPLzU7kJdGDC76Wzz5lh1oB8dJIfnoUAD11/Q7cZWXepw=
X-Received: by 2002:a05:6102:10c7:: with SMTP id t7mr11095040vsr.44.1630180597645;
 Sat, 28 Aug 2021 12:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210828121329.1971762-1-szeder.dev@gmail.com>
In-Reply-To: <20210828121329.1971762-1-szeder.dev@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 28 Aug 2021 12:56:24 -0700
Message-ID: <CAPUEspg43gxRiVydtaYdM06ObQGYUVn6oThjg1VTR+EfsxRVjA@mail.gmail.com>
Subject: Re: [PATCH] test-lib: set GIT_CEILING_DIRECTORIES to protect the
 surrounding repository
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 28, 2021 at 5:15 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index abcfbed6d6..a1e0182c2f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1343,7 +1343,8 @@ fi
>  GIT_TEMPLATE_DIR=3D"$GIT_BUILD_DIR"/templates/blt
>  GIT_CONFIG_NOSYSTEM=3D1
>  GIT_ATTR_NOSYSTEM=3D1
> -export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_=
NOSYSTEM
> +GIT_CEILING_DIRECTORIES=3D"$GIT_BUILD_DIR"

this wouldn't work as expected with --root and would be IMHO safer
anyway if using instead

  GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY/.."

Carlo
