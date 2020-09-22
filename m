Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C92C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F632071A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="DSWYjfsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgIVWuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIVWuz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:50:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2754DC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:55 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c62so7738256qke.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nN6bJrj4N/km2e+ROlSwUAEO25dq+vCA518kUob9Gws=;
        b=DSWYjfsM1pMKxC/dfA4rKmfvnWF3WO35lufTiVPQPvTU1l7HeP5zzDNCLKqmJiarOV
         3WzD32JoQbDdiGk5cg/DnwLoIAfzkd4mgV78mmiddALLk/UcvJHgxl4G1TwwpfCC9uqK
         k+aTHe5kCgtWZ4rLuHKyz1Oes4lMhtKCJQY1NxMcjFLMvghDZRlHDqbj+h5x+9C+eRWw
         We7jDFwlmp/OQAv1lo7KkgsT8F0un2n+DYRgCkPpy+zf6bZ9tfQIt5Xja//yj85oo0oP
         SR4zqiOQtEJ+nGnJI5RvXpKHEiR0pTH4K2eECrxzvoQgp8aaeeuNHXXrHhYVxtuIUs5l
         kmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nN6bJrj4N/km2e+ROlSwUAEO25dq+vCA518kUob9Gws=;
        b=tPKWmSrvG41WfysvgRgMQm/qL9W0C1oIXV9zHwtSUx3XJkB76qQvhfZbEquz5LZch5
         QMikBtul+aZAfSWYjYAnnwp0FPECuTqjhqn0H/vrVmn2oR0HAZis032tPzruuq+xP6Rq
         W2OHyNHX6tB0rVZVNVlWkFoxoFNtWYiUv4iqeAbtCgfVr72OkhJuhrRRmD4OlmMK8WOm
         Ju2tS+RDJ5hc7ZMDulz33CfStzDN8aCCYqqQN1Njmwu00fjJyA4uuHS4qdet0bH13yui
         kVcFY+eUXFMgMIGNzo6g4P6R4tKwxmogkMLhycb3nD7/yF/qCHsvW1jUvYrZEfZoM34W
         At4Q==
X-Gm-Message-State: AOAM530f8KRX2uP7HRLFpK5vitZRLGSA+o35KhXGo95vBzOhvNWJbQDb
        xNXLo0eYYTNDPMtxWWHPxzcWGkoJFE6apw==
X-Google-Smtp-Source: ABdhPJzUeBHdRPpZbtwIDOnsnC1rh7iMMggl0THUMSRYnqxANmhYffLDzRLdSoEQyMPJmrMS+kD0bQ==
X-Received: by 2002:a05:620a:a09:: with SMTP id i9mr6593058qka.201.1600815054033;
        Tue, 22 Sep 2020 15:50:54 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:50:53 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 07/19] entry: extract cache_entry update from write_entry()
Date:   Tue, 22 Sep 2020 19:49:21 -0300
Message-Id: <b61b5c44f03819ea797727021261d54822b5f9ad.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code will be used by the parallel checkout functions, outside
entry.c, so extract it to a public function.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 25 ++++++++++++++++---------
 entry.h |  2 ++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/entry.c b/entry.c
index b36071a610..1d2df188e5 100644
--- a/entry.c
+++ b/entry.c
@@ -251,6 +251,18 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 	return errs;
 }
 
+void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
+			   struct stat *st)
+{
+	if (state->refresh_cache) {
+		assert(state->istate);
+		fill_stat_cache_info(state->istate, ce, st);
+		ce->ce_flags |= CE_UPDATE_IN_BASE;
+		mark_fsmonitor_invalid(state->istate, ce);
+		state->istate->cache_changed |= CE_ENTRY_CHANGED;
+	}
+}
+
 static int write_entry(struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
@@ -371,15 +383,10 @@ static int write_entry(struct cache_entry *ce,
 
 finish:
 	if (state->refresh_cache) {
-		assert(state->istate);
-		if (!fstat_done)
-			if (lstat(ce->name, &st) < 0)
-				return error_errno("unable to stat just-written file %s",
-						   ce->name);
-		fill_stat_cache_info(state->istate, ce, &st);
-		ce->ce_flags |= CE_UPDATE_IN_BASE;
-		mark_fsmonitor_invalid(state->istate, ce);
-		state->istate->cache_changed |= CE_ENTRY_CHANGED;
+		if (!fstat_done && lstat(ce->name, &st) < 0)
+			return error_errno("unable to stat just-written file %s",
+					   ce->name);
+		update_ce_after_write(state, ce , &st);
 	}
 delayed:
 	return 0;
diff --git a/entry.h b/entry.h
index f860e60846..664aed1576 100644
--- a/entry.h
+++ b/entry.h
@@ -39,5 +39,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
 void unlink_entry(const struct cache_entry *ce);
 void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
 int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
+void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
+			   struct stat *st);
 
 #endif /* ENTRY_H */
-- 
2.28.0

