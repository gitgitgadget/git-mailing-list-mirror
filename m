Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B80C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CB522258
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esTO1Ygw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbgJOB74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732483AbgJOB7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:59:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF9CC0613A6
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 14:13:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z22so558283wmi.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ow+/NiC5LPtUcWqbRrL35jbgCSi7RxYdbnk1PlDpvqU=;
        b=esTO1YgwvKG+xeBIuhv0L4pv0KEVPaoD+bdwVk/tcA/gqJJ3gDXENpV6fNPb9pAoxh
         +ibezdg+MT5GJYLgOHGVrt9GBdtoJwcO3njrEFOi3IQ5y63zD/7ZjThjjLTY8zs417eg
         uRDgwpfz+AidXZ6468VL61KM2SR5RwfooRzY+xzYjFQNNtw7UpeGsCN3lIdaGN+TZz85
         zTyFqCLWhxhWiLmEmsCZYyhymcnGpDuK6VuDF3o35rTKd/XWJvoNScRV63hIeK+mJ1Oh
         Tvs4jdoN161dSjSaYiQGx/nWMEVogg2kXQWUVD1BYv5ljx1Riwk7xkYGFoKuloRHerXV
         ylnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ow+/NiC5LPtUcWqbRrL35jbgCSi7RxYdbnk1PlDpvqU=;
        b=cpWpPJoRJBl+HjBLmRlz9HG7av9wB3LfH6rtMtkzJo+tr6Cl2nOU/iUdq6vnnA1JM+
         ujLT7u6YDYXhjibOxN99bUlfLw4kBeWaSH/9VJAcpVmInkZx58FL3K546fSKqRMms4UX
         3ZaLmFTUYCtcPb25/XN3sdUqPFWStNFNQE+TDRUEOtb4y0qeFNGOEPBLFZY5UmaN6UYc
         IbBImY5ECRJFWoYzbTSFdttSyiMuaU/bzuXx0PpdVYlFhdeRUFeqrwatXpdEHlzLlml5
         zyDzIyqsSmsKh7y74LSJZOyyE1ouJTq5WuoijK/EHJN8t6ssrYUYbV5HuHhdgJICl2wq
         l7oA==
X-Gm-Message-State: AOAM531T123guq5yz9UFW5X164MhD1twjhjnhHuLjTg4giO+mXZvYHZw
        xbPpcICNrl1r0Wc0jFXkL73MP/6ecjU=
X-Google-Smtp-Source: ABdhPJwEeh9BUgbsDfm6im9+Rskxfr/bQ0oHbzfMFlzAcjJHnomB6OTLDED1SXOq85JxafRVTk5QKw==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr631538wml.99.1602710029147;
        Wed, 14 Oct 2020 14:13:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm921631wmi.39.2020.10.14.14.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:13:48 -0700 (PDT)
Message-Id: <24f6febde649d8fbe847cbba95171e6fec923e2a.1602710025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Oct 2020 21:13:45 +0000
Subject: [PATCH v3 3/3] test-lib: reduce verbosity of skipped tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When using the --run flag to run just two or three tests from a test
file which contains several dozen tests, having every skipped test print
out dozens of lines of output for the test code for that skipped test
(in addition to the TAP output line) adds up to hundreds or thousands of
lines of irrelevant output that make it very hard to fish out the
relevant results you were looking for.  Simplify the output for skipped
tests to remove this extra output, leaving only the TAP output line
(i.e. the line reading "ok <number> # skip <test-description>", which
already mentions that the test was "skip"ped).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/test-lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a040d54a76..3f8c404335 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1062,7 +1062,6 @@ test_skip () {
 				"      <skipped message=\"$message\" />"
 		fi
 
-		say_color skip >&3 "skipping test: $@"
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
-- 
gitgitgadget
