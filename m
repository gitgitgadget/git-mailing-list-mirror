Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6B2C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 14:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiGMOOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGMOOa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 10:14:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207825588
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 07:14:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a15so12218583pjs.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86XEN8F/TnVY4nIg4hu5tZT5wc/Ud25ikUy8EiCxJ0w=;
        b=XXYDEhsg4P+XnwuekrU4kD23/1s77qmjDQYrXP3Cmnh9stWH5ntkGO+9GwNklSnvf/
         Hrn6GTsBLMHZz3NzjIQ/yZN46m1Apr7/wLRQONk7n0xJMhBMiQ83s1poGwzFvbtwbrCH
         EM2eCqYn4s4M4a0AtCUafoYJ0Wba8Ct/jxMGRd6h+7BJIgFrYpvNcE646OTxry746zgY
         KS0RF2DmfNheoi/q9BNsALWnmuOoVizJrUuTgLeoKrzy1imCJ8As/3CNkYJUvyHXhGMb
         9D7ZPKe0ppxOZqp8x678tptGhAj1Yth9ZShDq0JAlAN1PAhg4HDsKBpCuTRi8yi/21AM
         3P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86XEN8F/TnVY4nIg4hu5tZT5wc/Ud25ikUy8EiCxJ0w=;
        b=18+PqL9QrQ+qOElzlcg3JX4CBeAbdF7lBu3BPfQbALBRnc+AOMo2V00qpP+FHscysq
         C6b33SnyTcEmZSlx3uCVWHLa3E8t2CEtUfE3UtoymHSkepndCrDeC6Hv8GjBzPoRFh/1
         HvHGx3wi4cKrUTw4G9E5c4HvIvwKzTCjOd8WxqKlAbM7z5X4cPSdoGfp98so84TfkhMk
         oa2YzvfancorX7KpbfbQ10dsRX6hk7wQCHyxolC/Zd//IexYYj08x22KlDbvwoCrrIj1
         96eOhaAPLGNGrYR6lxsIJVBauU3MgTPmaNB5jScceltXMqwG3vHEBGUg3LQxOBvt4n8j
         PRmg==
X-Gm-Message-State: AJIora/Acpbr53Y0UhNJ58bjL76f25YgVxDVSymVpo5K+P0KIN0YELUz
        79gs7U8RXQnMhXUXVxVehKSmYxjlx2E=
X-Google-Smtp-Source: AGRyM1tybMMLyisl3ErS5xDxX7SV3IoACrhz6lrLozFStZcUP2EdotWje5o6OuoXeGSsY7OCU8wCng==
X-Received: by 2002:a17:90b:2bd3:b0:1ef:9ac7:d90c with SMTP id ru19-20020a17090b2bd300b001ef9ac7d90cmr4060921pjb.53.1657721668906;
        Wed, 13 Jul 2022 07:14:28 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id s30-20020a17090a2f2100b001ef831a2015sm1667532pjd.22.2022.07.13.07.14.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 07:14:28 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 4/7] pack-bitmap.c: don't ignore ENOENT silently
Date:   Wed, 13 Jul 2022 22:14:21 +0800
Message-Id: <20220713141421.57768-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <220711.86k08j7lyn.gmgdl@evledraar.gmail.com>
References: <220711.86k08j7lyn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 11 Jul 2022 16:38:01 +0200, Ævar Arnfjörð Bjarmason wrote:

> Makes sense, but...
> ...
> This should just be warning_errno("cannot open '%s'", bitmap_name),
> unless I'm missing something...
> ...
> ...ditto.
>

You are right, I didn't notice warning_errno() before, will improve.

Thanks.
