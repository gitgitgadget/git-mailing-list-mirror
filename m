Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC7C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 09:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbjD1JYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 05:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1JXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 05:23:54 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874193C01
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso7717690b3a.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682673832; x=1685265832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wd1K00lHiEYruSh/8mnS/IwOpa3xN+rbHeZE/i26A4=;
        b=W2/0p2NSlnpHtw5yv7pNq+nURkF1x8iJqoW6Mp33ptEFifoH+qi9KbR45Rox0u1F+A
         67arBtNUMvnRQ2l8PamkLH+JWahxCAXdQ1hATW1/jESVStXUxtMh6J0AWtVte3+cEnqa
         pX/nXHcHpW7a7TbcGXuGApTTTd1KR5yOZw8KPwJq42gqcL1g3ZI+XRIA+mhw7hdBQZa5
         4czBhs8SrMGep8wk0QyNFE1BcmEWW1F6rqgpzWKEe9Kx+nqiiWqfewsp2jO1SVLo7UAd
         Y4M8MTqR1fS8imDOqXH1toFzDkooF8ZKpm8/A/4FCb/kge9XsDPvfVB5Q2rgbFYc6opU
         TvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682673832; x=1685265832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wd1K00lHiEYruSh/8mnS/IwOpa3xN+rbHeZE/i26A4=;
        b=OwiEwNTmSWyRP3ZBk6db2Xup0H633q5hqmYiH5iwilF9pYvTwAnmiIIxwHPOOEniKz
         ost8g98wzTaG3irpsPYcFiKDBWhXeboXwRBifoMrOCiqBDwja+ulpuggn1AcHF/H05pn
         GQ4NBwdcnUxbJWK1XhN6cDw0dPH3IMytlwaF6AhuIA38xqhNbCDYjT7AkWPJ0N1UFbhO
         TiJxOoO58qZ2F/wqvgJZKjmTyWcDnX6QK8GA8S/OUwgzIvq3AZk3d9xxfPf4utDa3H7V
         BfpN9j1u/hR7tSHEX/6rfN3iMtN69RSULD6HsFWj51iDgv8C9Ji7HFm7jKelg9qJOi+h
         6krQ==
X-Gm-Message-State: AC+VfDwPOQYCeCeWNe+lPo8Eqcn4xl3E4lLOKCU3S3Yr5vlCtkMpbfHM
        kOuuATHeuTdvcHrf1QpYH2jb13mVHIZHwg==
X-Google-Smtp-Source: ACHHUZ5/Dvuz16HcpmUSofNe35xZewJxuoo87Xe1LbTt9ARAYxMLjBfKh9U6j2JOnoS8D8mBnBITtA==
X-Received: by 2002:aa7:88cf:0:b0:639:28de:a91e with SMTP id k15-20020aa788cf000000b0063928dea91emr7841354pff.17.1682673831884;
        Fri, 28 Apr 2023 02:23:51 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id i21-20020a056a00225500b0063b8f33cb81sm15107078pfu.93.2023.04.28.02.23.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2023 02:23:51 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v9 3/6] t3321: add test cases about the notes stripspace behavior
Date:   Fri, 28 Apr 2023 17:23:31 +0800
Message-ID: <c2fc2091d2afbb5911220bb55574fae11cf1c1dc.1682671758.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g2947072e.dirty
In-Reply-To: <cover.1682671758.git.dyroneteng@gmail.com>
References: <cover.1682671758.git.dyroneteng@gmail.com>
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
2.40.0.358.g2947072e.dirty

