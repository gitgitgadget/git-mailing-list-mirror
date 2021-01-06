Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB22C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233DA2310C
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbhAFJCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbhAFJCr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 04:02:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA6C06134D
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 01:02:07 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 11so1348705pfu.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 01:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdLUcs3RHXTDanAA+JFePnfaSbgyLTYONomgKCN8nyY=;
        b=YxPPMI27+9AOBOzvJp6+DeWs4vT4W2WWREA2s3+WlIeDANMsKfdzkrDkfJ/BQRcYEG
         1XhYcg1qqm1OPP/JTmq7i2/8g60/IQTRVst4VgVabcFPk9dtooyClkRekVYes0PEX+NA
         1taGWn4ao+7BDOPUnLTNyOqfJdsU7BJpLKsi6mnFPj94875KdTrTOYVjRI642ppTskjX
         WK15zjKYuP57+Xh/SAZM+TA0QwnXjcFqvIHOluV1ujYze8Zz52vrAbf1hJtBM79HPW2c
         seHOPI4xpU/S9bC73Bga20EukBwYobvWp91BgHxqQGyJIeSqDrEIzGuqNf+ritvXB3Lr
         eXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdLUcs3RHXTDanAA+JFePnfaSbgyLTYONomgKCN8nyY=;
        b=WEzLOm+LIjNXUakKAES3NiZVQ/WYbyO0xUlRdK5zOCdGHFqQYzKJBajFrec0wbUf9K
         MBrvlvzUqLxSfRXz9D+0q5YZbo0gu9V08HL4zrXDh9g2CcOAdZ38nRQT6CPU8vQM2KK3
         EaQEBwx2fOFT5t546j+/9omqPPzQbog/R36j81kqkOeGv6n+xVIGdz67J7sjrzOXzsWt
         BAwH9uqNTRg6tYRuQEFHBVin1MdS4+Zosx1x767XiR6HXNXEKmSoOKNlui4JUBhIUqUo
         8ls3z0exFre2z7ahcAjl3KnpE8QTo8m1uWeylq/lUy/N86FKn984PPNarAR//2ksD9A/
         RKVQ==
X-Gm-Message-State: AOAM5312HZRx4bR5oRyTHOHtYBlMoCUGv2PAKxiH9b/2Y5Tr0UIpkDgg
        T+C7pY0nAGE9vhE7xmFuNF4/8AD7oTQ=
X-Google-Smtp-Source: ABdhPJzkNYX8vkGFYO47G7LQvo2oihMGj4pB4maNJjqnOJgyhkl0rf9NQBu1ukQuBWs1FW1EnByMfg==
X-Received: by 2002:a63:e1b:: with SMTP id d27mr3502071pgl.441.1609923726988;
        Wed, 06 Jan 2021 01:02:06 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id m10sm1561919pjn.53.2021.01.06.01.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 01:02:06 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] refs: factor out set_read_ref_cutoffs()
Date:   Wed,  6 Jan 2021 01:01:53 -0800
Message-Id: <8f14ec39970b6cbf9b6615485316063306706e6a.1609923643.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609923643.git.liu.denton@gmail.com>
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com> <cover.1609923643.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This block of code is duplicated twice. In a future commit, it will be
duplicated for a third time. Factor out the common functionality into
set_read_ref_cutoffs().

In the case of read_ref_at_ent(), we are incrementing `cb->reccnt` at the
beginning of the function. Move these to right before the return so that
the `cb->reccnt - 1` is changed to `cb->reccnt` and it can be cleanly
factored out into set_read_ref_cutoffs(). The duplication of the
increment statements will be removed in a future patch.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 refs.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 13dc2c3291..bfdd04aefd 100644
--- a/refs.c
+++ b/refs.c
@@ -882,25 +882,30 @@ struct read_ref_at_cb {
 	int *cutoff_cnt;
 };
 
+static void set_read_ref_cutoffs(struct read_ref_at_cb *cb,
+		timestamp_t timestamp, int tz, const char *message)
+{
+	if (cb->msg)
+		*cb->msg = xstrdup(message);
+	if (cb->cutoff_time)
+		*cb->cutoff_time = timestamp;
+	if (cb->cutoff_tz)
+		*cb->cutoff_tz = tz;
+	if (cb->cutoff_cnt)
+		*cb->cutoff_cnt = cb->reccnt;
+}
+
 static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		const char *email, timestamp_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
 
-	cb->reccnt++;
 	cb->tz = tz;
 	cb->date = timestamp;
 
 	if (timestamp <= cb->at_time || cb->cnt == 0) {
-		if (cb->msg)
-			*cb->msg = xstrdup(message);
-		if (cb->cutoff_time)
-			*cb->cutoff_time = timestamp;
-		if (cb->cutoff_tz)
-			*cb->cutoff_tz = tz;
-		if (cb->cutoff_cnt)
-			*cb->cutoff_cnt = cb->reccnt - 1;
+		set_read_ref_cutoffs(cb, timestamp, tz, message);
 		/*
 		 * we have not yet updated cb->[n|o]oid so they still
 		 * hold the values for the previous record.
@@ -917,11 +922,13 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 			warning(_("log for ref %s unexpectedly ended on %s"),
 				cb->refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
+		cb->reccnt++;
 		oidcpy(&cb->ooid, ooid);
 		oidcpy(&cb->noid, noid);
 		cb->found_it = 1;
 		return 1;
 	}
+	cb->reccnt++;
 	oidcpy(&cb->ooid, ooid);
 	oidcpy(&cb->noid, noid);
 	if (cb->cnt > 0)
@@ -935,14 +942,7 @@ static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid
 {
 	struct read_ref_at_cb *cb = cb_data;
 
-	if (cb->msg)
-		*cb->msg = xstrdup(message);
-	if (cb->cutoff_time)
-		*cb->cutoff_time = timestamp;
-	if (cb->cutoff_tz)
-		*cb->cutoff_tz = tz;
-	if (cb->cutoff_cnt)
-		*cb->cutoff_cnt = cb->reccnt;
+	set_read_ref_cutoffs(cb, timestamp, tz, message);
 	oidcpy(cb->oid, ooid);
 	if (is_null_oid(cb->oid))
 		oidcpy(cb->oid, noid);
-- 
2.30.0

