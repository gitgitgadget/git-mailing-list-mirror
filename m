Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47080C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 01:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiKQBdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 20:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiKQBdj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 20:33:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D01DDF9
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 17:33:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a14so583843wru.5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 17:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbxhdIdxxp0+cXttnuEMXMXcc6xuqFuqcgFE2UORBu4=;
        b=Lr7YDpX0IikgHPl1Ij3YlaAsmECYv+VaLKVfZpzi6ByeJ462yVizpr8AFS8St/4aHg
         0Pfcl4IcqjW0MAg5iACfAuD4TK0JwoI8CY3qyH9lyFGLRcecW1vZpLirR2GVswnv54LT
         KIcXVULTOEbkP+DY6EpNyLLy23QylztGfBS+hd2Fax0J7olI9rCvFxHA87qXamggR4AS
         TXznNuuKNIpWu2tfiUJQxXMHiKYuUpYYPr1OQ6AzWNyM14pDgwZiUH5FDoTxgxUZwJl9
         KWLmilEWlQ/kVDEEuvGPt82/ZqBcgNvynjM+vlg00Yq7dhCVP+rkn8kQd4q95zapiDPI
         hLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbxhdIdxxp0+cXttnuEMXMXcc6xuqFuqcgFE2UORBu4=;
        b=KTodFqYgUQdM888NBhyvivrYhCr6dBswda9wCeSCnXk6LLj6vaxp5vTYJkxVsbEt1D
         GhNI/mBg82MSwizZ2By/0Kxf0Od1m+mDnhbi6MCfNdFV9bvB597wtz/+9ScZ2itWJAXr
         xziXIoTE2Rn+MPo31jy3TKzstLbVH3wlgVB+HRw6s1IM95uYMN9BPtRO1oF65J1elUUf
         vkvlc28hRRDDtwyHT9lBPEmOEk97ULnY4jW7hNmZlxJDxvttq4J4KLTt6jDiFLHidHG5
         Y2atkw9oJ7Ih3fpuHvJHT+XkoYjGqMDI8QH6Yv2pJPGp30YK4oqdwF+dPBhtfDWWAFwH
         cPVQ==
X-Gm-Message-State: ANoB5pm2LX5RdzpE3yq1JYQznSWHrByOqFWCDjBJ/Hs/1SKS6RsperMM
        v5xla0PMX0KMsGbEy0PeQUQ=
X-Google-Smtp-Source: AA0mqf6kB38+ZJJo0Ri7Bc31eb40lhNpmbfhu3nn2qPlb63xkIQcuCPZccTt/MOHkXbhyqCuYL/7yA==
X-Received: by 2002:a5d:6244:0:b0:236:73b2:f026 with SMTP id m4-20020a5d6244000000b0023673b2f026mr90682wrv.396.1668648816775;
        Wed, 16 Nov 2022 17:33:36 -0800 (PST)
Received: from [192.168.2.52] (104.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.104])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003c6c4639ac6sm4104760wms.34.2022.11.16.17.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 17:33:36 -0800 (PST)
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH 0/2] branch: fix some malfunctions in -m/-c
Message-ID: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
Date:   Thu, 17 Nov 2022 02:33:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix some malfunctions found in git branch, copying and renaming                                                                                               
branches.                                                                                                                                                     
                                                                                                                                                              
                                                                                                                                                              
Rubén Justo (2):                                                                                                                                              
  branch: force-copy a branch to itself via @{-1} is a no-op                                                                                                  
  branch: clear target branch configuration before copying or renaming                                                                                        
                                                                                                                                                              
 builtin/branch.c                      | 17 +++++++++++------                                                                                                 
 t/t3200-branch.sh                     | 19 +++++++++++++++++++                                                                                               
 t/t3204-branch-name-interpretation.sh | 10 ++++++++++                                                                                                        
 3 files changed, 40 insertions(+), 6 deletions(-)                                                                                                            
                                                                                                                                                              
--                                                                                                                                                            
2.36.1
