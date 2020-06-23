Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D6C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D559120738
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="cFDZ8Um/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404284AbgFWVCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404280AbgFWVCV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:02:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B79C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 14:02:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so137392pgm.8
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zgx2Rqv750nKdaZN2EVLeZAhnJwZ+1V4aC/XubRUz68=;
        b=cFDZ8Um/14FfVglvj0PUxutkWwhjQWBE8MJWcfwqPHA1FAEx3D1LD/YxWwZheDR3/I
         KHJi7AUwHbj+Suob849Jm/xfk0P1lDrijOuQopC4NW8QdxoBDvW1KH5fLyF0FexaNhyr
         zSyl2ncnwJ37KgYkrLNjDAD7HftFih0X3pBkLnu8IzJT/w4CLn6dkFpLqphsCmVTttsy
         iwo70b2p40vq3aNKUux9aFUlWfV1+YGZNoLXK9kN3ZkOhQYYTiOL59kZohywv/K5fsH9
         DMoC1LzxfukHFiAzENXJJFaPNReijkNjX8ToBR+MfMpJSPGlX6pLYdiUxwZchAmP8sQZ
         Us2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgx2Rqv750nKdaZN2EVLeZAhnJwZ+1V4aC/XubRUz68=;
        b=U8BulRbzfpEXgTwZLLYe2ewW/VjljxpXB3N9XXHbj2TBb+JT50l+ml/yW9l0yi0aIQ
         LpvXAHR8pqDFK4IjR0fohm4/oW+PknbsnRqs6uUvahaRqADtRkb0m1UQFZCnk6i4k76m
         XMQOwu4Icv/14PEmWzZUaPy/KRCtuRJOtWfMuIyv+qGg7iu8Ll78jQa5D+qPodq/44uo
         wgz7h5SHujGIFBiQIRDb3uUAWiyoSaeNRDQmwgfQL0nkh7gw5s28M95uVvYH5w4gwoiF
         W+aXYb/Tpl3KbP+S8Ut+tUUiWKWfZ/LafIZxue7uRiw4srQ7veTVhL/2xzcbMaLbxPbh
         03bA==
X-Gm-Message-State: AOAM531+5H5HUOqRh2kq8SDY1J9w5BBeu881NJmzBJFQ/7qmutTTLIxu
        rS/G6ayRMdOmJHdFzK+8ScrQWh+UI6wg+A==
X-Google-Smtp-Source: ABdhPJyi0LwXxTQCpHM/tOyLwlO3+lWJxTUhFcyJtMM08DRPSUqKl7Pk3PucVCkzy55TKWiWSs5a6Q==
X-Received: by 2002:a65:6799:: with SMTP id e25mr13157417pgr.364.1592946140999;
        Tue, 23 Jun 2020 14:02:20 -0700 (PDT)
Received: from localhost ([2601:647:5180:4570:16dd:a9ff:fee7:6b79])
        by smtp.gmail.com with ESMTPSA id f14sm14967530pgj.62.2020.06.23.14.02.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jun 2020 14:02:20 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 2/2] submodule: use submodule repository when preparing summary
Date:   Tue, 23 Jun 2020 13:56:59 -0700
Message-Id: <20200623205659.14297-2-mforney@mforney.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623205659.14297-1-mforney@mforney.org>
References: <20200623205659.14297-1-mforney@mforney.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In show_submodule_header(), we gather the left and right commits
of the submodule repository, as well as the merge bases. However,
prepare_submodule_summary() initializes the rev_info with the_repository,
so we end up parsing the commit in the wrong repository.

This results in a fatal error in parse_commit_in_graph(), since the
passed item does not belong to the repository's commit graph.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 submodule.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index e2ef5698c8..785ab47629 100644
--- a/submodule.c
+++ b/submodule.c
@@ -438,13 +438,13 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	 */
 }
 
-static int prepare_submodule_summary(struct rev_info *rev, const char *path,
-		struct commit *left, struct commit *right,
+static int prepare_submodule_summary(struct repository *r, struct rev_info *rev,
+		const char *path, struct commit *left, struct commit *right,
 		struct commit_list *merge_bases)
 {
 	struct commit_list *list;
 
-	repo_init_revisions(the_repository, rev, NULL);
+	repo_init_revisions(r, rev, NULL);
 	setup_revisions(0, NULL, rev, NULL);
 	rev->left_right = 1;
 	rev->first_parent_only = 1;
@@ -632,7 +632,7 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 		goto out;
 
 	/* Treat revision walker failure the same as missing commits */
-	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
+	if (prepare_submodule_summary(sub, &rev, path, left, right, merge_bases)) {
 		diff_emit_submodule_error(o, "(revision walker failed)\n");
 		goto out;
 	}
-- 
2.27.0

