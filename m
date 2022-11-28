Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0A2C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiK1OUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiK1OUk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:20:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0373B2250B
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:20:38 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h33so5074484pgm.9
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNXsU8j/pDypOarbn6uDMHpNzm8BOeG3YejAVEvj8ck=;
        b=EdHD5WrQE+pAnNvGvId8GaXlfGtJe0w2z/xfwt9/TgyQHfyp/Z5rlUhSGeuzogl0ll
         72D/IxzS0QJP2ofo71wBOde77U4/zRApTRvOFQcnVAksQ4cySRUeYm9V+kK1WBEVl7xD
         0cSSTqq7ZmoILfUuZ87WQXrb0XrNF2/Rou1cvyAcbJqZXYkdHVDrEgVRncFS/0fSGgZt
         rxyk+mVDuqzSV1rZ1Cuea1caclOtkA93o2oIsF4Ij3Dcvvajm4MLGhQPiLBS5gA8XS2v
         XU6XDRIgiz8g+WsHBC5tdKNMa/UxHd/QMK7A4mNWH6uTZqH2nOBjosT0HJoHqY9H2ZLl
         Tx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNXsU8j/pDypOarbn6uDMHpNzm8BOeG3YejAVEvj8ck=;
        b=TDW20EbE7H+JGb0Addiconk3nqW+rclk7VLOEfty+rU9uoLHWzCE2PVpOt5RThjBYI
         /3h4CMSsoOjvCfD962nLA0D8KsBJA5fXklMvtEZhkSHdRuPcPrUIjzD7e7de1pwe30kF
         tozb+zviGw9R9MHNtqf3MAwDoyNhbwQtzXNCE0GKwBdOyb1Hb5YR1mHmlZDZEsvQBxF/
         u+IQMOeK7ETQYE3uuhNEToD7hH9Z+IcmMjXEr32bsPa0iMk3ye6ZrsTHlBY3ulnNKkcH
         o2TzMJtYUNd5tp0Q/lyZJv2MIP+PXUPmAk96/nzwmsjDlVoAkjA3Fv4Cm+Ho4DfHhuu9
         iMjQ==
X-Gm-Message-State: ANoB5pksqZLinLnnJqYsDx9eKHMfVGiDSL/10DECQwk7aqHCwae4Gbmi
        uAMqZMNp3ELp/bbxg39qXzg=
X-Google-Smtp-Source: AA0mqf4sHl7GZAkFxKVkk6ME44PQG45OjADCKVE5C8M2z4M1PPtMD3pzeANDNebTksGx6E2yYNOpIQ==
X-Received: by 2002:a65:6908:0:b0:477:ae2c:48bb with SMTP id s8-20020a656908000000b00477ae2c48bbmr24929490pgq.525.1669645238494;
        Mon, 28 Nov 2022 06:20:38 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903244300b001896522a23bsm7360280pls.39.2022.11.28.06.20.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:20:37 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
Date:   Mon, 28 Nov 2022 22:20:32 +0800
Message-Id: <20221128142032.71179-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <cover.1667980450.git.dyroneteng@gmail.com>
References: <cover.1667980450.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teng Long (5):
>   notes.c: cleanup 'strbuf_grow' call in 'append_edit'
>   notes.c: cleanup for "designated init" and "char ptr init"
>   notes.c: drop unreachable code in 'append_edit()'
>   notes.c: provide tips when target and append note are both empty
>   notes.c: introduce "--no-blank-line" option

I'm not sure if this patch series should continue, and if there are no
updated comments it will be temporarily suspended.

Thanks for the reviews on the past patches.
