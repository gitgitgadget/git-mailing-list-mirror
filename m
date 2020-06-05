Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A9C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2234206E6
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbF1w18x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgFENAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgFENAk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3DC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y17so9647281wrn.11
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+LZ3igzlZfkARBprDlGrVj7POrjOs/Cwtz+2xfBC8Jw=;
        b=RbF1w18xMUaayttKbdZMk76JKQzHeTcsrNiwYzrvmqz+cCjO5T9Aydqd7MsVsOSI4t
         aOisJrkubDAO5VAVAOnplzNf/tdq8BEP4MVL2z+iWaog+lrQaiKMNsdn/tZBB0rjfNSE
         EYRdmIkmzHVWl1NdVi0iBxDI6ubR/2zNU9Q9nEZyoZ/zBmNUFamUE/gFYW4I28g1OlQh
         hGvdx+jIk74MJ21D6v8wpHQqOsxUAVltxcX2/yjNzS4v/bAIjQ6Ioxo317Rbu8XpZH0A
         8BFIemoBe03dYgO9t+pPjhvVLLkVcstLRtkhQHuJ50yD2AjKm+SvFOyfBfEq9WEJCXt+
         UOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+LZ3igzlZfkARBprDlGrVj7POrjOs/Cwtz+2xfBC8Jw=;
        b=oI4gxHfsVJCPhETxASedK8FOAZWiBtg1C2gPsRRHMm7fvBEhLirykpzzSCf6oOrsGC
         Z8jGTcC+RzUrGrg/DWUtP7HWfUC3btczZTougGAf8PoLkVQtJ2BKOdoCk8QPAaTRz3H4
         xt+gvCQRqpIt0L+/n4Z0PmU9Ul06CxJl/DNyBke193i9YItuwx1GAdAiTbgPdD8eZhM0
         Qeorlwsbt+HpKIqNMnEloFvY5urJDV9489WdDctw4mqVmLwRoMTZCGpY4PF4X5BseL13
         T2rve3I5gcTP0B+3joyEzytEJcZTx7k5z2z5Frngh2XgYKuQWZO/EgeOvYambkZXmwTg
         ZOTw==
X-Gm-Message-State: AOAM532fZOM8d5+oedBk8mBucz0Bvc2vdKDWG7rlL/NC3GGS8V/53F7E
        c5018GjSnXeFEfr6pLcK55cquks0
X-Google-Smtp-Source: ABdhPJxRfZeiMetZj3wCHaayqtZAgqjg9sNIXz34l+dBVenhZYU+DOHOXfQuAzbfsKS3m4VuLnYvsg==
X-Received: by 2002:adf:de84:: with SMTP id w4mr9702726wrl.54.1591362038349;
        Fri, 05 Jun 2020 06:00:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5sm16392274wrr.5.2020.06.05.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:37 -0700 (PDT)
Message-Id: <a09d0bd5b7a9869430f4633df7f01651b4cfbdda.1591362033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:25 +0000
Subject: [PATCH 03/10] commit-graph-format.txt: all multi-byte numbers are in
 network byte order
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

The commit-graph format specifies that "All 4-byte numbers are in
network order", but the commit-graph contains 8-byte integers as well
(file offsets in the Chunk Lookup table), and their byte order is
unspecified.

Clarify that all multi-byte integers are in network byte order.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 1beef171822..440541045d4 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -32,7 +32,7 @@ the body into "chunks" and provide a binary lookup table at the beginning
 of the body. The header includes certain values, such as number of chunks
 and hash type.
 
-All 4-byte numbers are in network order.
+All multi-byte numbers are in network byte order.
 
 HEADER:
 
-- 
gitgitgadget

