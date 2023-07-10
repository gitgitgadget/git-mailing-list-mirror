Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013FDEB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjGJVNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjGJVMt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:49 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B7E6B
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:47 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b71cdb47e1so4454991a34.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023566; x=1691615566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QRhKRU6IaQRy/A9sdRYUIiKuR+/G44O9TxNQUPacLsQ=;
        b=3iuDb4WPfvZ877/54aVBTPnZiWk3pub9Khfo4wE786mK2PxXB2R1rblULiqTba0qGs
         CJ7CXp2GmHp8l3w/LN7k12vtgUf0PXb9jS4/No3/N5XwPjAfyRSsOw1Gml/jewHX6zQI
         vc+iP+qw2MoBLvZwEOE09OjeI+vyBUIbs3JcoUu5urv0e1bgr1/1QzwndkAnxYnhh79C
         Makm8GpyqU6TdgdFbgjVysE73s2BlOQeURqDx5UHRmCKMAHd1KjcI9M3is/YD+FKLS+j
         XqpUGKGWNq+4xSvZmQUrCxvHECPTcnAHtbMJMa7SPYB8/iogz9OYkPQcCC3v9xezkIM5
         x9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023566; x=1691615566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRhKRU6IaQRy/A9sdRYUIiKuR+/G44O9TxNQUPacLsQ=;
        b=dVOnvDviErJenYgiW4D0DNlm1iG7Xtjf7r+mxXYq4i3TcJvJQuvL7jA2RWt5+DeSsl
         Lr82b8er7mMzCiEKDltJI/1ktCRgBW7recnk5x0h/Xe3bkq0JtEYHLQNVCyDSt8BeCYe
         gSn0Xa+2Lht1sWegQuOraCI0xl7kxW56PsY5ILNmomE5HiGPVcWXQZvLK4kmCpfqFpMw
         +poVwYMBQMmYcENPP8vdmq46wHROdCxlhdenXR/8G8R7h/H6oy8f3MIm5wsZxlpHOsFl
         l/JS/7QBf75geHOgPMV+yKPZIHWnK0jKfdFlVSp3CDq9B2JVGOq16X2nseko9/Jh2yMf
         W6hg==
X-Gm-Message-State: ABy/qLYt9QNBIKNdeH2Crf/LRdBdnl21ZnRt50tk3mfdblLq1tTXhCc0
        ii4lJ5GamXY0Q7cIvkg/hZyJXeuvo87G52vz84r5+w==
X-Google-Smtp-Source: APBJJlHzf/pgZYQtA0eWNVFHi+PBPmC3yja98GecB7tthvyDZwMnaMgEwL+VZ8fJmqkKp6ocixU1/Q==
X-Received: by 2002:a9d:6d82:0:b0:6b2:dc79:5870 with SMTP id x2-20020a9d6d82000000b006b2dc795870mr13765525otp.36.1689023566355;
        Mon, 10 Jul 2023 14:12:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w8-20020a253008000000b00be4f34d419asm141058ybw.37.2023.07.10.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:46 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 15/16] upload-pack.c: avoid enumerating hidden refs where
 possible
Message-ID: <8544a647798de68eb46f9f5c5b269d03ed3500a5.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
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
 upload-pack.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index da4f17f64ac..db4709adb77 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -602,11 +602,36 @@ static int get_common_commits(struct upload_pack_data *data,
 	}
 }
 
+static int allow_hidden_refs(enum allow_uor allow_uor)
+{
+	if ((allow_uor & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1)
+		return 1;
+	return !(allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
+}
+
+static void for_each_namespaced_ref_1(each_ref_fn fn,
+				      struct upload_pack_data *data)
+{
+	const char **excludes = NULL;
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
+		excludes = hidden_refs_to_excludes(&data->hidden_refs);
+
+	for_each_namespaced_ref(excludes, fn, data);
+}
+
+
 static int is_our_ref(struct object *o, enum allow_uor allow_uor)
 {
-	int allow_hidden_ref = (allow_uor &
-				(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
-	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
+	return o->flags & ((allow_hidden_refs(allow_uor) ? 0 : HIDDEN_REF) | OUR_REF);
 }
 
 /*
@@ -855,7 +880,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		 * marked with OUR_REF.
 		 */
 		head_ref_namespaced(check_ref, data);
-		for_each_namespaced_ref(NULL, check_ref, data);
+		for_each_namespaced_ref_1(check_ref, data);
 
 		get_reachable_list(data, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
@@ -1392,7 +1417,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		if (advertise_refs)
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
-		for_each_namespaced_ref(NULL, send_ref, &data);
+		for_each_namespaced_ref_1(send_ref, &data);
 		if (!data.sent_capabilities) {
 			const char *refname = "capabilities^{}";
 			write_v0_ref(&data, refname, refname, null_oid());
@@ -1406,7 +1431,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(check_ref, &data);
-		for_each_namespaced_ref(NULL, check_ref, &data);
+		for_each_namespaced_ref_1(check_ref, &data);
 	}
 
 	if (!advertise_refs) {
-- 
2.41.0.343.gdff068c469f

