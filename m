Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA18C2BB1D
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A6820738
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="HcKeh8Ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgCQS6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:58:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36460 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQS6b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 14:58:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id u25so34461283qkk.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U9JuKsd1AwbGjjEfLiRCBaOE3lF8n5U9gEctarqdXpY=;
        b=HcKeh8AiPN1ZaEfWhYvdHPa1yXMyhhJQ/p1M3BBmu15spcqJV8kbio4JUPV+uxzA8A
         V0lHILyREIBOqxsTewD2gm+JZU4Oqgj9n787rQJYrYZpGgOiQzDr+zt40Bybt3WkxSog
         07ZWSU8na5cSjKnPXggVKEJvCM6E/dwhn/UTYNMpmnxO63q3/HuvhPNGopSt0Uj3KZcE
         bGkXBr0t2J9kbGpu05gIPVGx+LY8K1k0J0pycXZfmy+gR/YlBrQ80pk7Wy+nkKm0LGqZ
         wcUC16Z+XH3+MANYt3W/m1mfiEvCzZ+dV9y2XtWrKS0DZ0pP/SL4ZyBWgpM2GPWFXlHK
         FLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9JuKsd1AwbGjjEfLiRCBaOE3lF8n5U9gEctarqdXpY=;
        b=KiRuYLlku2eXDyMlzkFQVc+ZoCZhNAnFNrDwkurUBLRKIB8O8dzXgzjjrI3FxllzY8
         NvFDa/nVUv1ZPd7rU+BoryTrMXDKOJ9YLkhekrIJv1ig4c7MNOcM5HpA6FvX/pDzKGmg
         C+MmA4qVVihjLa/oFBp8Q4MQHzioA/nnU1GoUQwwVoV+uh4iwMCMDhaJ+XFrTzow5FWV
         2E42nC6opRvm/A3xtBYapdohj39c1s6ImvcGoiRKaNNpY69NYsLjhXSeasQTWy1n7Yvw
         UZ4R1Es1fny3AL9/AeK57vRdBCZNQOuabzP7Z7u0j79NYw7WkgfsasZ1ISh0RSO0NYSt
         jeXQ==
X-Gm-Message-State: ANhLgQ1HhOjsFekOCzGYI1FlRjOXeYlxi/zRxz09BdTDzci6UEOWD5iR
        SD4gKxyf9PJAuSoRBxwiQLmuQvGMHjY=
X-Google-Smtp-Source: ADFU+vsDmutKe5QXurYg0jxaODJ8ojaPV88O3zj3J/R/O8wkKLhwKsTandoWUaFrYEcUNXkve5M8zw==
X-Received: by 2002:ae9:e51a:: with SMTP id w26mr330809qkf.312.1584471509921;
        Tue, 17 Mar 2020 11:58:29 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::2])
        by smtp.gmail.com with ESMTPSA id n190sm2414707qkb.93.2020.03.17.11.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 11:58:29 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, dreamer.tan@gmail.com, peff@peff.net
Subject: [PATCH v2 1/3] dir: fix outdated comment on add_patterns()
Date:   Tue, 17 Mar 2020 15:57:43 -0300
Message-Id: <9de4c8cdee441be7d9bbef2a961a8ed7d423f448.1584471137.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584471137.git.matheus.bernardino@usp.br>
References: <cover.1584471137.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4b33e60 ("dir: convert struct sha1_stat to use object_id",
2018-01-28), the struct sha1_stat was converted to oid_stat. In this
process, add_patterns() also learned to use the new struct definition.
However, the comments in this function still refers to "ss" (i.e. the
old sha1_stat). Update that.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 0ffb1b3302..ab2e5b8717 100644
--- a/dir.c
+++ b/dir.c
@@ -1015,9 +1015,10 @@ static int add_patterns_from_buffer(char *buf, size_t size,
  * an index if 'istate' is non-null), parse it and store the
  * exclude rules in "pl".
  *
- * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
+ * If oid_stat is not NULL, compute OID of the exclude file and fill
  * stat data from disk (only valid if add_patterns returns zero). If
- * ss_valid is non-zero, "ss" must contain good value as input.
+ * oid_stat->valid is non-zero, oid_stat must contain good value as
+ * input.
  */
 static int add_patterns(const char *fname, const char *base, int baselen,
 			struct pattern_list *pl, struct index_state *istate,
@@ -1065,7 +1066,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			int pos;
 			if (oid_stat->valid &&
 			    !match_stat_data_racy(istate, &oid_stat->stat, &st))
-				; /* no content change, ss->sha1 still good */
+				; /* no content change, oid_stat->oid still good */
 			else if (istate &&
 				 (pos = index_name_pos(istate, fname, strlen(fname))) >= 0 &&
 				 !ce_stage(istate->cache[pos]) &&
-- 
2.25.1

