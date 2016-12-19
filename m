Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA921FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbcLSSZq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:25:46 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35714 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763998AbcLSSZq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:25:46 -0500
Received: by mail-pf0-f180.google.com with SMTP id i88so24923167pfk.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 10:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FYWqJvdiTJg9wvEdiRcdVGgZEw2pY4bD6zDUofYG1rY=;
        b=qRWdtreFKAm8uluEQPPXor3V7sGNOCHtH3M5xxC9s4JtY2qw6n71EegMJDZ40e85mR
         yrFXfvA+3Ucbdrl4rjFxII6LlVuACaJhVhqo6EDllb3P5LXoBdzQVirmSRyLw+iBRLhp
         Okam/YBGsEQ7qQvnD4XRi7nlrwsYM1vHStKg0W5HmJ2gLMixEi+nawVnvz+6cuVMmSXV
         312GX/Tl8U5zyma6m0Elu5DjTV8sbDYx6v4q3cZQK9EPIW2J70EzKvS4lfk6NUtZwuQG
         5PA+IXeEQJx9hsVUos7hkOD3GiZWh4ODReSRfU1zDs0zjgdWaVqxC9zmtnvwXttQqWP3
         AEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FYWqJvdiTJg9wvEdiRcdVGgZEw2pY4bD6zDUofYG1rY=;
        b=VascmiLivun82eeGtFykzhdcnmF1GmeDlDMDCrZQ6im3OeWFe5Vc7eMXQ9oqxCQtYe
         Qaud6E3I5VssBFqWGahRswGNXpfyPJUI/LLKB5cvtzfFJBgtMvFqUbboC7HveJ02qKW9
         JzoiDUDYrZAT1e8fOyAxX6AJS78ozMGnU/8ueV2GdyRWoRDWvTSLQEg1YLAvD0jIuCxy
         nI7sr7XOEIxpdy+yCBefkyHZvfa83AUDLBJeEWoQ0eEsrp9TrDg3ZLEO/YXYH28sGLk5
         DqRtn5excbjLRepPXGi2aZe2mGE9T+bs6PYGqByq68igc+imYBQVwg5ETm+R+ok5Vssj
         W3dA==
X-Gm-Message-State: AKaTC02QAawqII06pe9R9zc/ADK+HPr8Wes1RUbQt7SJFvC/FhGKaFCSn+2X4A6nx2Ln3WW9
X-Received: by 10.98.19.137 with SMTP id 9mr15980689pft.150.1482171945265;
        Mon, 19 Dec 2016 10:25:45 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm33098745pfk.73.2016.12.19.10.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 10:25:43 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/3] transport: refactor flag #defines to be more readable
Date:   Mon, 19 Dec 2016 10:25:31 -0800
Message-Id: <1482171933-180601-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1482171933-180601-1-git-send-email-bmwill@google.com>
References: <1482171933-180601-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the #defines for the TRANSPORT_* flags are hardcoded to be powers
of two.  This can be error prone when adding a new flag and is difficult
to read.  This patch refactors these defines to instead use a shift
operation to generate the flags.  This makes adding an additional flag
simpilar and makes the defines easier to read.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/transport.h b/transport.h
index b8e4ee8..1b65458 100644
--- a/transport.h
+++ b/transport.h
@@ -131,21 +131,21 @@ struct transport {
 	enum transport_family family;
 };
 
-#define TRANSPORT_PUSH_ALL 1
-#define TRANSPORT_PUSH_FORCE 2
-#define TRANSPORT_PUSH_DRY_RUN 4
-#define TRANSPORT_PUSH_MIRROR 8
-#define TRANSPORT_PUSH_PORCELAIN 16
-#define TRANSPORT_PUSH_SET_UPSTREAM 32
-#define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
-#define TRANSPORT_PUSH_PRUNE 128
-#define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
-#define TRANSPORT_PUSH_NO_HOOK 512
-#define TRANSPORT_PUSH_FOLLOW_TAGS 1024
-#define TRANSPORT_PUSH_CERT_ALWAYS 2048
-#define TRANSPORT_PUSH_CERT_IF_ASKED 4096
-#define TRANSPORT_PUSH_ATOMIC 8192
-#define TRANSPORT_PUSH_OPTIONS 16384
+#define TRANSPORT_PUSH_ALL			(1<<0)
+#define TRANSPORT_PUSH_FORCE			(1<<1)
+#define TRANSPORT_PUSH_DRY_RUN			(1<<2)
+#define TRANSPORT_PUSH_MIRROR			(1<<3)
+#define TRANSPORT_PUSH_PORCELAIN		(1<<4)
+#define TRANSPORT_PUSH_SET_UPSTREAM		(1<<5)
+#define TRANSPORT_RECURSE_SUBMODULES_CHECK	(1<<6)
+#define TRANSPORT_PUSH_PRUNE			(1<<7)
+#define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND	(1<<8)
+#define TRANSPORT_PUSH_NO_HOOK			(1<<9)
+#define TRANSPORT_PUSH_FOLLOW_TAGS		(1<<10)
+#define TRANSPORT_PUSH_CERT_ALWAYS		(1<<11)
+#define TRANSPORT_PUSH_CERT_IF_ASKED		(1<<12)
+#define TRANSPORT_PUSH_ATOMIC			(1<<13)
+#define TRANSPORT_PUSH_OPTIONS			(1<<14)
 
 extern int transport_summary_width(const struct ref *refs);
 
-- 
2.8.0.rc3.226.g39d4020

