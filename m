Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94BCC2BBFD
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8895B2075E
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePTBjSHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgDMOpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbgDMOpa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 10:45:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4DAC0A3BE2
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:45:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id cb27so12202143edb.11
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wMWAdJaDoesQ7l4YrmZbXUqFvfIk/aDRRi7TZz1QS+k=;
        b=ePTBjSHtVMe0onPh+iNXJwqxoaBvxIwbdhdZ9NpFO3jrvrCxi19Ov3TatjLxsP6Ms8
         oIJ0HueZl6+5oo0n0SprhogjAStC6qw3A7NS7EpIde/qOmv0SwWsCWYswXiZ+XoKkeTn
         lLAkVigrsksBV9BS+Lye6C4xI4XrdyoqmrsFgVaOVpUdNUpFPRbWtAB0GRSCdvKIjNzH
         I6oA+unYlfvhXP6KfI/RbtpdsKJwVcy/5c80pO8bApw9pR+18ct57qEEvcCVgIfYUXjw
         5JrLER9ToP4+jDLCYkbqOpFzeu+CLBXK4s3/bfDs8zSL/5uOQMZcRlC0q3MXTkbXcQzf
         vgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wMWAdJaDoesQ7l4YrmZbXUqFvfIk/aDRRi7TZz1QS+k=;
        b=ejG59kxjO/We2AM79hTtN7BACCBN1rRoGKyw0T5tG30zHdgQwc1kr4lWCckogON8+i
         V1oHZwuHqB79nu7mUx358OPAduN6rYx7JcU1f0YDqpvNqjO3AxG2xZLCQLsvka3nS0e+
         +JOYaG3jJUYkWXQ9D6Sz7tc8801JodxqsIJZqtfSRWIxGWDOfyAl2Pfhyt8RthqV9iwz
         amv2nUNWrWJI+shBtVSe1YlNe13q68fFAPqieAmsl+eog/4AvBfZQVBztFXSEvA46qjt
         /GP19u2Y9bhPYFTKOm3E/0KIgjYvMf0YfchQ9psiPoKmJqjceKm00ac0JcZR06Jhupmd
         743g==
X-Gm-Message-State: AGi0Pub4XizRXb7nB5qtI+4eBX0rJyNFM2AYUjQGgmQxql1RrYiYipPp
        Q57sihfvpR+/Vk4NTBMZu71rlyH/
X-Google-Smtp-Source: APiQypJSJpbaqUlEQ87s31wxTVA85gup8ie6dfGSM/BK4TSTF4oejmNTXj99kBxN9Y241upSC6PRzg==
X-Received: by 2002:a17:906:1f55:: with SMTP id d21mr16288767ejk.320.1586789128613;
        Mon, 13 Apr 2020 07:45:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm1334855edx.13.2020.04.13.07.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:45:28 -0700 (PDT)
Message-Id: <adc03eee4ac8a0911bfd2a7ae03364ef0e744ef0.1586789126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Apr 2020 14:45:23 +0000
Subject: [PATCH v2 1/4] revision: complicated pathspecs disable filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The changed-path Bloom filters work only when we can compute an
explicit Bloom filter key in advance. When a pathspec is given
that allows case-insensitive checks or wildcard matching, we
must disable the Bloom filter performance checks.

By checking the pathspec in prepare_to_use_bloom_filters(), we
avoid setting up the Bloom filter data and thus revert to the
usual logic.

Before this change, the following tests would fail*:

	t6004-rev-list-path-optim.sh (Tests 6-7)
	t6130-pathspec-noglob.sh (Tests 3-6)
	t6131-pathspec-icase.sh (Tests 3-5)

*These tests would fail when using GIT_TEST_COMMIT_GRAPH and
GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS except that the latter
environment variable was not set up correctly to write the changed-
path Bloom filters in the test suite. That will be fixed in the
next change.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2b06ee739c8..f78c636e4d0 100644
--- a/revision.c
+++ b/revision.c
@@ -650,6 +650,20 @@ static void trace2_bloom_filter_statistics_atexit(void)
 	jw_release(&jw);
 }
 
+static int forbid_bloom_filters(struct pathspec *spec)
+{
+	if (spec->has_wildcard)
+		return 1;
+	if (spec->nr > 1)
+		return 1;
+	if (spec->magic & ~PATHSPEC_LITERAL)
+		return 1;
+	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
+		return 1;
+
+	return 0;
+}
+
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
@@ -659,7 +673,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	int len;
 
 	if (!revs->commits)
-	    return;
+		return;
+
+	if (forbid_bloom_filters(&revs->prune_data))
+		return;
 
 	repo_parse_commit(revs->repo, revs->commits->item);
 
-- 
gitgitgadget

