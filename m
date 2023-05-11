Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9B2C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbjEKTtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjEKTs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:48:58 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D25FD864
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:28 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e0d569a01so4924636a91.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683834506; x=1686426506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RM7Tp/cJxc85DODJJt9RWBinbDsXRIX6vLlLwgvugw=;
        b=S6zFRE+sk/wMRgvzGZkN2zRy8fL7dGXhp8FVS8O83wap0C+sCPB8Xq+k8wDbkguTKp
         sq52fVwFJrzJqFhNSmAJABt/P3zdnXT/MjQPGh5g8rkWPjXYuzlJJYlTUcJoRnjgAxoV
         XQ8cWxN4bfoXnMX9HPCKq3hMiK9qTx5H2+d6lXi0gNWm7AJw3DOv7K0Nv19ZIs7zmmak
         wzxuFrMBc/JHZT8Fi/VAFwC1K09KgpE+DKCQ5d/nr0hWnRYQzfTOxYm211AQpRila+p+
         06kd3NaGk8pq25o1FKTflGcBd3uVKI27pKjeuY2GQxo9HJY3fmW4ZsdRWmrbxjLtfart
         wqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834506; x=1686426506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RM7Tp/cJxc85DODJJt9RWBinbDsXRIX6vLlLwgvugw=;
        b=B0/0VscghfwmXxdOHwQ5fvHLQez5ko1OjMqpBLrSnagBuX947PtvzkKnTP4yiAS6/E
         J/yomX8zQd4WFdT1sykXc6oBDbVRJcYezhJ5K3JB3GkCkAOnea0C56xYCsX1T7eSDhc+
         1DQkEPPlfqA+l7CEuz2e+L5zv7DBROUD+4QSx44lq/yLH04SNW8Hpt2MCGxtbsSZElO2
         /9PhFwecD2NSYBBtHNAOXMaPoTOaa2JgiH5/Db+yzniY7t1g3CPJpez/549+daNk4DDw
         BtAZ3NCJBojTdYYSSx3GI4oxPiIN2/1OVZ28YKfkmLeoQaVXcJg4vPpIshqXHhOGWAd8
         T1Yg==
X-Gm-Message-State: AC+VfDxu6l8cE+e9PcsWhAYF0kr4ypL4M187N066EbXfiT3rG0qdXG7G
        oRKewjL7xBwiW7hNW3ejL2ymOUSwfIsW8TcvXx2FXzmcIWREZLls3aklN/KRsMv2yZE2txnXHs8
        Szi0iZ3gd/7GtA2gJDHZ8DMKunqquJ5H5XLHSlrmdS7msBS1zF7cFNUFdXL0eb5nD8w==
X-Google-Smtp-Source: ACHHUZ5qHpbkBKORx55828vFEP/HoVe3tD9RV4NTVSHfRWDYn1XYznQoX4bcJuS0rBi7sIZAepZRNSL1fSaBufQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:d701:b0:24d:fb1d:106d with SMTP
 id y1-20020a17090ad70100b0024dfb1d106dmr6823155pju.2.1683834506340; Thu, 11
 May 2023 12:48:26 -0700 (PDT)
Date:   Thu, 11 May 2023 19:48:16 +0000
In-Reply-To: <20230511194446.1492907-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511194822.1493798-1-calvinwan@google.com>
Subject: [PATCH v5 1/7] strbuf: clarify API boundary
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf, as a generic and widely used structure across the codebase,
should be limited as a library to only interact with primitives. Add
documentation so future functions can appropriately be placed. Older
functions that do not follow this boundary should eventually be moved or
refactored.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 strbuf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c..0256114002 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,15 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+/*
+ * NOTE FOR STRBUF DEVELOPERS
+ *
+ * The objects that this API interacts with should be limited to other
+ * primitives, however, there are older functions in here that interact
+ * with non-primitive objects which should eventually be moved out or
+ * refactored.
+ */
+
 struct string_list;
 
 /**
-- 
2.40.1.606.ga4b1b128d6-goog

