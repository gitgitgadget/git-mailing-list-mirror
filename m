Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FCAC4332F
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376404AbiAXUJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 15:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354564AbiAXUDK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 15:03:10 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A6C06809E
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:29:12 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id i2-20020a17090a4b8200b001b426d8be4eso81099pjh.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5OBu2UBrRK4Eiq2/NSFMT0+v7gx8SqBrr56UZbBDj5U=;
        b=Jfq6f0mVbridlrxg2cCUZG5gj5jkuRQXW9eXLznNOchakBWxahPslzseYlPY9gCccF
         Iv6hW4rMjxjNxNaCFdVvgg2k4o3NqwOcpyUPx4eXzxRIGOIjAQuDjQHO7TKx4Uf9jfHY
         XmjkWftX8mazW12mWk4FQBr8daXlrBZhIqtOC2YtcoevLYCgtyxl6kg3ILrU1tKPW0Ks
         u9+uYBYNF7PV8eYPGRR5wJGzMhJv9BpLXzx+xnAYb7teznA/TJqQvoHYqIMzqTYN13U2
         bAkjVCO1mmTCb0jDsbJSD7flqO5DhVpffqDe2QSHrYSWXaheNHj78r67BN0myDDGb/Kx
         W74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5OBu2UBrRK4Eiq2/NSFMT0+v7gx8SqBrr56UZbBDj5U=;
        b=XU1VQGFmxE0fdjbHltKAbr9v6hPmwdOCCQByIkgy+DmPdthHYGV9mahO3ScoVScXV6
         gtI+4gHKKt621LB6ueCU4R+e3f6GAA2xQDHMcuoirH3h0e1XSEK8XXcXadgMB2FZbm48
         P+b8Pcf2HKI20Q0jVv8k3bERyZjiHNizWCdpo3N8+BIej+XuhLTeGuT8IVEO8j7snPXk
         GrmO3ztCOomM99mzmasGL7Osm+Nc52P0TSTLlSmWBmlx2MBOgoFZ3KztiOxioRS8Bi8D
         nCFj7HRM2D1yiso1CHXe75+/YR6iBFmfWKTDqmuuMJD7zAVKK8DJ4pNb5CX2mqoP7/dT
         0g+A==
X-Gm-Message-State: AOAM532tPWz58Ni/kHgfg+mU3mWvD3298sYZDSiZPpY+SltqgbVLUsOC
        q56ZjSYB/CxHwVx29uNl21LTzjvyG60B1a6PqT9O
X-Google-Smtp-Source: ABdhPJz0EN3uLY8KW10BzkcUnlp/0xR0venNrARqNMojXi5sTKM2pm4erzjb5UyEf3CvsKhmY5I2aXZvzXwNmaDWZWVN
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4d8a:: with SMTP id
 oj10mr162423pjb.191.1643052552455; Mon, 24 Jan 2022 11:29:12 -0800 (PST)
Date:   Mon, 24 Jan 2022 11:29:10 -0800
In-Reply-To: <9707d5ea4433d9a5c7f8581dbb2d8a05f410efd3.1641320129.git.me@ttaylorr.com>
Message-Id: <20220124192910.2453842-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <9707d5ea4433d9a5c7f8581dbb2d8a05f410efd3.1641320129.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v3 9/9] pack-bitmap.c: gracefully fallback after opening pack/MIDX
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> When opening a MIDX/pack-bitmap, we call open_midx_bitmap_1() or
> open_pack_bitmap_1() respectively in a loop over the set of MIDXs/packs.
> By design, these functions are supposed to be called over every pack and
> MIDX, since only one of them should have a valid bitmap.

Thanks for this series. Apart from my minor comments on patches 7 and 8,
this series looks good.
