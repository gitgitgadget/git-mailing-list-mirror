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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640BCC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0CC61206
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbhDLRRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244016AbhDLRQY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96239C06134E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so8332861wma.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GM3w22/EA9Vygg7V9dviM0LetUvUWSl0IHXYhbF2vOE=;
        b=ILIMqWUUabOINA3EmZCphauS9WijuMaDw8fRuKKhf4SVmYTyjSQaPt0i7DkW+/i7uK
         cRoH8iSTwwnqa2anvsTUQaz2LaUcKR5HZ1HDACxlCD/e3L+IMR+CqQLlcBkggPkYFx04
         tm6P87YdOLmWlDBMbXgzidpaDljX09q+GXBJKhI7cPXyf6ZmTtI8zdwChSi1ohb13Swc
         6xEcHBqSn0WidePW1CWNkQcETMB97PjRroR94m8oZ+5dNHd2UwHx15E2GPUwFbZxP5wF
         6evynT1HnIEWi3ds5oi24dA0cd3F/s1Gy5oO7J6rBD76l9horXH++eBf5F9Y0UpeB1ak
         JFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GM3w22/EA9Vygg7V9dviM0LetUvUWSl0IHXYhbF2vOE=;
        b=Nk51OPeH/g2OqwrhqoKy62t6R9MeDV58GG0v7GWYW3FuGR9flO99oSjfEdED2im5ol
         aD96doaKlCdeMKHofmBMCh6FOHcu25CIhLBdC7tXT0QWWpbH4vECmTNxEEg9/TyBPI8h
         CaGaEQ91l5Twv73PqgqjiUjE926GwPsSMQGoBbmi1VkbfDlaiJ0Uj3ZB3mQxoc/7PWT5
         skdW8DgH53nTyUNl5f95PxHmXHIaPRarAfiVjNLtnGsGpb5/E98z3mrlDrBDuIVtX1Js
         ohURTK3EOoVF5hxxkJ6essjm7aluGcvfsdmSdHQhn4xrfSuBjXYSqhZrffpW3z0nlrGS
         yD1A==
X-Gm-Message-State: AOAM5316929rlxv6790m1z+vSwlWlYxkDZQRN0oq69GEXdJGumfo+nTq
        TojcKMzFlorp/qKeYfx50oo1R9DUIDihqg==
X-Google-Smtp-Source: ABdhPJzDknOBAWpgadSmUcSoMxHaBsDUdQ8O26sn5q0/uCT3JnRrFg9X39fo7Ft1cqsyyt8SGEtLeQ==
X-Received: by 2002:a05:600c:3590:: with SMTP id p16mr157935wmq.140.1618247752042;
        Mon, 12 Apr 2021 10:15:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 18/22] xdiff-interface: allow early return from xdiff_emit_line_fn
Date:   Mon, 12 Apr 2021 19:15:25 +0200
Message-Id: <patch-18.22-76d667f152f-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finish the change started in the preceding commit and allow an early
return from "xdiff_emit_line_fn" callbacks, this will allows
diffcore-pickaxe.c to save itself redundant work.

Our xdiff interface also had the limitation of not being able to abort
early since the beginning, see d9ea73e0564 (combine-diff: refactor
built-in xdiff interface., 2006-04-05). Although at that time
"xdiff_emit_line_fn" was called "xdiff_emit_consume_fn", and
"xdiff_emit_hunk_fn" didn't exist yet.

There was some work in this area of xdiff-interface.[ch] recently with
3b40a090fd4 (diff: avoid generating unused hunk header lines,
2018-11-02) and 7c61e25fbf1 (diff: use hunk callback for word-diff,
2018-11-02).

In combination those two changes allow us to not do any work on the
hunks and diff at all, but didn't change the status quo with regards
to consumers that e.g. want the diff lines, but might want to abort
early.

Whereas now we can abort e.g. on the first "-line" of a 1000 line diff
if that's all we needed.

This interface is rather scary as noted in the comment to
xdiff-interface.h being added here, as noted there a future change
could add more exit codes, and hack xdl_emit_diff() and friends to
ignore or skip things more selectively as a result.

I did not see an inherent reason for why xdl_emit_{diffrec,record}()
could not be changed to ferry the "xdiff_emit_line_fn" error code
upwards instead of returning -1 on all "ret < 0".

But doing so would require corresponding changes in xdl_emit_diff(),
xdl_diff(). I didn't see any issue with narrowly doing that to
accomplish what I needed here, but it would leave xdiff's own return
values in an inconsistent state.

Instead I've left it at returning a more conventional (for git's own
codebase) 1 for an early return, and translating it (or rather, all
non-zero) to -1 for xdiff's consumption.

The reason for most of the "stop" complexity in xdiff_outf() is
because we want to be able to abort early, but do so in a way that
doesn't skip the appropriate strbuf_reset() invocations.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff-interface.c | 18 ++++++++++++++----
 xdiff-interface.h | 17 +++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 5d8c8c67dc2..50c0ef759dd 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -37,9 +37,12 @@ static int consume_one(void *priv_, char *s, unsigned long size)
 	char *ep;
 	while (size) {
 		unsigned long this_size;
+		int ret;
 		ep = memchr(s, '\n', size);
 		this_size = (ep == NULL) ? size : (ep - s + 1);
-		priv->line_fn(priv->consume_callback_data, s, this_size);
+		ret = priv->line_fn(priv->consume_callback_data, s, this_size);
+		if (ret)
+			return ret;
 		size -= this_size;
 		s += this_size;
 	}
@@ -50,11 +53,14 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 {
 	struct xdiff_emit_state *priv = priv_;
 	int i;
+	int stop = 0;
 
 	if (!priv->line_fn)
 		return 0;
 
 	for (i = 0; i < nbuf; i++) {
+		if (stop)
+			return 1;
 		if (mb[i].ptr[mb[i].size-1] != '\n') {
 			/* Incomplete line */
 			strbuf_add(&priv->remainder, mb[i].ptr, mb[i].size);
@@ -63,17 +69,21 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 
 		/* we have a complete line */
 		if (!priv->remainder.len) {
-			consume_one(priv, mb[i].ptr, mb[i].size);
+			stop = consume_one(priv, mb[i].ptr, mb[i].size);
 			continue;
 		}
 		strbuf_add(&priv->remainder, mb[i].ptr, mb[i].size);
-		consume_one(priv, priv->remainder.buf, priv->remainder.len);
+		stop = consume_one(priv, priv->remainder.buf, priv->remainder.len);
 		strbuf_reset(&priv->remainder);
 	}
+	if (stop)
+		return -1;
 	if (priv->remainder.len) {
-		consume_one(priv, priv->remainder.buf, priv->remainder.len);
+		stop = consume_one(priv, priv->remainder.buf, priv->remainder.len);
 		strbuf_reset(&priv->remainder);
 	}
+	if (stop)
+		return -1;
 	return 0;
 }
 
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 0198f9632f5..7d1724abb64 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -11,6 +11,23 @@
  */
 #define MAX_XDIFF_SIZE (1024UL * 1024 * 1023)
 
+/**
+ * The `xdiff_emit_line_fn` function can return 1 to abort early, or 0
+ * to continue processing. Note that doing so is an all-or-nothing
+ * affair, as returning 1 will return all the way to the top-level,
+ * e.g. the xdi_diff_outf() call to generate the diff.
+ *
+ * Thus returning 1 means you won't be getting any more diff lines. If
+ * you need something in-between those two options you'll to use
+ * `xdl_emit_hunk_consume_func_t` and implement your own version of
+ * xdl_emit_diff().
+ *
+ * We may extend the interface in the future to understand other more
+ * granular return values. While you should return 1 to exit early,
+ * doing so will currently make your early return indistinguishable
+ * from an error internal to xdiff, xdiff itself will see that
+ * non-zero return and translate it to -1.
+ */
 typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
 typedef void (*xdiff_emit_hunk_fn)(void *data,
 				   long old_begin, long old_nr,
-- 
2.31.1.639.g3d04783866f

