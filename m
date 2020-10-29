Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50394C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DDF2076B
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="wFVOJhnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbgJ2CQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbgJ2CPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB62C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:47 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t20so757464qvv.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nN6bJrj4N/km2e+ROlSwUAEO25dq+vCA518kUob9Gws=;
        b=wFVOJhnl6iHEsSMayaEubiH7SFMOUli/rkv9VTIFRr1F7RIP+ZG2xh6tGrgROjRFmC
         jqfmL81Bto6x3xQEQ6fKHVTuwqwZOKxYy11B8Td4djjf/h2q29pXhzmhWYCDWPQIeX1y
         tI+RP32DOQGRze8u1YfWcUM4TJcazET0OlklVIV1KakiV7OtSaYIewpLvObu+mFl5Fu4
         ZNfixdQ7QsiSUbhGKDWobEHKKgmUeriDhWi0IqRb9R+NLvrkz2UklRZudkhZsCA1iRMJ
         zEx1zLQh7qSQXIFmTUYlKqG0Pngxy/i0GgjK6xy7bSo2Bekz83FsKOgqv413YeabldYp
         UDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nN6bJrj4N/km2e+ROlSwUAEO25dq+vCA518kUob9Gws=;
        b=HUdyITzgMZtzmrAu/+ahblR3qFClU9pxr5ClWaZDm4pt6W2KqG2EF0IC0yH2sG6oQr
         846aiWVYfl9vJKKbMtR3pUtWkP8BU6t1/ZEpxJ2bBvKii6JfJLTxjdPdYKHLCiDNT5In
         0kFKttjk8TayDkq6Sw+nwJxwGMdm4caW9eruondolDG7K4i9uGfb1o685wtxO5Gw4FLR
         jdv2yGm5rvJdZu+IWUX8ossKJPUuzz893CP5/Ghl8t/rzQE4TMFwAWlMtwNoYA6AVtcL
         /oXoeXSsYOrYRKxNxFtKJFym644XYuk8RkPTEoYjsa4tgHPeFZ7O3SsHS0NiZuIi1nMC
         hTBw==
X-Gm-Message-State: AOAM533zXYoe8kSIe1TcE3xep+IVhtPSJaack/CNO9ukRNNXk5IraFC7
        fUFs15dPMdSs9CO/bDgxeR6MXZVvLvGrJw==
X-Google-Smtp-Source: ABdhPJyT4bieDGlyv5BE/Q707KWsuubgLgSo+N6Mj50e+sX1KMa0QDibZPuvlCVzw4qao0EbbIcLPg==
X-Received: by 2002:a0c:b2c6:: with SMTP id d6mr2474795qvf.38.1603937746420;
        Wed, 28 Oct 2020 19:15:46 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:45 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 07/19] entry: extract cache_entry update from write_entry()
Date:   Wed, 28 Oct 2020 23:14:44 -0300
Message-Id: <91ef17f533e6ed8ba2410ca6b966f06ca40973bb.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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

