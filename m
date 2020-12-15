Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D411C2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651CD22B2D
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgLOS3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbgLOS3h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:29:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DAFC0611CD
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q75so153893wme.2
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FuVethZdiI2jUh5+5cKumgbbQ/flJO7nj960YyQLtEA=;
        b=u1sXvIPzA3oqWOVQWLILBNfl4sKdLzQNKw7700Tev8VldEhAnbTdn3NSYSkmUtOKYn
         7PdJHAxr28BljmVDs4k7p7jDrPkIerG8u7bgPF1HsmnpeBcw2dORMCv/H4heRQndhE5g
         gNK6KwZvBM6dyanMvmCcZ7u3+p7/FSxEBz+zCM0G1MJF/AMNs0zOXt9X4EfprHz1WwAN
         q3k5+vRbvF1Imx/BCsUIPEqRMJRglevZbDj59yf1bMvxa4r3RkpvLrUjQMyhXrSn/7EQ
         3qXQjBmkcRkzJAh1NTfyxqkpn+rU8Gg3qSDFNZhLmMTe8gRanogfQkuq071P88qqVkx1
         nyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FuVethZdiI2jUh5+5cKumgbbQ/flJO7nj960YyQLtEA=;
        b=IztROVDmVTS3z6MNHVo0Q2wGRYI+Ws4GRaN1CFKoyvliMx+ebqfRgIIljCQXELYeiE
         EuSiB6S4z0LGzK576YQQfbq2Px2LClUlmINOiYUfrOmxOiPpPUOCrMJV5GTLP8o2QKWO
         RdBCTsx9KknV12iBEIb/o3vjVAuRR+vyN2CVhi/2iNP9AIiS/KHS9xi8JitqR0bnu/lw
         HwvRCbFwcP+vYsuZRoc1fJu37MreUEIfL8yQpaew3uoxZkbh2EUX2bGbNeb/EUYF9GER
         CwY82Ri7c09VcMqlPqCvSdMLXI7c0JfezGAuRUea+OoyZcE9hHB76M6d84xcF3+BVaeM
         /wzQ==
X-Gm-Message-State: AOAM5315Vbmn7/s4O+6xn1Ns2pXmgUo+hOPp85vYij5KH96BtwP5F/gi
        3rJEfwjzEOlZHHL/4R7ilSy+kBZ2bPk=
X-Google-Smtp-Source: ABdhPJzn7fmnaflN+Xr/pxyzEz4I8TVc+Wjw0TuT7dOlcVZjOle7geuQA1UwHQkwh6NEuni9DYlv/g==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr167185wmb.77.1608056898094;
        Tue, 15 Dec 2020 10:28:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r82sm39022356wma.18.2020.12.15.10.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:17 -0800 (PST)
Message-Id: <8f4662398ab4421a466b88b8984bd047528f31f1.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:28:06 +0000
Subject: [PATCH v3 11/11] merge-ort: add implementation of type-changed rename
 handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement cases where renames are involved in type changes (i.e. the
side of history that didn't rename the file changed its type from a
regular file to a symlink or submodule).  There was some code to handle
this in merge-recursive but only in the special case when the renamed
file had no content changes.  The code here works differently -- it
knows process_entry() can handle mode conflicts, so it does a few
minimal tweaks to ensure process_entry() can just finish the job as
needed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 26f357e524f..677c6a878c5 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -777,8 +777,33 @@ static int process_renames(struct merge_options *opt,
 			(S_ISREG(oldinfo->stages[other_source_index].mode) !=
 			 S_ISREG(newinfo->stages[target_index].mode));
 		if (type_changed && collision) {
-			/* special handling so later blocks can handle this */
-			die("Not yet implemented");
+			/*
+			 * special handling so later blocks can handle this...
+			 *
+			 * if type_changed && collision are both true, then this
+			 * was really a double rename, but one side wasn't
+			 * detected due to lack of break detection.  I.e.
+			 * something like
+			 *    orig: has normal file 'foo'
+			 *    side1: renames 'foo' to 'bar', adds 'foo' symlink
+			 *    side2: renames 'foo' to 'bar'
+			 * In this case, the foo->bar rename on side1 won't be
+			 * detected because the new symlink named 'foo' is
+			 * there and we don't do break detection.  But we detect
+			 * this here because we don't want to merge the content
+			 * of the foo symlink with the foo->bar file, so we
+			 * have some logic to handle this special case.  The
+			 * easiest way to do that is make 'bar' on side1 not
+			 * be considered a colliding file but the other part
+			 * of a normal rename.  If the file is very different,
+			 * well we're going to get content merge conflicts
+			 * anyway so it doesn't hurt.  And if the colliding
+			 * file also has a different type, that'll be handled
+			 * by the content merge logic in process_entry() too.
+			 *
+			 * See also t6430, 'rename vs. rename/symlink'
+			 */
+			collision = 0;
 		}
 		if (source_deleted) {
 			if (target_index == 1) {
@@ -859,7 +884,11 @@ static int process_renames(struct merge_options *opt,
 			newinfo->pathnames[0] = oldpath;
 			if (type_changed) {
 				/* rename vs. typechange */
-				die("Not yet implemented");
+				/* Mark the original as resolved by removal */
+				memcpy(&oldinfo->stages[0].oid, &null_oid,
+				       sizeof(oldinfo->stages[0].oid));
+				oldinfo->stages[0].mode = 0;
+				oldinfo->filemask &= 0x06;
 			} else if (source_deleted) {
 				/* rename/delete */
 				newinfo->path_conflict = 1;
-- 
gitgitgadget
