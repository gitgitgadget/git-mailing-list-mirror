Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80459C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F4460E97
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhHBUvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhHBUvj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 16:51:39 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB67C061764
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 13:51:29 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 184so17982627qkh.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmX2Tz5WyJVwPpUbMXHGTng18c0xbWJjmEr776QwqeU=;
        b=cBH2xW+l926/tdO5NcakPCpTG2yhQnfKmG6ogwq+8vhTQU8OpKGfJmU5GCP4TWQp4Q
         eNwhpmc3kjMXoraB7udAR7bej2SOCWllbWRi1ylABLaUImVke0l7Y8x63jUHrdwFj2v4
         9Jw+AI7JmZLZ4kzyLTXnsSFW6LeTd5jMQZpjNMpP4urKuUK0FZPkrgV3XGeJddudHYHg
         A3J2G3I/5AL9oYKxst1igKt9vdEOEs1mTY0cTxspGyAuclT5QV+d5tTxdfbNqfnAScHh
         41JpkiO17D9TC3X6TDo8c+4MERTuUnsY2w0lHuQ7WyTq5X9aV4UPT0C60sHzCCA1lMri
         SLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmX2Tz5WyJVwPpUbMXHGTng18c0xbWJjmEr776QwqeU=;
        b=MqG7NYX2puLjGzSLQBN25cQNjvFIQVd1OP4sghf/uAv43+FT5xgb7ptXcj8bxS8eZN
         JDzoGIPLlcpcFOIrgMUZ4ZK1b40wsej6sX9OvyuPPccm3taLFraJklnxSGG9yqK+o2c2
         1BAxil1ygy+//7nIN80NnnBq4ph8zQd51mEhKnHiJgVuDjvik2w7sMViZMMI5Qd+bQ27
         DtGs8YW51TyByg8rCBZ/49BQh1RqhYdWT5fEhGSg7EMh60JYlc9qUZGaEEWdUGaAdCs+
         JnVF2JBJsqCI9r19qdPgK3DPsltYFkx/Bt3cSYIR+QKteh3ZZwh1xXZl5FRpHJ1nRm05
         C2xA==
X-Gm-Message-State: AOAM533w5gfYSOwIbcQD0H63VMzWABTymT3PYN2GCZ2hXA2tOBuj075d
        iulZgQbg3gunjh1EOvluJ0eRVB3qx4Y=
X-Google-Smtp-Source: ABdhPJx8wPql+XxeW+sduAFDQCmOtIKTiBQi5AFdl03l3inAfLs7SXK+Gw0H4qDn4kxmdGLFoTnDlw==
X-Received: by 2002:a05:620a:1398:: with SMTP id k24mr17324578qki.12.1627937488298;
        Mon, 02 Aug 2021 13:51:28 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id v5sm6539073qkh.39.2021.08.02.13.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:51:28 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org
Cc:     Thiago Perrotta <tbperrotta@gmail.com>
Subject: [PATCH 3/3] Expand git-send-email docs to mention format-patch options.
Date:   Mon,  2 Aug 2021 16:49:53 -0400
Message-Id: <20210802204953.229867-4-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802204953.229867-1-tbperrotta@gmail.com>
References: <20210802204953.229867-1-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently git-send-email(1) does not make it explicit format-patch
options are accepted.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 Documentation/git-send-email.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab..05dd8de 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -42,6 +42,8 @@ and the "Subject:" of the message as the second line.
 OPTIONS
 -------
 
+Options from linkgit:git-format-patch[1] are also accepted.
+
 Composing
 ~~~~~~~~~
 
-- 
2.32.0

