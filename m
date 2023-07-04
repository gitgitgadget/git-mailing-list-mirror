Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79367EB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 18:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjGDSnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDSno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 14:43:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C110D5
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 11:43:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5776312eaddso53671087b3.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688496221; x=1691088221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYYUmuNMrxPH60hLtNS5Kt2P+bmNKRm7HUXAd4nWRko=;
        b=QvGYtsPBy/zRThDSa6Gmvt6tj5LgGAyDkTE2DovAfI44ezktsZ3HrI1x7beVKbsT3v
         pVnA68K2wDXSV3Uncm9jxufbjDUJgib8SBqHJdhu1u8v2sDZpY/shlIIa2c8mmm+Vbvk
         CTj6Tnx0umD4JWxacu2dLKiA4kaAJi1wJU76vubyaNJ1Wff0lg5bIm7NpqjBHreZQQGN
         +Dg3jCrCEYaEC6jLQJ+QgD5LgQt9hMIqYeVUFfM+iFvhz/ZVKL8Zok8tc1Tzm/xxxxce
         m93vxGhUSTXup6hKFf1NVrCb64T85FFoRC8eWKNg1psKuGRiGTMEaB9ZBsKvuGnuJbsj
         AScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688496221; x=1691088221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYYUmuNMrxPH60hLtNS5Kt2P+bmNKRm7HUXAd4nWRko=;
        b=Ew7IvCEwraA14fwl85kkQeQjUbAPgIZozY3IvjSsTJ7PRGK4aj9nmD2QbEppm6W+3d
         xZitGdJ5dDM+A/IGX8+vPAjaLfZMa4fiCd8VkbT5ZCbbXiYULZxq/YM//mwbxQLhXCbi
         IGp0WmnSai1LB8wBw2BuBzEc7hU+QwqcQ1zhaaUgH9B7o6pfykSMRbA5FZ4Kd54/ZP/P
         wNIc7U50ib7i2obxALdEg6c8hkYKa6jccbnVDHTwLhRnT4f+oGfhc2tCA+AzbpnpdL7g
         QfjEnKlXvYVQiKpkdkbmdfz9mI9FkiPUDb7g3MJDyK1C749LequBSOpNMP0b18RSghi8
         jfgg==
X-Gm-Message-State: ABy/qLaXW4mcys42iK7iRdfPBEqJr/3AVqXbrKc7tl98tUM3yNui+NNM
        A2f8g8x5l555TuzxsNcAg2vc/A==
X-Google-Smtp-Source: APBJJlEkowED5Wu+1JhOaQB7w+qv8r8EHgu7gmBCiv58NjkXGxu3ZHUdVEU+kOnzHzTruz0SRvFZag==
X-Received: by 2002:a0d:d9c3:0:b0:576:a91d:d3ee with SMTP id b186-20020a0dd9c3000000b00576a91dd3eemr13648845ywe.42.1688496221147;
        Tue, 04 Jul 2023 11:43:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b0056d2a19ad91sm5671646ywe.103.2023.07.04.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 11:43:40 -0700 (PDT)
Date:   Tue, 4 Jul 2023 14:43:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 15/16] upload-pack.c: avoid enumerating hidden refs
 where possible
Message-ID: <ZKRoW0epxO4rfn1U@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <19bf4a52d696b4789e6ab9c62f51d0ba955b7b6a.1687270849.git.me@ttaylorr.com>
 <20230703062644.GI3502534@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703062644.GI3502534@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 03, 2023 at 02:26:44AM -0400, Jeff King wrote:
> I guess v2 clients don't hit this code at all (they are handled by
> ls-refs, which comes in the next patch). So that just leaves the case
> that allowAny is set. By itself the optimization should kick in (good).
> With allowTip or allowReachable it would not, but that is the "this is
> stupid" case in which it is OK to fall back to the existing behavior
> (even though we _could_ enable the optimization). OTOH, it would be easy
> to check it, as it's just another bit in allow_uor.
>
> I'm OK going either way.

As am I, though I agree that checking for it is not hard. The return
value of `allow_hidden_refs()` as currently written is confusing, so
here's an inversion of that function with this suggestion on top:

--- >8 ---
diff --git a/upload-pack.c b/upload-pack.c
index ef2ca36feb..5a0fa028c6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -604,7 +604,9 @@ static int get_common_commits(struct upload_pack_data *data,

 static int allow_hidden_refs(enum allow_uor allow_uor)
 {
-	return allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1);
+	if ((allow_uor & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1)
+		return 1;
+	return !(allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
 }

 static void for_each_namespaced_ref_1(each_ref_fn fn,
@@ -620,7 +622,7 @@ static void for_each_namespaced_ref_1(each_ref_fn fn,
 	 * has the OUR_REF bit set or not, so do not need to visit
 	 * hidden references.
 	 */
-	if (!allow_hidden_refs(data->allow_uor))
+	if (allow_hidden_refs(data->allow_uor))
 		excludes = hidden_refs_to_excludes(&data->hidden_refs);

 	for_each_namespaced_ref(excludes, fn, data);
@@ -629,7 +631,7 @@ static void for_each_namespaced_ref_1(each_ref_fn fn,

 static int is_our_ref(struct object *o, enum allow_uor allow_uor)
 {
-	return o->flags & ((allow_hidden_refs(allow_uor) ? HIDDEN_REF : 0) | OUR_REF);
+	return o->flags & ((allow_hidden_refs(allow_uor) ? 0 : HIDDEN_REF) | OUR_REF);
 }

 /*
--- 8< ---

Thanks,
Taylor
