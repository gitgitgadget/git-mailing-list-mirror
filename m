Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE74EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 05:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGUFxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 01:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGUFwY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 01:52:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398273ABF
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 22:51:44 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76731802203so156562585a.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 22:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689918703; x=1690523503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzZKVVE2DzoStiL/MGbZXeaDIKmcKugPMywqr2rsJwc=;
        b=qMwVSi6zjmc+7qRbhxYD8Qw0X95Vqmu8Il816O81gNduFvUQO2y6F5fnJTPkZtV3bG
         VtPqPZU9YPzi/F7m4CtQsz1lbiY0jUQ7ZZ1nefSjqN/dsvbyUQtIu3oG8SLrsZvSaLxe
         mXTaha4Hkm5zTTwGI7jxlWTCs0GwMyADb5npPVM1Cyhnm5olH+3xeEwlOhKGU6M+MXH4
         baxuziiQ40ObmMC9vkYzOyXyYJ4oB2Cw8HDFuyAzqNRZ6BVRY2ZykwYFZmkX+cXLnzoM
         2H2VPEERS+QX55qMSpj85/0fduc1gm3uY4Hhwabt9/P8PBFo7/FHWZZOlXJgTLcXqMRq
         8OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689918703; x=1690523503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzZKVVE2DzoStiL/MGbZXeaDIKmcKugPMywqr2rsJwc=;
        b=QBRc928l0tUBqDCUOhLCiWkTwEsiSIQpgyzSIxHfpMgbMQCpypyojtLBkCg8sgeVco
         uD/sFkVbh7h7eZqxOkkfRr9gWanJTh1myzyabG7aT/qYmcorSkFo0ubEdgPWjM464iGI
         WlCdXBf5simnCzUTJXGZky71rn7xvw6TMO12WdWO5vVVL+ZFNCBE1ZStqOscamc2KtgJ
         6ML7V6e7g6vY1KOQRGk+HPpQLUGrIA9zddGCVqFkRxqqIv4we1FSwXMm7M+X1N12yZku
         8KAN4QKPSQDSVyAvgr23tL3FoAKfpJmQvbPTnngDnYUZ9eONxFQJSQtNRCEj5d8nGQiy
         Uvkg==
X-Gm-Message-State: ABy/qLb2MtJidvObo9Oq+k845HC1vBdLzCOQqvrBA1RCSVtmnNxZXlxg
        wwQR9lLlZyl3rKvEedtxuAkQ1sQP3nA=
X-Google-Smtp-Source: APBJJlF+PVkBJ9y1hc78bk2ijaS3Nyw/+gzXYfpSfml12gP+J7W06l1464OQm4O3CMDIErMJq76oLw==
X-Received: by 2002:a05:620a:3956:b0:767:3124:b90b with SMTP id qs22-20020a05620a395600b007673124b90bmr1015735qkn.10.1689918702744;
        Thu, 20 Jul 2023 22:51:42 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b00265c742a262sm1803673pjl.4.2023.07.20.22.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 22:51:42 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 1/1] sequencer: finish parsing the todo list despite an invalid first line
Date:   Thu, 20 Jul 2023 23:38:57 -0600
Message-ID: <20230721053906.14315-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721053906.14315-1-alexhenrie24@gmail.com>
References: <20230719144339.447852-1-alexhenrie24@gmail.com>
 <20230721053906.14315-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ddb81e5072 (rebase-interactive: use todo_list_write_to_file() in
edit_todo_list(), 2019-03-05) made edit_todo_list more efficient by
replacing transform_todo_file with todo_list_parse_insn_buffer.
Unfortunately, that innocuous change caused a regression because
todo_list_parse_insn_buffer would stop parsing after encountering an
invalid 'fixup' line. If the user accidentally made the first line a
'fixup' and tried to recover from their mistake with `git rebase
--edit-todo`, all of the commands after the first would be lost.

To avoid throwing away important parts of the todo list, change
todo_list_parse_insn_buffer to keep going and not return early on error.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index cc9821ece2..adc9cfb4df 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2702,7 +2702,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 		if (fixup_okay)
 			; /* do nothing */
 		else if (is_fixup(item->command))
-			return error(_("cannot '%s' without a previous commit"),
+			res = error(_("cannot '%s' without a previous commit"),
 				command_to_string(item->command));
 		else if (!is_noop(item->command))
 			fixup_okay = 1;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff0afad63e..d133cbae32 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1596,6 +1596,24 @@ test_expect_success 'static check of bad command' '
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'the first command cannot be a fixup' '
+	rebase_setup_and_clean fixup-first &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="fixup 1 2 3 4 5" \
+			       git rebase -i --root 2>actual &&
+		grep "cannot .fixup. without a previous commit" actual &&
+		grep "You can fix this with .git rebase --edit-todo.." actual &&
+		grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
+		test_must_fail git rebase --edit-todo &&
+		grep "cannot .fixup. without a previous commit" actual &&
+		grep "You can fix this with .git rebase --edit-todo.." actual &&
+		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
+		# check that --edit-todo did not lose any of the todo list
+		test_cmp orig actual
+	)
+'
+
 test_expect_success 'tabs and spaces are accepted in the todolist' '
 	rebase_setup_and_clean indented-comment &&
 	write_script add-indent.sh <<-\EOF &&
-- 
2.41.0

