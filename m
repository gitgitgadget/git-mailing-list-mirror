Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B20EB64DA
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjGJVN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjGJVMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:50 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DD4BF
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:50 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5634db21a58so3889109eaf.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023569; x=1691615569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jfTE4UGW/QR3/B1v/IqptkS5aPv7JtbMC+crI2nYtc=;
        b=mPXnm7HDbJAWQWIJvO4TsNE/I/8fSrSUthJZC21pKZH8kORTjIh20m29N7006st5Nh
         YseZGmNkNck8vHjceMNTFHhT/3v2lBCyejQmR4UO+zdOHpsg9L0+xAG8YT2201QuS839
         mGiLyRgIxHHWxwxw338Dh5GoVbqu5UFEcV0x/5tyCHe5Q4BqCSwbNdsLsf2VvhPYjHDQ
         QHYGR6BjvnlN7Tjc5oiw8CuPj3xbdukcE8BLktgkiJML6p0LrnK9lfF7iuhiMKg0Ka+X
         j+loRC8sVhWFJ+TeC6hDssIS5H8+qRYUYfTbeIVO6dDDXm8T8rLiX0EXPdD9W/t0HoeJ
         +i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023569; x=1691615569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jfTE4UGW/QR3/B1v/IqptkS5aPv7JtbMC+crI2nYtc=;
        b=Znfkilt9rH4Ip6htYYQBNSWFYVEdiAf/tK/9sRtWTzGAFtN3p6f6vLGuuhyLuwBHQc
         c9loF2bYxkmqkh7UBtBcqq6duXo8q+RDqLrHL37NXvDtk66N3gteKPaCN+mFQ2SygKPx
         y0ns4a4V4jyp68EEa/A2AZuo7PVygxqBvWJnI+qISw9uhpJRzr07bsF2Ckl+/scf4HFy
         VRfK3xuWuYAkvewE5PzyKOZO/ikcOy+pDXZuORAZthu/cnXSFcb3YmFohXizPJQxyH3j
         K8Ql+DI4SWP7mjxWAVhHSOgriklkIiKKenG0UT96uziily7o3HSpigYCwr419GZyYrif
         LehA==
X-Gm-Message-State: ABy/qLZBeG/hfNPieKNk4vwJZzMJy5KxYNc1WMNeJfXbXEZfJQylhFWa
        YuDTb2y3cU4MpKlxoSbpbEwYGFS2vIPMwk7udjod2w==
X-Google-Smtp-Source: APBJJlFsTmDdsKIRp7tb0UsIgt6KhybSAANqwyfe0cRRdiNs4oD0aI/KGK/HNa9/N1maOxq2dfVa9w==
X-Received: by 2002:a05:6808:1244:b0:3a3:61df:da with SMTP id o4-20020a056808124400b003a361df00damr16336989oiv.53.1689023569207;
        Mon, 10 Jul 2023 14:12:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y80-20020a0dd653000000b0055a21492192sm182181ywd.115.2023.07.10.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:48 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 16/16] ls-refs.c: avoid enumerating hidden refs where
 possible
Message-ID: <dff068c469f9c59c94775209e34edfb678b627d9.1689023520.git.me@ttaylorr.com>
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

In a similar fashion as in previous commits, teach `ls-refs` to avoid
enumerating hidden references where possible.

As before, this is linux.git with one hidden reference per commit.

    $ hyperfine -L v ,.compile 'git{v} -c protocol.version=2 ls-remote .'
    Benchmark 1: git -c protocol.version=2 ls-remote .
      Time (mean ± σ):      89.8 ms ±   0.6 ms    [User: 84.3 ms, System: 5.7 ms]
      Range (min … max):    88.8 ms …  91.3 ms    32 runs

    Benchmark 2: git.compile -c protocol.version=2 ls-remote .
      Time (mean ± σ):       6.5 ms ±   0.1 ms    [User: 2.4 ms, System: 4.3 ms]
      Range (min … max):     6.2 ms …   8.3 ms    397 runs

    Summary
      'git.compile -c protocol.version=2 ls-remote .' ran
       13.85 ± 0.33 times faster than 'git -c protocol.version=2 ls-remote .'

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ls-refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ls-refs.c b/ls-refs.c
index 9291ddfdf8c..0e49b932c30 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -194,7 +194,8 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 		strvec_push(&data.prefixes, "");
 	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
 					  get_git_namespace(), data.prefixes.v,
-					  NULL, send_ref, &data);
+					  hidden_refs_to_excludes(&data.hidden_refs),
+					  send_ref, &data);
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
-- 
2.41.0.343.gdff068c469f
