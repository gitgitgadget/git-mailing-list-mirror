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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E581AC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34E72335A
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgLPW2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgLPW2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 17:28:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF66C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d26so11443474wrb.12
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yTd9uvR88hm/8Xz8D5DFENH0FZiLu6P6/mc3i0TgKMc=;
        b=IPUQTqwe4dQzeQg5gxL+ii/0YSTiZ/E3XcSl0gLXcCylCfmkm98YErkqnV/tvP83C8
         KsuNxSyJHghW8woDb4mQejEw4BeN9OUqIlHBb0gvfH4oTPZ6EGILiN/BXTProLjS3OQQ
         TjlJLQve28su5rvooKfdfgDprLjbNMBJ3CWVadEnFFrz2YTreKVl5BvEwEaSKhYUvzKd
         MFfS5q0ONQlS2S7p+d7AfTDwTP4K9LupAH7yJiHKMZCNTYg7tSAmTb7yggTp7PZExv16
         yDc+CexhacK1W6rUiLK7h+5/LyFVmp4xq25F+kNDfzYgr9w0JMEUMnTM4mbYupx1Wq/U
         VPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yTd9uvR88hm/8Xz8D5DFENH0FZiLu6P6/mc3i0TgKMc=;
        b=NQYq1jmFHtDsoIPlSQrMIxd2JQTAFbRX3pOklwDSMpoZftoNcSpc1beyE0kP5QoLpt
         PVkaf6XLQ2QO59XjTN59/MSOtJ5XFMbotfLHRvAivhFtB68JjpdTeaEwfRvLgh4ySdMW
         C83MYkIbLbCo7y28sOfIRlMXIVA093xYNeAN2TLx9RpgdlBmdhBOB0p85HLKih7wfswQ
         JSmcmno66n4/jwEAH8WWXcdaZj2jYQ9Wc+3Z41/mleXlaw9iMaBFnorRzjcMiyOwgXEe
         LXGjlTg5LyutM6yurMRk5vCmgvg6d2z8JIZwWFPk7ZxqY8syI7TVHxHFt1b7drlcOUWR
         Ct3A==
X-Gm-Message-State: AOAM532j3BdQrh7ImvbjOwufpAqi9CVTyJfDcQWQaqQWL/LT/0n7K6UK
        dR2Bgrx3iwxhka8zauWY2duK0lXQc4s=
X-Google-Smtp-Source: ABdhPJwuSqQHEVptmdh/EwWuA/T4cbeWAYVqa9DZH8It3TIsWRfbdwjO5Bu4gmAdA0iCOk6PvSBzzA==
X-Received: by 2002:adf:8185:: with SMTP id 5mr8891921wra.44.1608157684094;
        Wed, 16 Dec 2020 14:28:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x25sm4508256wmc.3.2020.12.16.14.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:28:03 -0800 (PST)
Message-Id: <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
References: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 22:27:58 +0000
Subject: [PATCH v5 0/4] merge-ort: implement recursive merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-ort-2 (it does NOT depend on en/merge-ort-3
and can thus be reviewed/merged independently of it).

This short series adds handling of recursive merges (merging of multiple
merge-bases to create a virtual merge base) to merge-ort. With this short
series the number of test failures under GIT_TEST_MERGE_ALGORITHM=ort drops
by 801 (from 1448 to 647).

Changes since v4:

 * add an earlier patch in the series that moves reverse_commit_list(),
   as-is, to commit.c. This also shrinks what is now the second patch.

Elijah Newren (4):
  commit: move reverse_commit_list() from merge-recursive
  merge-ort: copy a few small helper functions from merge-recursive.c
  merge-ort: make clear_internal_opts() aware of partial clearing
  merge-ort: implement merge_incore_recursive()

 commit.c          |  11 +++++
 commit.h          |   3 ++
 merge-ort.c       | 121 +++++++++++++++++++++++++++++++++++++++++++---
 merge-ort.h       |  10 ++++
 merge-recursive.c |  11 -----
 5 files changed, 138 insertions(+), 18 deletions(-)


base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-814%2Fnewren%2Fort-recursive-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-814/newren/ort-recursive-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/814

Range-diff vs v4:

 -:  ----------- > 1:  9052faeabe6 commit: move reverse_commit_list() from merge-recursive
 1:  dcf28565ad3 ! 2:  949741932e5 merge-ort: copy a few small helper functions from merge-recursive.c
     @@ merge-ort.c: void merge_finalize(struct merge_options *opt,
      +	commit->object.parsed = 1;
      +	return commit;
      +}
     -+
     -+MAYBE_UNUSED
     -+static struct commit_list *reverse_commit_list(struct commit_list *list)
     -+{
     -+	struct commit_list *previous = NULL, *current, *backup;
     -+	for (current = list; current; current = backup) {
     -+		backup = current->next;
     -+		current->next = previous;
     -+		previous = current;
     -+	}
     -+	return previous;
     -+}
      +
       static void merge_start(struct merge_options *opt, struct merge_result *result)
       {
 2:  bffc45c6570 = 3:  3852125c70b merge-ort: make clear_internal_opts() aware of partial clearing
 3:  f622d6905d0 ! 4:  63e30492ccb merge-ort: implement merge_incore_recursive()
     @@ merge-ort.c: static inline void set_commit_tree(struct commit *c, struct tree *t
       static struct commit *make_virtual_commit(struct repository *repo,
       					  struct tree *tree,
       					  const char *comment)
     -@@ merge-ort.c: static struct commit *make_virtual_commit(struct repository *repo,
     - 	return commit;
     - }
     - 
     --MAYBE_UNUSED
     - static struct commit_list *reverse_commit_list(struct commit_list *list)
     - {
     - 	struct commit_list *previous = NULL, *current, *backup;
      @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *opt,
       	}
       }

-- 
gitgitgadget
