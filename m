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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584FEC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425F961154
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhGLR67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbhGLR6x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7335C0613E9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r11so21535546wro.9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O0bk0uMoOfzc+R3V+w3r7b7PaKiQoEFR2JUhLyX6ccg=;
        b=uEDf/4iETF/IUh/+8bjYd9pXMdTRe1gLO73uh8Gkr1z3eB6md6Yol9x9q/ErZMoLff
         h0OGu32B/IPLd4EYyGKbayjlABy4HnOYBI6noeJa2PTkubfIGpshYMw2Xieu3dUHksFx
         GttuaFqMdyxEPeD3y0hYj3Bue9z6StLIy191hmbVNOXfXrSt08MJiWJZCd8bI1DDZ0zh
         2xPbYnzYQrQq2NWCOqttybgiGL7HvO7khWvtR8sBoyvpqIzSeuR7q2QfV7Dvp9jn2pdf
         PgSDxWPkt92q2q0qUCTsKDPC3H0uM5JSGKoMz/okC37ZdEKSttWuKdIxCumxOaY+QfMP
         Ux6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O0bk0uMoOfzc+R3V+w3r7b7PaKiQoEFR2JUhLyX6ccg=;
        b=O/wQGXdjZVSIAlzKkUHZzAnfVf/ZJfA9GR0d+6WiRkWNJnEfcP423UY3uFkd8o1Em2
         qwMFxkt+UTFH2cnhJhA8VgR6JR6iWjx0PEABkFKympHYKvdj1z91MLEtlp9DlbFJhqh+
         RsWfPgHkZYHmyYEClIkOkWyiTQjj8aBgTX0hS8eyxanFDDJnz5L7ffHiwXL7MvBqe6pb
         ybRDaE6GrUhNM0lDXURHDNzti2rEv1ON1vXsdrez+o0V0fbGhRIULr9kcWp3Es+rIIpD
         IdbxqaUekK4qsWhRs7vTzdEz2TS+xNcz+1pEaS/FWkPu8x5RXGh1q2JymY+NIMBcHEL5
         QzeA==
X-Gm-Message-State: AOAM533PZFjHqB8G2OKklASOrHPFC6GaWI5bzW9EAQZeQARxOGBdircL
        ecpNb1NqTb79l5qK8fUbxde1NMHlQnA=
X-Google-Smtp-Source: ABdhPJwxUQMvRlszSad4cKEd3WGGGCbYu0raHs3hJ5q5do6vKz751hapNbOH3OwxSsi1LyqyXiu2Mw==
X-Received: by 2002:adf:9d8d:: with SMTP id p13mr246690wre.300.1626112563323;
        Mon, 12 Jul 2021 10:56:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24sm121207wmi.30.2021.07.12.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:56:03 -0700 (PDT)
Message-Id: <d67ad048b08aa168495fa89e007d905a79c1c5db.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:49 +0000
Subject: [PATCH v8 08/15] unpack-trees: rename unpack_nondirectories()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In the next change, we will use this method to unpack a sparse directory
entry, so change the name to unpack_single_entry() so these entries
apply. The new name reflects that we will not recurse into trees in
order to resolve the conflicts.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index b113cc750f2..d26386ce8b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -804,7 +804,7 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 		BUG("We need cache-tree to do this optimization");
 
 	/*
-	 * Do what unpack_callback() and unpack_nondirectories() normally
+	 * Do what unpack_callback() and unpack_single_entry() normally
 	 * do. But we walk all paths in an iterative loop instead.
 	 *
 	 * D/F conflicts and higher stage entries are not a concern
@@ -1075,11 +1075,11 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
  * without actually calling it. If you change the logic here you may need to
  * check and change there as well.
  */
-static int unpack_nondirectories(int n, unsigned long mask,
-				 unsigned long dirmask,
-				 struct cache_entry **src,
-				 const struct name_entry *names,
-				 const struct traverse_info *info)
+static int unpack_single_entry(int n, unsigned long mask,
+			       unsigned long dirmask,
+			       struct cache_entry **src,
+			       const struct name_entry *names,
+			       const struct traverse_info *info)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
@@ -1322,7 +1322,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_single_entry(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
 	if (o->merge && src[0]) {
-- 
gitgitgadget

