Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA65BC4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B8760E78
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhGYM2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:28:43 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:12476 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhGYM2H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 1591B12A9;
        Sun, 25 Jul 2021 15:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218515; x=1629032916;
         bh=0jMdcEl+v8anRYlylgj5GIKKh1JdlpG6Qo+FJNJT3hs=; b=eRCuHVC3sQ4j
        8tg2Joy2W+tSLJwNkK8G328k2wxwF7o/UxbzbIyqmrL+g0s1PgbCkWSXSOGU1zO3
        FDMLuHCXY5Xi2wNWMg6aLuk/PzuNN360qUyzHBgmmMGRLD63KkcS3/7QHEnJOtPh
        vii4awT0+WhnDYogSZFV/Ifx2CZMImMIxx9R53eOLVFm4G/VrFM3T8y2jrjK5jqu
        G8WZr/dOkzh5i7Mf/u8nsHUHst0p02sAW9TKghKe8bBZVNv2BLZzjP0FUwYmoKiK
        Pkf/nJxovEoyYvlJzJwPidb+GaUnW3a81m8JpO0lwfu/cuP43RnpGoNcwJ9VzEDf
        un27qsJIofr6Wg8HgwnfDFfcgM/gErtJAmFhtbX5WtMQdu0CHWPiYEj05isT7xLg
        vWB1wOGpK2MOoF3AmeCWduhdrP/pchDsEyNRV2uR6pCGt1fLnOy2V0OdXiulaa6R
        FPWBBuuHgjSINtlT/k0F3hT7fVS8mnx2er5Fy6QWHF6WBj1ycCkFmpdOHWb23tgg
        iigp3BXBmU2i/EZtH7bzrlQ8uV1VS9Wym6YB6NjmY2ThEfw8Dv3qrRYQta+ZBVBm
        L/nTlrLAQD5BEJF6yPAfssJC7dA57W32htbtfP3zr1k9QOTYQ1dgotIL0xX2kfr+
        1w3yt5FZzPr1KPxJyWbBOQhXxQ1iwws=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ENf_ftrME_bv; Sun, 25 Jul 2021 15:08:35 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 78600BCD;
        Sun, 25 Jul 2021 15:08:35 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 4CD182469;
        Sun, 25 Jul 2021 15:08:33 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 00/12] Fix all leaks in tests t0002-t0099: Part 2
Date:   Sun, 25 Jul 2021 15:08:18 +0200
Message-Id: <20210725130830.5145-1-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

V2 fixes patch 11/12 (rebase_options.strategy lifecycle) as per review
discussion. Many thanks to Phillip and Elijah for spotting the issues there!

ATB,

  Andrzej

Andrzej Hunt (12):
  fmt-merge-msg: free newly allocated temporary strings when done
  environment: move strbuf into block to plug leak
  builtin/submodule--helper: release unused strbuf to avoid leak
  builtin/for-each-repo: remove unnecessary argv copy to plug leak
  diffcore-rename: move old_dir/new_dir definition to plug leak
  ref-filter: also free head for ATOM_HEAD to avoid leak
  read-cache: call diff_setup_done to avoid leak
  convert: release strbuf to avoid leak
  builtin/mv: free or UNLEAK multiple pointers at end of cmd_mv
  builtin/merge: free found_ref when done
  builtin/rebase: fix options.strategy memory lifecycle
  reset: clear_unpack_trees_porcelain to plug leak

 builtin/for-each-repo.c     | 14 ++++----------
 builtin/merge.c             |  3 ++-
 builtin/mv.c                |  5 +++++
 builtin/rebase.c            |  3 ++-
 builtin/submodule--helper.c |  6 ++++--
 convert.c                   |  2 ++
 diffcore-rename.c           | 10 +++++++---
 environment.c               |  7 +++----
 fmt-merge-msg.c             |  6 ++++--
 read-cache.c                |  1 +
 ref-filter.c                |  8 ++++++--
 reset.c                     |  4 ++--
 12 files changed, 42 insertions(+), 27 deletions(-)

Interdiff against v1:
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9d81db0f3a..33e0961900 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1723,6 +1723,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (options.strategy) {
+		options.strategy = xstrdup(options.strategy);
 		switch (options.type) {
 		case REBASE_APPLY:
 			die(_("--strategy requires --merge or --interactive"));
@@ -1775,7 +1776,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.type == REBASE_MERGE &&
 	    !options.strategy &&
 	    getenv("GIT_TEST_MERGE_ALGORITHM"))
-		options.strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
+		options.strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
 
 	switch (options.type) {
 	case REBASE_MERGE:
@@ -2108,6 +2109,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.head_name);
 	free(options.gpg_sign_opt);
 	free(options.cmd);
+	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
 	return ret;
-- 
2.26.2

