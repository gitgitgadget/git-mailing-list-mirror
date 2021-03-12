Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AB6C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE95D64F92
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhCLBdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 20:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhCLBdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 20:33:01 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC6CC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 17:33:01 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id n195so23708958ybg.9
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 17:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zcJF0rfsstmWW3S0qTZ6mW/lyuanwK2btk7w5SFEdH0=;
        b=PpJGV9NeA1By0Jw1nRW2xScQx0GLOov68tAAByAy1SzwFLjCO0+a0hZ/BIfvoqjgC+
         U3Y9LlFDb/0UEAMKHWXK3ka4kzDOfj3uwNwZ8bJ+RfSELJl43FVTKzSbpBPMxqOne1rP
         BAw2tyq6hwbmDWM7wrkFcKvn+gVZ/oct1hOSxT13QDbi07vou2/3u4g8Z/bux3IGj7bE
         DXEtx7K632j1Zb4fmWeM8GhAhEdaFpT9QHw4Enb5GQ5FnRfIEeptvT3Q8S9Y8qt1lHxc
         Zgoo6POiL30hybA7393n1P8wiIjO2JWELqi52TjpXFFAZCtz1YT8r9q8TD+fTm25Llec
         y/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zcJF0rfsstmWW3S0qTZ6mW/lyuanwK2btk7w5SFEdH0=;
        b=MeitHUEIDAbeL2oE4/Db+b3hG2S1oiROMQHhEbZ68LapXVNZjQFBjfH6s50IPt8P5R
         VTPBM4lH3PuT8ePbllKvekbhXpYgVJD/ypNKBU5bOjszuY0QYa5O6ZEdgs9ruvHsx5cu
         fuHmyWElY6x45ztNVSbK6d1EU82UkaIW33awvT0uBLEUL7VNmees0SMcC154pxbnHZGe
         BLqI382opZRohGZNvisoM3eyE6SErHF/1wQdat2Iblg+gx2KFdPkjc3qzZl+J2PC4Ggj
         jmd7Im991ljtHrH106bxJdKIIDf0ynU95Gl4ggjKkTYgVJtVTztTFXEGMP+csu0FyROX
         FnYQ==
X-Gm-Message-State: AOAM5309j93qIcQZCEx7uMZP24obWGTYRAVVfelgb2pqPUKcDI7CAfpA
        Kx5+/4/X0CZ5AuOATO7BMXrLMFjMdo3d8VtJ9AOF4Phh
X-Google-Smtp-Source: ABdhPJyQ+ICjWCYRqdOtKIZo1KvDHGWdOyx20/jeHNygwals6ocjxQAWp0cfQD/Jo0qMHFbtiNx3kGeGZ13oGTh9Cd0=
X-Received: by 2002:a25:ddc3:: with SMTP id u186mr14990545ybg.238.1615512780971;
 Thu, 11 Mar 2021 17:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20210311125511.51152-1-bagasdotme@gmail.com> <20210311125511.51152-3-bagasdotme@gmail.com>
In-Reply-To: <20210311125511.51152-3-bagasdotme@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 12 Mar 2021 09:32:49 +0800
Message-ID: <CANYiYbE-Pr7LSOB-qjLn0jus-ERzUXR7E3LTWb8_35THaqA1FQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] po/README: document "core translation"
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:56=E5=86=99=E9=81=93=EF=BC=9A
>
> We now expect new language translations to have core subset of 5000+
> messages translated for these to be merged. If it hasn't been done yet,
> do so by first generate core PO, then do translation work there, merge
> it back to main PO (XX.po), and fix any "fuzzy" errors.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  po/README | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/po/README b/po/README
> index 9beffc2954..eda7edf4e6 100644
> --- a/po/README
> +++ b/po/README
> @@ -39,6 +39,42 @@ coordinate among yourselves and nominate the team lead=
er for your
>  language, so that the l10n coordinator only needs to interact with one
>  person per language.
>
> +Because there are now over 5000 messages that needs to be translated,
> +we expect to complete translation for core subset of messages before
> +a new language translation can be merged. See "Core translation"
> +below.
> +
> +
> +Core translation
> +----------------
> +The core translation file, core-XX.po, covers some of commonly used
> +commands:
> +
> +  - wt-status.c
> +  - builtin/clone.c
> +  - builtin/checkout.c
> +  - builtin/index-pack.c
> +  - builtin/push.c
> +  - builtin/reset.c
> +
> +To generate core-XX.po, install the helper script (see "PO Helper")
> +and check the main PO file:
> +
> +    cd po/
> +    po-helper.sh check id.po

s/id.po/XX.po/


> +
> +This will generate po/core-XX.po and corresponding po/core-XX.pot
> +template. Now complete the translation in po/core-XX.po.
> +
> +When it is completed, merge core translation back to main PO file:
> +
> +    msgcat core-XX.po XX.po -s -o /tmp/XX.po
> +    mv /tmp/XX.po XX.po
> +    msgmerge --add-location --backup=3Doff -U XX.po git.pot
> +
> +Fix any "fuzzy" errors that occurs, such as misplaced translated
> +messages and duplicate messages.
> +
>
>  Translation Process Flow
>  ------------------------
> --
> 2.25.1
>
