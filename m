Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC4C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 19:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiGAT4L convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 1 Jul 2022 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiGAT4K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 15:56:10 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B943AE0
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 12:56:09 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id h187so5877868ybg.0
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 12:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Qj4KtvAUBGANNl7QIZKdFS1ZoyYH+1m4VwqYw9cRpk=;
        b=IlkSDnritttEppuXYBL/u+urbneOEARZTLxc35SWsmRFIYiqV8mMj7IGK44tRpuCHa
         F5PMr+3HmuNGRkTBvF/0UCpv8WrjMjvhMIHxSJCv8PLLBpOcsYvsPrUgMhUUM8o+KJMF
         oHV8BHyu1vxfLuUhhViqwkRF5quOsd9dezSVnTzhgXtspGgxFR/IXUiCQvvOSJRBqc0k
         GEJT/11Q+6x4ZyUy05Py4DoCvm57/tNlNPos928z7/JkXWsZQ2YPkbSSprkXBLapoBSf
         2WPR96yoLOFvfahixh5p/mKRHxOStbtydVZIzniB/sh14QoUqlICuftl8oYfaOxBINbI
         OHJA==
X-Gm-Message-State: AJIora+YJ4qqJUO252qK8IlYZRz48+Pq5uyBAJ5Kv9UFjc28G0dwLxgb
        QSIoZ3LmAzKcp0LcJmSSbOt6R7a4jr0KBh4LAj0=
X-Google-Smtp-Source: AGRyM1uAa1UKBahdDX+o3zJ0vMaf09r0yT4Twmh1pzcesccfah6V+ppNRvcmwv88Yzvq8VNmYmjOSJVcXvThKJQz9IQ=
X-Received: by 2002:a25:33d6:0:b0:64a:9d22:f005 with SMTP id
 z205-20020a2533d6000000b0064a9d22f005mr16592586ybz.54.1656705368479; Fri, 01
 Jul 2022 12:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com> <patch-v3-1.4-49e9ccb5819-20220701T102506Z-avarab@gmail.com>
In-Reply-To: <patch-v3-1.4-49e9ccb5819-20220701T102506Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jul 2022 15:55:57 -0400
Message-ID: <CAPig+cSWpzHtv-Kv7=fibkPot=NTwKgc5_Eo_7G4fT=FnaGrxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] cocci: add and apply a rule to find "unused" strbufs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 1, 2022 at 6:36 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Add a coccinelle rule to remove "struct strbuf" initialization
> followed by calling "strbuf_release()" function.

I'm probably being overly pedantic, but I tripped over this failing to
mention that the strbuf is not used between the initialization and the
release. That is, I had expected it to say:

    Add a coccinelle rule to remove "struct strbuf" initialization
    followed by calling "strbuf_release()" function without any uses
    of the strbuf in between.

> See extensive commentary in the new "unused.cocci" for how it works,
> and what it's intended to find and replace.
>
> The inclusion of "contrib/scalar/scalar.c" is because "spatch" was
> manually run on it (we don't usually run spatch on contrib).
>
> The use of "with strict" here will be explained and amended in the
> following commit.

Did you mean "when strict"?

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
> @@ -0,0 +1,61 @@
> +// This rule finds sequences of "unused" declerations and uses of

s/declerations/declarations/

> +// To do do this we find (continued below)...

s/do do/do/
