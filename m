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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88151C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C85D2312F
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbhAGKiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 05:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbhAGKiO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 05:38:14 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3423AC0612FC
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 02:37:10 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g3so3284546plp.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdLUcs3RHXTDanAA+JFePnfaSbgyLTYONomgKCN8nyY=;
        b=IIKcrxK/yzdHoiEDXZf65PA0f6LvutURcAoh+eAf1aU+SZo4pjXAA9jZlcExUNwU+P
         I1CT7tFJwCMWze5jRGDeQEiqqwaIi8/w26A7ykXMZjgx0H+6Hcaue9Ua9sTA/bY3I9CJ
         gWEXdUfk68q+lUmMSQs8oZ0mkXP9kU6avRCDVGupqZwAIEGaDJc1nukUAxe+XVlFe5A2
         XXzK4JCCSffKcuWgo8X5Be8doTu/NZ2iGa7gUhj4vVCx6Tf+4QYtt/DWS5zn9fShrOdk
         VXLdlYtp2vhjr5S7HaU+71ijS8BiuqqmPNjlcaXGTVcg9dvIz0x/Qo+3RApXkI1Ta0Vj
         H4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdLUcs3RHXTDanAA+JFePnfaSbgyLTYONomgKCN8nyY=;
        b=sSa+6fjzI+EA9AqA2c1gDBinUuFDjl/iFCmn2tBTIDuIRHcYg2MqGRz3hAxzFejLBz
         rbWYVZ6nxxrPrOcverqABqEY6ll3KVwx3JnshvAENWdh95In8HTqCHBHlSmdxGQIj7yH
         vSILXijXWwgCDJj5OrZ1UtRarrCPH0xcGJBccrX4RyUDZi4xuhxqBVfDRlv9YgyDudS/
         4ibKGVmgVcyv7M2CLT3eMPW4fd+AhxXIoDTN/jEQjCjCyU+2cSE4YXeC/lNSaOkS43ua
         BCvitJIE+MOOjFeEQ4dKHcKeNNhgmfgS+2C7tYmrOl5Jd2zqZPWjpaMl+f2cDbVZrdjY
         DeCQ==
X-Gm-Message-State: AOAM531vI7f97Wc8wwctoED6Ld+qgQ+IQQNiAKA2+8iBybvRK25JPPsZ
        B0ZCDIBLDUiIwBdHw8E9F9kG3Ivy2aI=
X-Google-Smtp-Source: ABdhPJxtqSf7hsuyOYyO7eN2LOoSSLXzX8Xr+FpwJBFUaY2FIIzlVI+dlyKOsDPH4F4CU3K8OgmnHg==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr7854478pjb.199.1610015829509;
        Thu, 07 Jan 2021 02:37:09 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id bg20sm1777416pjb.6.2021.01.07.02.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:37:08 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] refs: factor out set_read_ref_cutoffs()
Date:   Thu,  7 Jan 2021 02:36:58 -0800
Message-Id: <8f14ec39970b6cbf9b6615485316063306706e6a.1610015769.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610015769.git.liu.denton@gmail.com>
References: <cover.1609923643.git.liu.denton@gmail.com> <cover.1610015769.git.liu.denton@gmail.com>
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

