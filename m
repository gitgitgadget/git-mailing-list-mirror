Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F81C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 14:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiGHOVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbiGHOUy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 10:20:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604F22C126
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 07:20:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q9so30762748wrd.8
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kK05ySLlHXevAX+06icRmA94Eu/2FwHXfFeZ+orFlqw=;
        b=Y0YugUoYaLlCXEmyS0U9IRJUfbBjnyQlIGD2V9QjtdxIv88ZO9uOLtCiYFBM0Ov822
         5N2IUNuM/s1OpbxTjTS1NJH488usnKILMkpxJhrV1JeliQ65rHxG96rjTAZcaltG3AVm
         i2dceyzEqJifTByHNzDESXIkB2jBCsPfc0rOiXuvtIeerAMT6XB4jZbmSH3yiuPvd9e8
         fEmXUh9m7vLqiInq97asaCyG/7TIoOrMzHPEt9VlkObaBS5IWO79CfHf1i58Z1kr23kJ
         gqydYsHV6ZJRK7c5fOnb0RtuLjYmklcuo0W/tZVfGL7+gregqVbH94aeRvJGOF6APqq2
         XuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kK05ySLlHXevAX+06icRmA94Eu/2FwHXfFeZ+orFlqw=;
        b=w319FJh7+VjaKVjbc0wBjATbirHWBtCfdtnvWP6SxBQxy7KZakewO9i99Z81TEXySM
         N4vhd+u4NSZQW61ZuEfKdNl3ePLd7dz+Yu9fuDwaK5Hogzu6OZXfRBP9GozMi01RnrKd
         1CaLFudJoVSYTgs0aVZJNhn9NYgZEy3uOTrWfD4JlrvzOLHpJrhfR0wd44CsnR39UDt3
         dd3NRJ/pOyEre7MvXSWFVekS1PzHt12TW37GMSjK3D9x5RZVwYIxNC6TRg+5q3w40OmI
         Vpi2LXmCugTolzSm9ilK9QEvn8FxsQfoIfZv62Hr2MTgDGn73Rt/qEeaPce3FKRZfrOC
         mA5g==
X-Gm-Message-State: AJIora8JzIzjaC7mZF+LtF38BkXU+MutXp3TSz9shpNASJDgzMhGJo8+
        VRUpeIQ15FFMTeKX1F8kZNtefP8v40PgTA==
X-Google-Smtp-Source: AGRyM1uXakj9vkuBwO8gN3/AufQWt+I9yfyjiB0YKu7PDNdx6FEbrp+CgzSvANqMWCn5S6fxTW/l+w==
X-Received: by 2002:a5d:584f:0:b0:21b:a557:98fa with SMTP id i15-20020a5d584f000000b0021ba55798famr3522336wrf.462.1657290039575;
        Fri, 08 Jul 2022 07:20:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm40393924wrr.101.2022.07.08.07.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:20:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/7] xdiff: remove xdl_free(), use free() instead
Date:   Fri,  8 Jul 2022 16:20:19 +0200
Message-Id: <patch-7.7-a1bf9a94f0a-20220708T140354Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com> <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the xdl_free() wrapper macro in favor of using free()
directly. The wrapper macro was brought in with the initial import of
xdiff/ in 3443546f6ef (Use a *real* built-in diff generator,
2006-03-24).

As subsequent discussions on the topic[1] have made clear there's no
reason to use this wrapper. Both git itself as well as any external
users such as libgit2 compile the xdiff/* code as part of their own
compilation, and can thus find the right malloc() and free() at
link-time.

When compiling git we already find a custom malloc() and free()
e.g. if compiled with USE_NED_ALLOCATOR=YesPlease.

1. https://lore.kernel.org/git/220415.867d7qbaad.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xdiff.h      |  3 ---
 xdiff/xdiffi.c     |  4 ++--
 xdiff/xhistogram.c |  6 +++---
 xdiff/xpatience.c  |  8 ++++----
 xdiff/xprepare.c   | 28 ++++++++++++++--------------
 xdiff/xutils.c     |  2 +-
 6 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index df048e0099b..a37d89fcdaf 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -118,9 +118,6 @@ typedef struct s_bdiffparam {
 	long bsize;
 } bdiffparam_t;
 
-
-#define xdl_free(ptr) free(ptr)
-
 void *xdl_mmfile_first(mmfile_t *mmf, long *size);
 long xdl_mmfile_size(mmfile_t *mmf);
 
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 6590811634f..375bb81a8aa 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -359,7 +359,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	res = xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
 			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
 			   &xenv);
-	xdl_free(kvd);
+	free(kvd);
 
 	return res;
 }
@@ -960,7 +960,7 @@ void xdl_free_script(xdchange_t *xscr) {
 
 	while ((xch = xscr) != NULL) {
 		xscr = xscr->next;
-		xdl_free(xch);
+		free(xch);
 	}
 }
 
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index f20592bfbdd..be35d9c9697 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -240,9 +240,9 @@ static int fall_back_to_classic_diff(xpparam_t const *xpp, xdfenv_t *env,
 
 static inline void free_index(struct histindex *index)
 {
-	xdl_free(index->records);
-	xdl_free(index->line_map);
-	xdl_free(index->next_ptrs);
+	free(index->records);
+	free(index->line_map);
+	free(index->next_ptrs);
 	xdl_cha_free(&index->rcha);
 }
 
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index bb328d9f852..8fffd2b8297 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -233,7 +233,7 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 	/* No common unique lines were found */
 	if (!longest) {
 		*res = NULL;
-		xdl_free(sequence);
+		free(sequence);
 		return 0;
 	}
 
@@ -245,7 +245,7 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 		entry = entry->previous;
 	}
 	*res = entry;
-	xdl_free(sequence);
+	free(sequence);
 	return 0;
 }
 
@@ -358,7 +358,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
 			env->xdf1.rchg[line1++ - 1] = 1;
 		while(count2--)
 			env->xdf2.rchg[line2++ - 1] = 1;
-		xdl_free(map.entries);
+		free(map.entries);
 		return 0;
 	}
 
@@ -372,7 +372,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
 		result = fall_back_to_classic_diff(&map,
 			line1, count1, line2, count2);
  out:
-	xdl_free(map.entries);
+	free(map.entries);
 	return result;
 }
 
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 4182d9e1c0a..169629761c0 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -89,7 +89,7 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 
 	GALLOC_ARRAY(cf->rcrecs, cf->alloc);
 	if (!cf->rcrecs) {
-		xdl_free(cf->rchash);
+		free(cf->rchash);
 		xdl_cha_free(&cf->ncha);
 		return -1;
 	}
@@ -102,8 +102,8 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 
 static void xdl_free_classifier(xdlclassifier_t *cf) {
 
-	xdl_free(cf->rcrecs);
-	xdl_free(cf->rchash);
+	free(cf->rcrecs);
+	free(cf->rchash);
 	xdl_cha_free(&cf->ncha);
 }
 
@@ -230,11 +230,11 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	return 0;
 
 abort:
-	xdl_free(ha);
-	xdl_free(rindex);
-	xdl_free(rchg);
-	xdl_free(rhash);
-	xdl_free(recs);
+	free(ha);
+	free(rindex);
+	free(rchg);
+	free(rhash);
+	free(recs);
 	xdl_cha_free(&xdf->rcha);
 	return -1;
 }
@@ -242,11 +242,11 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 static void xdl_free_ctx(xdfile_t *xdf) {
 
-	xdl_free(xdf->rhash);
-	xdl_free(xdf->rindex);
-	xdl_free(xdf->rchg - 1);
-	xdl_free(xdf->ha);
-	xdl_free(xdf->recs);
+	free(xdf->rhash);
+	free(xdf->rindex);
+	free(xdf->rchg - 1);
+	free(xdf->ha);
+	free(xdf->recs);
 	xdl_cha_free(&xdf->rcha);
 }
 
@@ -424,7 +424,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	}
 	xdf2->nreff = nreff;
 
-	xdl_free(dis);
+	free(dis);
 
 	return 0;
 }
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 865e08f0e93..00eeba452a5 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -88,7 +88,7 @@ void xdl_cha_free(chastore_t *cha) {
 
 	for (cur = cha->head; (tmp = cur) != NULL;) {
 		cur = cur->next;
-		xdl_free(tmp);
+		free(tmp);
 	}
 }
 
-- 
2.37.0.913.g189dca38629

