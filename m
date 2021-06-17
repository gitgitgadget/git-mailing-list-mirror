Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FE2C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 04:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997AF60FDA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 04:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhFQExt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 00:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhFQExs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 00:53:48 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E4C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 21:51:41 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m137so5120799oig.6
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JycNJU2EKEJlR23iUzXSn+OCTxp6PUM/kE/OxN8oBAY=;
        b=TE7IGDUrNMvDsSJ3dy1MmyC/Y9zdEUK3s+almZzEbKN+Yre9XClbdrnNGZLpCAmC4j
         9J8OGmiV43k8xMGjG0QiT3Fiu79P89kMMlJ7rISegCMLfQplzmiKKJRREJHV4GOQmFj8
         FyoihpjcBI2wDEvvwJqFgFBOJNURjRTvsC9oCVP+m65ssljcoUnn4TL3UheGgGSpGI6W
         YKfks7RYD38/p+5B2FMbUMq3byeFQQ4wsLKyheuuONpjS5rFkF1X/1rDRcbFTazf3qF5
         rM7WuLsdhRze+0EWZ0/GgxCfZpcQKobA7tehyci1Gqvq/7JdhSoFHpqf5A1UmumD16dM
         d/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JycNJU2EKEJlR23iUzXSn+OCTxp6PUM/kE/OxN8oBAY=;
        b=gFcX+30MxQvxUIfjr8xE55qbwa2Ak13C0Ov4A0ym2lzRTvST1yTBPcKB/Ct0YCoa7o
         BWV+/L1X2VJSIX20quy6Yg15/kwePp+lGAXeHOAuqO7/hVlOAL7U1ty3uIwEZH9VhppH
         6+F6+hnYs+budQzUBFzJFrFWm/48IOFdJbFU9HcggfgjGu7OBLSHUG3xcPxG8OL4cPNZ
         fcjUa3ZtmTrHT2svJZwVfNtdkVArucmnE0ZO6wdm1khPsvZMR89vEQqL/vq1my0Nj334
         VcjPv6wiGYNSMJ+G0PmzzSqz9zkY33pm+d3jPrI2udkAeZfieromVsO5iYVkNXnGYs2I
         bevA==
X-Gm-Message-State: AOAM532rWmtJe0G470I0n7ajp+YKwHq4bpbezuWwpSjLeesS9O6ssVmw
        gIYmbzGFAy7moT4y/IuCgno=
X-Google-Smtp-Source: ABdhPJwwLbxiA26BK2mYoh+q+HyuZH0/iYNcIuYv4pSEGUN+sYVmuQOOVqVvz8iHQ+T3R0+qx61U5Q==
X-Received: by 2002:aca:b343:: with SMTP id c64mr1952890oif.137.1623905501321;
        Wed, 16 Jun 2021 21:51:41 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t26sm1061118oth.14.2021.06.16.21.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:51:40 -0700 (PDT)
Date:   Wed, 16 Jun 2021 23:51:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60cad4db9200b_10448208fd@natae.notmuch>
In-Reply-To: <20210615172038.28917-2-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
 <20210615172038.28917-2-congdanhqx@gmail.com>
Subject: RE: [PATCH v2 1/5] test-lib-functions: introduce test_line_count_cmd
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> In Git project,

In _the_ Git project

> we have multiple occasions that requires checking number

multiple instances that require checking the number

> of lines of text in stdout and/or stderr of a command. One of such
> example is t6400,

One of such examples

> which checks number of files in various states.

that checks the number of files (see 'that' vs. 'which' [1]).

> Some of those commands are Git command,

are git commands,

> and we would like to check their
> exit status.  In some of those checks, we pipe the stdout of those
> commands to "wc -l" to check for line count,

for a line count,

> thus loosing the exit status.

losing

> Introduce a helper function to check for number of lines in stdout and

the number of lines

> stderr from those commands.
> =

> This helper will create 2 temporary files in process,

the process

> thus it may affect output of some checks.

the output

> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  t/test-lib-functions.sh | 117 ++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 117 insertions(+)
> =

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index f0448daa74..b3281409de 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -845,6 +845,123 @@ test_line_count () {
>  	fi
>  }
>  =

> +# test_line_count_cmd checks exit status,

the exit status

> and the number of lines in

> +# captured stdout and/or stderr of a command.

the captured stdout...

> +#
> +# Usage:
> +#
> +# test_line_count_cmd [--[out|err] <binop> <value>]... [--] [!] cmd [a=
rgs...]
> +#
> +# Options:
> +# --out <binop> <value>:
> +# --err <binop> <value>:
> +#	Run sh's "test <# of lines> <binop> <value>" on # of lines in stdout=

> +#	(for --out) or stderr (for --err)
> +# !:
> +#	Instead of expecting "cmd [args...]" succeed, expect its failure.
> +#	Note, if command under testing is "git",

the command under...

> test_must_fail should be used

> +#	instead of "!".
> +#
> +# Example:
> +#	test_line_count_cmd --out -ge 10 --err =3D 0 git tag --no-contains v=
1.0.0
> +#	test_line_count_cmd --out -le 10 ! grep some-text a-file
> +#	test_line_count_cmd --out =3D 0 test_must_fail git rev-parse --verif=
y abcd1234
> +#
> +# NOTE:
> +# * if "--out" is specified, a temporary file named test_line_count_cm=
d_.out
> +#   will be created.
> +# * if "--err" is specified, a temporary file named test_line_count_cm=
d_.err
> +#   will be created.
> +# Those temporary files will be created under $TRASH_DIRECTORY/.git/tr=
ash
> +# if $TRASH_DIRECTORY/.git directory existed.

if $TRASH_DIRECTORY/.git/ exists

> +# Otherwise, they will be created in $TRASH_DIRECTORY.
> +# Those temporary files will be cleant by test_when_finished

will be cleaned by ...

Cheers.

[1] https://www.merriam-webster.com/words-at-play/when-to-use-that-and-wh=
ich

-- =

Felipe Contreras=
