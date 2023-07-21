Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90295EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 06:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGUGKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 02:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjGUGJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 02:09:57 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838733583
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 23:09:08 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-345fcf8951fso7723275ab.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 23:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689919747; x=1690524547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS4Q3p56nv6nDwoOdN4NXZeyMl4jjyK8sbYMRfhqig0=;
        b=baoN8r1Vl7KAYFXdN70jpoAbevsdH4C5iEW5lQmSJ00il4oEpUKdttJFl8H4DseuuM
         JlbCECgeGFwkSkcMnjbvqvOjJIsNbDepT5/cvR6k3vrd1Nf6OhN9aTflUUCNO3vTS+bF
         irdImM9RtkA1lc+aETyDuBc4R/L14ltgh66wQMjPURdj4VC1j+XdKoW0nofX7PvlVHkb
         oOeXp3s3lahAj8IvX/28Jqg/OGcMNJyNY93EKo9OReLK38pAqg3FXYUcgZc6BL0wG5Fy
         tI3X5u4w7zZyzPc/v+fyQ+6ZPGhB2kq8L+lTUwyTniTM0pV7GM2uKn6fMkZcZZZ/pUP7
         yU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689919747; x=1690524547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS4Q3p56nv6nDwoOdN4NXZeyMl4jjyK8sbYMRfhqig0=;
        b=BJue21nO4gOh5TbdPsBRip+BCgs8k+HmW3Sb4xRiX6/9V6OGBtU0tadGy3YB2fbFwG
         QqXnxODhYakwVPyeDXSZEgAwM0NKx9qA36p1v9mKULjjAJYRwnbK027brxc7C3bg6IxX
         AgRy58yq4zhTv2YfpengW+5BIqqocteHxOhKWAYhmxctSfG4pPL9ej/vvVkKD/586b3K
         Z9/NxDGD7rna4DGc9Xk4QWXUcEHxvjd2An+Q4q516ZWIyajqfSS8315sbUL9Fn21fc2h
         ASlxjLw6AaKw5U5yqYWeDpA+tlWUPEdGC1lNBWXp6FefE31+yFerDMwO4X6Y7Av/5QOz
         WfeA==
X-Gm-Message-State: ABy/qLY88B+QQQo/s2Mb3j5UVL/Al71GFmyFLGYwXdRAFmcuylvmNYj+
        eLuaAM4PaguKY80/FWuQ4n/AsUtfhOI=
X-Google-Smtp-Source: APBJJlH4hQUw9bNCziDJmMyE0HdznbfeYswCj3pyoVZOQdEidWWkxq4hx+xVuKMgt8NdbUIrzumj6g==
X-Received: by 2002:a05:6e02:12ce:b0:347:5ce2:b996 with SMTP id i14-20020a056e0212ce00b003475ce2b996mr1253328ilm.20.1689919747063;
        Thu, 20 Jul 2023 23:09:07 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7928e000000b0067a1f4f4f7dsm2121639pfa.169.2023.07.20.23.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 23:09:06 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4 1/1] sequencer: finish parsing the todo list despite an invalid first line
Date:   Fri, 21 Jul 2023 00:07:51 -0600
Message-ID: <20230721060848.35641-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721060848.35641-1-alexhenrie24@gmail.com>
References: <20230721055841.28146-1-alexhenrie24@gmail.com>
 <20230721060848.35641-1-alexhenrie24@gmail.com>
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
index ff0afad63e..8ffd2a7318 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1596,6 +1596,24 @@ test_expect_success 'static check of bad command' '
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'the first command cannot be a fixup' '
+	rebase_setup_and_clean fixup-first &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="fixup 1 2 3 4" \
+			       git rebase -i HEAD~4 2>actual &&
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

