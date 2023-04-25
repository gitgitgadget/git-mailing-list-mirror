Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D8C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 13:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjDYNfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjDYNfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 09:35:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A7D14469
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso4642462b3a.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682429695; x=1685021695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIQ8zF8yWmFvnIYpLblmdHus18rHX8CYW0kBt/vZspg=;
        b=UvgBehJtH3luIHWDSyYLGHwyBI5EkslBX2EQOcot4YbLuDr02y3yU8qAv7WH35UnEQ
         Gvt99dnD/xrAhNZ4fNHJfbu1HRmb9ZO4aeq4yUjGZRqyPy9naJWnn0a2K3mqV93WykyQ
         /MIQ565XdJGzfTYk2hEgPyaCc/LSNcc3rnczxJB/sU/kiGCjFN3z9VTi5OT94oAHY7Tv
         3RsE0PWf7segbk76O9pDMMkmP5Jv7ZzG1m3IpUC4DZc00Br1EDa5FsxsyjniT9VlfjMa
         3PAucjfrgRI03FLXQtGsnAjIki80GIFE8vQBp6t5HGGUzOuovcai5hqo3qzhCVt9V49g
         yG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429695; x=1685021695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIQ8zF8yWmFvnIYpLblmdHus18rHX8CYW0kBt/vZspg=;
        b=BBOefV1MZrHCuksOS5FyiubcvPbYD28Eop4UD0lxcj9rM4JImg54qXZwjgGBY9KAyj
         Rfa5MebHCwT6pUKqTePXIQZHAJruSUDnayvxqrZoLhDELatCy8DUb2Z0Y1NTu8PT0VMe
         tiI6a8iFimq4yzj/SUt+dwkuXivuzYF8N9dhXUOR7pVRr9LIVV07ctF/abtyUxJ4ofJN
         ry45OGq0fmeaenuY/Tr4xUaapud1tsCwRRYjLvxyeKQ7KPFzh6Y9yDEZGzIUDC8CoJ7p
         FLMP8fZldKaNFTRqGbEegWsk/xZrdMADds2xVdFIJZ4oob/yUAQFsF9ReeeShyL0JJnb
         98ig==
X-Gm-Message-State: AAQBX9fYudMHp6v8Ysrf7T88QccTrBCHRUE5MzERsgVClbAnyG3tGF5i
        IwCYH0rBmrN3XXGaI9RWLv0=
X-Google-Smtp-Source: AKy350Z92xa0GMkb6Og5F8fLR8fZObCvHfAwr5WwtjropemkBxsh4YbKA7KhrRVdcN0lJWOt/+fX0A==
X-Received: by 2002:a05:6a00:1396:b0:63b:2102:9fc8 with SMTP id t22-20020a056a00139600b0063b21029fc8mr21854987pfg.21.1682429695450;
        Tue, 25 Apr 2023 06:34:55 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id c192-20020a621cc9000000b0063d44634d8csm9243469pfc.71.2023.04.25.06.34.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:34:55 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 3/6] t3321: add test cases about the notes stripspace behavior
Date:   Tue, 25 Apr 2023 21:34:38 +0800
Message-ID: <6dfb5bf294dd4038290a4945706c81aececc6d4d.1682429602.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g931d6dc6
In-Reply-To: <cover.1682429602.git.dyroneteng@gmail.com>
References: <cover.1682429602.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t3321-notes-stripspace.sh | 291 ++++++++++++++++++++++++++++++++++++
 1 file changed, 291 insertions(+)
 create mode 100755 t/t3321-notes-stripspace.sh

diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
new file mode 100755
index 00000000..7c26b184
--- /dev/null
+++ b/t/t3321-notes-stripspace.sh
@@ -0,0 +1,291 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Teng Long
+#
+
+test_description='Test commit notes with stripspace behavior'
+
+. ./test-lib.sh
+
+MULTI_LF="$LF$LF$LF"
+write_script fake_editor <<\EOF
+echo "$MSG" >"$1"
+echo "$MSG" >&2
+EOF
+GIT_EDITOR=./fake_editor
+export GIT_EDITOR
+
+test_expect_success 'setup the commit' '
+	test_commit 1st
+'
+
+test_expect_success 'add note by editor' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes add  &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add note by specifying single "-m"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	git notes add -m "${LF}first-line${MULTI_LF}second-line${LF}" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add note by specifying multiple "-m"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+	first-line
+
+	second-line
+	EOF
+
+	git notes add -m "${LF}" \
+		      -m "first-line" \
+		      -m "${MULTI_LF}" \
+		      -m "second-line" \
+		      -m "${LF}" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'append note by editor' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	git notes add -m "first-line" &&
+	MSG="${MULTI_LF}second-line${LF}" git notes append  &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append note by specifying single "-m"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	git notes add -m "${LF}first-line" &&
+	git notes append -m "${MULTI_LF}second-line${LF}" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append note by specifying multiple "-m"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+	first-line
+
+	second-line
+	EOF
+
+	git notes add -m "${LF}first-line" &&
+	git notes append -m "${MULTI_LF}" \
+		      -m "second-line" \
+		      -m "${LF}" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add note by specifying single "-F"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	cat >note-file <<-EOF &&
+		${LF}
+		first-line
+		${MULTI_LF}
+		second-line
+		${LF}
+	EOF
+
+	git notes add -F note-file &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add notes by specifying multiple "-F"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		file-1-first-line
+
+		file-1-second-line
+
+		file-2-first-line
+
+		file-2-second-line
+	EOF
+
+	cat >note-file-1 <<-EOF &&
+		${LF}
+		file-1-first-line
+		${MULTI_LF}
+		file-1-second-line
+		${LF}
+	EOF
+
+	cat >note-file-2 <<-EOF &&
+		${LF}
+		file-2-first-line
+		${MULTI_LF}
+		file-2-second-line
+		${LF}
+	EOF
+
+	git notes add -F note-file-1 -F note-file-2 &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append note by specifying single "-F"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		initial-line
+
+		first-line
+
+		second-line
+	EOF
+
+	cat >note-file <<-EOF &&
+		${LF}
+		first-line
+		${MULTI_LF}
+		second-line
+		${LF}
+	EOF
+
+	git notes add -m "initial-line" &&
+	git notes append -F note-file &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append notes by specifying multiple "-F"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		initial-line
+
+		file-1-first-line
+
+		file-1-second-line
+
+		file-2-first-line
+
+		file-2-second-line
+	EOF
+
+	cat >note-file-1 <<-EOF &&
+		${LF}
+		file-1-first-line
+		${MULTI_LF}
+		file-1-second-line
+		${LF}
+	EOF
+
+	cat >note-file-2 <<-EOF &&
+		${LF}
+		file-2-first-line
+		${MULTI_LF}
+		file-2-second-line
+		${LF}
+	EOF
+
+	git notes add -m "initial-line" &&
+	git notes append -F note-file-1 -F note-file-2 &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add notes with empty messages' '
+	rev=$(git rev-parse HEAD) &&
+	git notes add -m "${LF}" \
+		      -m "${MULTI_LF}" \
+		      -m "${LF}" >actual 2>&1 &&
+	test_i18ngrep "Removing note for object" actual
+'
+
+test_expect_success 'add note by specifying "-C" , do not stripspace is the default behavior' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		${LF}
+		first-line
+		${MULTI_LF}
+		second-line
+		${LF}
+	EOF
+
+	cat expect | git hash-object -w --stdin >blob &&
+	git notes add -C $(cat blob) &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add notes with "-C" and "-m", "-m" will stripspace all together' '
+	test_when_finished "git notes remove" &&
+	cat >data <<-EOF &&
+		${LF}
+		first-line
+		${MULTI_LF}
+		second-line
+		${LF}
+	EOF
+
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+
+		third-line
+	EOF
+
+	cat data | git hash-object -w --stdin >blob &&
+	git notes add -C $(cat blob) -m "third-line" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add notes with "-m" and "-C", "-C" will not stripspace all together' '
+	test_when_finished "git notes remove" &&
+	cat >data <<-EOF &&
+
+		second-line
+	EOF
+
+	cat >expect <<-EOF &&
+		first-line
+		${LF}
+		second-line
+	EOF
+
+	cat data | git hash-object -w --stdin >blob &&
+	git notes add -m "first-line" -C $(cat blob)  &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.40.0.358.g931d6dc6

