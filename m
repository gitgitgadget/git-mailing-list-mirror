Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECD0C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379220AbhK2SbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377455AbhK2S25 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:28:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD09C12B683
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:50:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j3so37417135wrp.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwpWzxj83Xw7NGuTqMjzZHrSaU+DphNc7jZW0xslEIE=;
        b=LZGdCBHU4NoWJHKlqUXaz8ggsomITTjRObMvzA89TWY1iz4VUncbKLkIBqU9PmuUOU
         E3XxbRckrN1FJD/wJzNtUWiqJN8XIJg5phFAK6hBAzYuGvvdhlJ2OU4TeSxVbevuo/yi
         mdlLHxC2r/wrTwr6dJz3uAMoJT2a962leJiKj7DCJsL96yXhE4QddoyuOTXK8P6XweME
         zIh2AZ904aCSDWJFogaor/M/J97oT4cSBmx/pZoKuWz5XsN1NLvw7KSsav0BY6fV6KRw
         wy6r68Wa7KT1OlyYJfdNeQfB3gVDYH00j0M0A4FZ0op5oOKEnQ99fHAkGL7jepuelpPD
         QSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwpWzxj83Xw7NGuTqMjzZHrSaU+DphNc7jZW0xslEIE=;
        b=H8uHIB+uqo1t6mecrqn3I6mlC82+OYkrNN2m8oaty6Xw5ulzSGZvOvYeLz1xJor2fu
         dJRc1yCAT5XC8TLDOyZrCCJuEOk091lTqUZWfR97DXFF33uWRDvJ5GaLBC69NX2wGZWz
         5N7343fLqKbim7iclHlo8rQBA1JT+qqNLszOyGzOF3+VEfYI4AZMq8rVwSdDsXUECKkC
         QJr0VZglwd2rBZgj77GAtKva80RJqvN/ScWdXyUg3Eqz7//zmmJuNoO9emzwsZ9XUmCn
         5lF7kDcka0HPsU67scEfly6VfoVYivsJjinXNHghkkBuSICi8aT9ba6QrEogB2+Q/ZCc
         fdlw==
X-Gm-Message-State: AOAM533LM+sjZKJRI7RCOxtfNsj/bGam6NUq9GhXIpbnZqDXw4IM0CVg
        J0CRctCn/6ADO1JqSy+EwArdvoxzzELPRw==
X-Google-Smtp-Source: ABdhPJzvcWpEyRyGgYu48Um7Pz1UT1j3m/Sodp+ml50FvTx0wZLcY4G5qRcdPEecRZ3iXb9yVzCnKw==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr35839409wrd.362.1638197458241;
        Mon, 29 Nov 2021 06:50:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b11sm19579946wmj.35.2021.11.29.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:50:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/7] log tests: check if grep_config() is called by "log"-like cmds
Date:   Mon, 29 Nov 2021 15:50:48 +0100
Message-Id: <patch-v3-2.7-ec8e42ced1a-20211129T143956Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in my 9df46763ef1 (log: add exhaustive tests
for pattern style options & config, 2017-05-20) to check not only
whether "git log" handles "grep.patternType", but also "git show"
etc.

It's sufficient to check whether we match a "fixed" or a "basic" regex
here to see if these codepaths correctly invoked grep_config(). We
don't need to check the details of their regular expression matching
as the "log" test does.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b3..11bb25440b0 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -449,6 +449,30 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
 	)
 '
 
+for cmd in show whatchanged reflog format-patch
+do
+	case "$cmd" in
+	format-patch) myarg="HEAD~.." ;;
+	*) myarg= ;;
+	esac
+
+	test_expect_success "$cmd: understands grep.patternType, like 'log'" '
+		git init "pattern-type-$cmd" &&
+		(
+			cd "pattern-type-$cmd" &&
+			test_commit 1 file A &&
+			test_commit "(1|2)" file B 2 &&
+
+			git -c grep.patternType=fixed $cmd --grep="..." $myarg >actual &&
+			test_must_be_empty actual &&
+
+			git -c grep.patternType=basic $cmd --grep="..." $myarg >actual &&
+			test_file_not_empty actual
+		)
+	'
+done
+test_done
+
 test_expect_success 'log --author' '
 	cat >expect <<-\EOF &&
 	Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
-- 
2.34.1.841.gf15fb7e6f34

