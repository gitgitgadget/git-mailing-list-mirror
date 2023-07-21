Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F48EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 05:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGUF7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 01:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGUF7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 01:59:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B919B3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 22:59:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55fcc15e109so865562a12.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689919171; x=1690523971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QWjGYYL8lcbCygo56eLZiTuWlksZjs7B5jO36G0o78=;
        b=mYcay7OahoAZMe8lxKlBNUK1wmvQPUfgMqjfMSStUdTMxiiZEDhXgMkIubabHk91hV
         4TK9eFvcGF7WJBvLsoWqlb5T6SD86YCqskSIPrDxg3qCmH8MAClUiRAOtPHC6P+biaBH
         /18frUEQr0HsIS/a2z7xmc94fL+aEW6HcQDSlv3kaglNBPVwe+cWCJiZ1EWy9E+6QgQP
         0xjb1B8yQ2+cWn8gu1qDa3MxOawbTS0TnmZBAjmDtOwpH6Zg1DHnjcvARUDdmGUrTaSy
         6Bh83+3HDScw276kPaz6jkPHxHMiUqNQcjsEf4gufUySqArv/O+5gtvrykHixITwSg8H
         TUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689919171; x=1690523971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QWjGYYL8lcbCygo56eLZiTuWlksZjs7B5jO36G0o78=;
        b=TY6VsLTXdFb9YCGQfVGxwNfRxkalY5lqaeLuMsJdGMAsBGm/hC8Q40pjP8/PX0JY33
         H1xJMDFSRuZTZRUuyKK4Ax0dFUDUmX4kBVX24l/CM/fkwzpy4id0T23O7tzIgKCH82Sm
         iuA33ICGpbIvn+IfX294RqPj/oOq5x6MjA0sYD51X1+PEM3stz5YWF30CfhnCsI6KiLW
         bA01yyE1mbwvUrt6l2+atsOnbyfq7kcj4+PSM+UGIfqfF2OypUzuuk6vmIrO6VARuVPf
         qBgaxziaXK7iW5VKPHsuA0wSqX4H31dmT2ufiVJakNuTPSEHfhXrR0St08A0YqQBLDpq
         igpA==
X-Gm-Message-State: ABy/qLbRevhaNPPv9YXaRCcuCeGLuRj1os5fThhHmxh50AiWHHUaaz/D
        rrJqoSRMIMFFpsE3YRvRSxCf0Bl93gg=
X-Google-Smtp-Source: APBJJlHG7Wgfn0nc3Tq3bN04MONvTzXocUsxwH+c9cQeO2SGqQ+XU88ztpK4YGwk0D+6ZgHq3HrQVw==
X-Received: by 2002:a17:90b:3907:b0:263:5c6a:1956 with SMTP id ob7-20020a17090b390700b002635c6a1956mr608539pjb.25.1689919171337;
        Thu, 20 Jul 2023 22:59:31 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090aab1700b002636e5c224asm1777941pjq.56.2023.07.20.22.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 22:59:30 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 1/1] sequencer: finish parsing the todo list despite an invalid first line
Date:   Thu, 20 Jul 2023 23:58:17 -0600
Message-ID: <20230721055841.28146-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721055841.28146-1-alexhenrie24@gmail.com>
References: <20230721053906.14315-1-alexhenrie24@gmail.com>
 <20230721055841.28146-1-alexhenrie24@gmail.com>
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
index ff0afad63e..fba89146cf 100755
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
+		test_must_fail git rebase --edit-todo 2>actual &&
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

