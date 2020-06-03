Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BAFC433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDE22067B
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 22:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pQpVyaKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgFCWVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgFCWVK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 18:21:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67000C08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 15:21:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so1322440plr.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZIcoXxH4b5GB1zCKP0HCa+yd/CtbEWABai9t3T0dNa8=;
        b=pQpVyaKkCZ9TAVxuKw1+b3wbVWKsm5ZuCPk0cLsyF4OSlE1lY7CoMKXXDpPFr7Q1tk
         82kqHJohkmZn+4sUJ84ND0f/2X7mVuzpw8jzuDxnUcs5xWriM+umhby4Amc58LboTfGs
         KGNxAJ8a9+lU/LO7n9bgWcjWhbJUCdAd6KorhOpIZtkMFpAFLgJrpAQGDQJfEnc69+za
         Xk0yuJBqzToicjABVlrA0n3j73kd6tQy5zBbmQ1bVPvl3t67YoWf1ZkpnLF9jGdWBWVH
         b3EBmSM8fDBg/8IRSUH37Da3OR2oxrC6PpGHnc+ukgexeCoWMCl7n+vR6s9CGehpYLKN
         PEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZIcoXxH4b5GB1zCKP0HCa+yd/CtbEWABai9t3T0dNa8=;
        b=LJxdV3+fP+ljKff16036gphYDRCajOUe++NMxLlj19mNRmXYPZM0m7fGWi09A5qRQU
         x8ABxJPX2QxZnxDaBGJHAqv+7pgVlV/TEO/HpKxG2PhwT4UIhColcnjDJZn+gXF0Xzuu
         D/GnKAHvg+n6CQ1CU+ylG/CfxSXsE13s7b282mK9W5kKsIOUMK/osBidB24RYlWJaw8A
         rleHjQRbfEmihiukF8ftxVZJ7A7S4xmlKgL0UEtzi5aiD06n/y4ntjts9dg5oN17UjpO
         bFAtJP3DOhmVWrkv2UVPXtD1MIGYZ8RmSF/D/EnF1e3xlL0ZucxJqUBtazUStUJL5hI8
         bRVg==
X-Gm-Message-State: AOAM530h7t448Abk3LOUAW8ZYgJe5iCw7sKCgd0nQlRRFpIAfzgRlwxE
        HeW38bA3UF3h4w4owdekbG1C9A==
X-Google-Smtp-Source: ABdhPJw/nshT5hDVIfr9PYNXZcWfD8yu/58ji1ip2DCGHD2xf+rtpUieC491uqan0zCR27ryjS+r6g==
X-Received: by 2002:a17:902:242:: with SMTP id 60mr1708030plc.120.1591222869746;
        Wed, 03 Jun 2020 15:21:09 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q26sm2593078pfh.74.2020.06.03.15.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 15:21:08 -0700 (PDT)
Date:   Wed, 3 Jun 2020 16:21:07 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/2] t5318: use 'test_must_be_empty'
Message-ID: <20200603222107.GA37471@syl.local>
References: <cover.1591034353.git.me@ttaylorr.com>
 <fddbe588147444fe2675224c94f50e24a1d12871.1591034353.git.me@ttaylorr.com>
 <20200602180403.GA4791@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200602180403.GA4791@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 02, 2020 at 08:04:03PM +0200, SZEDER Gábor wrote:
> On Mon, Jun 01, 2020 at 12:01:27PM -0600, Taylor Blau wrote:
> > A handful of tests in t5318 use 'test_line_count = 0 ...' to make sure
> > that some command does not write any output. While correct, it is more
> > helpful to use 'test_must_be_empty' instead, since the latter prints the
> > contents of the file if it is non-empty.
> >
> > Since 'test_line_count' only prints the expected and actual line count,
> > not the contents, using 'test_must_be_empty' may be more helpful for
> > debugging if there is regression in any of these tests.
>
> These two paragraphs essentially say the same thing, so I think only
> one would be sufficient, but...  Both paragraphs are wrong, because
> 'test_line_count' does include the content of the file on failure:
>
>   expecting success of 9999.1 'test':
>           cat >foo <<-EOF &&
>           Add
>           some
>           content
>           EOF
>           test_line_count = 0 foo
>
>   test_line_count: line count for foo != 0
>   Add
>   some
>   content
>   not ok 1 - test
>
> Having said that, I think that the change itself is good, because
> 'test_must_be_empty foo' is more idiomatic.

Sounds good. Let's use this version of the patch instead, and otherwise
I think this should be ready to go:

--- >8 ---

Subject: [PATCH] t5318: use 'test_must_be_empty'

A handful of tests in t5318 use 'test_line_count = 0 ...' to make sure
that some command does not write any output. While correct, it is more
idiomatic to use 'test_must_be_empty' instead. Switch the former
invocations to use the latter instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a79c624875..d23986f603 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -147,7 +147,7 @@ test_expect_success 'Add more commits' '
 test_expect_success 'commit-graph write progress off for redirected stderr' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write 2>err &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '

 test_expect_success 'commit-graph write force progress on for stderr' '
@@ -159,13 +159,13 @@ test_expect_success 'commit-graph write force progress on for stderr' '
 test_expect_success 'commit-graph write with the --no-progress option' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --no-progress 2>err &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '

 test_expect_success 'commit-graph verify progress off for redirected stderr' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph verify 2>err &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '

 test_expect_success 'commit-graph verify force progress on for stderr' '
@@ -177,7 +177,7 @@ test_expect_success 'commit-graph verify force progress on for stderr' '
 test_expect_success 'commit-graph verify with the --no-progress option' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph verify --no-progress 2>err &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '

 # Current graph structure:
--
2.27.0

