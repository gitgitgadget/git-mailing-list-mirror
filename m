Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D058EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjFTOWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjFTOW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:22:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF4D173E
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:27 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bd729434fa0so5039389276.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270946; x=1689862946;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rv6iBiPqgdMc4qfRCJscGhQMttGPgpDSS9xYcsIKIJ4=;
        b=qT3trzW8Z0cIL1ipAfHcMtdOsCtwifhfVVketJF5GLbU1qR5EEjapOu5+eEecOTwck
         j5TIEdAQygewQJHjhRYYd6RE0pAi1VRgukyKP43tZS9bduYCg9G9TEPjnoNtzuli+wUZ
         w5uSga5jlPNCpQctFdbQwfPLrMaeDZ/RZyjNHVwFHSDeYwuBhhqXaBgcioiOp02gZ8KV
         HrUKlqQXZF3CQrxppCsmkUd2+AQQZJA1JLP19rKu07IU3WltTMTQCjgGVv5KHXnSKiqE
         KQgAW1HVLqMlSZ8/VR3hu9vNd98edDn04YH0HhjQbO7lXlruQ986AX7mBWeINGdqFbNT
         pUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270946; x=1689862946;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rv6iBiPqgdMc4qfRCJscGhQMttGPgpDSS9xYcsIKIJ4=;
        b=EYBhEwy0q6mDigv0eC4mBeyG9xSzILdZcN/YL/Z75hlGF8idNEkrYVlNlh6xB64L/n
         gnguwlgTyOZ3dNU8zA3FGFhNBL31WXDH0LfuzEH1AbwEcnSiha6MowQq2j46JkPmon/o
         huM080mGH6sdCKQLGOz2WahU8ncfRNG5bWF+88RwhLJJOqOsTkpJ5kMxMJs3R1006m6V
         MPoSqM+kPV0Nne2nebiNFeU0TUMUSIZlPtjRBggE280rGlohY0HCnetI2JfdVO21wqxL
         oH9RVhpwp84KCysEksLZZZRpubN6aNy5u4jUIJ3fFQn4k7wUgVZ2R8Ax+aulh5zGnLcE
         uYcQ==
X-Gm-Message-State: AC+VfDwlVDreOmNYu3VU1tN05gFd2UijkidqGg3jRCLXHz9KDRwlZjGU
        O+TG/WSRX4+JbhdV+FMu5vvzlg4OHnfZilJEaeAhAnDk
X-Google-Smtp-Source: ACHHUZ4y3P+r5i9KafbECoueCqDNjH7V15MnhuW2NBuqDxRsHFy+EgpQlGoSqEfuBs7k4vLLRa9a5g==
X-Received: by 2002:a25:ca13:0:b0:bc4:1245:1528 with SMTP id a19-20020a25ca13000000b00bc412451528mr11137540ybg.52.1687270946145;
        Tue, 20 Jun 2023 07:22:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w187-20020a2530c4000000b00be865f3d4fdsm377576ybw.62.2023.06.20.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:22:25 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:22:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 16/16] ls-refs.c: avoid enumerating hidden refs where
 possible
Message-ID: <ea6cbaf292f59c96bedc304c74a36fe1c53c1c6d.1687270849.git.me@ttaylorr.com>
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
2.41.0.44.gf2359540d2
