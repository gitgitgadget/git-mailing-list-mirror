Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E51C6379F
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBQOiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 09:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBQOh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 09:37:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4550346
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 06:37:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p22so1118732wms.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 06:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zOQAQKCn1f2PcH964ucx3HMFmvD/vLm54uhHEoL+JMs=;
        b=aUT48HaM9XSvKT3Hf8E5qW1vdeMmfeMXWluPOSuz1VOE4+/uKDlXPKV/aW91YXBxrp
         EwgIcmZQtMfHMmPaFRIHrns0hNMeq2Uce+LRoZ1Xtg1nBcNo7BvezZi0pGH72Ur9ChKw
         i211j/KI1kztmuuJ/ZC0c3V+RvVIzavjuOuquvm77BWQ2JTS64UE9A+G6goO8+QVWhyW
         7C+lI9UNiSurddlOtXoqidLVuq8DXT3puSDYXjS+q5E+8T5nYsIMpX0u2ZcU73oN9k24
         KmLYecmm4PAqEbvAApP06D3yRnu48zcjzBj8wN+7aNrqp8y2IxmSnJ9rWh74i/eEXz9M
         ukuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOQAQKCn1f2PcH964ucx3HMFmvD/vLm54uhHEoL+JMs=;
        b=np5OewipWxX2Upd+k8MozgPr33rwIhFhkaTZBPCNMnTfUfS8vd8guXSrutW1QFHrrn
         QkTlySk+WsYdqeb5yEe6Ov6dkbbaG/5weL6VJeRT00MldrjjZG4RgvwUmweHHAmncvcR
         IGQ0tzncmuTf0TcVlxvxjP5HxufT0H4dMFPpd1hmo3FVkbSWPsieNu/qdq2mPHH15WmZ
         wtDnRG4bY7PQGwpON62O2+u5VFhSR8Y0hyXI6yU32ruGjq4G0knFXRqSdC60EQlw+1YQ
         u5G5Fcp555m7tXime6UmzrzDQZYFq2FCSe4k9uxN5nCMkL0mz1udAPsKtvJXKO4pbvbF
         1D+A==
X-Gm-Message-State: AO0yUKWNJUpCzTyE53adzEFuO3SldOLsXodCSMnYo3r45R3MLrO2yDil
        CUMdkoo4vc2mFh6ZtY2DmF9Q/Bm3BSk=
X-Google-Smtp-Source: AK7set+KLWnk9w8iJdA+VP3guIAE/X1wINVZEA5P+KOCHJWJS1pQ6G5rM8+wcymm4OlDjKZOP6FNCA==
X-Received: by 2002:a05:600c:492f:b0:3e2:1f63:4beb with SMTP id f47-20020a05600c492f00b003e21f634bebmr2076890wmp.19.1676644676838;
        Fri, 17 Feb 2023 06:37:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b002c59e001631sm3242450wrv.77.2023.02.17.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 06:37:56 -0800 (PST)
Message-Id: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Feb 2023 14:37:55 +0000
Subject: [PATCH] rebase -i: check labels and refs when parsing todo list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check that the argument to the "label" and "update-ref" commands is a
valid refname when the todo list is parsed rather than waiting until the
command is executed. This means that the user can deal with any errors
at the beginning of the rebase rather than having it stop halfway
through due to a typo in a label name. The "update-ref" command is
changed to reject single level refs as it is all to easy to type
"update-ref branch" which is incorrect rather than "update-ref
refs/heads/branch"

Note that it is not straight forward to check the arguments to "reset"
and "merge" commands as they may be any revision, not just a refname and
we do not have an equivalent of check_refname_format() for revisions.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: check labels and refs when parsing todo list
    
    Hopefully detecting these errors when the user edits the todo list will
    give a better experience.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1482%2Fphillipwood%2Frebase-check-labels-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1482/phillipwood/rebase-check-labels-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1482

 sequencer.c                   | 37 ++++++++++++++++++++++++++++++++++-
 t/t3404-rebase-interactive.sh | 25 ++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3e4a1972897..b4b5c3f331d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2477,6 +2477,26 @@ static int is_command(enum todo_command command, const char **bol)
 		 (*bol = p));
 }
 
+static int check_label_or_ref_arg(enum todo_command command, const char *arg)
+{
+	int allow_onelevel =
+		command == TODO_LABEL ? REFNAME_ALLOW_ONELEVEL : 0;
+
+	if ((command == TODO_LABEL && !strcmp(arg, "#")) ||
+	    check_refname_format(arg, allow_onelevel)) {
+		if (command == TODO_LABEL)
+			error(_("'%s' is not a valid label"), arg);
+		else if (check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
+			error(_("'%s' is not a valid refname"), arg);
+		else
+			error(_("update-ref requires a fully qualified refname e.g. refs/heads/%s"),
+			      arg);
+		return -1;
+	}
+
+	return 0;
+}
+
 static int parse_insn_line(struct repository *r, struct todo_item *item,
 			   const char *buf, const char *bol, char *eol)
 {
@@ -2523,8 +2543,23 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 		return error(_("missing arguments for %s"),
 			     command_to_string(item->command));
 
-	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
+	if (item->command == TODO_LABEL ||
 	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
+		int ret = 0;
+
+		item->commit = NULL;
+		item->arg_offset = bol - buf;
+		item->arg_len = (int)(eol - bol);
+		if (item->command != TODO_RESET) {
+			saved = *eol;
+			*eol = '\0';
+			ret = check_label_or_ref_arg(item->command, bol);
+			*eol = saved;
+		}
+		return ret;
+	}
+
+	if (item->command == TODO_EXEC) {
 		item->commit = NULL;
 		item->arg_offset = bol - buf;
 		item->arg_len = (int)(eol - bol);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 462cefd25df..2cf2d2b8a24 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2120,7 +2120,30 @@ test_expect_success '--update-refs: check failed ref update' '
 	tail -n 6 err >err.last &&
 	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
 		<err.last >err.trimmed &&
-	test_cmp expect err.trimmed
+	test_cmp expect err.trimmed &&
+	git rebase --abort
+'
+
+test_expect_success 'bad labels and refs rejected when parsing todo list' '
+	cat >todo <<-\EOF &&
+	exec >execed
+	label #
+	label :invalid
+	update-ref :bad
+	update-ref topic
+	EOF
+	rm -f execed &&
+	(
+		set_replace_editor todo &&
+		test_must_fail git rebase -i HEAD 2>err
+	) &&
+	grep "'\''#'\'' is not a valid label" err &&
+	grep "'\'':invalid'\'' is not a valid label" err &&
+	grep "'\'':bad'\'' is not a valid refname" err &&
+	grep "update-ref requires a fully qualified refname e.g. refs/heads/topic" \
+		err &&
+	test_path_is_missing execed &&
+	git rebase --abort
 '
 
 # This must be the last test in this file

base-commit: b1485644f936ee83a995ec24d23f713f4230a1ae
-- 
gitgitgadget
