Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9908C46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 23:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjAOXzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 18:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjAOXzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 18:55:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0FD144B0
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 15:55:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r30so1538421wrr.10
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 15:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChPFnYrun7zN6MxMJOzMfIXcQrH2qs11l5BlcBoDXYs=;
        b=ITjjYZ8jKO+fbU8qEBKJ+J08tdxvsQTyFEBBawisnKjmv8/aNO6KhHqu0ovigeRgBl
         4SeF7U6K91RUUzmQ+wbFCd9836r6+wYAw55Aes5xbfKM2JSqHVwhF/iY4Dk6/dEIn21U
         fNpLzcpcDyrdwDvl0VXcKRssP4WrseJdL5RqX+K71VcBFfWXD7zWM1L42+bAPG2qqIIf
         I0dTaJnmTZ0eiSAwb3xjKk1KLEz05gOGy0dzJjf0+PCS5YVWXdHlvaKCUzUNtiGYvumf
         OO2Sm3obBWfs8d/+FOEI/ZGdXj2OFFFvCC7RlB0keP+py3Dgy9xHwexbrqmd0i7VJvaX
         JEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChPFnYrun7zN6MxMJOzMfIXcQrH2qs11l5BlcBoDXYs=;
        b=UquHiI959Cg2MmK95IXB38nXa9daIlkjZLtA7Obuf8dllpaVKLje/Iq/b92QdiJYvz
         dFTO4qSF4v6fC9bbpCO5kGBM9OQSl2OU3d2jXwIRcvnODtuhpQiIP+hNCMtDZQUR9xbA
         1HCx5VCJcYoU7y6Xjo0Tq89UlCQrDFD+x/hpT2jiLF1eibCWyCFVutAi8YZq1IZVWjdI
         2Ux1iTy9yoXNs74PR7RmXB/M0omYm1d4YWPV7A0UCDUkEmJ21kZFhhx4GHTtqLGHm3/r
         p3aYkvsHoc6xT7W/tlyJyMp0OFSK5BBLERtZweEOWnrQi7YXLWVIPnTX54IJwPqfI0NL
         W0ww==
X-Gm-Message-State: AFqh2krq8XuaoExISDGslM07ivRXfofy4MxDgRQfMzSitWZSsSI8O8wC
        1sTGZI5aSGva2HooAX1oaf6o+Fky2UE=
X-Google-Smtp-Source: AMrXdXsD5egyrQL+Gx1e1pdmBKMsQTBXe54TvMW4aYIHqBzBlP/2YButbxIm1IsTwV3uCHZn/JSMeg==
X-Received: by 2002:adf:e346:0:b0:2ab:80b3:67b0 with SMTP id n6-20020adfe346000000b002ab80b367b0mr25122457wrj.61.1673826900020;
        Sun, 15 Jan 2023 15:55:00 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b002bbed1388a5sm19506978wrp.15.2023.01.15.15.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 15:54:59 -0800 (PST)
Subject: [PATCH v2 0/3] branch: operations on orphan branches
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
Date:   Mon, 16 Jan 2023 00:54:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid some confusing errors operating on orphan branches when
working with worktrees.

Thanks.



Rubén Justo (3):
  branch: avoid unnecessary worktrees traversing
  branch: description for orphan branch errors
  branch: rename orphan branches in any worktree

 builtin/branch.c       | 40 ++++++++++++++++++++--------------------
 t/t3200-branch.sh      | 16 ++++++++++++++++
 t/t3202-show-branch.sh | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+), 20 deletions(-)

-- 
2.39.0
