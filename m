Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D848C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 17:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJDRoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 13:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJDRnY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 13:43:24 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE7F1E729
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 10:43:22 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id k3so15842446ybk.9
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 10:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=uYRrTv0WHdFUSVuLTM/w5epX/aTGFABzwiFGhxTsHxM=;
        b=Z5Ozg5zoyshs9kwIWREZdE18p4A+p7YWKH0AYDz5aSKfsWn/VHlwWNJ5gpOQ+uaW7p
         knk0tglndf1e0bBoOAGFwBdG8ri7RrGShEPvxs+jpqiyyb3EJuLkMS3x/qsRZO0UaZNK
         5qjcFXxhbbcryXzhdxYpTOCQcxGvUayS0PUTkv+ceX0tA/Zs8Jryhi8NT2PYn53ZWxvA
         sa/QIsjziFdwpjukbCAzuVgYfpgZWOow3glH+63doJAgabMjHY65+Aii98E99GuxKivk
         ar9Yq5CP5eqlju09iNZn9mIOsYlzpFYXPKYdOg0yZq8pLMR4qXUgTMkzAgpoEsq39OFY
         CpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=uYRrTv0WHdFUSVuLTM/w5epX/aTGFABzwiFGhxTsHxM=;
        b=11z49hC1UTQnS7V5l3v+h1SFyf+RMrhvxPv+adLS+I34gKDM78c2BB8NKapNWkeTF0
         EtmEk1tNtWVgMwkn4pSqAijba10/kAoRH9AFFgvzq4vPRI638UeF312idNQlu7CMLy8l
         a7o1ui/F77OO/t7u26tBdtn0umAtVizDm7l1HzWqFxAvlXrRHFwPb65zbrNxhdG0bBl0
         t4E0ndW9KfsUgJLr+15LtbkIDhx6ndsIpsIN69gMkfR/BLGA7kB41f2UzI61chQEMKmU
         6//V2iITuS2lHCxJlWr+iasqHAaI0HDAec3BN+RaGhvvoGlrCPQhPCMzoF/5/3waHcSz
         LcTA==
X-Gm-Message-State: ACrzQf3K9BYzLlupcXIymAHVOFcOMyR7NdXK9M+dthSIEseoivhiijbw
        wG/8tNhuAlNueOBj/pQQRqzrq8X5MkDDbawa1025funwz8yLaQ==
X-Google-Smtp-Source: AMsMyM466O7Ny5/wUL3q44ZbTS1ickMG3I0r15Sx3o42VcpLKRU3DFeuhp62aZUdAfTp5VlXLxAQVhpe/ziOJ8mUo6w=
X-Received: by 2002:a05:6902:309:b0:6b4:61c3:d991 with SMTP id
 b9-20020a056902030900b006b461c3d991mr26638579ybs.394.1664905401685; Tue, 04
 Oct 2022 10:43:21 -0700 (PDT)
MIME-Version: 1.0
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Oct 2022 10:43:10 -0700
Message-ID: <CA+P7+xrnAXceHJbBYV8Z9Ay9xbkzpiX3P0wXLwN7jfnifW2OBQ@mail.gmail.com>
Subject: issue with submodules using origin remote unexpectadly
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been running into an issue with submodules trying to fetch using
"origin" even though the submodule does not have a remote by that
name. (I recently switched the submodule remote name)

remote: Enumerating objects: 210, done.
remote: Counting objects: 100% (207/207), done.
remote: Compressing objects: 100% (54/54), done.
remote: Total 210 (delta 123), reused 197 (delta 119), pack-reused 3
Receiving objects: 100% (210/210), 107.20 KiB | 4.29 MiB/s, done.
Resolving deltas: 100% (123/123), completed with 48 local objects.
From <redacted>
...
Fetching submodule submodule
From <redacted>
   85e0da7533d9..80cc886f1187  <redacted>
Fetching submodule submodule2
fatal: 'origin' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
Errors during submodule fetch:
        submodule2


I thought at first there might be some configuration value in the
parent that is selecting origin, but I can 't find one. I also thought
maybe its some sort of defaulting to origin but I looked through
submodule code and didn't find one.

Is it just that submodule code is not resilient against changing the
default remote name away from origin?

Thanks,
Jake
