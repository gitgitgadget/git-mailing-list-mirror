Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41527C433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0262C207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAACfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbhAACfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:35:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC2C061575
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v14so8358310wml.1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LKxPoRve9hCdPWDxuTSZnGvESSVhojxu0AsY1j4NEN0=;
        b=u5viq6CueMvrMf51oCegNf/UcZsfqbK0LNJlO/0EIfN+mcp/mirfGB/7xWR7/tJdsb
         kMZQ+39280DE+wRAd7kJTROjw7hNMKoYZw8BV8pBLwjqlepDzwaCgMtp3v8btuRybEfT
         bwUazi8X55c7vD50Cj99N4W46fuZIa3u/bC7OilmKjcrqtHADTreu/ewX/ir0na/YBVH
         gh7lNpvFVkX0QwY4hSvuT5acqVZ/aD6DwjZle/PBYqj5AoKs9PFmKZ38Vx56UTHyayTe
         rswLIB13nf9mWougvDRUXYOnwI7DG7jrmeTsnQJ81ntQGHylA/1iauy2t1dPw99s66dX
         LhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LKxPoRve9hCdPWDxuTSZnGvESSVhojxu0AsY1j4NEN0=;
        b=Uix/2ngg190zQDs2Qeq9m6iJP2Gh3l/FMHljGsm5TUcs4jpbM0OrC5UbX8VHivR9bm
         rzRTnKgt4oHtDiX1zR73oG4Bc0qGY/4TeB+oCpWX/wf9IHNEk9oWoaKPkfkUC3C+O9f1
         n/sTHRa9vp8e2W5nlEGdO5T8qIHP6TN4Bi1NjyjLenokEv/wYsbK0Y/KykkUyqM7Bcqo
         FtRQqqdMHJ/618UFqDCNPD0R8s+o9pIiywP73vRs7iEhTeKMLdVpYMyLZql6+/1reSsX
         edRu548mcSWXunoWZKEezQMGnT3e2lWeg+x/Flf6k/G9GIMfyCo/zdMaP3UPcDap+npF
         05TA==
X-Gm-Message-State: AOAM533XXKVxnDAzqg5lmDVTqSrLQl2NCNwbB26DhEMlkVDjtboCvmBd
        6u2UHTbVQWFxPqMZRz0fukACH8McTL8=
X-Google-Smtp-Source: ABdhPJwPmu1hNNN3GrShB+Ghjul7gK3jUe/S/TYeOm/1CxnreDj7sLTUa0v1Xnkh0s6Ur0uDFvAdKg==
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr14232723wmg.65.1609468489943;
        Thu, 31 Dec 2020 18:34:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g192sm15362200wme.48.2020.12.31.18.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:49 -0800 (PST)
Message-Id: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:38 +0000
Subject: [PATCH v2 00/10] merge-ort: add more handling of basic conflict types
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-ort-2 (it does not depend on en/merge-ort-3
or en/merge-ort-recursive).

This series adds handling of additional basic conflict types (directory/file
conflicts, three-way content merging, very basic submodule divergence
reconciliation, and different filetypes). This series drops the number of
test failures under GIT_TEST_MERGE_ALGORITHM=ort by 211 (from 1448 to 1237).

Further, if en/merge-tests, en/merge-ort-3, en/merge-ort-recursive, and this
series are all merged down (in any order), then collectively they drop the
number of test failure under GIT_TEST_MERGE_ALGORITHM=ort from 1448 down to
60.

Changes since v1:

 * Wait to remove comment about a die-not-implemented code block until the
   commit where we actually remove it (spotted by Stollee)

Elijah Newren (10):
  merge-ort: handle D/F conflict where directory disappears due to merge
  merge-ort: handle directory/file conflicts that remain
  merge-ort: implement unique_path() helper
  merge-ort: handle book-keeping around two- and three-way content merge
  merge-ort: flesh out implementation of handle_content_merge()
  merge-ort: copy and adapt merge_3way() from merge-recursive.c
  merge-ort: copy and adapt merge_submodule() from merge-recursive.c
  merge-ort: implement format_commit()
  merge-ort: copy find_first_merges() implementation from
    merge-recursive.c
  merge-ort: add handling for different types of files at same path

 merge-ort.c | 671 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 653 insertions(+), 18 deletions(-)


base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-815%2Fnewren%2Fort-conflict-handling-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-815/newren/ort-conflict-handling-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/815

Range-diff vs v1:

  1:  382a009c18e !  1:  1869e497482 merge-ort: handle D/F conflict where directory disappears due to merge
     @@ merge-ort.c: static void process_entry(struct merge_options *opt,
       		die("Not yet implemented.");
       	}
       
     - 	/*
     - 	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
     - 	 *       which the code goes through even for the df_conflict cases
     --	 *       above.  Well, it will once we don't die-not-implemented above.
     -+	 *       above.
     - 	 */
     - 	if (ci->match_mask) {
     - 		ci->merged.clean = 1;
  2:  46953226ba8 !  2:  54f9be41a8a merge-ort: handle directory/file conflicts that remain
     @@ merge-ort.c: static void process_entry(struct merge_options *opt,
       	}
       
       	/*
     + 	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
     + 	 *       which the code goes through even for the df_conflict cases
     +-	 *       above.  Well, it will once we don't die-not-implemented above.
     ++	 *       above.
     + 	 */
     + 	if (ci->match_mask) {
     + 		ci->merged.clean = 1;
  3:  6ac555b3c0f =  3:  63fed5e49a7 merge-ort: implement unique_path() helper
  4:  4c641ec19d5 =  4:  d0fab13c78a merge-ort: handle book-keeping around two- and three-way content merge
  5:  0e7321e67f8 =  5:  69129a20edc merge-ort: flesh out implementation of handle_content_merge()
  6:  611141f24af =  6:  d1cc76ac620 merge-ort: copy and adapt merge_3way() from merge-recursive.c
  7:  4696f6c2d95 =  7:  2ddf6ece9d0 merge-ort: copy and adapt merge_submodule() from merge-recursive.c
  8:  a640cc0effc =  8:  b0bfada5d81 merge-ort: implement format_commit()
  9:  b898876b119 =  9:  334cc7c65a6 merge-ort: copy find_first_merges() implementation from merge-recursive.c
 10:  0a5778df253 = 10:  34eb647df40 merge-ort: add handling for different types of files at same path

-- 
gitgitgadget
