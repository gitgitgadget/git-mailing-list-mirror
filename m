Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7C1C7EE26
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbjEOTYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245203AbjEOTYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:24:17 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29686160BA
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:56 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba729a64ba8so3354765276.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178635; x=1686770635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZaLbohQ+PKZiejMjH0QzkbAVObghkl6P97WFXVQ+OhI=;
        b=T5JcUAGUKE+YUeiInqMEEmFtHd1u/E5//YY8L90/stspex3iQmKL/mSzVseITQIO9n
         82nAZLs1b5TlNTaFbuSfdQtwyZKLeKMfn4eXPJqpkwWoVxVxaNlsT6tkzlbLzLzA89So
         M5hb3czSCpDzV5nU2QAXS0to1XunWmZ1pKbNINT707sgS5hJARIUE+Oq3iduyvN42i/U
         OWTBafJJIttqTdK2Earuv2yX6DDM8SM3aUOPtRme/igvrFgj6HPV3mRnq3ivKhwrqvlv
         eak4YIkwr90xT/a0RqFsNuy8WAsqmAdtSarlZXObwymgo9gjAJvP/nNNqplq25CyD6Fr
         wpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178635; x=1686770635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaLbohQ+PKZiejMjH0QzkbAVObghkl6P97WFXVQ+OhI=;
        b=GSDKDXDRjUblH6NMBwjcDemNd7r8UEZzih1AH2Xz5O6yWZzQo75Yoe95T3ifNne9xx
         2zsNljSPrMa9hQ5i03komf7o+bWc9A4aCkPyj0Z8M9M+PgFKMGwVcPK9UlHYPVQE5Iqq
         Dp9NV210ANvYbhj18xR0ZkVG1IZCQPTl+o7oUkUm8K9zQLtmd76LnvjdCM+0t/MvSoCE
         W2dQPGSBFiyRcpKbEt5fADTinUyCbFK/Ucp2U/Vjjrw7sbzLGbG6LH3Lr9MvXIR8zYXL
         68QFHHnFjppMWdVF4gA493+oeL/4wSubIJA2VPn0G9D9Cr8VBijmtAdzgTUmGGw5a9dQ
         92zA==
X-Gm-Message-State: AC+VfDziKcbCos0L6Npkg80UwBmSS0z227tPMBfyNoOUfCEpLz8YXlGH
        HMZ9Mt5sD2ocDTH8IG0Thf44WlGQRqhCZeJ3weNyPg==
X-Google-Smtp-Source: ACHHUZ4QNJ1WIzXUhN1c7086uCwurZF4ULBgnxN1s2IJdIHh9tF313QxBayXD1fynXKgNPi/GlZKeg==
X-Received: by 2002:a25:6912:0:b0:b3b:a48c:b241 with SMTP id e18-20020a256912000000b00b3ba48cb241mr30248931ybc.31.1684178634861;
        Mon, 15 May 2023 12:23:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w14-20020a25ef4e000000b00ba7fd64e113sm17144ybm.36.2023.05.15.12.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:54 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 16/16] ls-refs.c: avoid enumerating hidden refs where
 possible
Message-ID: <2c6b89d64a164bdeec34db13017f3228c6a73184.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
 ls-refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ls-refs.c b/ls-refs.c
index 8c3181d051..c9a723ba89 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -193,7 +193,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 		strvec_push(&data.prefixes, "");
 	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
 					  get_git_namespace(), data.prefixes.v,
-					  NULL, send_ref, &data);
+					  data.hidden_refs.v, send_ref, &data);
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
-- 
2.40.1.572.g5c4ab523ef
