Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A483EB64DB
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjFTOWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjFTOWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:22:24 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7B1709
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:22 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bc40d4145feso4740103276.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270941; x=1689862941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WkOQIzMCGdgvwv7x2DCnO+7Y8aX3ZLdNX2i73moFBH0=;
        b=dE0Lwz/04SXJ1c/W6w3kgXCZk/yyc5j3JfmHqQZNqHADbNz38h/rWr9LnqOZOpkzGy
         w8ORFreKTBE1CTSAbQnOX7hmhKWDjx+4ZpmDJ0ebGuzDyCFvA72l/5aG2wRmp18pSuVT
         GPJGKOtsbszI0AWelg/9KWVFQYiRHXbbjbV5/unAchSpKSIus/hFLZpHEIqu74YkYjdI
         7GYrqI0zJ3gC7Qco4BrQgr9k6uA+VuGwvQlQbgscNBWZcCG+bySBAcSVuZIEQ5Tcx5kt
         oHsLOmYtiElka3T3x1b3sSflyH2PCHToFnA7w1XK4D7cR5yRoo+HbCTwF21d8wM0Nh1x
         G7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270941; x=1689862941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkOQIzMCGdgvwv7x2DCnO+7Y8aX3ZLdNX2i73moFBH0=;
        b=FpyBy8TFKAiRuMpCDRqzH6rZfokKndAOybSbItpuAd9qQ1dwwtanslVluDjmQ8bhET
         y4e8tQe8inKoNvszJdvKmSJFGm/NGJfWBrxvvpK62v0zbbHHKlYSup/mjwsO/q/un8j6
         YqdfeU0ljr8u2sKHSNKOIIa9kVsSN3XnrM+yesD8ajf0Ly82TLPA7HgkmPX9diu+Jjzg
         AwBYZmPAzRhfcuBt/TgrDRy3Ly8GvTXnRTIob7Kwmzxg0sjX3eheDjc/h5q+s7eMREiZ
         yTeqQutTzOcIPFaZt4ku4Uw6o6qTplwztvXrpceV9hex2qHBoiEgJxwgbkHtZlNEhjOR
         RMPA==
X-Gm-Message-State: AC+VfDxIErVOAaSbMni8D7MmYy54CRDGn2D50s0RVPtWEWO0ZdsUsSEo
        L7caA0YnridTK6ycSlAy4B5o9XkXqGpGAlLqS0DJWEwD
X-Google-Smtp-Source: ACHHUZ5aGkCw8GhLTOKeAMM5l95CAzbdOVvw/gPXLWz77gSfBeNmGOiT0TJzaKkW4b45zld9EI3Htg==
X-Received: by 2002:a25:8046:0:b0:bc4:5a65:1a4f with SMTP id a6-20020a258046000000b00bc45a651a4fmr10290963ybn.5.1687270941011;
        Tue, 20 Jun 2023 07:22:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w34-20020a25ac22000000b00bc7c81c3cecsm393338ybi.14.2023.06.20.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:22:20 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:22:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 15/16] upload-pack.c: avoid enumerating hidden refs where
 possible
Message-ID: <19bf4a52d696b4789e6ab9c62f51d0ba955b7b6a.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar fashion as a previous commit, teach `upload-pack` to avoid
enumerating hidden references where possible.

Note, however, that there are certain cases where cannot avoid
enumerating even hidden references, in particular when either of:

  - `uploadpack.allowTipSHA1InWant`, or
  - `uploadpack.allowReachableSHA1InWant`

are set, corresponding to `ALLOW_TIP_SHA1` and `ALLOW_REACHABLE_SHA1`,
respectively.

When either of these bits are set, upload-pack's `is_our_ref()` function
needs to consider the `HIDDEN_REF` bit of the referent's object flags.
So we must visit all references, including the hidden ones, in order to
mark their referents with the `HIDDEN_REF` bit.

When neither `ALLOW_TIP_SHA1` nor `ALLOW_REACHABLE_SHA1` are set, the
`is_our_ref()` function considers only the `OUR_REF` bit, and not the
`HIDDEN_REF` one. `OUR_REF` is applied via `mark_our_ref()`, and only
to objects at the tips of non-hidden references, so we do not need to
visit hidden references in this case.

When neither of those bits are set, `upload-pack` can potentially avoid
enumerating a large number of references. In the same example as a
previous commit (linux.git with one hidden reference per commit,
"refs/pull/N"):

    $ printf 0000 >in
    $ hyperfine --warmup=1 \
      'git -c transfer.hideRefs=refs/pull upload-pack . <in' \
      'git.compile -c transfer.hideRefs=refs/pull -c uploadpack.allowTipSHA1InWant upload-pack . <in' \
      'git.compile -c transfer.hideRefs=refs/pull upload-pack . <in'
    Benchmark 1: git -c transfer.hideRefs=refs/pull upload-pack . <in
      Time (mean ± σ):     406.9 ms ±   1.1 ms    [User: 357.3 ms, System: 49.5 ms]
      Range (min … max):   405.7 ms … 409.2 ms    10 runs

    Benchmark 2: git.compile -c transfer.hideRefs=refs/pull -c uploadpack.allowTipSHA1InWant upload-pack . <in
      Time (mean ± σ):     406.5 ms ±   1.3 ms    [User: 356.5 ms, System: 49.9 ms]
      Range (min … max):   404.6 ms … 408.8 ms    10 runs

    Benchmark 3: git.compile -c transfer.hideRefs=refs/pull upload-pack . <in
      Time (mean ± σ):       4.7 ms ±   0.2 ms    [User: 0.7 ms, System: 3.9 ms]
      Range (min … max):     4.3 ms …   6.1 ms    472 runs

    Summary
      'git.compile -c transfer.hideRefs=refs/pull upload-pack . <in' ran
       86.62 ± 4.33 times faster than 'git.compile -c transfer.hideRefs=refs/pull -c uploadpack.allowTipSHA1InWant upload-pack . <in'
       86.70 ± 4.33 times faster than 'git -c transfer.hideRefs=refs/pull upload-pack . <in'

As above, we must visit every reference when
uploadPack.allowTipSHA1InWant is set. But when it is unset, we can visit
far fewer references.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 upload-pack.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 99d216938c..366a101d8d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -602,11 +602,32 @@ static int get_common_commits(struct upload_pack_data *data,
 	}
 }
 
+static int allow_hidden_refs(enum allow_uor allow_uor)
+{
+	return allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1);
+}
+
+static void for_each_namespaced_ref_1(each_ref_fn fn,
+				      struct upload_pack_data *data)
+{
+	/*
+	 * If `data->allow_uor` allows fetching hidden refs, we need to
+	 * mark all references (including hidden ones), to check in
+	 * `is_our_ref()` below.
+	 *
+	 * Otherwise, we only care about whether each reference's object
+	 * has the OUR_REF bit set or not, so do not need to visit
+	 * hidden references.
+	 */
+	if (allow_hidden_refs(data->allow_uor))
+		for_each_namespaced_ref(NULL, fn, data);
+	else
+		for_each_namespaced_ref(data->hidden_refs.v, fn, data);
+}
+
 static int is_our_ref(struct object *o, enum allow_uor allow_uor)
 {
-	int allow_hidden_ref = (allow_uor &
-				(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
-	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
+	return o->flags & ((allow_hidden_refs(allow_uor) ? HIDDEN_REF : 0) | OUR_REF);
 }
 
 /*
@@ -855,7 +876,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		 * marked with OUR_REF.
 		 */
 		head_ref_namespaced(check_ref, data);
-		for_each_namespaced_ref(NULL, check_ref, data);
+		for_each_namespaced_ref_1(check_ref, data);
 
 		get_reachable_list(data, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
@@ -1386,7 +1407,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		if (advertise_refs)
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
-		for_each_namespaced_ref(NULL, send_ref, &data);
+		for_each_namespaced_ref_1(send_ref, &data);
 		if (!data.sent_capabilities) {
 			const char *refname = "capabilities^{}";
 			write_v0_ref(&data, refname, refname, null_oid());
@@ -1400,7 +1421,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(check_ref, &data);
-		for_each_namespaced_ref(NULL, check_ref, &data);
+		for_each_namespaced_ref_1(check_ref, &data);
 	}
 
 	if (!advertise_refs) {
-- 
2.41.0.44.gf2359540d2

