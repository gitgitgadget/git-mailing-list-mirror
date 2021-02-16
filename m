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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087E7C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B598464DFF
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhBPMEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhBPMBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:01:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE044C061221
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id x16so538160wmk.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+uixrS/rljvjvSC0UQsEDLMcnfCGT/6YAugBuqcb9M=;
        b=dXZcfZ4QhI5ZvdZm9KmXlSE6BAB8jnozIFNh/mCVdU/iiFwrWVoEHSHtknCYEZvPKc
         MgWH+0DriSOgxLXXv1t+/RTxqRsR6Y9euG4rvtDLCWd5GyRxntL3edx8iXuNdu/a3KlM
         ntS8brJ+ZeEqI0pnSlzDLfwn3kHTr8gK6owFzB+jH9lvn/JpX3Wxe+IYkRx3LmYIBXM8
         UbzWFMEvAhmPstWqQ30ihh73kgco7gXnUlojPMhzxBooDoUC8OCF2rXi6o3eW24ISRy0
         JTDF1fQtOFvWIxHCxUboirCNAJrHRUa82Jzf83N4Xz5ippkcMhDnIimj5iRvBTJbCq6k
         QMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+uixrS/rljvjvSC0UQsEDLMcnfCGT/6YAugBuqcb9M=;
        b=UkFS+0eguEwkM+SPHvefK/G9AwJzKv4nyZY5Nfy7uibLAiZSFNa9JKCE9M+HFdIbXq
         5AEvza3AEuPneotsJJylwCuhmdpO/zEDOkRPa99+S4BXsUl3a93x/5va5LXa/IcjOIos
         gxJy9rGQjw7MwnTEyVVIY2eqLTQN7n77F/mHb2KR1sXZUE8+CP3BFgXp9BWrQl9hyq9v
         7DfNaOub8Q8GhoINhpO4wlzj+2FeaLRQzOBr6lWYQA+V7jGZWaLz91W5lVLY1GRoj4DY
         p2VZtykNWPlb1SAWzHrrLIgumalccRO2/I9NwTZ0pP0Op4WtwuMg5kk1TTkWUptmmycx
         tV2g==
X-Gm-Message-State: AOAM5303LnPyNZKL+yrYzQnQtKkv9HDwwV7cbdKfrcrKN0NY9t+5FxvT
        +kZ2iDpC/9XLN0xvQ33kPQm2gwCGd2IIog==
X-Google-Smtp-Source: ABdhPJwjC4qWq0uzKOsCf4mNhE1lCP70uwEVrHA7PEiw53r54Lc+FqWh/VrsYY5/+gA2j3j5cnIqYA==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr3075913wmj.96.1613476711057;
        Tue, 16 Feb 2021 03:58:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 21/22] pickaxe -G: terminate early on matching lines
Date:   Tue, 16 Feb 2021 12:58:00 +0100
Message-Id: <20210216115801.4773-22-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Solve a long-standing item for "git log -Grx" of us e.g. finding "+
str" in the diff context and noting that we had a "hit", but xdiff
diligently continuing to generate and spew the rest of the diff at us.

The TODO item has been there since "git log -G" was implemented. See
f506b8e8b5f (git log/diff: add -G<regexp> that greps in the patch
text, 2010-08-23).

Our xdiff interface also had the limitation of not being able to abort
early since the beginning, see d9ea73e0564 (combine-diff: refactor
built-in xdiff interface., 2006-04-05). Although at that time
"xdiff_emit_line_fn" was called "xdiff_emit_consume_fn", and
"xdiff_emit_hunk_fn" didn't exist yet.

But now with the support added in the preceding ""xdiff-interface:
allow early return from xdiff_emit_{line,hunk}_fn" commit we can
return early, and furthermore test the functionality of the new
early-exit xdiff-interface by having a BUG() call here to die if it
ever starts handing us needless work again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 31 ++++++++++++++++++++-----------
 xdiff-interface.h  |  5 +++++
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 94601072bde..f11b38b7121 100644
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
+		return -1;
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
@@ -63,10 +63,19 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
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
+	 * comment for xdiff_emit_{line,hunk}_fn in xdiff-interface.h
+	 * for why.
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
index 1b27d6104ce..347d8a4425f 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -25,6 +25,11 @@
  * granular return values, but for now use it carefully, or consider
  * e.g. using discard_hunk_line() if you say just don't care about
  * hunk headers.
+ *
+ * Note that just returning -1 will make your early return
+ * indistinguishable from an error internal to xdiff. See "diff_grep"
+ * in diffcore-pickaxe.c for a trick to work around this, i.e. using
+ * the "consume_callback_data" to note the desired early return.
  */
 typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
 typedef int (*xdiff_emit_hunk_fn)(void *data,
-- 
2.30.0.284.gd98b1dd5eaa7

