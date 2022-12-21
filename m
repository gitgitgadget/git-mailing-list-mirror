Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DABAC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 09:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiLUJRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 04:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiLUJRA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 04:17:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224C4C2B
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 01:17:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1543447pjd.0
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 01:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVUTUfcRYQhVGXrngvTmdvDZ0lGJzF5+FT9WKp/GjA0=;
        b=kG5S3Pt7h51kLuIA6HDRlRokVCN+x3slJDSTfurTcbJi1FEWhqf5WYHFNoB/hFYjH9
         2HeDPCYfw/CTpalvyxThmRabGdYHUWAK+Q+iqksbfb5lJ2eLWywZUi1o1vJmEy24Fcv+
         XZ/OuBg+h8X1ecQyDv0U7lQNnaKy7FJFBidi5ylVg6UQxaDEnGvXagy/9iE2RexvvIcf
         kgaAhpihAtki5rSAb9z+2NWmn7mCw0oVdvZV+t3SSx0R+HMdGM/rXctsB4MpkomuMBKv
         ZI1cRXFesWYJ/0WM+cd2NVcR4M3DHRQhfRZhWYyWhesMRekfC/X1vV0mYiqPdFG/7tch
         W8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVUTUfcRYQhVGXrngvTmdvDZ0lGJzF5+FT9WKp/GjA0=;
        b=Ry3tHlB+S/+76AgdWMhcnLGtrUt75gVWMBsdOYIoZt1rk1CO3rX3AaoBC0ZgA1e//C
         xqBWbgjpz0w7lkeanAVJZJAhpRGFeC8R+xgJbw0OrAHL6iHpEHBlZEwOwgdp1SWaxxfI
         zgqUCQckiLC4bKcDT13jnoyFmNOnYH3RcgrL9aBlcltn43HlgPXDh+MtTCkO1SZI2esV
         /KB8keLBGAZBRiu4sR5OVt/xidHjENfiJxP3m0CaVgRy2uaMNZEVteu87tSmqHKXuPW7
         +zcgTrO4wULWas4mY/nj09mOvR3b/XGbWbZeHoxKEpqUyB7i40BI8aqlCmZfB0v0SQwc
         cFog==
X-Gm-Message-State: AFqh2krnxyhxViGoMIUgVPmcO8E1hN65BGMIl7A0IAJg1gDCgoCgrSbk
        VKVIqP0nwrf2ra3RR+x9LrY=
X-Google-Smtp-Source: AMrXdXtwicLXdec/iE82R6Y9uteaaBv1Jn7Cgv2D0ouVYbEPA7bP05OBptl4F9Qq5LUmfhjqZbWVxQ==
X-Received: by 2002:a17:90a:4507:b0:219:28b7:c581 with SMTP id u7-20020a17090a450700b0021928b7c581mr1427346pjg.21.1671614219453;
        Wed, 21 Dec 2022 01:16:59 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.55])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a744200b00218f7c1a7d4sm896241pjk.56.2022.12.21.01.16.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2022 01:16:58 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     sunshine@sunshineco.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
Date:   Wed, 21 Dec 2022 17:16:50 +0800
Message-Id: <20221221091650.43359-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.rc1.5.gad6de9d3003.dirty
In-Reply-To: <CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx65AOnw2FQXKg@mail.gmail.com>
References: <CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx65AOnw2FQXKg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Taking a step back, perhaps think of this in terms of "separator". The
> default behavior is to insert "\n" as a separator between notes. If
> you add a --separator option, then users could supply their own
> separator, such as "----\n" or, in your case, "" to suppress the blank
> line.

Your idea is an enhancement of the original one of me. I think it's a suitable
name and I could implement it, maybe we could hear about Junio's advice of the
naming?

Thanks.
