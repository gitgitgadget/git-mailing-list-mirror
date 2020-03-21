Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376D9C4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3D42070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjSdCeQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCUJWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:20 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44323 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgCUJWT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:19 -0400
Received: by mail-qv1-f66.google.com with SMTP id w5so4435630qvp.11
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+p/9uW24LgcQGfFEnY3l1C8SMQVOQeOo85lsYeBd//A=;
        b=WjSdCeQGNHiHslA2O5O/qPFMRSVvQDM20wTK+vUzFVbFFjhKOWZsLWrU8QnalSyohv
         KrAhlaDbOoHqeYHtngIaCYaN52o1sumfaCeAFYLC/1pJNh9yCpWJx/TcQRxhIluCnDNS
         gIN8NkH42qBBtVazMhplHYP1SgWZwv4HXy6WMjIreN5fcnxdDdGLPKj6Cu2AN6hnNKvw
         3nzxKlL4wiCvhEV7MrVwc7bQbazgYQA2wwnmNDKOdBm4IzNaq9/EcfYruf7xRGaGePPS
         gK7X5HXCX6lU2/3yqJkhn6zhyo8+8wtzL0zKOWSNC12p5tBv+m/JDEHsVQwbVQAtxI9V
         Fkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+p/9uW24LgcQGfFEnY3l1C8SMQVOQeOo85lsYeBd//A=;
        b=aDmuOWLfdAdgBEutTC/Or1dedl2YbcyBT/gTl8bBs+oHQHpyCI9Us0DZOmkouuf0JF
         AJIvimUxhOUleeIYqr1/wGH/Vc5a18QDdEQ2fKycw2+/7JXFfnq8KXBYx2rCl2D/2dQ2
         myUV3RMtCltvLraqZS2qn2BHoXLVKPO3Btvo2MofXgc9lRpmVFG5yRVMJ6KyzAr2ASLx
         hLRmoijXMedqRHBzQBUIKkFU95apmAslHjK2splicnEkPLsvAGbt3A8Kb5MV393WnDLI
         6ycL2OlRPwHadMOa4e5WRjs1S7HAbTNN8zAkDqq+y/2dXJVajf0l11sm9XmNg9tgo0qz
         la/g==
X-Gm-Message-State: ANhLgQ3nu0fwHTMwnwPc9t9EcUF0uLOZ7vcZejVRjB2QhKDbi2bzQtOg
        TrG6cEnNsJfRyofESiYdOzlm2B4R
X-Google-Smtp-Source: ADFU+vvX/nAvL8HgwwcnOZSy7bH454E94AfEqL1A6HdcCBVvbFzNlwn24IRllxeFbeUfFm3yCIRYTg==
X-Received: by 2002:ad4:58c2:: with SMTP id dh2mr11882982qvb.242.1584782538485;
        Sat, 21 Mar 2020 02:22:18 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 05/19] sequencer: configurably warn on non-existent files
Date:   Sat, 21 Mar 2020 05:21:24 -0400
Message-Id: <e42f4bdd4d763be4062f12fa6f1481849e87a0ad.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on externing read_oneliner(). Future users of
read_oneliner() will want the ability to output warnings in the event
that the `path` doesn't exist. Introduce the
`READ_ONELINER_WARN_NON_EXISTENCE` flag which, if active, would issue a
warning when a file doesn't exist by skipping the `!file_exists()` check
and letting `strbuf_read_file()` handle that case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index abb2a21e9d..92e8d38290 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -420,6 +420,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
 }
 
 #define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
+#define READ_ONELINER_WARN_NON_EXISTENCE (1 << 1)
 
 /*
  * Reads a file that was presumably written by a shell script, i.e. with an
@@ -436,7 +437,7 @@ static int read_oneliner(struct strbuf *buf,
 	int ret = 0;
 	struct strbuf file_buf = STRBUF_INIT;
 
-	if (!file_exists(path))
+	if (!(flags & READ_ONELINER_WARN_NON_EXISTENCE) && !file_exists(path))
 		return 0;
 
 	if (strbuf_read_file(&file_buf, path, 0) < 0) {
-- 
2.25.0.114.g5b0ca878e0

