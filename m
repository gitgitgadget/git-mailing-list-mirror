Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5C0C77B7E
	for <git@archiver.kernel.org>; Sat, 27 May 2023 07:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjE0H6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjE0H6L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 03:58:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0664BB
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5343c3daff0so996945a12.0
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685174290; x=1687766290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0t8lonkVbMdX7sCPgT5hTlbZHTOi68tTUL0y2xxNzlo=;
        b=Alq6pqq2a+pBLyN8fGuO4k5/z93xWqMfMRDvvVLhGTT3Do+TlbB5KUH3JHO05SAzEG
         rI75FtfCx2I9VdYcQl6mHJHHnVm7xiXqxEe8ixiBfErOh+HfHfdRyOtWzfKwiUu1IZBt
         khPCXxSOCUj+LOsMR5kJbugDkHhB45TEflGajSsa5sXuffu6HJ4tvdB0ZjI/GdEWZPnY
         qBNjG8F37T3uh4HnyK+xa8wT/UyVBEvYQeie1vHygSJxLTWFUzLgGxE4ET+HeueMDv9v
         mr5fO29wIQpYkuQb/jFhjcD5IvgZsrmz3U76HashJwQZBO4+mquagcQKs6rxH8Zses7Y
         8ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685174290; x=1687766290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0t8lonkVbMdX7sCPgT5hTlbZHTOi68tTUL0y2xxNzlo=;
        b=SpTP76LjM+H+gwQ27NTlo9+QLD+xjOAgNBnllqR+PrHIS46si3rUiNW/SMjW2ObO0g
         DHUHVlZuM6HBbdsmpib3lGYjmyXen/wS5gsufHNu3fu0V5Jp81K7mPO8pfsVI1fYtNPt
         G3hU/7F2CmUmeSH//d1Uo1CFIXsWxRrVFO0EdhhUQZzJ3KR7nzOxOdBELHhMYCDOJZ6R
         wH9U2C/Y8h1s0KtdrTsPoro7kHI32xJ9tX1PjFT3bssqNM3yI4XMiRjxSHpc8eMvUpNl
         kAREufYrOzCqAkJiFfBxr0vr7eoysXDDrW2d4/5+2lSmIqCFtu8UHmuU3unde2q0a+dH
         zSag==
X-Gm-Message-State: AC+VfDza3GhjwCgqWmsXiYJj420qEJiVjQqnEYoJOCuq34y5XLVkc2b5
        71+/CbPjyIjgBy7HckiUqM4=
X-Google-Smtp-Source: ACHHUZ59GIUTpaW9Y417vTMdUBKDabDMo1N5Jsv2qGGWcRz4cvEb5XWocqK3z1VkIWD0Y3Lbvi07jQ==
X-Received: by 2002:a17:903:2305:b0:1af:d78f:13f1 with SMTP id d5-20020a170903230500b001afd78f13f1mr6147261plh.49.1685174289946;
        Sat, 27 May 2023 00:58:09 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a6b2813c13sm4355239plr.172.2023.05.27.00.58.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 00:58:09 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net, code@khaugsbakk.name
Subject: [PATCH v11 3/7] t3321: add test cases about the notes stripspace behavior
Date:   Sat, 27 May 2023 15:57:50 +0800
Message-ID: <c2fc2091d2afbb5911220bb55574fae11cf1c1dc.1685174012.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g367cb1d4
In-Reply-To: <cover.1685174011.git.dyroneteng@gmail.com>
References: <cover.1685174011.git.dyroneteng@gmail.com>
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
index 00000000..89977873
--- /dev/null
+++ b/t/t3321-notes-stripspace.sh
@@ -0,0 +1,291 @@
+#!/bin/sh
+#
+# Copyright (c) 2023 Teng Long
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
+	first-line
+
+	second-line
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
+	first-line
+
+	second-line
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
+	first-line
+
+	second-line
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
+	first-line
+
+	second-line
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
+	first-line
+
+	second-line
+	EOF
+
+	cat >note-file <<-EOF &&
+	${LF}
+	first-line
+	${MULTI_LF}
+	second-line
+	${LF}
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
+	file-1-first-line
+
+	file-1-second-line
+
+	file-2-first-line
+
+	file-2-second-line
+	EOF
+
+	cat >note-file-1 <<-EOF &&
+	${LF}
+	file-1-first-line
+	${MULTI_LF}
+	file-1-second-line
+	${LF}
+	EOF
+
+	cat >note-file-2 <<-EOF &&
+	${LF}
+	file-2-first-line
+	${MULTI_LF}
+	file-2-second-line
+	${LF}
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
+	initial-line
+
+	first-line
+
+	second-line
+	EOF
+
+	cat >note-file <<-EOF &&
+	${LF}
+	first-line
+	${MULTI_LF}
+	second-line
+	${LF}
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
+	initial-line
+
+	file-1-first-line
+
+	file-1-second-line
+
+	file-2-first-line
+
+	file-2-second-line
+	EOF
+
+	cat >note-file-1 <<-EOF &&
+	${LF}
+	file-1-first-line
+	${MULTI_LF}
+	file-1-second-line
+	${LF}
+	EOF
+
+	cat >note-file-2 <<-EOF &&
+	${LF}
+	file-2-first-line
+	${MULTI_LF}
+	file-2-second-line
+	${LF}
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
+	${LF}
+	first-line
+	${MULTI_LF}
+	second-line
+	${LF}
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
+	${LF}
+	first-line
+	${MULTI_LF}
+	second-line
+	${LF}
+	EOF
+
+	cat >expect <<-EOF &&
+	first-line
+
+	second-line
+
+	third-line
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
+	second-line
+	EOF
+
+	cat >expect <<-EOF &&
+	first-line
+	${LF}
+	second-line
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
2.40.0.356.g367cb1d4

