Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE7C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E9561184
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 08:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhDJIbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 04:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhDJIbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 04:31:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6859C061762
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 01:30:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k128so4031278wmk.4
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=b2MPEAfCPVfFZ+28OeNLUbJaLbt8Rd3/VrSUOpbtnvQ=;
        b=YwlJ6gbhYHwq5zpTjEX/DzHwYVN/dmlXgfcCWU5ahNRwh/sMrRqvlY+sL16+bTjPsh
         L4N9zGebfIqPHqf/ZEWylAUz7yJHXRjtV5LaPPFOLQVn9yxA3Aj5qlpKBFSmLW/ORpm2
         WzYBo38j1fz1rl5+R3Ty6fLq4jb1cjhc8wff2vifQyP1vGGGe64Wzb0gIJTzraMTp4Ho
         7a57XLTMG1Z7hjChkZi4RPfDipYJz03H72mTo5u02W0xiiWk+RbxFdXpLxyNlPM3qJsR
         wf0s0Ox8hJTyY/NVNqSdT3kEzpuX0Yfshu1ZEQf9SsmREF5sszYu78cORY0QLD/D49vn
         hACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b2MPEAfCPVfFZ+28OeNLUbJaLbt8Rd3/VrSUOpbtnvQ=;
        b=dph1FAGoM15X2c8GsWEu9fja47Ie17KG1dyzP+TSVMbxsEz7ZuclK7VUoaw1LzuwLG
         buxeFqSZsnADMA4HossPoQ5tHW1CaTYx57M/4KIVRDd3TxOr/5hgsoh34FP/YErYfwAn
         b3a7kFWl+DBs5iPtDkfbTn0t0o45VMOwWUY2HWThhkzfqqrPdIuzxEUIF/9jewVHX80i
         mfbZaEoQZd6HARSjCAbKEYrXOjlG57cpM36q2WBFBTsPSs3uXA8ag9saHKWih23OdgI9
         aODe8uSx4Dk2P79IXjuwGpxnUuYVgRcAkZkVPEdCTb7ZX/RUd25DRq9G4ts3KJIDy0d5
         w6nQ==
X-Gm-Message-State: AOAM530EoA05UpJRdQJc8Wc8hE2L1AE9UDiTBMuzhiOcBHMd786tNPz8
        RUIrxqYomM836PJLtHvqWsV65NriKOQ=
X-Google-Smtp-Source: ABdhPJyYA4QQGQlasLMQ2An/svmLtfWHeDCAhKbuZwPYYXIGsjrdSd+Yc5GKqnYixXwUuiDl6VYiqg==
X-Received: by 2002:a1c:3182:: with SMTP id x124mr17268420wmx.41.1618043450170;
        Sat, 10 Apr 2021 01:30:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm7962755wro.29.2021.04.10.01.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 01:30:49 -0700 (PDT)
Message-Id: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Apr 2021 08:30:48 +0000
Subject: [PATCH] merge-ort: only do pointer arithmetic for non-empty lists
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

versions could be an empty string_list. In that case, versions->items is
NULL, and we shouldn't be trying to perform pointer arithmetic with it (as
that results in undefined behaviour).

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
    
    Here's a small and inconsequential UBSAN issue that started happening
    when running tests on next since yesterday (since the merge of
    en/ort-readiness).
    
    It can be reproduced with something like this (t3404 also triggers the
    same issue):
    
    make SANITIZE=undefined COPTS="-Og -g" T="$(wildcard t5601-*.sh)"
    GIT_TEST_OPTS="-v" UBSAN_OPTIONS=print_stacktrace=1 test
    
    ATB, Andrzej

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-930%2Fahunt%2Fmerge-ort-ubsan-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-930/ahunt/merge-ort-ubsan-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/930

 merge-ort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 5e118a85ee04..4da4b4688336 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2504,8 +2504,10 @@ static void write_tree(struct object_id *result_oid,
 	 * We won't use relevant_entries again and will let it just pop off the
 	 * stack, so there won't be allocation worries or anything.
 	 */
-	relevant_entries.items = versions->items + offset;
-	relevant_entries.nr = versions->nr - offset;
+	if (versions->nr) {
+		relevant_entries.items = versions->items + offset;
+		relevant_entries.nr = versions->nr - offset;
+	}
 	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
 
 	/* Pre-allocate some space in buf */

base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
-- 
gitgitgadget
