Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4402C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjEHWBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjEHWAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:00:36 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1186A5
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:00:30 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-55aa1da9d4aso91380377b3.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583229; x=1686175229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nRKz2UuVP7e31x/bU+NO+yIpBZtjGBCmmgfAWDVba2E=;
        b=msOqXUCnC3c0wxUGjOmtnm758F/38tB/upeKdV87bhElO/U27B2Ziw6iIbNG6Zft5j
         LzghpilI4zzWics4cPqRH/PK9c9ISmMNjhgUVI1VCT6QitgOCk5idAe0WWTY2eQWHR14
         oAmPLYhMrnzb4HVgEmwP3uIigBX3Q+BQhuMlROdsO4w6WQfVW+spJRQN6nP7HnIZGdC5
         LlN4aGcN3X3F++13fpP9hAzmP3Hs2Kp1ANaSWTddljlJ4LFjw8pVYmltDK8Z0F/XI/DQ
         PDdnD8U+IOgMNyw6E+ItFnwm0trCiL1OW+81wdwsJvP8aw/gThlcQJnxWfSj1gUuE/PQ
         efZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583229; x=1686175229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRKz2UuVP7e31x/bU+NO+yIpBZtjGBCmmgfAWDVba2E=;
        b=bpf56F1elXoT8SvPmxhXbLIxRff1OBzUMV+U9HMSSSSGhO5C801OiTPM92wEvYGCdx
         aX8JydAYZzKrFmrCO9izAl+4Y4GARnS4J12GTviGAhOViQkFKm0EpVe9QDGvq6h3kUnh
         CUWoLaUlgkPquuunL6FxHY7J7RARAieujYC23G+FYnZfNOc6NfSegKxzIdTQWeYFv7Z7
         V0W8biPgyHCE4V0EJm1hrtpy2JCGpMCIBUsect4OKBLSSFF4jyfDxXoCgwEHNhIWseaM
         g1t7bSLHix2v8IQ98XWyXFNrw6EvERbkM9JvYVh+SuYygF21LAVgCMKRcNiepNho98Zt
         Q8OA==
X-Gm-Message-State: AC+VfDxTWEbURlTGgAB9CCWUgzzkvb7qR7ihNLg/1TY7GZkQVJWi9nd4
        kgAOA22YMZITee0fVxRCiJec1L4DUpYvwg6PaUVXhQ==
X-Google-Smtp-Source: ACHHUZ60Urd9Nz9EMsCfaTBAXY/a21BxUtw5rUHsnp8yNCSM9oKo4FoU5lDbeOKJ8Nq55cgEaQ0Ppg==
X-Received: by 2002:a0d:ca15:0:b0:55a:8626:7725 with SMTP id m21-20020a0dca15000000b0055a86267725mr12437559ywd.26.1683583227991;
        Mon, 08 May 2023 15:00:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s12-20020a81bf4c000000b00556aa81f615sm1963925ywk.68.2023.05.08.15.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:00:27 -0700 (PDT)
Date:   Mon, 8 May 2023 18:00:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/15] upload-pack.c: avoid enumerating hidden refs where
 possible
Message-ID: <44bbf85e73676b2c89a82c09f7d355122ce6e805.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
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
index 7c646ea5bd..0162fffce0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -601,11 +601,32 @@ static int get_common_commits(struct upload_pack_data *data,
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
+	 * If `data->allow_uor` allows updating hidden refs, we need to
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
@@ -854,7 +875,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		 * marked with OUR_REF.
 		 */
 		head_ref_namespaced(check_ref, data);
-		for_each_namespaced_ref(NULL, check_ref, data);
+		for_each_namespaced_ref_1(check_ref, data);
 
 		get_reachable_list(data, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
@@ -1378,7 +1399,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		if (advertise_refs)
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
-		for_each_namespaced_ref(NULL, send_ref, &data);
+		for_each_namespaced_ref_1(send_ref, &data);
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref
 		 * uses stdio.
@@ -1388,7 +1409,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(check_ref, &data);
-		for_each_namespaced_ref(NULL, check_ref, &data);
+		for_each_namespaced_ref_1(check_ref, &data);
 	}
 
 	if (!advertise_refs) {
-- 
2.40.1.477.g956c797dfc

