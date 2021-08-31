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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B6C4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D9B6101C
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbhHaC1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbhHaC1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:27:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D2C06175F
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q14so25107654wrp.3
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=evgH69cGVC9jNNZhiJw0LZ3Qbyh9uA1+LfK/8vbOmaU=;
        b=t3CdilrU3AC2Ad5pdZcXpS6ed5yLh6jCmPHqR/HBZ4yDJ7PvF66Uz7WsX3WhOUXiLf
         JryESr3HAHVWNkxWhcM7r6y6jw1qKzARRXdAj/lOKu961nMUn93aQ+GkjXrNXuGnTfVF
         lqcKzrQv8A1fpb9yIzj+49xEQbFkDDx1Wri/hHuFBPDgJsSyo15NMfXNefKBZNeaA2vK
         BTtLkJA4mx//KGACsW0q4k47hePiun6YPOiIN7jmr1BYLBSqMpKq8UXI/9geRyUlRJxw
         ruxCxO5w/h18mmlG2fh62U44bGbL6nqJIn/S+pa91lODXKpuRhsltwZ7FiznLp+OMfx5
         Rm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=evgH69cGVC9jNNZhiJw0LZ3Qbyh9uA1+LfK/8vbOmaU=;
        b=gTpC4CAPr63icA/RaIOLrwRr7V86wT869pqQ5P1mw9rR6W7gn/6I/VFkL8+mzRLxFn
         HZUCp8XxmEqDImlBbQXn7i+X0lKs/4df0koYXwVKaCjnYAWK0QBNqr/7Gu5GGOAaY6Z7
         o5bRKEVcUqqG2ikFC8YbAadoJiYxCX6oIukUGvLUafarW6Ofr3aF3HE564nUxy71YvRj
         7P8wtVyXHO/RwupvWQvssK91bGO/HAa9q0jR0z6k8Tja4rfGDMWn41s/bIrSFUyEtM0g
         G5Cec6Yx7xMO1phG6+dKGUdI2NzBH4xSFVpte5AN8fyvTbjnnEh+s2twnPyXfImJzaDb
         9S/A==
X-Gm-Message-State: AOAM5316ntnAM6XD455W9vjRAYcMrw7PawH0D+pCLvhg4UfLyhf1v0O+
        tQ3ihkJZi8oDrz8FXlixt8QlQx+hjbI=
X-Google-Smtp-Source: ABdhPJz56gn4uatd1EhXH9reimBX7QiLXfpZUg37tuI9AZjFLS2CX9UUHgaSe4D9D7jjMM2wj30Yxw==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr28614816wrx.262.1630376802212;
        Mon, 30 Aug 2021 19:26:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm17092349wrs.7.2021.08.30.19.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:26:41 -0700 (PDT)
Message-Id: <df6e2774f1a5560a598dd8b46131bc6b0a261d4a.1630376800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 02:26:34 +0000
Subject: [PATCH 1/7] merge-ort: mark a few more conflict messages as omittable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

path_msg() has the ability to mark messages as omittable when recording
conflict messages in an in-tree file.  This conflict message file will
then be shown by diffing the merge-created tree to the actual merge
commit that is created.  While all the messages touched in this commit
are very useful when trying to create a merge initially, early use with
the --remerge-diff feature (the only user of this omittable conflict
message capability), suggests that the particular messages marked in
this commit are just noise when trying to see what changes users made to
create a merge commit.  Mark them as omittable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 515dc39b7f6..4dbf0a477af 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2409,7 +2409,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		 */
 		ci->path_conflict = 1;
 		if (pair->status == 'A')
-			path_msg(opt, new_path, 0,
+			path_msg(opt, new_path, 1,
 				 _("CONFLICT (file location): %s added in %s "
 				   "inside a directory that was renamed in %s, "
 				   "suggesting it should perhaps be moved to "
@@ -2417,7 +2417,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 				 old_path, branch_with_new_path,
 				 branch_with_dir_rename, new_path);
 		else
-			path_msg(opt, new_path, 0,
+			path_msg(opt, new_path, 1,
 				 _("CONFLICT (file location): %s renamed to %s "
 				   "in %s, inside a directory that was renamed "
 				   "in %s, suggesting it should perhaps be "
@@ -3814,7 +3814,7 @@ static void process_entry(struct merge_options *opt,
 				reason = _("add/add");
 			if (S_ISGITLINK(merged_file.mode))
 				reason = _("submodule");
-			path_msg(opt, path, 0,
+			path_msg(opt, path, 1,
 				 _("CONFLICT (%s): Merge conflict in %s"),
 				 reason, path);
 		}
-- 
gitgitgadget

