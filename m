Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86AAC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbjFGKmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbjFGKm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:42:26 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83D2115
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:42:15 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565c7399afaso80001717b3.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134535; x=1688726535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oFHCUunFc1C2OxzI27ntXEVCAIvtN6LZX1fBwmQ6qqw=;
        b=XBd2A1NR/xr9eQXEyztRFZoNX9JypO9LLb6xRIU6eQdLptxo/YdjIZzDCb4xAd3alY
         Se79bQwUy3R2tKqykWq415iRU44mB0QS82r8iJrPnNol+kOg5kbpvTUGcnfmoVD4bA9s
         GjUUNhdtwT6ZocpIz7oj3PX2yyXzO2gY9urESppCG29OhRNfB48oC7MxK/Gc/lk/PIQ3
         2I+ezjMM+eIwdEknI4O91UIOSlmDAnWYLNuHCEqmuZALPUxAG3Ncv51FZg7+DSL7WqqL
         JRdn8W04cPKec7jv9tegm/f3clzZjvDZ9gxd0VqOuNu9SGjDZ428RIop9hG6u/liji+d
         pkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134535; x=1688726535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFHCUunFc1C2OxzI27ntXEVCAIvtN6LZX1fBwmQ6qqw=;
        b=ieM8wHRtibZYszlzXPikqoYCdjl6c+ebN1pEmCBoWSAYxcikX9g7hCTh0N7TiWznKO
         QJE3+XtJcp5hRe8wmiIYrBmCRJaXc+l5wbghCVFvBTVfbCy70G5dziBOdLwDG8/9EW+D
         nPOkZNI99DhqFdvDZd06HKyBlQqPxcm70zamsigCHE9VdpHxa6DHYA6DIPCeAQ+27NJo
         W81ecVGVKUpfeApGl6ftPXa7WV1hIx4JbpTvwdXgeP2OVfxHx9rC0HBPkx6mIJExOcrk
         rn7YVTFszUbk4C0EVePUXwQ4U/GqduDUzmfl6hLnLOldh5iFis70TVW2E9B+DChnVtd+
         zBHQ==
X-Gm-Message-State: AC+VfDzL9fjM1/azPkhVfd0aiMvq6aRI1MX9OKB6/7iW6+AfHasC3OuO
        oZ/mFp/PJhss8Btk6L/7L2/s5euobO95WtKdJaU2ydCo
X-Google-Smtp-Source: ACHHUZ4eWZ9swHUCeOOLcdFZ1qKMwB+B8AquPAIGZ22zXkkgPFSdgmqZW+VNtmcYeXXyBUBPSS+CjQ==
X-Received: by 2002:a0d:cb07:0:b0:55a:5ce4:aff2 with SMTP id n7-20020a0dcb07000000b0055a5ce4aff2mr5268762ywd.39.1686134534925;
        Wed, 07 Jun 2023 03:42:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d14-20020a81d34e000000b0055a931afe48sm4721739ywl.8.2023.06.07.03.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:42:14 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:42:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 16/16] ls-refs.c: avoid enumerating hidden refs where
 possible
Message-ID: <e02fe9337953b8c742861320908a449fd20104d5.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
2.41.0.16.g26cd413590
