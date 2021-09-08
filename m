Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C9DC4332F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A5E61157
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351479AbhIHLZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351306AbhIHLZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:25:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC36C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 04:24:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v10so2745610wrd.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 04:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TW6UFTzZ+QULGGc8KN5tLIiTgHZXppX2ImGqtUqI5sQ=;
        b=INGovI4/xcEWUoyaPcaObXYGCHgdiCdTROa2fH+OjG9GbmZvA5aMpfA15cLu8NPxhY
         VXZ4x5R46dCgbxhjT/wt4lI4UoMcyz73LzGs0/rvKeh4Eb3liv+q2l06r5CxIxEndKMd
         Lx3JkGE1e3VF1j6PCI66ZbrPlTyzyIOpfxiSfBEDqz5hwW50+1Rt/PLFDP9HjfFOTwUA
         2AWslLxpnDlHR/CGZRsvsLvFAcxExBGi2Sd7d4mM4oRWya4NZ6RjwLt4bbqrtBUK1H6w
         jkil/3EZnUGrdqKpAXJOHtkM00KdrYoWTOvMzEC+BJQRahUmQ1edc0B25Zp5NwePBSid
         6v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TW6UFTzZ+QULGGc8KN5tLIiTgHZXppX2ImGqtUqI5sQ=;
        b=tIlo4F+QVEOZB756hoTFEKOM6Sq1qPH5Vifa9HiDbLXf+ILiiALif7Taar+mVmGQuG
         wGSZ+AG5wQaYOkKQJoFd+Tuzy9+e71ywZpUbOgPl4vSfQ7JSCR2KnBdLp9p8MR4fZ6E9
         KmfM+V294Bn+Hx14/SRAv0fwO17NHboBwF+yscxdyaYrtwkHznzdFn8O7GxLoDQGmNaE
         5ixIU42TK2vcjwnJqc25keCHJCCtN1zeim997Cbyo0hHuueFMaIwW11W/ufcjk2Nq+5Q
         riX5bJe+7ZwjFqxy14yHych/fgom880PhII1NS+v3ImLwXzf7sh8Luh5+Z2vhdv1MMAI
         ulyg==
X-Gm-Message-State: AOAM5334DpmLnGrsv3h4IkaMoff+mf1SN/nHrwrGLBBxOBdgj4myb3VZ
        pjTyM3E7XkbHKp0tw/NIAyqm9lJlWrc=
X-Google-Smtp-Source: ABdhPJwkg9v5HnNjcbRDUeyI6tmO6QzYYimcleOZo0qsi5A4sruC6LHJLpH2j3t/4cRHqK0I6q1ACQ==
X-Received: by 2002:adf:f84d:: with SMTP id d13mr3535297wrq.292.1631100246145;
        Wed, 08 Sep 2021 04:24:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm1814676wmp.1.2021.09.08.04.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:24:05 -0700 (PDT)
Message-Id: <20f5bbae5463cde26505f49bbcf80fdeeb9f65f4.1631100241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
References: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
        <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 11:24:00 +0000
Subject: [PATCH v3 5/6] sequencer: ensure full index if not ORT strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sequencer is used by 'cherry-pick' and 'rebase' to sequence a list
of operations that modify the index. Since we intend to remove the need
for 'command_requires_full_index', we need to ensure the sparse index is
expanded every time it is written to disk between these steps. That is,
unless the merge strategy is 'ort' where the index can remain sparse
throughout.

There are two main places to be extra careful about a full index:

1. Right before calling merge_trees(), ensure the index is full. This
   happens within an 'else' where the 'if' block checks if the 'ort'
   strategy is selected.

2. During read_and_refresh_cache(), the index might be written to disk
   and converted to sparse in the process. Ensure it expands back to
   full afterwards by checking if the strategy is _not_ 'ort'. This
   'if' statement is the logical negation of the 'if' in item (1).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sequencer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..228bc089d22 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -652,6 +652,7 @@ static int do_recursive_merge(struct repository *r,
 		merge_switch_to_result(&o, head_tree, &result, 1, show_output);
 		clean = result.clean;
 	} else {
+		ensure_full_index(r->index);
 		clean = merge_trees(&o, head_tree, next_tree, base_tree);
 		if (is_rebase_i(opts) && clean <= 0)
 			fputs(o.obuf.buf, stdout);
@@ -2346,6 +2347,7 @@ static int read_and_refresh_cache(struct repository *r,
 			_(action_name(opts)));
 	}
 	refresh_index(r->index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
+
 	if (index_fd >= 0) {
 		if (write_locked_index(r->index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED)) {
@@ -2353,6 +2355,13 @@ static int read_and_refresh_cache(struct repository *r,
 				_(action_name(opts)));
 		}
 	}
+
+	/*
+	 * If we are resolving merges in any way other than "ort", then
+	 * expand the sparse index.
+	 */
+	if (opts->strategy && strcmp(opts->strategy, "ort"))
+		ensure_full_index(r->index);
 	return 0;
 }
 
-- 
gitgitgadget

