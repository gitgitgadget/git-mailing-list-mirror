Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FCFC43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 00:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGIAwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 20:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIAwj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 20:52:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F3666BAE
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 17:52:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y9so377553pff.12
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DC55sQJWiKz7/hqpjg3gvurN8ZGsRpVNrjeZdCcdiGM=;
        b=NiUMPEYZIqx2qTCJMI9fUHMEtHjlOLLrMV0PHehmFdZGAU9mBJTqe0/5Cvg/9UKH/q
         Aw8GPzxj1P2N108fNB3olSQd8VcG9O2PVBaszO4wry1sq+wOOzrOty2YHxBP0nHuiAKZ
         8htG97wTbOCsqgJKDjGcE9j6DUXMgWlzjxQPsA3VN+bqS5d36JPXD7KHDRcw7DxdAvRr
         TkvBbDiDyD8O463fZXDr3xHn7nJV6GxlMIHKuv+EJIgE0FdQK/fGimQ3feJZhEV070Jb
         jBZiWDN9Yu/KVl5h+kTEbYO9+FlLZ5KzU2CqDC3j60TXzNwlZViA5kDzA4h4Qqqf87j6
         MYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DC55sQJWiKz7/hqpjg3gvurN8ZGsRpVNrjeZdCcdiGM=;
        b=OOWqXGhACDEH22p7vTCW/qgSC8bJzXkkD3X6lHadBKI5WW1/+p33Cv6uo5CsFggKvb
         C0FwVnqW28AytsHGCrbyfyzXFLUxNOm0O8sLFUpZXEvyYc0XC2tc2Xv4+iczEkJMG/Tn
         0cu1GBHlul9Zd4jNk87r3enOjbQYkN5yRHcGVOkXDhQoPnhVFpVJ8bjPV2QuoOYpNRwA
         1S6idgt63hKbrt1q2HBbknkE2RJQa/eFtHV9a3Af5p710/TjLn3DZuYK4xMNgNIei3wF
         IBvktlMl/w3W99E88wHdOnqEy3aeG2YPB8BpUnjvaqcXA4KReQbPXJler8iEkp4bhSdO
         b58w==
X-Gm-Message-State: AJIora9OQRZWvuHNpXbAGLOLZ8AQeB5ZlITLKOkHVxuY3W7YgXlN4KEY
        VV3Jx/M4BRu1/ZFp8J95YOSlPw==
X-Google-Smtp-Source: AGRyM1sKJ5d0SpSKMljORYUm6ogzmANQEOzgt1TBz0B7HpyKJvWWkBlBwYv64hyh5ZGHj5ZpXN7G1Q==
X-Received: by 2002:a63:1249:0:b0:411:54ac:71a0 with SMTP id 9-20020a631249000000b0041154ac71a0mr5577347pgs.4.1657327957849;
        Fri, 08 Jul 2022 17:52:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id v34-20020a631522000000b0040c52ff0ba9sm71287pgl.37.2022.07.08.17.52.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Jul 2022 17:52:37 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     carenas@gmail.com
Cc:     bagasdotme@gmail.com, chengyang@xiaomi.com,
        derrickstolee@github.com, fanjunhui@xiaomi.com,
        git@vger.kernel.org, hehao@xiaomi.com, lilinchao@oschina.cn,
        maxin7@xiaomi.com, shifengbing@xiaomi.com
Subject: RE: possible bug with commit-graph causing git to fork bomb (was Re: [External Mail]Re: Git fork process infinitely and never stop)
Date:   Sat,  9 Jul 2022 08:52:27 +0800
Message-Id: <20220709005227.82423-1-hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220709002658.vt34nnzhxefg72d3@Carlos-MacBook-Pro-2.local>
References: <20220709002658.vt34nnzhxefg72d3@Carlos-MacBook-Pro-2.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > To be a supplement.
> > If I delete .git/objects/info/commit-graph,  everything works well As well as fetch with `-c core.commitGraph=false`
> 
> This would seem to indicate that something in the repository might be
> triggered by the commit-graph code.
> 
> > if I execute `git fetch --filter=blob:none --quiet --progress miui --prune --tags +refs/heads/*:refs/remotes/miui/* +refs/heads/miui13-s-thor-vendor-stable:refs/remotes/miui/miui13-s-thor-vendor-stable`  on version 2.25.1. It just throw error rather than infinite loop, like this youtube video "https://www.youtube.com/watch?v=qvYTvVRE0FU&feature=youtu.be"
> 
> maybe a regression?
> 
> Carlo

I looks like the same issue I reported in [1], and we can see the fixup
in [2].

1. https://lore.kernel.org/git/20220612161707.21807-1-chiyutianyi@gmail.com/
2. https://lore.kernel.org/git/cover.1656593279.git.hanxin.hx@bytedance.com/

-Han Xin
