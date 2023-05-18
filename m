Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15956C7EE22
	for <git@archiver.kernel.org>; Thu, 18 May 2023 12:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjERMCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 08:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjERMCi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 08:02:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52303185
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-517c840f181so995514a12.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684411352; x=1687003352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txXP1AgyuZeTON+cUCF1GTyrdaR6B8CaHjgRnJq4iTk=;
        b=ooWpDTVqZ0ur5nXiL5Ds/mO4/1o+LR4Jw+Rt42DIK24B2wlRQGxlBlfPH4/vp0u8rs
         a1mSVpjOcUzZWqjplznt6pBGgYZJJ/ln9BE3RnbZ/51ngDOBYESTeruBqMuSSf8zxOl9
         ngam3n8gChA94kkvvkZO7B7iC+cUAIV6S0BCHRPV9LXakg1qmuvVYl0Z8k7i1R1sJutj
         FpH4M1n//gUilwDRK3S9LE6j/p0FcpFA0+RkQhxzIiV8vRgcFj7RWxdRS02UJIAQFgjn
         4Xb71/ikZZd0CfwtZAQcXkBNHEEkT72z2XxO6WB8asi/2XbDGaWmvSyjXLWgVGoOXwJW
         H+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411352; x=1687003352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txXP1AgyuZeTON+cUCF1GTyrdaR6B8CaHjgRnJq4iTk=;
        b=hUUvkMAAnonAmvMeOkiFA04vPtlxXKgGeXLBW0Y51fp4/0+0MKdMu01PGkQ/S/8W2+
         VLfLqVM/12lsC1LYOiNyw7cCb3uSjNUk9Y0N+n99NqEo7dp3iJo8dDJNVEF7TGhuQVNq
         lVErKmPftPytqKLsEr54qYxjzgJwe8TrxRuJXvob0T8+M6xXtZBdhrIpBqd/uSb8QCS/
         W0uowsoplwDFOeNo5w2OGcU2EN8x38ndy7ElYRxnoOiKy+YEtsxn/Xb7E/GH0utFTJuH
         YJihhO3GGW/rNbA56xvdmVBiAZxeIAXClJ2k6F3a34eplu92JNwOpEBdoqts0Hf0Mo0v
         Ch6w==
X-Gm-Message-State: AC+VfDw5aIysRUbhbdBcAy4eT8t1JYOQvvSOf7qocFLdbgfkzglFRWZB
        nqjLkU7jXkr0dg7A8bVuw2sjBr7BBhYcq4mE
X-Google-Smtp-Source: ACHHUZ6NZMh/zRz1GREhLhlx+iZuR99XptKT0DU8INmN3mgv9WL9GRkWc3jYKcTGcN9aEcEn5jC0tw==
X-Received: by 2002:a17:902:e751:b0:1aa:df9e:2d19 with SMTP id p17-20020a170902e75100b001aadf9e2d19mr2836946plf.54.1684411351467;
        Thu, 18 May 2023 05:02:31 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001960706141fsm1264203plb.149.2023.05.18.05.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 05:02:30 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v10 3/6] t3321: add test cases about the notes stripspace behavior
Date:   Thu, 18 May 2023 20:02:08 +0800
Message-ID: <c2fc2091d2afbb5911220bb55574fae11cf1c1dc.1684411136.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g67a1c1d0
In-Reply-To: <cover.1684411136.git.dyroneteng@gmail.com>
References: <cover.1684411136.git.dyroneteng@gmail.com>
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
2.40.0.356.g67a1c1d0

