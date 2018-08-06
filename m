Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B43208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbeHFT7w (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:59:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37354 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732994AbeHFT7v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:59:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so9689427lfb.4
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fa1DvOGIYI74cm5n8sNTmducLdeNCPsZIMiS5UeeiqM=;
        b=t7myDjnmfLBuQVJZcjCP+zLyj24KqKCMIoAAgynEIuF+kHPgrg0X9Dw1bnZx/G823V
         UEnk4dq2mBsv3Tp5aaMaq4LpTjCUOHHcbHBVEO0BoyMZ+mt3X1CG3pAIDgpdPvZytH0i
         iMhKiIVVafCpSmK8rbeZsrNBPI+larM4jkn9Il8j+EKzOf6l0HQspeVez9CuTJM7TRvG
         kfldVDKrE3gQZ6uSfCrh3zUdZwCuLr7rQl/u2LxklZOiSDCVwF+NfyLNbzlgNDb+H3pe
         Ig1XwFM/ZTryfJUoWeWQSb/7Q/LhV3piJnU9s5Manr4Ni3LgBg4qqIhMExDrAUBV4X5h
         M1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fa1DvOGIYI74cm5n8sNTmducLdeNCPsZIMiS5UeeiqM=;
        b=ToPvBhmbGpSo92JLNRWAnR/8c+PO5D84byoqh9wxjwzgxLkZp4ERaMnt+fpTqVaC9Y
         CXOWPTrgOpcgk0ybtAY7Psm/2XG8vAb69d8nqUmqFn9Rlrmx1VI56qrUUvY22mmrJxUm
         FjmOi3IxcaLFsxzzetNxbtweKo9ir3Y4Lo071ixB+5B6Lf1gM2FIASVqynacaXlLEZI8
         Uqz4aLcJM2QsrAQlXKqkeelm0yohMpBFzP7YCguyGCCaEOlahGN6J4AqJdkSTx3H+ZJV
         PZX0ggcR7P4A2Kp8wQbQmrjZ596qgNQKFIqQLIgZOnu6PTmKV2yCLWtAMeR4T2/n+OCf
         oBuQ==
X-Gm-Message-State: AOUpUlHuK1SWYK372GxL0xDVZ/Cc2jSFhZT2UFKbbDXDL7cXMOijnxvs
        QSW8K1S60piq12H1PnRdmdc=
X-Google-Smtp-Source: AAOMgpfPUWjV1qr6mM+ZaryEhWwqZnsxi3cCKREkPByrPG+z0XPylxjBvN3bxZgh571BbpZfbxo7oA==
X-Received: by 2002:a19:cb44:: with SMTP id b65-v6mr12410390lfg.12.1533577780453;
        Mon, 06 Aug 2018 10:49:40 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id z7-v6sm2249930lfg.89.2018.08.06.10.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 10:49:39 -0700 (PDT)
Subject: [PATCH v3] t4150: fix broken test for am --scissors
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
 <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com>
 <bea0e5d0-d944-ddd8-c3ab-a95355352b47@gmail.com>
Message-ID: <27bb8e3b-5b1d-dcc2-b002-df6941c62ee6@gmail.com>
Date:   Mon, 6 Aug 2018 19:49:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bea0e5d0-d944-ddd8-c3ab-a95355352b47@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests for "git am --[no-]scissors" [1] work in the following way:

 1. Create files with commit messages
 2. Use these files to create expected commits
 3. Generate eml file with patch from expected commits
 4. Create commits using git am with these eml files
 5. Compare these commits with expected

The test for "git am --scissors" is supposed to take an e-mail with a
scissors line and in-body "Subject:" header and demonstrate that the
subject line from the e-mail itself is overridden by the in-body header
and that only text below the scissors line is included in the commit
message of the commit created by the invocation of "git am --scissors".
However, the setup of the test incorrectly uses a commit without the
scissors line and without the in-body header in the commit message,
producing eml file not suitable for testing of "git am --scissors".

This can be checked by intentionally breaking is_scissors_line function
in mailinfo.c, for example, by changing string ">8", which is used by
the test. With such change the test should fail, but does not.

Fix broken test by generating eml file with scissors line and in-body
header "Subject:". Since the two tests for --scissors and --no-scissors
options are there to test cutting or keeping the commit message, update
both tests to change the test file in the same way, which allows us to
generate only one eml file to be passed to git am. To clarify the
intention of the test, give files and tags more explicit names.

[1]: introduced in bf72ac17d (t4150: tests for am --[no-]scissors,
     2015-07-19)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Applies on top of 980a3d3dd (Merge branch 'pt/am-tests', 2015-08-03).
This patch is also available at

  https://github.com/rybak/git fix-am-scissors-test-v3

Only changes since v2 are more clear tag names.

 t/t4150-am.sh | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index e9b6f8158..a821dfda5 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -67,13 +67,15 @@ test_expect_success 'setup: messages' '
 
 	EOF
 
-	cat >scissors-msg <<-\EOF &&
-	Test git-am with scissors line
+	cat >msg-without-scissors-line <<-\EOF &&
+	Test that git-am --scissors cuts at the scissors line
 
 	This line should be included in the commit message.
 	EOF
 
-	cat - scissors-msg >no-scissors-msg <<-\EOF &&
+	printf "Subject: " >subject-prefix &&
+
+	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF &&
 	This line should not be included in the commit message with --scissors enabled.
 
 	 - - >8 - - remove everything above this line - - >8 - -
@@ -150,18 +152,17 @@ test_expect_success setup '
 	} >patch1-hg.eml &&
 
 
-	echo scissors-file >scissors-file &&
-	git add scissors-file &&
-	git commit -F scissors-msg &&
-	git tag scissors &&
-	git format-patch --stdout scissors^ >scissors-patch.eml &&
+	echo file >file &&
+	git add file &&
+	git commit -F msg-without-scissors-line &&
+	git tag expected-for-scissors &&
 	git reset --hard HEAD^ &&
 
-	echo no-scissors-file >no-scissors-file &&
-	git add no-scissors-file &&
-	git commit -F no-scissors-msg &&
-	git tag no-scissors &&
-	git format-patch --stdout no-scissors^ >no-scissors-patch.eml &&
+	echo file >file &&
+	git add file &&
+	git commit -F msg-with-scissors-line &&
+	git tag expected-for-no-scissors &&
+	git format-patch --stdout expected-for-no-scissors^ >patch-with-scissors-line.eml &&
 	git reset --hard HEAD^ &&
 
 	sed -n -e "3,\$p" msg >file &&
@@ -418,10 +419,10 @@ test_expect_success 'am --scissors cuts the message at the scissors line' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout second &&
-	git am --scissors scissors-patch.eml &&
+	git am --scissors patch-with-scissors-line.eml &&
 	test_path_is_missing .git/rebase-apply &&
-	git diff --exit-code scissors &&
-	test_cmp_rev scissors HEAD
+	git diff --exit-code expected-for-scissors &&
+	test_cmp_rev expected-for-scissors HEAD
 '
 
 test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
@@ -429,10 +430,10 @@ test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
 	git reset --hard &&
 	git checkout second &&
 	test_config mailinfo.scissors true &&
-	git am --no-scissors no-scissors-patch.eml &&
+	git am --no-scissors patch-with-scissors-line.eml &&
 	test_path_is_missing .git/rebase-apply &&
-	git diff --exit-code no-scissors &&
-	test_cmp_rev no-scissors HEAD
+	git diff --exit-code expected-for-no-scissors &&
+	test_cmp_rev expected-for-no-scissors HEAD
 '
 
 test_expect_success 'setup: new author and committer' '
-- 
2.18.0
