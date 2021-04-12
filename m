Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90842C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7010861206
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244289AbhDLRRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244044AbhDLRQY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481DC06134F
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h4so4702860wrt.12
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4g4zkBFclK/dJVd1IEGEqwg97RwzW49Nxm5byI7uQM0=;
        b=BSO+VKeVlD7WGdEfUdBbrzHAvVchzbcX2hfn9PztcJgALtlh+mNvwBslx/DCJyLwjD
         kaYSewg4VCYol1yx5lJpT2uKZTtFRrhQeK3Yg9WpnzZwkdBnxrkoLab7RXHV+3zmwnyu
         oc0bH9uGOo9kratpgnEMPXOVTQfe65AL/S9SGewGw8YYPKcdLdzWKoD/q7tpo08LaxBL
         sK6H2BX2uqp9TwO/+Gsmf6tb++qvIZys1LSnL6PiRryRujov6/HJnAO+LA5Nje5QzktN
         QB4Sjoph3q6CgJYPq8ylSWkp+o5ET6t2CF/esONgvDcSvIrgbBXCBg6Bp+VAAOKlZjS6
         yrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4g4zkBFclK/dJVd1IEGEqwg97RwzW49Nxm5byI7uQM0=;
        b=ZIbO5IIyI685u82rXN8Q6RIi6b3GRV/yP514V3vZByODE4UXVEYT3f9X5oMXETANNP
         KP7k2ugn6lz4bntBOukZY+uVXTfRUDlAugug7RLSgmSo4qMKS/EexA6MWYh9w4tf0iqw
         u42BVR+dNFnTpp4hgYO5QBMDlTRat+AyaqoVreU+EGtgamERDPTr7Xzm+oIr26906oJ9
         WjCONhDNqJvDN9bZ8+C/wY8mYkPBePMmrokrnXU/6m+bM8ktpAMNDtomsrXFgoZBS3cy
         s+hLbo51H94Z7JBbd+KO5T5AlbC+jaBNlxre0VLqWljut5/2K3Ll9Il6oU3SOxuSBm6u
         DKBw==
X-Gm-Message-State: AOAM530QMhKHZAu/SqOkyEaTvyBASHvUHrPrufETE9hMyzt8GXuFenTn
        rnj4HObkfEqzmSlFJpV654YOe32upaW2yA==
X-Google-Smtp-Source: ABdhPJxpVXDmJEThActEFwzX/sEMis2DUn4dY4m9WWc2Vk0c9vq9h+RIxu2uaFke1jCrJI74GcohWg==
X-Received: by 2002:a5d:5083:: with SMTP id a3mr32873527wrt.157.1618247752978;
        Mon, 12 Apr 2021 10:15:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 19/22] pickaxe -G: terminate early on matching lines
Date:   Mon, 12 Apr 2021 19:15:26 +0200
Message-Id: <patch-19.22-53e9405f849-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Solve a long-standing item for "git log -Grx" of us e.g. finding "+
str" in the diff context and noting that we had a "hit", but xdiff
diligently continuing to generate and spew the rest of the diff at
us. This makes use of a new "early return" xdiff interface added by
preceding commits.

The TODO item (or, the NEEDSWORK comment) has been there since "git
log -G" was implemented. See f506b8e8b5f (git log/diff: add -G<regexp>
that greps in the patch text, 2010-08-23).

But now with the support added in the preceding changes to the
xdiff-interface we can return early. Let's assert the behavior of that
new early-return xdiff-interface by having a BUG() call here to die if
it ever starts handing us needless work again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 30 +++++++++++++++++++-----------
 xdiff-interface.h  |  4 ++++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 27aa20be350..2147afef722 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -27,13 +27,12 @@ static int diffgrep_consume(void *priv, char *line, unsigned long len)
 	if (line[0] != '+' && line[0] != '-')
 		return 0;
 	if (data->hit)
-		/*
-		 * NEEDSWORK: we should have a way to terminate the
-		 * caller early.
-		 */
-		return 0;
-	data->hit = !regexec_buf(data->regexp, line + 1, len - 1, 1,
-				 &regmatch, 0);
+		BUG("Already matched in diffgrep_consume! Broken xdiff_emit_line_fn?");
+	if (!regexec_buf(data->regexp, line + 1, len - 1, 1,
+			 &regmatch, 0)) {
+		data->hit = 1;
+		return 1;
+	}
 	return 0;
 }
 
@@ -45,6 +44,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	struct diffgrep_cb ecbdata;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
+	int ret;
 
 	if (!one)
 		return !regexec_buf(regexp, two->ptr, two->size,
@@ -63,10 +63,18 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	ecbdata.hit = 0;
 	xecfg.ctxlen = o->context;
 	xecfg.interhunkctxlen = o->interhunkcontext;
-	if (xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
-			  &ecbdata, &xpp, &xecfg))
-		return 0;
-	return ecbdata.hit;
+
+	/*
+	 * An xdiff error might be our "data->hit" from above. See the
+	 * comment for xdiff_emit_line_fn in xdiff-interface.h
+	 */
+	ret = xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
+			    &ecbdata, &xpp, &xecfg);
+	if (ecbdata.hit)
+		return 1;
+	if (ret)
+		return ret;
+	return 0;
 }
 
 static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws,
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 7d1724abb64..3b6819586da 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -27,6 +27,10 @@
  * doing so will currently make your early return indistinguishable
  * from an error internal to xdiff, xdiff itself will see that
  * non-zero return and translate it to -1.
+ *
+ * See "diff_grep" in diffcore-pickaxe.c for a trick to work around
+ * this, i.e. using the "consume_callback_data" to note the desired
+ * early return.
  */
 typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
 typedef void (*xdiff_emit_hunk_fn)(void *data,
-- 
2.31.1.639.g3d04783866f

