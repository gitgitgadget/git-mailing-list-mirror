Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D9C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49938206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MxO8KhIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgKYRRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 12:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbgKYRRc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 12:17:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457FCC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:17:32 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b63so2921294pfg.12
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kSUzz6oZiVkN7bwi7Iy4qoKpkmDgc8biv7EHgaXpvgY=;
        b=MxO8KhIyY8nfjbojRDfTjuRH2fPFqueJ+nfGjzrBMJP/T8er+2FjSTvk6DuD6KwSWm
         kF+k4X8nMQx7Bfd8VPqpM/YyqaCoSgXntM+31P9XF8qBhuh4CfQgGROgs6Hxlhf9TmiW
         xcgPvIiv8QBWOnhY9u4GzIISkrvvfPuEH88mzlpHf7vVGqK28iv2lWSxn1Uidn6XWBdf
         JClw5Qv2uH6MnhB1mSXXBUik0OuArEetI1ds8Ws7MKdpc+4p4xr92A5FAWuRvvvGQQ33
         304TyC6Kyi99aaOjnoZ81wdHNsQpT/n5fLFFGi4kDg+1A+kClUb2cSLAdXubC3rRm7wB
         ghFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kSUzz6oZiVkN7bwi7Iy4qoKpkmDgc8biv7EHgaXpvgY=;
        b=uN3wqoY+WfbcbvWMxkREqySIVpmArJhhguO3c4WnRztXJ9MWIxnQgJie+WjBeuBmlr
         bSzSNflpzjtrk+mcZmcFsTEBurkOPNMOzlT6d0A5NFbrDtM/L96aD9Ma41tk7dIJKVy0
         7ruF13gUd9ilyTfkOnOamYCUpc8bRx90HQ9C1Jz5fcDP0eWHHW1GuuYQIiFVFRSi4YrI
         i7Ux9S55xPwADNPvBaT5c/fjr73zPebzvmH4tSZpzOxzEav/zY0GgnuYPa/YNS7GLWbN
         n1zk+ZlnO609U/ACJJK8JnvujXE05bZ4tnvZgwb+E00SneWnxtNi+00MWpq4FJroGVsJ
         hDhg==
X-Gm-Message-State: AOAM530tKdxUjJjRM/Tu3dNpIt08O0VDfIpl3SCIN/sKJc0eqsb82teP
        VWiIWEbuDW15yQIy2EkvYXZWC78I2uLIpWjF
X-Google-Smtp-Source: ABdhPJz/wQvHCV6vTRrH7BXj6kBV2tseNimOu4qi6DFdTa3dewaVGiAdxezlj49Ykkt6xkFrhbXxIA==
X-Received: by 2002:a05:6a00:13a3:b029:18b:d5d2:196 with SMTP id t35-20020a056a0013a3b029018bd5d20196mr635689pfg.62.1606324651429;
        Wed, 25 Nov 2020 09:17:31 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id p127sm2553895pfp.93.2020.11.25.09.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 09:17:30 -0800 (PST)
Date:   Wed, 25 Nov 2020 12:17:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 1/2] packfile.c: protect against disappearing indexes
Message-ID: <cee25cc1ca5bc3371e32099980f28b623c1349d5.1606324509.git.me@ttaylorr.com>
References: <cover.1606324509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1606324509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 17c35c8969 (packfile: skip loading index if in multi-pack-index,
2018-07-12) we stopped loading the .idx file for packs that are
contained within a multi-pack index.

This saves us the effort of loading an .idx and doing some lightweight
validity checks by way of 'packfile.c:load_idx()', but introduces a race
between processes that need to load the index (e.g., to generate a
reverse index) and processes that can delete the index.

For example, running the following in your shell:

    $ git init repo && cd repo
    $ git commit --allow-empty -m 'base'
    $ git repack -ad && git multi-pack-index write

followed by:

    $ rm -f .git/objects/pack/pack-*.idx
    $ git rev-parse HEAD | git cat-file --batch-check='%(objectsize:disk)'

will result in a segfault prior to this patch. What's happening here is
that we notice that the pack is in the multi-pack index, and so don't
check that it still has a .idx. When we then try and load that index to
generate a reverse index, we don't have it, so the call to
'find_pack_revindex()' in 'packfile.c:packed_object_info()' returns
NULL, and then dereferencing it causes a segfault.

Of course, we don't ever expect someone to remove the index file by
hand, or to be in a state where we never wrote it to begin with (yet
find that pack in the multi-pack-index). But, this can happen in a
timing race with 'git repack -ad', which removes all existing packs
after writing a new pack containing all of their objects.

Avoid this by reverting the hunk of 17c35c8969 which stops loading the
index when the pack is contained in a MIDX. This makes the latter half
of 17c35c8969 useless, since we'll always have a non-NULL
'p->index_data', in which case that if statement isn't guarding
anything.

These two together effectively revert 17c35c8969, and avoid the race
explained above.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c                  | 19 ++-----------------
 t/t5319-multi-pack-index.sh | 24 ++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0929ebe4fc..8d7f37a5f6 100644
--- a/packfile.c
+++ b/packfile.c
@@ -514,19 +514,8 @@ static int open_packed_git_1(struct packed_git *p)
 	ssize_t read_result;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
-	if (!p->index_data) {
-		struct multi_pack_index *m;
-		const char *pack_name = pack_basename(p);
-
-		for (m = the_repository->objects->multi_pack_index;
-		     m; m = m->next) {
-			if (midx_contains_pack(m, pack_name))
-				break;
-		}
-
-		if (!m && open_pack_index(p))
-			return error("packfile %s index unavailable", p->pack_name);
-	}
+	if (open_pack_index(p))
+		return error("packfile %s index unavailable", p->pack_name);
 
 	if (!pack_max_fds) {
 		unsigned int max_fds = get_max_fd_limit();
@@ -567,10 +556,6 @@ static int open_packed_git_1(struct packed_git *p)
 			" supported (try upgrading GIT to a newer version)",
 			p->pack_name, ntohl(hdr.hdr_version));
 
-	/* Skip index checking if in multi-pack-index */
-	if (!p->index_data)
-		return 0;
-
 	/* Verify the pack matches its index. */
 	if (p->num_objects != ntohl(hdr.hdr_entries))
 		return error("packfile %s claims to have %"PRIu32" objects"
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ace469c95c..d4607daec1 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -138,7 +138,7 @@ test_expect_success 'write midx with one v2 pack' '
 
 compare_results_with_midx "one v2 pack"
 
-test_expect_success 'corrupt idx not opened' '
+test_expect_success 'corrupt idx reports errors' '
 	idx=$(test-tool read-midx $objdir | grep "\.idx\$") &&
 	mv $objdir/pack/$idx backup-$idx &&
 	test_when_finished "mv backup-\$idx \$objdir/pack/\$idx" &&
@@ -149,7 +149,7 @@ test_expect_success 'corrupt idx not opened' '
 	test_copy_bytes 1064 <backup-$idx >$objdir/pack/$idx &&
 
 	git -c core.multiPackIndex=true rev-list --objects --all 2>err &&
-	test_must_be_empty err
+	grep "index unavailable" err
 '
 
 test_expect_success 'add more objects' '
@@ -755,4 +755,24 @@ test_expect_success 'repack --batch-size=<large> repacks everything' '
 	)
 '
 
+test_expect_success 'load reverse index when missing .idx' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		git config core.multiPackIndex true &&
+
+		test_commit base &&
+		git repack -ad &&
+		git multi-pack-index write &&
+
+		git rev-parse HEAD >tip &&
+		idx=$(ls .git/objects/pack/pack-*.idx) &&
+
+		mv $idx $idx.bak &&
+		git cat-file --batch-check="%(objectsize:disk)" <tip
+	)
+'
+
 test_done
-- 
2.29.2.368.ge1806d1bdc

