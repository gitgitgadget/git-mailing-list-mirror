Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38265C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E723B216C4
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="QGSuZpwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgI2ACJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgI2ACI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:02:08 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7AFC0613D3
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 17:02:08 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di5so1415360qvb.13
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 17:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLA7ekWB8dEmbu2dJtQw6dGQMwkGDpKTirU552i0TYc=;
        b=QGSuZpwxbBR3cuRUlu40Vg8JZ7SuGdCAm79LnM7uredbSCVysVxdvjVsBTEXyQFwzu
         Vb0qs+klDc9SjWZyJdlty+EnuA+9d4JrmJg2LLiU5EkUnsWOxep5vMpeSaGUwhqOkg/r
         KUzubVUytF2Mqf7tZT8NlbDOFI/yJas3dSS2YkLaFo+w8QTofMssqMkgTNYycQn8T+hE
         UQBCriK4IGvKABogKU6XPYBucweG13PGAnQkfFhZGfS1gthHET9E5+clQtW+5IHcqTWy
         0+URRt2go5q4mQTjsy5F17f6Vpik10dO95LVCk6jUW2LANiYAD9VI8e/raQBErvDw4pZ
         M7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLA7ekWB8dEmbu2dJtQw6dGQMwkGDpKTirU552i0TYc=;
        b=erY6Zf67i3RbnKwee6byFmxOZiWoRccS5kZ40xRZGlBdmVti3ok/RYT6YNya5Q2QW9
         x5whvxh3h6dIX1EhO9pSVVe5ElUxuRfvmidqL007rkfOh+cyORSS8NC426nIiL6Suhfo
         9t+wbCSmEo1jAZlAnE4L2sIGthF+qg/ND2RJFk4lWMgV/ckfwcTU8riZ/nDvlkgprmab
         5Wm04KWYwLo2WzAgVJyPkHfwkyd8c15I19s4lZ5Wwwouq585TkwbK4Zcv+zRPRGDf6v8
         rvCUp7heSbzLnIk/HVFFu6ZhmLbHS4B1/Iak15Ld8hwkWdHBBolTRu9D7zwXRR+FQCGd
         yyEg==
X-Gm-Message-State: AOAM531Y9Kt4CvdGCduYOZuRid8RV4sfazUEsK3Dvk1QwH3AfkIWztxm
        N6CEqlXRalqcOvEWzOcn/jtjtsr6RVZYvg==
X-Google-Smtp-Source: ABdhPJzg0KpgRRR5EYznRnaM1p03KXGzslaXal13W/rJ5DgAeGczuqrsmQDbBu2TPaW+FzI4nxy50w==
X-Received: by 2002:a0c:e5cf:: with SMTP id u15mr2104287qvm.14.1601337726741;
        Mon, 28 Sep 2020 17:02:06 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id f14sm2567545qkh.134.2020.09.28.17.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:02:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     phil.hord@gmail.com, dstolee@microsoft.com,
        jonathantanmy@google.com, stefanbeller@gmail.com, gitster@pobox.com
Subject: [PATCH v2 1/2] packfile: fix race condition on unpack_entry()
Date:   Mon, 28 Sep 2020 21:01:52 -0300
Message-Id: <948d07673f3b7eebf3d776ec2c785e65228ed185.1601337543.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601337543.git.matheus.bernardino@usp.br>
References: <cover.1601337543.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The third phase of unpack_entry() performs the following sequence in a
loop, until all the deltas enumerated in phase one are applied and the
entry is fully reconstructed:

1. Add the current base entry to the delta base cache
2. Unpack the next delta
3. Patch the unpacked delta on top of the base

When the optional object reading lock is enabled, the above steps will
be performed while holding the lock. However, step 2. momentarily
releases it so that inflation can be performed in parallel for increased
performance. Because the `base` buffer inserted in the cache at 1. is
not duplicated, another thread can potentially free() it while the lock
is released at 2. (e.g. when there is no space left in the cache to
insert another entry). In this case, the later attempt to dereference
`base` at 3. will cause a segmentation fault. This problem was observed
during a multithreaded git-grep execution on a repository with large
objects.

To fix the race condition (and later segmentation fault), let's reorder
the aforementioned steps so that `base` is only added to the cache at
the end. This will prevent the buffer from being released by another
thread while it is still in use. An alternative solution which would not
require the reordering would be to duplicate `base` before inserting it
in the cache. However, as Phil Hord mentioned, memcpy()'ing large bases
can negatively affect performance: in his experiments, this alternative
approach slowed git-grep down by 10% to 20%.

Reported-by: Phil Hord <phil.hord@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 packfile.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/packfile.c b/packfile.c
index 9ef27508f2..0319418d88 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1775,12 +1775,10 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		void *external_base = NULL;
 		unsigned long delta_size, base_size = size;
 		int i;
+		off_t base_obj_offset = obj_offset;
 
 		data = NULL;
 
-		if (base)
-			add_delta_base_cache(p, obj_offset, base, base_size, type);
-
 		if (!base) {
 			/*
 			 * We're probably in deep shit, but let's try to fetch
@@ -1818,24 +1816,33 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			      "at offset %"PRIuMAX" from %s",
 			      (uintmax_t)curpos, p->pack_name);
 			data = NULL;
-			free(external_base);
-			continue;
-		}
+		} else {
+			data = patch_delta(base, base_size, delta_data,
+					   delta_size, &size);
 
-		data = patch_delta(base, base_size,
-				   delta_data, delta_size,
-				   &size);
+			/*
+			 * We could not apply the delta; warn the user, but
+			 * keep going. Our failure will be noticed either in
+			 * the next iteration of the loop, or if this is the
+			 * final delta, in the caller when we return NULL.
+			 * Those code paths will take care of making a more
+			 * explicit warning and retrying with another copy of
+			 * the object.
+			 */
+			if (!data)
+				error("failed to apply delta");
+		}
 
 		/*
-		 * We could not apply the delta; warn the user, but keep going.
-		 * Our failure will be noticed either in the next iteration of
-		 * the loop, or if this is the final delta, in the caller when
-		 * we return NULL. Those code paths will take care of making
-		 * a more explicit warning and retrying with another copy of
-		 * the object.
+		 * We delay adding `base` to the cache until the end of the loop
+		 * because unpack_compressed_entry() momentarily releases the
+		 * obj_read_mutex, giving another thread the chance to access
+		 * the cache. Therefore, if `base` was already there, this other
+		 * thread could free() it (e.g. to make space for another entry)
+		 * before we are done using it.
 		 */
-		if (!data)
-			error("failed to apply delta");
+		if (!external_base)
+			add_delta_base_cache(p, base_obj_offset, base, base_size, type);
 
 		free(delta_data);
 		free(external_base);
-- 
2.28.0

