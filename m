Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97245C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673B3214AF
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BGgal6Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgA3XAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:00:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39027 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgA3XAq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 18:00:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1922746plp.6
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=38zLZ7aCxl5GX/ZK9TIOtwDt7VD9dWxDyz/bNM5GiRo=;
        b=BGgal6Kh7j0Bp8+qpzUs7Yxjx/HnvMWV+rMgCQX86s+Oz0Pg2DD46BnTPf3raSkTAw
         Nu6aSfij9N9+Po4g2EHhAe5wwTeU/DG2QiwpkRVpNhiPq8MMw+xCfnWU72h2Qc9fYR6E
         EDyQ00PdFY+3MC9uQhbijAsAAq3VjZKHgZ9CHMT6Eq0huxHSn4OrAulcC5m9WIOoLLw/
         oSvw9QSb7Oe0KoU2koiePaS5cQerEN+JC0XDb6vKdBKevdnhC7MDBPeEBnMzQgEaucbP
         asN1zBogSQICDpzk2fgTgAPxq+1Lo8nuU7TOUE86U28IdacW4Lmexk/TThTT6m7dI/05
         8p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=38zLZ7aCxl5GX/ZK9TIOtwDt7VD9dWxDyz/bNM5GiRo=;
        b=hkxAPwLictuRYF6bo2xhLEyzoo8KNKU5GgREdWXhVwTPM4jfm912/aOhwFKdcmxB2b
         vYVbmFPmioryWvYkQpc//fnmL8vTXFptVilL9GDhSFuWg5fuH4fo4v5ScJBwUQ0jJw2S
         cs3mK/3q+us6M0iYqsu3vAtQJlAkP1TOhFO9tMQlPx2gSdGErH4SDPcM7mZ6RG9kdfIF
         e2vo0gs3IhcDhvy94OYGuroiQZSEZnu+04ZW1hj9MH50fYI29crOyEhpxy4Qkp/LDJFd
         lFYjKw3f/KOB6X31wosCcQDyUHcoZ7NAvgc9V/JWMKae+tOWm6sxtf9uUCkcnBdvpm7N
         jbzA==
X-Gm-Message-State: APjAAAWpSdH/mHbkBrkdFcv4aZuGGaGEl55abVVP92Gx1QRf8ISj7sjX
        dhPtZJSbauxqyOReDgWCwjJE3pnnQ0QQDw==
X-Google-Smtp-Source: APXvYqx7rKyk53leZ74Qqm9TeMORA1gP6DOFBfRgeg0cXAPy0a4cJ9N28mf9PAdn2O6BI5LWBDy79g==
X-Received: by 2002:a17:90a:b009:: with SMTP id x9mr8669320pjq.124.1580425245051;
        Thu, 30 Jan 2020 15:00:45 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id y2sm7847992pff.139.2020.01.30.15.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 15:00:44 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:00:43 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 1/6] t5318: don't pass non-object directory to '--object-dir'
Message-ID: <7b22efb0c61046a5864afeb052332a3a53331533.1580424766.git.me@ttaylorr.com>
References: <cover.1580424766.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580424766.git.me@ttaylorr.com>
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
2.25.0.dirty

