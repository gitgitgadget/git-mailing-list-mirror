Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76414C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJTXDC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 20 Oct 2022 19:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJTXCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:02:40 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD3922EE25
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:02:20 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id y17so737167ilq.8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43CBXAJUFsIce4Db/7N7Eq4/uqkj/50hntOF/1ReYD8=;
        b=fLGeqWdMz0tSE+1KmLQ44u3MdkH1QSfu62rGG8Clkdukwfnx1tlZX398ZjQ6ymAP3Q
         AepKwX0QyrLlZSxt0UUJSd9J1RO+othNT+ZQ261zSZEtQWVYTdeM+ftiImpcjunXSMg9
         jzIYjxjcD5ukNGhQiAgJH3KLU75GnNomFDQvwDK6/sihmAhPrMN+fAAcd4GGoj48zrHn
         xTb5eqKNLe8h5QgfM+xkxRRJOBbKHokUeZucTexYADWHgIpaBurBEuQTNR7pAxsw7/yx
         Da1OEo925JvxVsXSC2Y5n9uwfj1P7+L6z70pvVyneykffMyJr1r3AmeYRv28pdnMP6uH
         0tAQ==
X-Gm-Message-State: ACrzQf1tZphr+1MlQTMj+9enSToX8lyXAuLr2n3ukS07IvsLnvIe5YZv
        JqLndqAR+wQ7P5ToNAB4q0UAJbdQVsz15RyWaeg=
X-Google-Smtp-Source: AMsMyM61WfnJebcwKFV3oRaX1C3JzzCuf7Pa23fYl7fp3dbomMQJDiVWwWPqkGXmYAXQ0U2xxyKfC5z4CblNtHzHeak=
X-Received: by 2002:a05:6e02:1549:b0:2fa:f6e3:e2c8 with SMTP id
 j9-20020a056e02154900b002faf6e3e2c8mr11145530ilu.252.1666306929777; Thu, 20
 Oct 2022 16:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <patch-v3-8.9-859e69fbe9f-20221020T223946Z-avarab@gmail.com>
In-Reply-To: <patch-v3-8.9-859e69fbe9f-20221020T223946Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 20 Oct 2022 19:01:59 -0400
Message-ID: <CAPig+cQHgc-4kfaRHJm9VKxbSE_Y0k_f_Fa=NFGs7wEq09nkYw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] Makefile: document default SHA-1 backend on OSX
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 6:43 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Since [1] the default SHA-1 backend on OSX has been
> APPLE_COMMON_CRYPTO. Per [2] we'll skip using it on anything older
> than Mac OS X 10.4 "Tiger"[3].
>
> When "DC_SHA1" was made the default in [4] this interaction between it
> and APPLE_COMMON_CRYPTO seems to have been missed in. Ever since
> DC_SHA1 was "made the default" we've still used Apple's CommonCrypto
> instead of sha1collisiondetection on modern versions of Darwin and
> OSX.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> @@ -519,6 +519,11 @@ include shared.mak
> +# Define NO_APPLE_COMMON_CRYPTO on OSX to opt-out of using the
> +# "APPLE_COMMON_CRYPTO" backend for SHA-1, which is currently the
> +# default on that OS. We'll define NO_APPLE_COMMON_CRYPTO on Mac OS
> +# 10.4 or older ("Tiger", released in early 2005).

I found the "we'll define..." part somewhat confusing. I might have
written it as:

    On macOS 01.4 (Tiger) or older, NO_APPLE_COMMON_CRYPTO
    is defined by default.

or:

    ...is defined automatically.

Probably not worth a reroll.
