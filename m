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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734BAC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5030161278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbhDLRRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbhDLRQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18308C061357
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so6639986wmg.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBQByfbMpWAYJQjKShuk4G/TDV40HLdbWDi7X12cOI0=;
        b=AzF+PAAhmVBbkmlcF7OivKX8cNB6ESLuodiFDA4lJKPUmxtE66+PqHuTH3/rrV7Ubp
         yfNf4ng+eyJYr7YjgW+1zRPLFIFYb564BIaecwWUwWbGMpy0oxZQxFVnyxk8enoRY/6t
         gAfT0nAaMzXnFCqQM6Hva8UDop3ZTDW/Fx4K/S1Jrty21omwWyiyKa5ppfffx6NC4B4P
         oDTeWrQzZuAJmId16+BA1+UhFKYMC5/C92xUNHRxzgmad/DmCvzI4PvNBLR5DoYWCrAR
         m/fMK0gw2OLChJzoh5/jd4obWXqluKnnvZYJ1Ru0G9GKI1V3hMNBGaMJjySJjTvw7pd/
         mFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBQByfbMpWAYJQjKShuk4G/TDV40HLdbWDi7X12cOI0=;
        b=HOY67wrq2xfOCQ/A8kHvu4ghr4Cxa6reV53C80U6sYoNrjO8EADh4L6PCcfH6O8bfa
         ZZxAcxxtjaQt018OAcH+y2P2NBPkCjPJ44sJJ/NVxijA1dNDk0tuHl0bw/ZOkf0NB63R
         6UHATObJ1xHBYcGcM1Mtw3n6hTwerC7k2RHId/HKWzi/pRjfVVEuk/eDLfCh5pKHTbya
         Fm1QvwALhS2moJ1g+j2qpC0bos1bIvbtNNgLkdYZoK2pXoypBvFQit1ZHCczLaQUwq6O
         UNEhUOrwroLaUxBTEpiQ0Ho7bvHpGm/NTaz4a4cQxLD7DZzop4i3y3Jdr/bny8DJIqHN
         veAg==
X-Gm-Message-State: AOAM530G6dj0uXGweyG7eHdN8CT6hrwIGEwuA9cSLmm1r1/8IHzaR3kG
        UKod6lY7+deVYlX8zfD9vsTv0BtEdsSiRg==
X-Google-Smtp-Source: ABdhPJx6Py9pOguyMBsUAphO90Gr3wjx1h05oQV2lN2QlRKm1CLxsrrIPdO+Hz1TtMS3XiE4VxcL8g==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr173550wmo.68.1618247755609;
        Mon, 12 Apr 2021 10:15:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 22/22] xdiff-interface: replace discard_hunk_line() with a flag
Date:   Mon, 12 Apr 2021 19:15:29 +0200
Message-Id: <patch-22.22-1178956fb3d-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the dummy discard_hunk_line() function added in
3b40a090fd4 (diff: avoid generating unused hunk header lines,
2018-11-02) in favor of having a new XDL_EMIT_NO_HUNK_HDR flag, for
use along with the two existing and similar XDL_EMIT_* flags.

Unlike the recently amended xdiff_emit_line_fn interface which'll be
called in a loop in xdl_emit_diff(), the hunk header is only emitted
once.

It makes more sense to pass this as a flag than provide a dummy
callback because that function may be able to skip doing certain work
if it knows the caller is doing nothing with the hunk header.

It would be possible to do so in the case of -U0 now, but the benefit
of doing so is so small that I haven't bothered. But this leaves the
door open to that, and more importantly makes the API use more
intuitive.

The reason we're putting a flag in the gap between 1<<0 and 1<<2 is
that the old 1<<1 flag was removed in 907681e940d (xdiff: drop
XDL_EMIT_COMMON, 2016-02-23) without re-ordering the remaining flags.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c             | 7 ++++---
 diffcore-pickaxe.c | 3 ++-
 xdiff-interface.c  | 6 ------
 xdiff-interface.h  | 8 --------
 xdiff/xdiff.h      | 1 +
 xdiff/xemit.c      | 3 ++-
 6 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/diff.c b/diff.c
index 7a03c581c79..fe3abac79fe 100644
--- a/diff.c
+++ b/diff.c
@@ -3725,7 +3725,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xpp.anchors_nr = o->anchors_nr;
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
-		if (xdi_diff_outf(&mf1, &mf2, discard_hunk_line,
+		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
+		if (xdi_diff_outf(&mf1, &mf2, NULL,
 				  diffstat_consume, diffstat, &xpp, &xecfg))
 			die("unable to generate diffstat for %s", one->path);
 
@@ -6233,8 +6234,8 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 
 		xpp.flags = 0;
 		xecfg.ctxlen = 3;
-		xecfg.flags = 0;
-		if (xdi_diff_outf(&mf1, &mf2, discard_hunk_line,
+		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
+		if (xdi_diff_outf(&mf1, &mf2, NULL,
 				  patch_id_consume, &data, &xpp, &xecfg))
 			return error("unable to generate patch-id diff for %s",
 				     p->one->path);
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 96183f4cfab..c88e50c6329 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -53,6 +53,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	memset(&xecfg, 0, sizeof(xecfg));
 	ecbdata.regexp = regexp;
 	ecbdata.hit = 0;
+	xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
 	xecfg.ctxlen = o->context;
 	xecfg.interhunkctxlen = o->interhunkcontext;
 
@@ -60,7 +61,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	 * An xdiff error might be our "data->hit" from above. See the
 	 * comment for xdiff_emit_line_fn in xdiff-interface.h
 	 */
-	ret = xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
+	ret = xdi_diff_outf(one, two, NULL, diffgrep_consume,
 			    &ecbdata, &xpp, &xecfg);
 	if (ecbdata.hit)
 		return 1;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 50c0ef759dd..95f13a93ff9 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -126,12 +126,6 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 	return xdl_diff(&a, &b, xpp, xecfg, xecb);
 }
 
-void discard_hunk_line(void *priv,
-		       long ob, long on, long nb, long nn,
-		       const char *func, long funclen)
-{
-}
-
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_hunk_fn hunk_fn,
 		  xdiff_emit_line_fn line_fn,
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 3b6819586da..4301a7eef27 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -53,14 +53,6 @@ void xdiff_clear_find_func(xdemitconf_t *xecfg);
 int git_xmerge_config(const char *var, const char *value, void *cb);
 extern int git_xmerge_style;
 
-/*
- * Can be used as a no-op hunk_fn for xdi_diff_outf(), since a NULL
- * one just sends the hunk line to the line_fn callback).
- */
-void discard_hunk_line(void *priv,
-		       long ob, long on, long nb, long nn,
-		       const char *func, long funclen);
-
 /*
  * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
  * Returns 1 if the strings are deemed equal, 0 otherwise.
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 7a046051468..b29deca5de8 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -50,6 +50,7 @@ extern "C" {
 
 /* xdemitconf_t.flags */
 #define XDL_EMIT_FUNCNAMES (1 << 0)
+#define XDL_EMIT_NO_HUNK_HDR (1 << 1)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
 /* merge simplification levels */
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 9d7d6c50874..1cbf2b9829e 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -278,7 +278,8 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 				      s1 - 1, funclineprev);
 			funclineprev = s1 - 1;
 		}
-		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
+		if (!(xecfg->flags & XDL_EMIT_NO_HUNK_HDR) &&
+		    xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
 				      func_line.buf, func_line.len, ecb) < 0)
 			return -1;
 
-- 
2.31.1.639.g3d04783866f

