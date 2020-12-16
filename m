Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC346C2BBCF
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F75A23407
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgLPOwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgLPOwR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:52:17 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC7FC061248
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:19 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id u21so17313642qtw.11
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ke/NvkM355z48YS6G4lDF36Qx2Gzpv7OGCXzNnG+leM=;
        b=yAaxyJ/kkmHnUJKBOJ0cLh2Cp4J+XTK95TtSRbBPX5saCG6Fmwqte66XT6ikBi/Bla
         HAx9XV0D0WAM+SuD0XwjvWgJVIlXBQgZ2K5FRpwvxL+88QhPFrOivs3TvdFr4+u4HE1S
         vFB/IsFsQo950ETSrq5KSNs0n72Tyj+rrZJa40WaDSz8JwiwWu7tuSiUGsbC3qL5VvQp
         o3GxMeJ3BP1d4AqatAif/cnOFRIyMwDmUUF/f8G4acVTRynWXN9Djz2phFCvezayFs6x
         TtgkLy8X7KoH0OnsNGTaExWdGRX2i2X8M9mCCicpywNaSj6e1Kkxzry4gVI8xRrAvMM0
         RHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ke/NvkM355z48YS6G4lDF36Qx2Gzpv7OGCXzNnG+leM=;
        b=Nwio+qkrp7mpSLiTp4goGbGWB6i89/gurepEaqA2u9l+65xNI4FON7q5ukjy99oyR3
         J6evRxwo/zn87/1OouvknHtL871ZegjOGmi1ibh8IUgdmAZF3h+bGrwl2RPWzOW+yS4N
         t6XTyEiqkq9KzCDnDMsq85dM5f7Pkdd1WubtJlm0yqJPkDkfbR+8UzBCp7ikWi22BF4B
         AHWQuF/epMit/vhhNSsM8nHFLk9T6kR3xFW1CfKSMuE0ljBWHXQcsFcXedGztrQANyyy
         T6Qi7PHOhml4ihX0VA8xgV3mo9bg1gvFlzrnNnkAD06DRJ0SZnwMTn3ulpK6zk6a+J27
         aWjg==
X-Gm-Message-State: AOAM533JZSZemoTLQqKSfKHJwWv+JHzve7cDJlCMQxsDk6SzOgdvVmnW
        4E3Knr4G+w1uSfQP6dxx5M45CKSrcmH/3w==
X-Google-Smtp-Source: ABdhPJyIlCZjVYji0Vy/VkjWpWz4OgfT5mj97fvri0HrNve8fiZaVWQp/37fC5XoQudx/5sOch/ogA==
X-Received: by 2002:ac8:4648:: with SMTP id f8mr42265126qto.5.1608130278474;
        Wed, 16 Dec 2020 06:51:18 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:51:17 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com
Subject: [PATCH v5 7/9] entry: extract update_ce_after_write() from write_entry()
Date:   Wed, 16 Dec 2020 11:50:36 -0300
Message-Id: <def654606d1ec8aef0d3807db15ebe259a30ac68.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code that updates the in-memory index information after an entry is
written currently resides in write_entry(). Extract it to a public
function so that it can be called by the parallel checkout functions,
outside entry.c, in a later patch.

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
index 60df93ca78..ea7290bcd5 100644
--- a/entry.h
+++ b/entry.h
@@ -41,5 +41,7 @@ void unlink_entry(const struct cache_entry *ce);
 
 void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
 int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
+void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
+			   struct stat *st);
 
 #endif /* ENTRY_H */
-- 
2.29.2

