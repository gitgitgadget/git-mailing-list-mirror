Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3936C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 19:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJLTFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJLTFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 15:05:37 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B7D38EF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:05:36 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id q18so6472330ils.12
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geDVt+qjHYdErwPo1NZNF5eogvvbIqCWqz5tigU4SXo=;
        b=ciiaxH3o4vyYQGzU6MzYVyezqqSbiHmUnpoXDDROZ5n8o9BbzDQarwFCfJbDHYiqZB
         eZ+lmt2WyXkSBj6rM79EthyNJbW5P/EayRxc+Sb+1wnx4CW4rXwaTc4UbW+ZZXHSkMMf
         tPQDyxzT2BbiLg1uekV8EqysIDGaGYNQsclokHtZ0d586wrCv3GBtkKKHmqyPXrivERs
         FDry16laAUee1byKtlJFCD6zt8mUaqp4INCes7XqvRAFqKA2hRBmwRSAsf2eCwgZqm3g
         A3CK4zSDD8mzauVsCTuHiLY4JL/yrohx1CaSWzjfvkojPE2vi/ZoaXQeFEzqLmexqtlc
         b/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geDVt+qjHYdErwPo1NZNF5eogvvbIqCWqz5tigU4SXo=;
        b=JMv2WxKFiQ/YTru3vxejPCLkNN5ithrsZna+Oy6DFwvkrpz7UW7XSVbmBHgPLuH2yY
         /8FVIK1ScWPemXuyt4Yoi01SLTn7LXHlLF48MCseBYb4c+TyWN34q7Gazrz/GihqWzh5
         2XJSCx4giri6+hH0cdh0pZakxjbFseCK86uecBTc5cIXtFYTjJRo1Y77TA0cUxTdmApe
         m7zb2qcPwfitGwkKiD/bkFyKzyW3QngbIJEpw5jFTErOWZMtZnFbay9C4dRDcFewt4zW
         +jJpWcElDzec8TwPM7I5q5dgWJnqIzJXzMOCV4inacTJYkb3JiXR+x3lU6GyJNYuOZzU
         MU4Q==
X-Gm-Message-State: ACrzQf3ID/eRrO9b3kI29t9FK6hOBKfQXV8QZdLy43aTBKcvQM0xtsEq
        2VI9f/1tgXRXp8jrZ3PzKekWShOXCLPOZy5X
X-Google-Smtp-Source: AMsMyM6M3q91aMz/myfIMxCS1av2VBRoU5yHICutPsIz00UMRrW9lMw+ZpKRHkFbIWoptTsF9vEbMA==
X-Received: by 2002:a92:cccc:0:b0:2fc:cc40:6a7 with SMTP id u12-20020a92cccc000000b002fccc4006a7mr1314803ilq.68.1665601535637;
        Wed, 12 Oct 2022 12:05:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e31-20020a028622000000b0035b496b0a7fsm6572392jai.36.2022.10.12.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:05:34 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:05:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH] builtin/repack.c: remove redundant pack-based bitmaps
Message-ID: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we write a MIDX bitmap after repacking, it is possible that the
repository would be left in a state with both pack- and multi-pack
reachability bitmaps.

This can occur, for instance, if a pack that was kept (either by having
a .keep file, or during a geometric repack in which it is not rolled up)
has a bitmap file, and the repack wrote a multi-pack index and bitmap.

When loading a reachability bitmap for the repository, the multi-pack
one is always preferred, so the pack-based one is redundant. Let's
remove it unconditionally, even if '-d' isn't passed, since there is no
practical reason to keep both around. The patch below does just that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c  | 40 +++++++++++++++++++++++++++++++++++++---
 t/t7700-repack.sh | 21 +++++++++++++++++++++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a5bacc7797..59001e8020 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -661,6 +661,35 @@ static int write_midx_included_packs(struct string_list *include,
 	return finish_command(&cmd);
 }
 
+static void remove_redundant_bitmaps(struct string_list *include,
+				     const char *packdir)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct string_list_item *item;
+	size_t packdir_len;
+
+	strbuf_addstr(&path, packdir);
+	strbuf_addch(&path, '/');
+	packdir_len = path.len;
+
+	/*
+	 * Remove any pack bitmaps corresponding to packs which are now
+	 * included in the MIDX.
+	 */
+	for_each_string_list_item(item, include) {
+		strbuf_addstr(&path, item->string);
+		strbuf_strip_suffix(&path, ".idx");
+		strbuf_addstr(&path, ".bitmap");
+
+		if (unlink(path.buf) && errno != ENOENT)
+			die_errno(_("could not remove stale bitmap: %s"),
+				  path.buf);
+
+		strbuf_setlen(&path, packdir_len);
+	}
+	strbuf_release(&path);
+}
+
 static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *pack_prefix,
 			    struct string_list *names,
@@ -1059,10 +1088,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
 						show_progress, write_bitmaps > 0);
 
+		if (ret) {
+			string_list_clear(&include, 0);
+			return ret;
+		}
+
+		if (write_bitmaps)
+			remove_redundant_bitmaps(&include, packdir);
+
 		string_list_clear(&include, 0);
-
-		if (ret)
-			return ret;
 	}
 
 	reprepare_packed_git(the_repository);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index ca45c4cd2c..2d0e9448dd 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -426,6 +426,27 @@ test_expect_success '--write-midx -b packs non-kept objects' '
 	)
 '
 
+test_expect_success '--write-midx removes stale pack-based bitmaps' '
+       rm -fr repo &&
+       git init repo &&
+       test_when_finished "rm -fr repo" &&
+       (
+		cd repo &&
+		test_commit base &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Ab &&
+
+		pack_bitmap=$(ls $objdir/pack/pack-*.bitmap) &&
+		test_path_is_file "$pack_bitmap" &&
+
+		test_commit tip &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -bm &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+		test_path_is_missing $pack_bitmap
+       )
+'
+
 test_expect_success TTY '--quiet disables progress' '
 	test_terminal env GIT_PROGRESS_DELAY=0 \
 		git -C midx repack -ad --quiet --write-midx 2>stderr &&
-- 
2.38.0.16.g393fd4c6db
