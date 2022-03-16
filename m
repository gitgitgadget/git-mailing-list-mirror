Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14E3C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 11:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355298AbiCPLVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355296AbiCPLVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 07:21:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EEE65781
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:20:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q20so1107683wmq.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QuaZuTHIyAZElrzUd43ACUTXmPC29E3quI8pMbZff+g=;
        b=VtO6Y6xVegCOLT5OJF0JNjfuRxu1NfJq8PW1wi40wuVUIiHc8GoBbSFX5TZ+825ltk
         KWolMOfXKAs14oym5AIigLZY0ysYvlZUlNnkFtFhxQaLtZoVikn8W0t2v9UhMCUerAWr
         dAXWj+kBbOEp5WfQ5KH7rC0oDvBBMivWMJUg+YxVjNXJ4rZpZdqfppDHEUeIG/iz+k+f
         cOvDG2wu34ueDDQwtc14+w06SnAi4ZYO7487uUptOGY8Qif0jsCgwhvfgP3OfMwZfo1e
         hoD+rbeE1KWhtroECYYdizqGQsj88X+XhRxtC/HOJ94lZKJc76KcvaPF/ChIzAl/xKl+
         D1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QuaZuTHIyAZElrzUd43ACUTXmPC29E3quI8pMbZff+g=;
        b=tNTtSOinz0gSpMb3dJtx75WukAKqAXynN1gE99jLPYfZaUKbRQVzBO/PM2KF6NGLu6
         QHOAKnSqiuh41sbSdNBuTeNhDFeVD1LyEOvQXrRGTEvmZyaiZKTMfVSS2jIQqKfJZrFH
         T4SKQs6bsCUQFhH3DIoj07TguI1BvDVVPoYHitDl4Ziccy8i+SQdj0wGRYec5YVRogQm
         OAFzq0UZx+M+qqRL1uzl6iZuER+P8e7bv+mecrtSH2ra3OeILlPk2oob8l5PF3S5TPcx
         DU9B4UT/Hlc4iMBzA1Z+5SpuZrBJN+FjJacv5i0aITUDJaCR0NYuQohq2MWGUIYCKwhS
         +mqg==
X-Gm-Message-State: AOAM531J8UX4drgPMsPmNhWDz3j1F0VFIPFXuMv1ryw5qr+O+4Z7uDMx
        ptkRRpEXiQW8t92/Jr4I2Ty0W6nlAPk=
X-Google-Smtp-Source: ABdhPJwLbA7oBr4TXNnrscE0nPelYNyHgGzt2IF7SwQinTzHApII2JDekWKt4AO+PtrkZXjA8Wk0hA==
X-Received: by 2002:a05:600c:3c8a:b0:389:cf43:eaf6 with SMTP id bg10-20020a05600c3c8a00b00389cf43eaf6mr6829046wmb.199.1647429625316;
        Wed, 16 Mar 2022 04:20:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm1478067wmi.8.2022.03.16.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 04:20:24 -0700 (PDT)
Message-Id: <pull.1177.v3.git.1647429623830.gitgitgadget@gmail.com>
In-Reply-To: <pull.1177.v2.git.1647427356490.gitgitgadget@gmail.com>
References: <pull.1177.v2.git.1647427356490.gitgitgadget@gmail.com>
From:   "Jayati Shrivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Mar 2022 11:20:23 +0000
Subject: [PATCH v3] sequencer.c: use reverse_commit_list() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jayati Shrivastava <gaurijove@gmail.com>,
        Jayati Shrivastava <gaurijove@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jayati Shrivastava <gaurijove@gmail.com>

Instead of creating a new allocation, reverse the
original list in-place by calling the
reverse_commit_list() helper. The original code
discards the list "bases" after storing its
reverse copy in a newly created list "reversed".
If the code that followed from here used both
"bases" and "reversed", the modification would not
have worked, but since the original list "bases"
gets discarded, we can simply reverse "bases"
in-place with the reverse_commit_list() helper and
reuse the same variable in the code that follows.

builtin/merge.c has been left unmodified, since in
its case, the original list is needed separately
from its reverse copy by the code.

Signed-off-by: Jayati Shrivastava <gaurijove@gmail.com>
---
    Use reverse_commit_list helper function for in-place list reversal
    
    This patch address https://github.com/gitgitgadget/git/issues/1156
    Changes since v2:
    
     * updated the commit message to explain why builtin/merge.c has not
       been modified

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1177%2Fvictorphoenix3%2Freverse-list-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1177/victorphoenix3/reverse-list-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1177

Range-diff vs v2:

 1:  f794bcd8bda ! 1:  6dd0d92096b sequencer.c: use reverse_commit_list() helper
     @@ Metadata
       ## Commit message ##
          sequencer.c: use reverse_commit_list() helper
      
     -    Instead of creating a new allocation, reverse the original
     -    list in-place by calling the reverse_commit_list() helper.
     -    The original code discards the list "bases" after storing
     -    its reverse copy in a newly created list "reversed". If the
     -    code that followed from here used both "bases" and "reversed",
     -    the modification would not have worked, but since the original
     -    list "bases" gets discarded, we can simply reverse "bases"
     -    in-place with the reverse_commit_list() helper and reuse the
     -    same variable in the code that follows.
     +    Instead of creating a new allocation, reverse the
     +    original list in-place by calling the
     +    reverse_commit_list() helper. The original code
     +    discards the list "bases" after storing its
     +    reverse copy in a newly created list "reversed".
     +    If the code that followed from here used both
     +    "bases" and "reversed", the modification would not
     +    have worked, but since the original list "bases"
     +    gets discarded, we can simply reverse "bases"
     +    in-place with the reverse_commit_list() helper and
     +    reuse the same variable in the code that follows.
     +
     +    builtin/merge.c has been left unmodified, since in
     +    its case, the original list is needed separately
     +    from its reverse copy by the code.
      
          Signed-off-by: Jayati Shrivastava <gaurijove@gmail.com>
      


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
