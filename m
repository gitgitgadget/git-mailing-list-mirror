Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69ABC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24CC613AE
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbhDMMaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345920AbhDMM3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:29:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6154CC06138D
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:28:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id 12so16284289wrz.7
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNLlSOye1Xd6wnS52p75QkLdb+OWbSJI1yqIxGbTDrQ=;
        b=nTnrBtoZqc52pbyXO71DmO2my3Kk17wCPuQ09/LjKZYo8+O+Hl+Z+J4ghdY8iQLn7G
         pnbs0xrR5DaA/Ch078gakljqrTYlNDAMyJfe5I1h/8vThDMhmvtdS0abC7ZoQ0GbTbMZ
         Z8ssADzJwQ0ekcuxakpLRui4cxJcLlEKXdxfkY7zd5V9AkWkaJtCmtzEAHeLRZ2wB1/d
         ATdebay0ClCaJvUPySO8yNO91/FhGFPSPc0JFICT2lYtUPeC31VL2MAcW74MM9k5L8fh
         1osMkA94y2cmA4H+Rs1lzM/DVkDU1au86zrfUXzSojrqa2NHYdnaz3q8d76QZtIgnSRs
         6wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNLlSOye1Xd6wnS52p75QkLdb+OWbSJI1yqIxGbTDrQ=;
        b=LO/IhXXDA0MuUV5RFAaEFBSA/X6DaqZo1Twpx9tNFWBxR6OTVji7P1CMM8GZS6yJYV
         u/L58J/F2N5YTrxhTFr6IrkTxhYointdkeBbU1R/z5RunH6YGtUumUDXiKMDuaNmdhXR
         jBiZRaqBDgXjpJwGUgrLRvEYZj8o7rhY4kjwcO1vll6t24ki0VSV4oWnxShkASDP78v7
         ccUDLsFhUJHvaQTch4/Cxr8rWFlf2/vf9MRm3awtCHunnoPCWLamtx1bmwHjGVPXCMb7
         ZgxrOu/NuUyKZv8k3ZXRtT0p93D+qqEf/0Z3HtmnyR9X34lIBZNRT9RQkMxWJ28cRMqh
         9m3w==
X-Gm-Message-State: AOAM533leFQSgC+NCHfXrK66zNYuE9GZmXMNWAooDMcqsF09106BuhVU
        CKNYgr6tH5FS+tL0Dx0cIlPQUUrX/+qN5Q==
X-Google-Smtp-Source: ABdhPJxcWceXlN5ZQS/rfYrIlitYW3gdkiPZ1qOQJIbC8PKatF12n6Evn5vqDSuW9uASKt+8vQSojw==
X-Received: by 2002:adf:f948:: with SMTP id q8mr37028138wrr.296.1618316924926;
        Tue, 13 Apr 2021 05:28:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 7sm19565445wry.60.2021.04.13.05.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:28:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
Date:   Tue, 13 Apr 2021 14:28:34 +0200
Message-Id: <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.646.g06d606cb9c7
In-Reply-To: <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com> <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a new test is added to this "while read magic cmd" test facility
added in 3c2f75b590c (t4013: add tests for diff/log family output
options., 2006-06-26) but no test file is added it'll fail the first
time, but then succeed on subsequent runs as a new file has been added
in t4013.

Let's accomplish the same aim in way that doesn't cause subsequent
test runs to succeed. If we can't find the file we'll BUG out, and
suggest to the developer that they copy our "expect.new" file over,
unlike the previous "expect" file this won't be picked up on
subsequent runs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4013-diff-various.sh | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 67f6411aff9..228ff100c61 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -200,10 +200,12 @@ do
 	esac
 	test=$(echo "$label" | sed -e 's|[/ ][/ ]*|_|g')
 	pfx=$(printf "%04d" $test_count)
-	expect="$TEST_DIRECTORY/t4013/diff.$test"
+	expect_relative="t4013/diff.$test"
+	expect="$TEST_DIRECTORY/$expect_relative"
 	actual="$pfx-diff.$test"
 
 	test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
+		test_when_finished "rm $actual" &&
 		{
 			echo "$ git $cmd"
 			case "$magic" in
@@ -216,16 +218,19 @@ do
 			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
 			echo "\$"
 		} >"$actual" &&
-		if test -f "$expect"
+
+		if ! test -f "$expect"
 		then
-			process_diffs "$actual" >actual &&
-			process_diffs "$expect" >expect &&
-			test_cmp expect actual
-		else
-			# this is to help developing new tests.
-			cp "$actual" "$expect"
-			false
-		fi
+			expect_new="$expect.new" &&
+			cp "$actual" "$expect_new" &&
+			BUG "Have no \"$expect_relative\", new test? The output is in \"$expect_new\", maybe use that?"
+		fi &&
+
+		test_when_finished "rm actual" &&
+		process_diffs "$actual" >actual &&
+		test_when_finished "rm expect" &&
+		process_diffs "$expect" >expect &&
+		test_cmp expect actual
 	'
 done <<\EOF
 diff-tree initial
-- 
2.31.1.646.g06d606cb9c7

