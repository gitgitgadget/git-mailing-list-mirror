Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52321C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC6364F68
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhBDEA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 23:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhBDEAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 23:00:30 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F44C06178A
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 19:59:16 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id a19so2172842qka.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 19:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p87MUy52mah7gn9Cd/dxh8jj1AQD9AiXxzxugefES70=;
        b=V4b8C7x1g7vk2UuozJpSP3lKbTzVzcKaIi5iEkpoMmFhMyYGq8YvHHe2nBsZAEZAyQ
         97OsgV93OJ8Htjy2z16o+MZOdCV+eS+tid9FQP19+x23H5s9woR0yTG7BoJ4VEjzBWX3
         ly1APhMZBx1dzI9TW6IX+yJr5OWwnhpDzLs6PdQeQM/VY+4T60Cz0QiynE6Q2zc5Hyf5
         9fMvzmrwHGIixxU+0AQKnQM3Vl0giA52herZyLTSshekWvqxUWgAdlYQS90KorMG4BqG
         0E1DTrFFAn4TJCdBnUufXnp8JMQ4OewtU2lD04+c/TjJbTRGBy7YQiUFDtoXAazccTtF
         orFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p87MUy52mah7gn9Cd/dxh8jj1AQD9AiXxzxugefES70=;
        b=ixxaC2qj9gtw45abdFNqmnP7sF1rBfFLQoKCs9arCrnpJKUO5ceGI8kFcpHGHJ/Moa
         dRa+MnovT0kU6Srg4+TF1wKrMnd2MseROH8X3e7SrXuLNI/OsXOggjXmWRT5ebNwHxK0
         BRKqaiU4a7xsRNpJyUU9D8AzazRlsDwgzn8r8cKOyTVS05fFU6fLLUqv5ypUy/QsaNkZ
         SV5aIdT/cXpN7wWICif5xj7F88FMDHxMjzB4fpd0xa+pgNZLFRPPui2rOTSL0oni9yAj
         mJOMvXOntQxLhP2modv0diSkFkkMlpEvTN4ZeJD8Pbm/DMkxWncj7Uf1oYWxWyrjNpqT
         GjOw==
X-Gm-Message-State: AOAM531fw1SKOc/wtLfPaIW1REbzGeAhZ1o2LYHPS9EID98qKlewMEMJ
        KaMjjj0yVuaSjTMlbdgYslM8EfgUtvWV9w==
X-Google-Smtp-Source: ABdhPJxrz6U0Wr1fJc6vy11+jLkhJZKj+3afy5eqpCYq+kgb2iSptGMQgINATrcSdZzzBvCL9xy8nA==
X-Received: by 2002:ae9:eb95:: with SMTP id b143mr5888637qkg.442.1612411155809;
        Wed, 03 Feb 2021 19:59:15 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id 17sm4228255qtu.23.2021.02.03.19.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:59:15 -0800 (PST)
Date:   Wed, 3 Feb 2021 22:59:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v2 5/8] p5303: measure time to repack with keep
Message-ID: <b5081c01b53beb568ef2e59956d25b36be9f24d0.1612411124.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612411123.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

This is the same as the regular repack test, except that we mark the
single base pack as "kept" and use --assume-kept-packs-closed. The
theory is that this should be faster than the normal repack, because
we'll have fewer objects to traverse and process.

Here are some timings on a recent clone of the kernel. In the
single-pack case, there is nothing do since there are no non-excluded
packs:

  5303.5: repack (1)                          57.42(54.88+10.64)
  5303.6: repack with --stdin-packs (1)       0.01(0.01+0.00)

and in the 50-pack case, it is much faster to use `--stdin-packs`, since
we avoid having to consider any objects in the excluded pack:

  5303.10: repack (50)                        71.26(88.24+4.96)
  5303.11: repack with --stdin-packs (50)     3.49(11.82+0.28)

but our improvements vanish as we approach 1000 packs.

  5303.15: repack (1000)                      215.64(491.33+14.80)
  5303.16: repack with --stdin-packs (1000)   198.79(380.51+7.97)

That's because the code paths around handling .keep files are known to
scale badly; they look in every single pack file to find each object.
Our solution to that was to notice that most repos don't have keep
files, and to make that case a fast path. But as soon as you add a
single .keep, that part of pack-objects slows down again (even if we
have fewer objects total to look at).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5303-many-packs.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index d90d714923..b76a6efe00 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -31,8 +31,11 @@ repack_into_n () {
 	' "$1" >pushes &&
 
 	# create base packfile
-	head -n 1 pushes |
-	git pack-objects --delta-base-offset --revs staging/pack &&
+	base_pack=$(
+		head -n 1 pushes |
+		git pack-objects --delta-base-offset --revs staging/pack
+	) &&
+	test_export base_pack &&
 
 	# and then incrementals between each pair of commits
 	last= &&
@@ -49,6 +52,12 @@ repack_into_n () {
 		last=$rev
 	done <pushes &&
 
+	(
+		find staging -type f -name 'pack-*.pack' |
+			xargs -n 1 basename | grep -v "$base_pack" &&
+		printf "^pack-%s.pack\n" $base_pack
+	) >stdin.packs
+
 	# and install the whole thing
 	rm -f .git/objects/pack/* &&
 	mv staging/* .git/objects/pack/
@@ -91,6 +100,15 @@ do
 		  --reflog --indexed-objects --delta-base-offset \
 		  --stdout </dev/null >/dev/null
 	'
+
+	test_perf "repack with --stdin-packs ($nr_packs)" '
+		git pack-objects \
+		  --keep-true-parents \
+		  --stdin-packs \
+		  --non-empty \
+		  --delta-base-offset \
+		  --stdout <stdin.packs >/dev/null
+	'
 done
 
 # Measure pack loading with 10,000 packs.
-- 
2.30.0.533.g2f8b6b552f.dirty

