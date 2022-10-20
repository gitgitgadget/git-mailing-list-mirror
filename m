Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703D9C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJTW6f convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 20 Oct 2022 18:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJTW6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:58:33 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EBB224A81
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:58:32 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id l6so748126ilq.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFGIMqjItdtZQ1BSjKfL1TUtzPO4YPggR5k5ARtIkFs=;
        b=bxwZ8vYlDqBUTn4GMF404WLYzDv9sQRZMLIJDh/oalFJk4SCqDS/wj5f9NuKxBmbAQ
         yTtbFJ9/xcy0Io7SRKRVgtHudZHwMvzZwTHu62FwqzFRJRR2KGmAF+zFoBVPZ+udjcWj
         doRGnJIO+x0L748pXfaAIAZly2jw6BFsHzIFjzI6PXJfkAb1McvfxbacEpeg33y6Nj/C
         9hOAZWMgyZuJ6r88+XQ1bDk8/FdDcgIyjHlqkWJUwqSgm6I8nDBP6WmRXJMCy+Iwv4nF
         tAW6dIVyss9ff8AApu9xYFxTKvNPJT4gVeER2xZfFYlJEYHAftLF16SALzqk3aTKMUuj
         eKxw==
X-Gm-Message-State: ACrzQf3t9vbel2icuPkjpJRDCWzPMUOg3mL4fndALqY93B3tT16BTaF1
        VFphmlvIxhi8SDU//BZw/7DTdMwoJTuYUWmDN6w+ps5/
X-Google-Smtp-Source: AMsMyM7AdQk8ISE5eT97qxPGJReGQtAykmY3jV93f5JMrOt3s44Q+t1tHyDpbRHpPZOWAhsnWRG1EabluwBHdAWonTw=
X-Received: by 2002:a05:6e02:2141:b0:2fa:c219:6158 with SMTP id
 d1-20020a056e02214100b002fac2196158mr10499897ilv.48.1666306711616; Thu, 20
 Oct 2022 15:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <patch-v3-7.9-05edcfb9cd9-20221020T223946Z-avarab@gmail.com>
In-Reply-To: <patch-v3-7.9-05edcfb9cd9-20221020T223946Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 20 Oct 2022 18:58:20 -0400
Message-ID: <CAPig+cQEugkHFQivkeRCXdn-_6pYuyRffchz0Aej3FSxra0Xwg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] Makefile: document SHA-1 and SHA-256 default and
 selection order
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
> For the *_SHA1 and *_SHA256 flags we've discussed the various flags,
> but not the fact that when you define multiple flags we'll pick one.
>
> Which one we pick depends on the order they're listed in the Makefile,
> which differed from the order we discussed them in this documentation.
>
> Let's be explicit about how we select these, and re-arrange the
> listings so that they're listed in the priority order we've picked.
>
> I'd personally prefer that the selection was more explicit, and that
> we'd error out if conflicting flags were provided, but per the
> discussion downhtread of[1] the consensus was to keep theses semantics.
>
> This behavior make it easier to e.g. integrate with autoconf-like

s/make/makes/

> systems, where the configuration can provide everything it can
> support, and Git is tasked with picking the first one it prefers.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> @@ -481,6 +481,14 @@ include shared.mak
> +# ==== Default SHA-1 backend ====
> +#
> +# If no *_SHA1 backend is picked we'll fall fall back on using the
> +# default.

s/fall fall/fall/

>  # Define OPENSSL_SHA1 to link to the the SHA-1 routines from
>  # the OpenSSL library.

Not a problem introduced by this patch, but this could use a: s/the the/the/
