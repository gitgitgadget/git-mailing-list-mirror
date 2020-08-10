Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F9C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB29206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="LtFTgYsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgHJVe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:34:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD45C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:56 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p4so9885332qkf.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eM9FUx2sec1LsRUfqnljMBGrcrO2+jcyZTwQ95XJhww=;
        b=LtFTgYsmsjBKqXqB/vhINbdAjd5/JGC9a1kPqiuoCRI0vKuh4B3vr7oPc/OP55VdeQ
         OMWGErrA1D/hjEZFmH1hutWuxd6W+CI8q5OF7u+r0X+MW+KpvmWMcLiiqdT4NbEkeNIP
         M8YWPrmdFuUCMtC5Zto92xcfy3osZi/82oGlaFwE6yAc3874FCtvWLgz57VXjF7dWZsK
         m8buBS1WG4AJ5DOOIbQy7W+0Mz9vZ58JiB430SnkMPKHZd0h5mJE4Xa5UkCT4pGFDF+F
         Z/FKwRvaDUYhLGXyLg8610mjtCvTqXiXI7nP7h0YW+0Fzat4ZsneeSZbfVxP18GvJYRP
         Vecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eM9FUx2sec1LsRUfqnljMBGrcrO2+jcyZTwQ95XJhww=;
        b=FMAm4ZohxxozqTZawAZ7I0nIztQOmIDfkqyDULay33/EzBRCeC5tU8GjHcAtMy8UBi
         zAqLZ/dAb0769les0VLY5PhShnud5V/rHIC5FsS+YN259qN3tlCl+EY00reWsGjm0NqW
         cOB/MYrsGq+728A/fFTjL8ihiOtekuQmtnsFh4vMLs9Buyg6n2f5aiGBe7DV9/GgYIEZ
         9ESUrZlCqSXpDdpUcUgODPNYZpnWJxbtCbKRD0bJ7cNnwf/LGxsAAXcNcze0/+fIuoRB
         Z+/4KBZLFH6RpkdOgOqBxcAnCsg3upf9wC4nFsGwINdomOaOZGWDuscp5gQPSdvhah0m
         Ju/Q==
X-Gm-Message-State: AOAM530te6zLelVNRD4HGfG6mnWOBqHy39mdWCWTJiJHK5qJn1DUTQmq
        PAbL+ZZhaO8Jphcp298v2OiwI8QVC/M=
X-Google-Smtp-Source: ABdhPJxVj8VYggZBUbTmELpkJ1A0cmn8/xMMX7Dr8PjyhuK3Kq2AL1ry6M3mKAj5wcVb3pHe6dPuoA==
X-Received: by 2002:a05:620a:9d0:: with SMTP id y16mr28874383qky.353.1597095295625;
        Mon, 10 Aug 2020 14:34:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:34:54 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <benpeart@microsoft.com>
Subject: [RFC PATCH 07/21] entry: extract cache_entry update from write_entry()
Date:   Mon, 10 Aug 2020 18:33:15 -0300
Message-Id: <4b9e130278495aa7819e5cfd450b0b01d8b58b6d.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code will be used by the parallel checkout functions, outside
entry.c, so extract it to a public function.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 26 +++++++++++++++++---------
 entry.h |  2 ++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/entry.c b/entry.c
index cc27564473..837629a804 100644
--- a/entry.c
+++ b/entry.c
@@ -251,6 +251,19 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
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
+
 static int write_entry(struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
@@ -371,15 +384,10 @@ static int write_entry(struct cache_entry *ce,
 
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
2.27.0

