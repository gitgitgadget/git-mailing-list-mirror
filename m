Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90311FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965362AbdCXS3N (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:29:13 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33243 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdCXS3I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:29:08 -0400
Received: by mail-pf0-f174.google.com with SMTP id o190so4352449pfo.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9/MpAIFs+sCq4MmmS1b4g3axNdosZboYyJ/IcYe7TlI=;
        b=ocjmhIHrgeigslo3sK7THTSDD6v07hHw3ed+b4GrwW9CFo3cB2Yc320/QMsNtLbEH9
         wuiaeW2jFZT4vHnMhtw7DOS3srs/jrrv7Y25Ip3uWE50b/iKW7cbrFQbP2TXr0NbQapp
         Wk+m4Hhd35UhmUSEa2hqcO2AwTv2xNpqDfZnFDXtZxYcrCnQhNp/f54Io8oZFP3bsjLs
         8/F+SGGWrzzrcNUdYu0fW5ufoFZeMVZTHYgJp26D4QnnoITDfBJZvb1TcTyjArJ2k7/3
         WzIaB8ssq2KEAjSOKClzksX0A6hvRwml4s54ki+BWsmSCm213qrTR07XPZzMGzf98YrS
         bM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/MpAIFs+sCq4MmmS1b4g3axNdosZboYyJ/IcYe7TlI=;
        b=hMTDqNDM0INW5RpoP2WWgpk16obs6r8UWGPGjty9LR6wILxuG26ok/8kmN+HjMFEuk
         mx3texAmy73yOVLNTl7Rl0aJXgLTNcXhzdrLxbQzqXQSUIfcCkUZkesno2sCbkMk2qMx
         HhS5PIOlnPNWg6WIHLfTm1hHJtuIMvwyH/FYWUz90+g4g8wF5NHMLlncOy4hPByVnwBV
         RWc2Z8v6hvwIjrWOab3Hn5fZl6njZtJgzgTsuoHfnkL3NIurgnMlriOT7yvvryWyzw1b
         14oTSmItJ54NOCGbLz/haVu3ERbwWvAzlgiZIX4c/mcwYDuAJ1Tz9kDw5UPXv4dbpPEd
         jIIw==
X-Gm-Message-State: AFeK/H0/xphvEoV1CEvqWfFQMu8RdIoMgJhoVZGJLewUThT904ddC5wmqyy4EMyZK/zFinxm
X-Received: by 10.99.225.5 with SMTP id z5mr10527093pgh.145.1490380147459;
        Fri, 24 Mar 2017 11:29:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id h71sm6054317pfj.65.2017.03.24.11.29.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 11:29:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] submodule.c: factor out early loop termination in is_submodule_modified
Date:   Fri, 24 Mar 2017 11:28:57 -0700
Message-Id: <20170324182902.19280-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.437.g2b7623d507
In-Reply-To: <20170324182902.19280-1-sbeller@google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier for a follow up patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2c667ac95a..e52cb8a958 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1075,16 +1075,15 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	len = strbuf_read(&buf, cp.out, 1024);
 	line = buf.buf;
 	while (len > 2) {
-		if ((line[0] == '?') && (line[1] == '?')) {
+		if ((line[0] == '?') && (line[1] == '?'))
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				break;
-		} else {
+		else
 			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-			if (ignore_untracked ||
-			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
-				break;
-		}
+
+		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) || ignore_untracked))
+			break;
+
 		next_line = strchr(line, '\n');
 		if (!next_line)
 			break;
-- 
2.12.1.437.g2b7623d507

