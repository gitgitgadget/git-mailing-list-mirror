Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E38C43460
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290D461008
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhDKLFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 07:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbhDKLF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 07:05:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F04C06138B
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 04:05:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s7so9838867wru.6
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q+oN9aySBt3edBnsA6x+lAV0Q3CaqjjX4P4Cz2G+un8=;
        b=MxE471Eje6yO+mMB6U3HVzUB+P9iUCRNQn6jZAQQfG2OdoHPakQMbc1QViix5+qc3+
         83NYVuqNXlLZPLmPjWh8413pKfGGwNJinprRIe8KU7Nm8e7pARAbOZfO3AABOt8PIbm+
         iRqGyLNhNkvtERZpGyV+9rlBD7MgCxxtBOW6e2rkHRcrzTuDZCpaxb149UNX1RcCO0X0
         3+8PCgwzcYnmKjjhV/JQldYqR/UChGRMn0oN2phJzh+IXcsb2US/3md5OSvLVFdLyNYY
         EYbjcTjWEs27tzrkE9P+2j4k5Zo5KjPNFxiHqyokavhPAmnJcaIMrZ+ysarBLF3Yhk7p
         Lukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q+oN9aySBt3edBnsA6x+lAV0Q3CaqjjX4P4Cz2G+un8=;
        b=rOgG5cFSvrUd1JYXxWVLKK2Exzil3B3HA9qPnNKLNgzCAdUn73oVXLs9BL/S/8tqx8
         yFlVCPi3jcP+xSfWJP7PcBjMXALqWmXykEgv1hMcgLClmdb3VmpC8q2gV90rOL27SkTY
         eKbbQcjw6Lwa4KbjordjrchuqAqNfHlzopwNXnmV/zgVN/Ue7jH38hkvCQQ5GU8k9ukB
         l0oSrOKtrcuRIXnP05BQUhnHCn6axDn+BpZnnJpZT14RSUWz8iRc1Ys6rtEbgHokCCGZ
         rDllIXHA9MMq0DBsP3PPmVAgnnSpU0BGM5bLu6Q8b449DoEUT6WvHZu1vY2SK7RhNtpW
         CbQw==
X-Gm-Message-State: AOAM531XpO3XYEBdMQHc2q8E7fS53C3yP6iKW0Ec7Va5FP/FWYuGITlv
        BgmYfqFW8jV8ditGQArF+NZtmTmXXyU=
X-Google-Smtp-Source: ABdhPJxlTG4ZGCit/mExOkpEOFKp55Jb2zsoLjtRRanw01q7cKcTP8mqnT3ov+befusCFApJSnDLSQ==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr5735378wrx.241.1618139108142;
        Sun, 11 Apr 2021 04:05:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm9224691wrc.85.2021.04.11.04.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:05:07 -0700 (PDT)
Message-Id: <pull.930.v2.git.1618139107203.gitgitgadget@gmail.com>
In-Reply-To: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
References: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Apr 2021 11:05:06 +0000
Subject: [PATCH v2] merge-ort: only do pointer arithmetic for non-empty lists
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

versions could be an empty string_list. In that case, versions->items is
NULL, and we shouldn't be trying to perform pointer arithmetic with it (as
that results in undefined behaviour).

Moreover we only use the results of this calculation once when calling
QSORT. Therefore we choose to skip creating relevant_entries and call
QSORT directly with our manipulated pointers (but only if there's data
requiring sorting). This lets us avoid abusing the string_list API,
and saves us from having to explain why this abuse is OK.

Finally, an assertion is added to make sure that write_tree() is called
with a valid offset.

This issue has probably existed since:
  ee4012dcf9 (merge-ort: step 2 of tree writing -- function to create tree object, 2020-12-13)
But it only started occurring during tests since tests started using
merge-ort:
  f3b964a07e (Add testing with merge-ort merge strategy, 2021-03-20)

For reference - here's the original UBSAN commit that implemented this
check, it sounds like this behaviour isn't actually likely to cause any
issues (but we might as well fix it regardless):
https://reviews.llvm.org/D67122

UBSAN output from t3404 or t5601:

merge-ort.c:2669:43: runtime error: applying zero offset to null pointer
    #0 0x78bb53 in write_tree merge-ort.c:2669:43
    #1 0x7856c9 in process_entries merge-ort.c:3303:2
    #2 0x782317 in merge_ort_nonrecursive_internal merge-ort.c:3744:2
    #3 0x77feef in merge_incore_nonrecursive merge-ort.c:3853:2
    #4 0x6f6a5c in do_recursive_merge sequencer.c:640:3
    #5 0x6f6a5c in do_pick_commit sequencer.c:2221:9
    #6 0x6ef055 in single_pick sequencer.c:4814:9
    #7 0x6ef055 in sequencer_pick_revisions sequencer.c:4867:10
    #8 0x4fb392 in run_sequencer revert.c:225:9
    #9 0x4fa5b0 in cmd_revert revert.c:235:8
    #10 0x42abd7 in run_builtin git.c:453:11
    #11 0x429531 in handle_builtin git.c:704:3
    #12 0x4282fb in run_argv git.c:771:4
    #13 0x4282fb in cmd_main git.c:902:19
    #14 0x524b63 in main common-main.c:52:11
    #15 0x7fc2ca340349 in __libc_start_main (/lib64/libc.so.6+0x24349)
    #16 0x4072b9 in _start start.S:120

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior merge-ort.c:2669:43 in

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
    merge-ort: only do pointer arithmetic for non-empty lists
    
    V2 removes relevant_entries as per René's suggestion, and adds an
    assertion as per Junio's question.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-930%2Fahunt%2Fmerge-ort-ubsan-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-930/ahunt/merge-ort-ubsan-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/930

Range-diff vs v1:

 1:  d52ce7110446 ! 1:  48c1a0ad6f46 merge-ort: only do pointer arithmetic for non-empty lists
     @@ Commit message
          NULL, and we shouldn't be trying to perform pointer arithmetic with it (as
          that results in undefined behaviour).
      
     +    Moreover we only use the results of this calculation once when calling
     +    QSORT. Therefore we choose to skip creating relevant_entries and call
     +    QSORT directly with our manipulated pointers (but only if there's data
     +    requiring sorting). This lets us avoid abusing the string_list API,
     +    and saves us from having to explain why this abuse is OK.
     +
     +    Finally, an assertion is added to make sure that write_tree() is called
     +    with a valid offset.
     +
          This issue has probably existed since:
            ee4012dcf9 (merge-ort: step 2 of tree writing -- function to create tree object, 2020-12-13)
          But it only started occurring during tests since tests started using
     @@ Commit message
      
       ## merge-ort.c ##
      @@ merge-ort.c: static void write_tree(struct object_id *result_oid,
     - 	 * We won't use relevant_entries again and will let it just pop off the
     - 	 * stack, so there won't be allocation worries or anything.
     - 	 */
     + 	size_t maxlen = 0, extra;
     + 	unsigned int nr = versions->nr - offset;
     + 	struct strbuf buf = STRBUF_INIT;
     +-	struct string_list relevant_entries = STRING_LIST_INIT_NODUP;
     + 	int i;
     + 
     +-	/*
     +-	 * We want to sort the last (versions->nr-offset) entries in versions.
     +-	 * Do so by abusing the string_list API a bit: make another string_list
     +-	 * that contains just those entries and then sort them.
     +-	 *
     +-	 * We won't use relevant_entries again and will let it just pop off the
     +-	 * stack, so there won't be allocation worries or anything.
     +-	 */
      -	relevant_entries.items = versions->items + offset;
      -	relevant_entries.nr = versions->nr - offset;
     -+	if (versions->nr) {
     -+		relevant_entries.items = versions->items + offset;
     -+		relevant_entries.nr = versions->nr - offset;
     -+	}
     - 	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
     +-	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
     ++	assert(offset <= versions->nr);
     ++	if (versions->nr)
     ++		QSORT(versions->items + offset, nr, tree_entry_order);
       
       	/* Pre-allocate some space in buf */
     + 	extra = hash_size + 8; /* 8: 6 for mode, 1 for space, 1 for NUL char */


 merge-ort.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 5e118a85ee04..702eb5bf362d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2493,20 +2493,11 @@ static void write_tree(struct object_id *result_oid,
 	size_t maxlen = 0, extra;
 	unsigned int nr = versions->nr - offset;
 	struct strbuf buf = STRBUF_INIT;
-	struct string_list relevant_entries = STRING_LIST_INIT_NODUP;
 	int i;
 
-	/*
-	 * We want to sort the last (versions->nr-offset) entries in versions.
-	 * Do so by abusing the string_list API a bit: make another string_list
-	 * that contains just those entries and then sort them.
-	 *
-	 * We won't use relevant_entries again and will let it just pop off the
-	 * stack, so there won't be allocation worries or anything.
-	 */
-	relevant_entries.items = versions->items + offset;
-	relevant_entries.nr = versions->nr - offset;
-	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
+	assert(offset <= versions->nr);
+	if (versions->nr)
+		QSORT(versions->items + offset, nr, tree_entry_order);
 
 	/* Pre-allocate some space in buf */
 	extra = hash_size + 8; /* 8: 6 for mode, 1 for space, 1 for NUL char */

base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
-- 
gitgitgadget
