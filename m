Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A4C35249
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C445020838
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="koR+fgbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBCVR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:17:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33790 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCVR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 16:17:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so6361506plb.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 13:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gMTQQpXQF+2KXtWvFP7ISqUU9kHh4GSMZaPwUsIlM/U=;
        b=koR+fgbTlKf3nKmu/+dk7YRQGBOVyyYBaVe72B2OoHBQZX9t+FwA+yBcSa0r4ZTkGi
         LZetb+q0jLNHsTsdJWaPTIFLIqAi5opb5DXslJHUhVnH84qPM6TXe1YYH6MNzUnRKNyV
         VdYdRKFqOiALK/530DMOvs6YyCHn9VmHIVHE6LxUGbBv90hlknfOCPQL6fE9OjomwgY+
         68bkVRTQcaxx1EWkk3ird7wITdn/Q5eZ42VEjcVEO+llTREBBHx/SAMKfJ/K1kVi5y1y
         58y9eDFHeLFhdVKYk8ZoVmoOyOf8hF0jtb4iNX1oy6cheZNSIZHlirur0YU7S7hunyJ0
         0DxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gMTQQpXQF+2KXtWvFP7ISqUU9kHh4GSMZaPwUsIlM/U=;
        b=AlrmxGmEzN249+C8Sx8FxY6jFCU8MKejmBo34tts4uSm3Hvrlg2BL4cRhTOfixvJuU
         IMrrARHTbjOP/nRzQQ7LXdEJIrAKy1sLllnIGxoDBYmSh5H5vPc1ieqVdc4Q6mU9Dq9b
         TtE6It7xodgEssVmYObIekTFUt7Li8LX3/cg5VunQGS2KjuEtNPBCfoMVRhI8hjUXJ9u
         NDuZIjTmgSsFzQUeJgnXMEESOV+9UTtmvbYWqk/1g0crbpfvAiEIzOij+atL59nCe3m1
         xRo34y6U53K+eGi9LOVH+Rrgoz/XrAoLpq3dT5AAysJnUhQ1n/rh5QIA+U30d5X/FJQ2
         UMUQ==
X-Gm-Message-State: APjAAAWS4td4RyxRkv3L+dHgByUBcVS8yyaiv1K+Xp0oRPZmsXkSooUP
        PrDWIVDGMWpjsPUMPHm9+5leL+z70Igfmg==
X-Google-Smtp-Source: APXvYqxYtR2iU2Hn2u4w1/RQQhL4oZyDwiSL8Baz9t4USPgfIELtB7O4KSxqjtdaPIm4DYTx405jDg==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr24817871plt.329.1580764677835;
        Mon, 03 Feb 2020 13:17:57 -0800 (PST)
Received: from localhost ([205.175.106.126])
        by smtp.gmail.com with ESMTPSA id s18sm999028pgn.34.2020.02.03.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:17:57 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:17:56 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v2 1/5] t5318: don't pass non-object directory to
 '--object-dir'
Message-ID: <84a8709ad14c8731e394d21b9ddee1372e0ec436.1580764494.git.me@ttaylorr.com>
References: <cover.1580424766.git.me@ttaylorr.com>
 <cover.1580764494.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580764494.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f237c8b6fe (commit-graph: implement git-commit-graph write,
2018-04-02) the test t5318.3 was introduced to ensure that calling 'git
commit-graph write' in a repository with no packfiles does not write any
commit-graph file(s).

To exercise more paths in 'builtin/commit-graph.c', this test passes
'--object-dir' to 'git commit-graph write', but the given argument
refers to the working copy, not the object directory.

Since the commit-graph sub-commands currently swallow these errors, this
does not result in a test failure. But, it is only lucky that the test
ends with no commit-graphs, since there were none to begin with.

In preparation for a future commit where an '--object-dir' argument that
does not match a known object directory will print out a failure, let's
fix the test to still use '--object-dir', but pass the correct location
to the object store instead of '.'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3f03de6018..0bf98b56ec 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -19,8 +19,8 @@ test_expect_success 'verify graph with no graph file' '
 
 test_expect_success 'write graph with no packs' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write --object-dir . &&
-	test_path_is_missing info/commit-graph
+	git commit-graph write --object-dir $objdir &&
+	test_path_is_missing $objdir/info/commit-graph
 '
 
 test_expect_success 'exit with correct error on bad input to --stdin-packs' '
-- 
2.25.0.119.gaa12b7378b

