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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1189FC43381
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB187221EC
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbhAACgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbhAACgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:36:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D394DC0617A1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q18so21318543wrn.1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OhtQzFMI2wfrUKk4Dudo41Vcv3rpe9NHzEcS9zY8l0c=;
        b=t3/7DvnV7PxAgwwcNbzBXilBQ8U+BHopV2OEAY6UcvxTPKNr9r/RnBhMUciEPs1Qyq
         Rvala1zX9C4UVLDVmCc3EjEw33B3TGybduaCA3F8usHDxzot3YBE/tADRMFCiTF91fou
         RbopoVVRgwYSxLopQtnBq/mYVCkz8K4TS7+IocR7Q/r7m+KqZ7+DbBs1yjZgfuPStuix
         /NXjF2H8XdRahtlhdDDZQvuD8ECPaZ7kGt/E3jC4VyzVpyU6J5Tp6NdhxPrW5vBDGEXT
         GNxQ8ltCcaYkNOagFE66mZItuxvf3tdV4ZWI7Mq9fBQXcmxVObdQ/vcvSgtS9ZDHW+46
         wZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OhtQzFMI2wfrUKk4Dudo41Vcv3rpe9NHzEcS9zY8l0c=;
        b=H0fo0y8FIP1srBO8C2YquF/eAtB6yB03OG0KhJMLGlOXpX5jUeVGLLVV7IyXnbpQbg
         NaXq7FvBhjO5i6t0Ls9criH9eQVyCpyQjjGMuwlxnbGOwI95gowbGxzlSo1MUQiCg8es
         1ZmOKPzsZajqeVfSX46hD/kcGm1+o8xoPKKXlg1Vl6VFlZfK38kiciAlVbcUBq4VQhtY
         2RjyLbA4lUPUwS0HePDWdqd5N6DrwwKf/hXTR4SrG/YSb2AcluUo7HC6NmAlVHhmhy2A
         U9MPisbzD2ydDGEwTpeJAHmskCg2su31hashQ/fdHAGsZWr6S3XNDJC43um5RwI0gMyu
         RiAA==
X-Gm-Message-State: AOAM533gwGbe2kck9dv58G46WMFStZE5cMNWDsu3RMzVyG3btbjty/Bf
        2TSH7r04PWK0DXaCvn+XMgLb8SRpPtE=
X-Google-Smtp-Source: ABdhPJwst+Ee8rn77FTMeBjGhixAFOeqxG6GAclujO8ujKadfpqjn4/PdOAI3/mxx3MGldz5L2lG4g==
X-Received: by 2002:adf:c40e:: with SMTP id v14mr66592727wrf.163.1609468498450;
        Thu, 31 Dec 2020 18:34:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm38837171wrh.78.2020.12.31.18.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:58 -0800 (PST)
Message-Id: <34eb647df40aa61ac961753118112ca2695eab4c.1609468488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
        <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:48 +0000
Subject: [PATCH v2 10/10] merge-ort: add handling for different types of files
 at same path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add some handling that explicitly considers collisions of the following
types:
  * file/submodule
  * file/symlink
  * submodule/symlink
Leaving them as conflicts at the same path are hard for users to
resolve, so move one or both of them aside so that they each get their
own path.

Note that in the case of recursive handling (i.e. call_depth > 0), we
can just use the merge base of the two merge bases as the merge result
much like we do with modify/delete conflicts, binary files, conflicting
submodule values, and so on.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 203fa987e43..afe721182e2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1521,10 +1521,109 @@ static void process_entry(struct merge_options *opt,
 	} else if (ci->filemask >= 6 &&
 		   (S_IFMT & ci->stages[1].mode) !=
 		   (S_IFMT & ci->stages[2].mode)) {
-		/*
-		 * Two different items from (file/submodule/symlink)
-		 */
-		die("Not yet implemented.");
+		/* Two different items from (file/submodule/symlink) */
+		if (opt->priv->call_depth) {
+			/* Just use the version from the merge base */
+			ci->merged.clean = 0;
+			oidcpy(&ci->merged.result.oid, &ci->stages[0].oid);
+			ci->merged.result.mode = ci->stages[0].mode;
+			ci->merged.is_null = (ci->merged.result.mode == 0);
+		} else {
+			/* Handle by renaming one or both to separate paths. */
+			unsigned o_mode = ci->stages[0].mode;
+			unsigned a_mode = ci->stages[1].mode;
+			unsigned b_mode = ci->stages[2].mode;
+			struct conflict_info *new_ci;
+			const char *a_path = NULL, *b_path = NULL;
+			int rename_a = 0, rename_b = 0;
+
+			new_ci = xmalloc(sizeof(*new_ci));
+
+			if (S_ISREG(a_mode))
+				rename_a = 1;
+			else if (S_ISREG(b_mode))
+				rename_b = 1;
+			else {
+				rename_a = 1;
+				rename_b = 1;
+			}
+
+			path_msg(opt, path, 0,
+				 _("CONFLICT (distinct types): %s had different "
+				   "types on each side; renamed %s of them so "
+				   "each can be recorded somewhere."),
+				 path,
+				 (rename_a && rename_b) ? _("both") : _("one"));
+
+			ci->merged.clean = 0;
+			memcpy(new_ci, ci, sizeof(*new_ci));
+
+			/* Put b into new_ci, removing a from stages */
+			new_ci->merged.result.mode = ci->stages[2].mode;
+			oidcpy(&new_ci->merged.result.oid, &ci->stages[2].oid);
+			new_ci->stages[1].mode = 0;
+			oidcpy(&new_ci->stages[1].oid, &null_oid);
+			new_ci->filemask = 5;
+			if ((S_IFMT & b_mode) != (S_IFMT & o_mode)) {
+				new_ci->stages[0].mode = 0;
+				oidcpy(&new_ci->stages[0].oid, &null_oid);
+				new_ci->filemask = 4;
+			}
+
+			/* Leave only a in ci, fixing stages. */
+			ci->merged.result.mode = ci->stages[1].mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+			ci->stages[2].mode = 0;
+			oidcpy(&ci->stages[2].oid, &null_oid);
+			ci->filemask = 3;
+			if ((S_IFMT & a_mode) != (S_IFMT & o_mode)) {
+				ci->stages[0].mode = 0;
+				oidcpy(&ci->stages[0].oid, &null_oid);
+				ci->filemask = 2;
+			}
+
+			/* Insert entries into opt->priv_paths */
+			assert(rename_a || rename_b);
+			if (rename_a) {
+				a_path = unique_path(&opt->priv->paths,
+						     path, opt->branch1);
+				strmap_put(&opt->priv->paths, a_path, ci);
+			}
+
+			if (rename_b)
+				b_path = unique_path(&opt->priv->paths,
+						     path, opt->branch2);
+			else
+				b_path = path;
+			strmap_put(&opt->priv->paths, b_path, new_ci);
+
+			if (rename_a && rename_b) {
+				strmap_remove(&opt->priv->paths, path, 0);
+				/*
+				 * We removed path from opt->priv->paths.  path
+				 * will also eventually need to be freed, but
+				 * it may still be used by e.g.  ci->pathnames.
+				 * So, store it in another string-list for now.
+				 */
+				string_list_append(&opt->priv->paths_to_free,
+						   path);
+			}
+
+			/*
+			 * Do special handling for b_path since process_entry()
+			 * won't be called on it specially.
+			 */
+			strmap_put(&opt->priv->conflicted, b_path, new_ci);
+			record_entry_for_tree(dir_metadata, b_path,
+					      &new_ci->merged);
+
+			/*
+			 * Remaining code for processing this entry should
+			 * think in terms of processing a_path.
+			 */
+			if (a_path)
+				path = a_path;
+		}
 	} else if (ci->filemask >= 6) {
 		/* Need a two-way or three-way content merge */
 		struct version_info merged_file;
-- 
gitgitgadget
