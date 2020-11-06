Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F18AC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E705E2087E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgKFWGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:06:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45916 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgKFWGN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 17:06:13 -0500
Received: by mail-ed1-f68.google.com with SMTP id q3so2769215edr.12
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 14:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8m8dAajY/srXFeWDMAXfcGJdE2jE3yVbe5XK0R3kKNA=;
        b=gPqCh78BpQckJ2dolPGQR5aeDbtVTXjhnp7uulZYOqWag8TiLVBQCLoEufz2ftZbcp
         N2epeds9BaAg0A/nxW9m4Qdt4rDv6kthGBZASjKkE+iapuzyKAlMq76SZVh22BQfysxv
         ep/ivmj+siLprKRbaWz+3rUDHJ/kn2XGfxPfHBxNdBp7/1KMiK6XF+m5Ml5D1m8LNOJA
         KhK4ka2m5makN7CmJ5mbWTMnhOfrajuMt8EOI+bckg4292ZZ7GobbkpqCzKMDtYQKHAi
         Ia24G5JDEUphrxCgKajXcSSK8+WYMkp72BpfDPieZWB3rd2bTsvM26GtFcuXP/7yO7N2
         bWYw==
X-Gm-Message-State: AOAM5331iTeEwc9G/S0O1bKZbzWHEc08tmy4WRrmGX0hm58SBQ58XDpq
        W9J6DZV9oc34aoT4pYn0NkOJTwYClCrA54EOpxw=
X-Google-Smtp-Source: ABdhPJzyRAUnAsWoTtuNQrk5mCX+cOV7+sAgyji+DzvOsi/uKtT+x23Ml5pe0MONFASOcr/ro38O+4eSNbgVxs34j1A=
X-Received: by 2002:a50:c40c:: with SMTP id v12mr4300357edf.233.1604700370611;
 Fri, 06 Nov 2020 14:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20201105201548.2333425-1-hukeping@huawei.com> <20201105150149.GA107127@coredump.intra.peff.net>
 <xmqqimajijwa.fsf@gitster.c.googlers.com> <xmqqwnyydxaw.fsf@gitster.c.googlers.com>
 <xmqqo8kadu9j.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqqo8kadu9j.fsf_-_@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Nov 2020 17:05:59 -0500
Message-ID: <CAPig+cQAreDJn_tS_K4sR9HwsSVNoFid9sWSdxzwSqkJLRidgQ@mail.gmail.com>
Subject: Re: [PATCH] format-patch: make output filename configurable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Hu Keping <hukeping@huawei.com>,
        zhengjunling@huawei.com, zhuangbiaowei@huawei.com,
        Patrick Hemmer <git@stormcloud9.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 6, 2020 at 4:56 PM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
> Introduce a new command line option --filename-max-length=<n> and a
> new configuration variable format.filenameMaxLength to override the
> hardcoded default.
> [...]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> @@ -200,6 +201,13 @@ populated with placeholder text.
> +--filename-max-length=<n>::
> +       Instead of the standard 64 bytes, chomp the generated output
> +       filenames at around '<n>' bytes (too short a value will be
> +       silently raised to a reasonable length).  Defaults to the
> +       value of the `format.filenamemaxlength` configuration
> +       variable, or 64 if unconfigured.

In user-facing documentation, I believe practice is to camelCase the
configuration variable name, so:
s/filenamemaxlength/filenameMaxLength/

This new configuration also ought to be mentioned in
Documentation/config/format.txt.

> diff --git a/builtin/log.c b/builtin/log.c
> @@ -37,6 +37,7 @@
> +#define FORMAT_PATCH_NAME_MAX 64

Nit: A slightly less confusing name would be FORMAT_PATCH_NAME_MAX_DEFAULT.
