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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF841C43332
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A844664EE8
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhCMWWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhCMWWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 17:22:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5164BC061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j18so3740293wra.2
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=R0z04Hb9b++84+nOhWzCIZ+vt6ikrVYjzV56JkLhAzc=;
        b=LSHPc5UP8AjkUrcSg+qk2ug+YgS/SJ3j5i2K+tMcSQckBea3MhUVzLr6YMN2EWKMpg
         YLAsYUnwwEEgWcQjDSknIu0WnVbwkUfuTfETD9k73QfBSj7BoGiVtoytHp1OIlYAKlMg
         YzVddNDzexvSBTozKd8YBunav1mmDWVIz+eM82RbY0zMLNsVAl1OB4a4hZtWAOl3PadN
         CwU0OXA7jtjWWKN++p6LgoU3s9s6y0D3a5+GHUqTkOrPjekNxg8arSsQOLWJ1mcVtY1v
         BMQlUXcqMitWbws6YY4UsYOQCudHVhdeWRkm4Nw5Dx42xOzQSyEGZRJZ5VNE19ZXzbb+
         K3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=R0z04Hb9b++84+nOhWzCIZ+vt6ikrVYjzV56JkLhAzc=;
        b=t7LJUly7qmNohP1/3JDbabbMcIQG42ypCBc2y2JcNz9bi2bGFm0fs6u70NMoN9SHjf
         AITVjZHZ4nP2y/gPqOc1RuHdterUkadEzrm2ru/mICnWwgx8ci9+e20UgGelnTRZa0aS
         RgA3IsQ+CnX332mRR/6VDqnuf6+f9w5x57Q2tFhgf21rhgdEoM5BQb9fxqKzo/sB28K4
         TmL8zpvoV096UytQz9CCwU2xwW9JLvylUDPLiOhDNtQK4cH+vEIsz7oxrrqMUQr3ngTh
         FwaJQYCCkTgmM4uu41UCzMh7IwuViTPELwPTSpBI8UgbBDqFhR3aIPGnTVQ8Bn6AYR6C
         cY2w==
X-Gm-Message-State: AOAM533tITEzMSRTt/fnhQty38zEcrVcnMFPxACEocUDd5G88x3zpuUh
        LQA90Nlw2TBeBRxImPKd0QEl1+TNm0w=
X-Google-Smtp-Source: ABdhPJzofzo0WRcbrc0d6R1sbwbzbAfHpwTOIEkNWpNryOlg7bri8vrMBpx5qC7AjKc5SbS7VSOozA==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr20328648wrr.93.1615674134102;
        Sat, 13 Mar 2021 14:22:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm8659226wmd.27.2021.03.13.14.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 14:22:13 -0800 (PST)
Message-Id: <495c10937b7f2b23b7d2a52c254e02ae9ce810a1.1615674128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.853.git.1615674128.gitgitgadget@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 22:22:08 +0000
Subject: [PATCH 8/8] diffcore-rename: determine which relevant_sources are no
 longer relevant
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted a few commits ago ("diffcore-rename: only compute
dir_rename_count for relevant directories"), when a source file rename
is used as part of directory rename detection, we need to increment
counts for each ancestor directory in dirs_removed with value
RELEVANT_FOR_SELF.  However, a few commits ago ("diffcore-rename: check
if we have enough renames for directories early on"), we may have
downgraded all relevant ancestor directories from RELEVANT_FOR_SELF to
RELEVANT_FOR_ANCESTOR.

For a given file, if no ancestor directory is found in dirs_removed with
a value of RELEVANT_FOR_SELF, then we can downgrade
relevant_source[PATH] from RELEVANT_LOCATION to RELEVANT_NO_MORE.  This
means we can skip detecting a rename for that particular path (and any
other paths in the same directory).

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        5.680 s ±  0.096 s     5.665 s ±  0.129 s
    mega-renames:     13.812 s ±  0.162 s    11.435 s ±  0.158 s
    just-one-mega:   506.0  ms ±  3.9  ms   494.2  ms ±  6.1  ms

While this improvement looks rather modest for these testcases (because
all the previous optimizations were sufficient to nearly remove all time
spent in rename detection already),  consider this alternative testcase
tweaked from the ones in commit 557ac0350d as follows

    <Same initial setup as commit 557ac0350d, then...>
    $ git switch -c add-empty-file v5.5
    $ >drivers/gpu/drm/i915/new-empty-file
    $ git add drivers/gpu/drm/i915/new-empty-file
    $ git commit -m "new file"
    $ git switch 5.4-rename
    $ git cherry-pick --strategy=ort add-empty-file

For this testcase, we see the following improvement:

                            Before                  After
    pick-empty:        1.936 s ±  0.024 s     688.1 ms ±  4.2 ms

So roughly a factor of 3 speedup.  At $DAYJOB, there was a particular
repository and cherry-pick that inspired this optimization; for that
case I saw a speedup factor of 7 with this optimization.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9844cd48788e..7cc24592617e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1129,7 +1129,7 @@ static void handle_early_known_dir_renames(struct dir_rename_info *info,
 	 * a majority.
 	 */
 
-	int i;
+	int i, new_num_src;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 
@@ -1193,6 +1193,55 @@ static void handle_early_known_dir_renames(struct dir_rename_info *info,
 				      RELEVANT_FOR_ANCESTOR);
 		}
 	}
+
+	for (i = 0, new_num_src = 0; i < rename_src_nr; i++) {
+		struct diff_filespec *one = rename_src[i].p->one;
+		int val;
+
+		val = strintmap_get(relevant_sources, one->path);
+
+		/*
+		 * sources that were not found in relevant_sources should
+		 * have already been removed by a prior call to
+		 * remove_unneeded_paths_from_src()
+		 */
+		assert(val != -1);
+
+		if (val == RELEVANT_LOCATION) {
+			int removable = 1;
+			char *dir = get_dirname(one->path);
+			while (1) {
+				char *freeme = dir;
+				int res = strintmap_get(dirs_removed, dir);
+
+				/* Quit if not found or irrelevant */
+				if (res == NOT_RELEVANT)
+					break;
+				/* If RELEVANT_FOR_SELF, can't remove */
+				if (res == RELEVANT_FOR_SELF) {
+					removable = 0;
+					break;
+				}
+				/* Else continue searching upwards */
+				assert(res == RELEVANT_FOR_ANCESTOR);
+				dir = get_dirname(dir);
+				free(freeme);
+			}
+			free(dir);
+			if (removable) {
+				strintmap_set(relevant_sources, one->path,
+					      RELEVANT_NO_MORE);
+				continue;
+			}
+		}
+
+		if (new_num_src < i)
+			memcpy(&rename_src[new_num_src], &rename_src[i],
+			       sizeof(struct diff_rename_src));
+		new_num_src++;
+	}
+
+	rename_src_nr = new_num_src;
 }
 
 void diffcore_rename_extended(struct diff_options *options,
-- 
gitgitgadget
