Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E838C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiCOTnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbiCOTnL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:43:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2235255209
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:41:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so2021078wms.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hDcUKEfoglkX3gL6O431c2TXUDF6ZuoBeLQ7MAQJhrE=;
        b=cMVFVGiEF2sqXEvu8OsXQS/GYW2ratdVK2ucJObbo+Ic9EiF83O/7fksjfOGostRQe
         54m/VseWcgomDA4YXYmUkccKPZhvmPgwJgIUzgVdcBVOAwq3YGtug5/extkaUHOFpcQ4
         0U9XIrlicrinpTEc2Rn9NVkEMhlvtecgudcoIBUBcHxKPUTVk4F9N27pQmejG0qp11Rj
         +AL8v9zReikerrhZfiXhAHrntU7VuSLT+MFalO8BBX1seKKbJrrgu62JflT9DB7TkCWv
         wFZJr81KpR3KYWnz8fXeEZAbFTOQEm/7IST1X3HEhKTB2ZGvasYFWasYTWU4PbOUnERf
         Kysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hDcUKEfoglkX3gL6O431c2TXUDF6ZuoBeLQ7MAQJhrE=;
        b=G9dnXT+zWe0kS5MSnsWAib7AmaPVuav9RUhgRG0kzEYxhtKXyj9Gb8y219K7wb1gG8
         FjeGyIPMhQA2fWUgh/F3tX5Pcwye72Q7p5Q7p/DSIjQ1JFlW/lRWZqzhpLzEQqMaeJCk
         YX11FSHv3SZnPWxB1FQCb1S11bUvx9l+6eUHSiUwetteuhFZgjFgzucGUnwmP/v1wmMf
         OPxfhbh5q+qe+nSZ9OghJ4BecjSbEwYdSJ0T+jkj9ssNFRqTPe43kOy7uwnKpZCcaMUd
         2TvBnUmN6Fugmy2HtVAK14eth40+BC1+R/v5ncJTlq5drYtZbUnaUmUyuJzcnlNkFja1
         1Z7w==
X-Gm-Message-State: AOAM531K16n5AUzf1YMNr6QloXksidiR4tJ+xL6r20K2dNl7IYSre1G1
        jjfcO4NWb5xtuEyNpvfR8tj+QVxXAOg=
X-Google-Smtp-Source: ABdhPJyCi/1t8volqTwmyLq4E5L1k/s+ohxJOWmPNDGx7jGlY4JwBjqb7XC3AbwB5T/QJKKcPbenUg==
X-Received: by 2002:a1c:f009:0:b0:387:6fea:8ebc with SMTP id a9-20020a1cf009000000b003876fea8ebcmr4582986wmb.84.1647373315561;
        Tue, 15 Mar 2022 12:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm3341863wmn.46.2022.03.15.12.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:41:55 -0700 (PDT)
Message-Id: <pull.1177.git.1647373314457.gitgitgadget@gmail.com>
From:   "Jayati Shrivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 19:41:54 +0000
Subject: [PATCH] Use reverse_commit_list helper function for in-place list
 reversal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jayati Shrivastava <gaurijove@gmail.com>,
        JAYATI SHRIVASTAVA <gaurijove@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: JAYATI SHRIVASTAVA <gaurijove@gmail.com>

Here, a reverse copy of a list is being created by iterating
over the list after which the original list is discarded.
Instead of creating a new allocation, we can reverse the
original list in-place using the reverse_commit_list helper
function.

Signed-off-by: Jayati Shrivastava <gaurijove@gmail.com>
---
    Use reverse_commit_list helper function for in-place list reversal
    
    This patch addresses https://github.com/gitgitgadget/git/issues/1156 . I
    have left builtin/merge.c unmodified since in its case, the original
    list is needed separately from the reverse copy.
    
    (Please excuse if you are receiving this patch again. I had previously
    sent it using git send-email but for some reason the patches are not
    getting delivered to the mailing list despite correctly passing the
    --to/--cc/--in-reply-to options.)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1177%2Fvictorphoenix3%2Freverse-list-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1177/victorphoenix3/reverse-list-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1177

 sequencer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 35006c0cea6..bccbb9e3522 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3749,7 +3749,7 @@ static int do_merge(struct repository *r,
 	int run_commit_flags = 0;
 	struct strbuf ref_name = STRBUF_INIT;
 	struct commit *head_commit, *merge_commit, *i;
-	struct commit_list *bases, *j, *reversed = NULL;
+	struct commit_list *bases, *j;
 	struct commit_list *to_merge = NULL, **tail = &to_merge;
 	const char *strategy = !opts->xopts_nr &&
 		(!opts->strategy ||
@@ -3984,9 +3984,7 @@ static int do_merge(struct repository *r,
 		      git_path_merge_head(r), 0);
 	write_message("no-ff", 5, git_path_merge_mode(r), 0);
 
-	for (j = bases; j; j = j->next)
-		commit_list_insert(j->item, &reversed);
-	free_commit_list(bases);
+	bases = reverse_commit_list(bases);
 
 	repo_read_index(r);
 	init_merge_options(&o, r);
@@ -4002,10 +4000,10 @@ static int do_merge(struct repository *r,
 		 * update the index and working copy immediately.
 		 */
 		ret = merge_ort_recursive(&o,
-					  head_commit, merge_commit, reversed,
+					  head_commit, merge_commit, bases,
 					  &i);
 	} else {
-		ret = merge_recursive(&o, head_commit, merge_commit, reversed,
+		ret = merge_recursive(&o, head_commit, merge_commit, bases,
 				      &i);
 	}
 	if (ret <= 0)

base-commit: b896f729e240d250cf56899e6a0073f6aa469f5d
-- 
gitgitgadget
