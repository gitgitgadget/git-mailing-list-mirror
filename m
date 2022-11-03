Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E1C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKCJL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCJL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:11:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD362E3
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:11:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n12so3419831eja.11
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FB4ZJqQZu+IrJy/4TfhoXhnxqtZCSyAtT5XmlyrsmGI=;
        b=XVZJDy6cSOsq7dqqhQvRV4ksL3XKqggCT/eUtfcLhavTHaURv7keebu3vZ313ccc3P
         d71tMjN/o9hvxphE5GEAAWUVbTrED4ECsYqtQZvgrE80kTvgbKRsfvbDfEJuoLpBNIAd
         iUhe771ShKdgD4G3L9q4AEsIq0sCttzWkc70GVbEwVb3d07C5B02Jd1NX6jmbyZZ8vwZ
         8xNsIiefMOsdZKP/lVUXWsKOBPBlt7j2Wxa0FL14gpuvL+Sgos1eCQN6MxVOX3r3xuj+
         OCAfPv2K6npAVHNiyDvp4RfMiXHjL9MeBlw+ibvLNbA4D0mA/mmrEiLN78fpu7I1cxAM
         knnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FB4ZJqQZu+IrJy/4TfhoXhnxqtZCSyAtT5XmlyrsmGI=;
        b=AgM3vjla0Oc+rZwLq+6S3IaseeS0tewV1li3kf3jti5KVV9/NP2xZ3PlSkrc8kdGAA
         BocAwSyBkH668+iDYaUrGvTXCm8aMIM04o4XAAAKRaTWUbIWBN4O9qk9zjblDLw0UFKJ
         G1qx9pRpW8xkFUtP5gg0KbOtD71YFUgctlmu5+OQjOypD2Wh7/KdFuC954dMvS69Aw2x
         GsKRzjsN08FOkwbxWZZMcoGyzklmlM3AoqA63Vo3O1nXYcl114t0fJWArXQJwf2eLUfy
         FKjsS6niCG6Wemh4Yam2RhXWTDDL5+esqkC/kr870CZkUpynOaZMPoPRR0MBQuH2ghOw
         ISHQ==
X-Gm-Message-State: ACrzQf15uATBV3E93R/fGdmkyL1OFrd4Dc8QMu5RzuCC9DE84D1NNjDI
        VT2yWpg06mcUewhPs7KZnp6nrjSc+vA=
X-Google-Smtp-Source: AMsMyM6BbkK9yT98hFdUWw56ZZ6IO+VyNOhO2kpa1XLaqaVRQqK92yupB8aQQFt1094PWtCj+N+EgA==
X-Received: by 2002:a17:907:2dab:b0:78d:fc4b:7e31 with SMTP id gt43-20020a1709072dab00b0078dfc4b7e31mr26511864ejc.531.1667466683370;
        Thu, 03 Nov 2022 02:11:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 25-20020a170906329900b00772061034dbsm222521ejw.182.2022.11.03.02.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:11:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqWFu-00CLJF-0t;
        Thu, 03 Nov 2022 10:11:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 0/3] line-log: plug some memory leaks
Date:   Thu, 03 Nov 2022 10:05:18 +0100
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221102220142.574890-1-szeder.dev@gmail.com>
Message-ID: <221103.864jvg2yit.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 02 2022, SZEDER G=C3=A1bor wrote:

> The first patch plugs the reported big memory leak, the second one
> plugs a minor leak, and the little cleanup in the third puts the
> cherry on top.

Looks good as far as it goes.

The "further" part seems a real mess though, e.g. I came up with the
below on top as a quick test, i.e. we have other existing users that
also loop over the same struct, and free "queue[n]", but do so
differently.

I handled the combine-diff.c one (rough WIP, only compiled it), but then
diffcore-rename.c has another such case.

I wonder if you looked at that further, and if the free function we're
adding now should anticipate that case or not.

And, orthagonally I came up with this rough WIP yesterday:
=09
	@@ -6640,9 +6633,7 @@ static void diffcore_apply_filter(struct diff_option=
s *options)
	 {
	 	int i;
	 	struct diff_queue_struct *q =3D &diff_queued_diff;
	-	struct diff_queue_struct outq;
	-
	-	DIFF_QUEUE_CLEAR(&outq);
	+	struct diff_queue_struct outq =3D DIFF_QUEUE_STRUCT_INIT;
=09=20
	 	if (!options->filter)
	 		return;
	@@ -6735,8 +6726,7 @@ static void diffcore_skip_stat_unmatch(struct diff_o=
ptions *diffopt)
	 {
	 	int i;
	 	struct diff_queue_struct *q =3D &diff_queued_diff;
	-	struct diff_queue_struct outq;
	-	DIFF_QUEUE_CLEAR(&outq);
	+	struct diff_queue_struct outq =3D DIFF_QUEUE_STRUCT_INIT;
=09=20
	 	for (i =3D 0; i < q->nr; i++) {
	 		struct diff_filepair *p =3D q->queue[i];
	diff --git a/diffcore.h b/diffcore.h
	index badc2261c20..a0a89568cec 100644
	--- a/diffcore.h
	+++ b/diffcore.h
	@@ -150,12 +150,7 @@ struct diff_queue_struct {
	 	int alloc;
	 	int nr;
	 };
	-
	-#define DIFF_QUEUE_CLEAR(q) \
	-	do { \
	-		(q)->queue =3D NULL; \
	-		(q)->nr =3D (q)->alloc =3D 0; \
	-	} while (0)
	+	#define DIFF_QUEUE_STRUCT_INIT { 0 }

You leave the DIFF_QUEUE_CLEAR in place, but I wonder given that that's
the common pattern whether you shouldn't have a *_reset() and
*_{free,release}() (one of the two, your current naming is fine) which
resets it too, as some callers seen below & in your diff context want
that.


diff --git a/combine-diff.c b/combine-diff.c
index b0ece954808..509c58ad556 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1297,12 +1297,6 @@ void show_combined_diff(struct combine_diff_path *p,
 		show_patch_diff(p, num_parent, 1, rev);
 }
=20
-static void free_combined_pair(struct diff_filepair *pair)
-{
-	free(pair->two);
-	free(pair);
-}
-
 /*
  * A combine_diff_path expresses N parents on the LHS against 1 merge
  * result. Synthesize a diff_filepair that has N entries on the "one"
@@ -1355,9 +1349,7 @@ static void handle_combined_callback(struct diff_opti=
ons *opt,
 	for (i =3D 0, p =3D paths; p; p =3D p->next)
 		q.queue[i++] =3D combined_pair(p, num_parent);
 	opt->format_callback(&q, opt, opt->format_callback_data);
-	for (i =3D 0; i < num_paths; i++)
-		free_combined_pair(q.queue[i]);
-	free(q.queue);
+	diff_free_queue(&q, 1);
 }
=20
 static const char *path_path(void *obj)
diff --git a/diff.c b/diff.c
index 03e6ffb5e4e..b48105c070f 100644
--- a/diff.c
+++ b/diff.c
@@ -5773,10 +5773,20 @@ void diff_free_filepair(struct diff_filepair *p)
 	free(p);
 }
=20
-void diff_free_queue(struct diff_queue_struct *q)
+static void free_combined_pair(struct diff_filepair *pair)
 {
-	for (int i =3D 0; i < q->nr; i++)
-		diff_free_filepair(q->queue[i]);
+	free(pair->two);
+	free(pair);
+}
+
+void diff_free_queue(struct diff_queue_struct *q, int combined)
+{
+	for (int i =3D 0; i < q->nr; i++) {
+		if (combined)
+			diff_free_filepair(q->queue[i]);
+		else
+			free_combined_pair(q->queue[i]);
+	}
 	free(q->queue);
 }
=20
@@ -6339,7 +6349,7 @@ int diff_flush_patch_id(struct diff_options *options,=
 struct object_id *oid, int
 	struct diff_queue_struct *q =3D &diff_queued_diff;
 	int result =3D diff_get_patch_id(options, oid, diff_header_only);
=20
-	diff_free_queue(q);
+	diff_free_queue(q, 0);
 	DIFF_QUEUE_CLEAR(q);
=20
 	return result;
@@ -6609,7 +6619,7 @@ void diff_flush(struct diff_options *options)
 		options->format_callback(q, options, options->format_callback_data);
=20
 free_queue:
-	diff_free_queue(q);
+	diff_free_queue(q, 0);
 	DIFF_QUEUE_CLEAR(q);
 	diff_free(options);
=20
diff --git a/diffcore-rename.c b/diffcore-rename.c
index c0422d9e709..1754411a916 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1686,6 +1686,7 @@ void diffcore_rename_extended(struct diff_options *op=
tions,
 			pair_to_free =3D p;
=20
 		if (pair_to_free)
+			/* ??? */
 			pool_diff_free_filepair(pool, pair_to_free);
 	}
 	diff_debug_queue("done copying original", &outq);
diff --git a/diffcore.h b/diffcore.h
index 9b588a1ee15..6cb74e6eadf 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -162,7 +162,7 @@ struct diff_filepair *diff_queue(struct diff_queue_stru=
ct *,
 				 struct diff_filespec *,
 				 struct diff_filespec *);
 void diff_q(struct diff_queue_struct *, struct diff_filepair *);
-void diff_free_queue(struct diff_queue_struct *q);
+void diff_free_queue(struct diff_queue_struct *q, int combined);
=20
 /* dir_rename_relevance: the reason we want rename information for a dir */
 enum dir_rename_relevance {
diff --git a/line-log.c b/line-log.c
index a7f3e7f6ce4..88c22b20c0f 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1090,7 +1090,7 @@ static struct diff_filepair *diff_filepair_dup(struct=
 diff_filepair *pair)
 static void free_diffqueues(int n, struct diff_queue_struct *dq)
 {
 	for (int i =3D 0; i < n; i++)
-		diff_free_queue(&dq[i]);
+		diff_free_queue(&dq[i], 0);
 	free(dq);
 }
=20
@@ -1193,7 +1193,7 @@ static int process_ranges_ordinary_commit(struct rev_=
info *rev, struct commit *c
 	if (parent)
 		add_line_range(rev, parent, parent_range);
 	free_line_log_data(parent_range);
-	diff_free_queue(&queue);
+	diff_free_queue(&queue, 0);
 	return changed;
 }
=20
