Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E1C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA62074B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ImUxao9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1QvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1QvD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 12:51:03 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751BEC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:51:03 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x201so1191280qkb.11
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpXU9hdUsaZWDEj97yEpUTi3MyllrkxnrCXCc8PGkyI=;
        b=ImUxao9hTob323u6xWAGS8nEeErbDTFzMTzIyIx3w7QTvwXu/OVz6JcLhdRAizeeU/
         9wH7aVny0Ok+sibnQaKdFdMOHOCLDFbXszv/3wkc60kg1t8VT6x+n6fIK0I3bmrdYHFQ
         JVwwqI1rvqFS0lpv3qUwVo4tUxwxZLtsD3mcPb+SRhr25yexyd63EVSGKufWlqGJ2yv2
         EWCFPx4JQpxyX4A6VNeTU6TZukAzG4NS6nSkIrlDDuYxs/MBDhNJby7T5FFCPu4LHyQh
         E4qx6iCqyC80cZL2swRWUOv8C3iC70xiciHY25CAt+YsWJfypzIbnMCtH8n2MQOLoVhy
         mxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpXU9hdUsaZWDEj97yEpUTi3MyllrkxnrCXCc8PGkyI=;
        b=UcDAMDUEyLWE3E2qSypXU9aQJivKGfKcl6NFUBzjsFhQ8UvngyZvSyJvEgMv9Yqai7
         T0SW2U4ED9kEpuMTEdYO8LWcCa/f+TXVUMEJLa9IemgYHY4rKHvAeQbvOXyc8R5Zt1Bj
         csf3+av3fvBqhqVYS45pS2ImjzmY1gAfDvmVYtn11H3MG49IxzcpGyMXXzMhZpb3ef5J
         Uqy7ffC6Foe04MV+sPcAh2iUv4pNujOkZ2vI8zsZ02Fi6SrqTTmEPPS2kEH6TdeSS8p6
         O8sKCGvCOCi+60NOwQQGFa/ixLGZq6Sb/BVK3KD0Jt944MrqawCK8vfG7OR0Vx8K1uOC
         juUw==
X-Gm-Message-State: AOAM530TCfAjJL7nmbDHA43nevpcY16VPk7BScSJIyUCtpuQ2Lca5Vtw
        YN2nKpMJ4m7hsF15ZCx+dwh/o19ote7aDw==
X-Google-Smtp-Source: ABdhPJzzjpz3vyY2bZLaSxhCsDMmNp6GHCeD7B8bmNIfg1DX7lAkNpuEOZx7RhOK6xcv8pT54TYS8A==
X-Received: by 2002:a05:620a:15c7:: with SMTP id o7mr338518qkm.486.1601311862224;
        Mon, 28 Sep 2020 09:51:02 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id u18sm1908358qtk.61.2020.09.28.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:51:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     phil.hord@gmail.com, dstolee@microsoft.com,
        jonathantanmy@google.com, stefanbeller@gmail.com
Subject: [PATCH 0/2] Fix race condition and memory leak in delta base cache
Date:   Mon, 28 Sep 2020 13:50:33 -0300
Message-Id: <cover.1601311803.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CABURp0puC324750dZUpeXBricWizy9Ldaz_=JzdvdOkUp8V4pA@mail.gmail.com>
References: <CABURp0puC324750dZUpeXBricWizy9Ldaz_=JzdvdOkUp8V4pA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch fixes the race condition problem reported by Phil, which
ocasionally caused a segmentation fault during git-grep executions. The
second patch fixes a memory leak in the same code.

Matheus Tavares (2):
  packfile: fix race condition on unpack_entry()
  packfile: fix memory leak in add_delta_base_cache()

 packfile.c | 51 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

-- 
2.28.0

