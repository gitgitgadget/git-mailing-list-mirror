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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7226BC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB0F23123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405516AbhALVhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436854AbhALUTP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:15 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10CC0617A4
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d26so3806575wrb.12
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lkQJYZosjrDDIJHFBFVqj3GEMy/9c+BLkaTLLR5ZcI=;
        b=iT0tAmjY4+wR0SmWENlMeIwqDO5pBq6DdMz1igk2DZMgdulyeBNOusrJTs7TmuEeC5
         gT4hrvkIJ71Mf9UGyVGC1acqLkzNvQevuSdNE+l/bBJIXfHgptwgr69nNtaAQZPcp6GR
         wjhuCmT3l/StfdL5YvRXZpQEXTifCl4+VTTczXCDRmbhtOoDDRq/33C/DZgRqGAqdxrM
         byU7XblAvEBe1ANTj+gsXNdyVdPdQS1tMhkytcQ+75jI3KAXZymHc5v6tx2bMUOy7wax
         eADH6acZdUocqexYLQ733K8RNH6SkPmYhhMFnjGjnar8rEoKmuCslOGMRZY0LcbhsI3H
         dQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lkQJYZosjrDDIJHFBFVqj3GEMy/9c+BLkaTLLR5ZcI=;
        b=G9DRHyDtnfV591MSxUMgVxNZzCGjwZKERJyv9pGyJWgnvvT1iaxMGlK7Fh/Ri4w1mn
         M91noJJlGvgRDFkxYR01B5GwcPr7lh3nhOFHDFfi14biitBTTS9aVI2/4yLKa76f343b
         J7KJMmxpicTCNMY+oW6VDrave59UScP3PD/JOhkFOQKdpfexoP0srahGRmAl8gn04nzu
         VDhCgy/uKoHb6rx9fYzzae9glANjIYgUzc5Hh7iCg5r2MSDHCancG2Fnp5Q1ec9mp23i
         WvYvIDoP5jmfBi5fVXT0tyn3pKYtM86Xhc1MP8BYF8mCsOstsLFErYAr3wXS+6CehWjq
         zRfQ==
X-Gm-Message-State: AOAM533UrdbbyFQQHrQC4h2YIT+jVpFFTyzrzb/9YR5Wx4haXC2Cskzl
        HVpvgHdJqa9ybaJCyPtnTTTwICxyGI1S7Q==
X-Google-Smtp-Source: ABdhPJzpC/HDDnIq9Suy6f4bHypKVaDWAF+hCVs7szSaNrNbVXaM8K6POCTXp8ddWPVqZqi8YMVWFg==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr574983wru.118.1610482702645;
        Tue, 12 Jan 2021 12:18:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/22] mailmap tests: modernize syntax & test idioms
Date:   Tue, 12 Jan 2021 21:17:50 +0100
Message-Id: <20210112201806.13284-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the mailmap tests to:

 * Setup "actual" test files in the body of "test_expect_success"

 * Don't have X of "test_expect_success X Y" be an unquoted string.

 * Not to carry over test config between tests, and instead use
   "test_config".

 * Replace various "echo" a line-at-a-time patterns with here-docs.

 * Change a case of "log.mailmap=False" to use the lower-case
   "false". Both work, but this ends up in git-config's boolean
   parsing and these atypical values are tested for elsewhere. Let's
   use the lower-case to not draw the reader's attention to this
   abnormality.

 * Remove commentary asserting that things work a given way in favor
   of simply testing for it, i.e. in the case of a .mailmap file
   outside of the repository.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 473 ++++++++++++++++++++++++++-------------------
 1 file changed, 274 insertions(+), 199 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 034a78aba1..61d1b62317 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -12,7 +12,7 @@ fuzz_blame () {
 	" "$@"
 }
 
-test_expect_success setup '
+test_expect_success 'setup commits and contacts file' '
 	cat >contacts <<-EOF &&
 	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	nick1 <bugs@company.xx>
@@ -66,128 +66,164 @@ test_expect_success 'check-mailmap bogus contact' '
 	test_must_fail git check-mailmap bogus
 '
 
-cat >expect << EOF
-$GIT_AUTHOR_NAME (1):
-      initial
-
-nick1 (1):
-      second
+test_expect_success 'No mailmap' '
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME (1):
+	      initial
 
-EOF
+	nick1 (1):
+	      second
 
-test_expect_success 'No mailmap' '
+	EOF
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<\EOF
-Repo Guy (1):
-      initial
+test_expect_success 'setup default .mailmap' '
+	cat >default.map <<-EOF
+	Repo Guy <$GIT_AUTHOR_EMAIL>
+	EOF
+'
+
+test_expect_success 'test default .mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
 
-nick1 (1):
-      second
+	cat >expect <<-\EOF &&
+	Repo Guy (1):
+	      initial
 
-EOF
+	nick1 (1):
+	      second
 
-test_expect_success 'default .mailmap' '
-	echo "Repo Guy <$GIT_AUTHOR_EMAIL>" > .mailmap &&
+	EOF
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
-# Using a mailmap file in a subdirectory of the repo here, but
-# could just as well have been a file outside of the repository
-cat >expect <<\EOF
-Internal Guy (1):
-      second
+test_expect_success 'mailmap.file set' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
 
-Repo Guy (1):
-      initial
+	test_config mailmap.file internal.map &&
+	cat >internal.map <<-\EOF &&
+	Internal Guy <bugs@company.xx>
+	EOF
 
-EOF
-test_expect_success 'mailmap.file set' '
-	mkdir -p internal_mailmap &&
-	echo "Internal Guy <bugs@company.xx>" > internal_mailmap/.mailmap &&
-	git config mailmap.file internal_mailmap/.mailmap &&
+	cat >expect <<-\EOF &&
+	Internal Guy (1):
+	      second
+
+	Repo Guy (1):
+	      initial
+
+	EOF
 	git shortlog HEAD >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	# The internal_mailmap/.mailmap file is an a subdirectory, but
+	# as shown here it can also be outside the repository
+	test_when_finished "rm -rf sub-repo" &&
+	git clone . sub-repo &&
+	(
+		cd sub-repo &&
+		cp ../.mailmap . &&
+		git config mailmap.file ../internal.map &&
+		git shortlog HEAD >actual &&
+		test_cmp ../expect actual
+	)
 '
 
-cat >expect <<\EOF
-External Guy (1):
-      initial
+test_expect_success 'mailmap.file override' '
+	test_config mailmap.file internal.map &&
+	cat >internal.map <<-EOF &&
+	Internal Guy <bugs@company.xx>
+	External Guy <$GIT_AUTHOR_EMAIL>
+	EOF
 
-Internal Guy (1):
-      second
+	cat >expect <<-\EOF &&
+	External Guy (1):
+	      initial
 
-EOF
-test_expect_success 'mailmap.file override' '
-	echo "External Guy <$GIT_AUTHOR_EMAIL>" >> internal_mailmap/.mailmap &&
-	git config mailmap.file internal_mailmap/.mailmap &&
+	Internal Guy (1):
+	      second
+
+	EOF
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<\EOF
-Repo Guy (1):
-      initial
+test_expect_success 'mailmap.file non-existent' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
 
-nick1 (1):
-      second
+	cat >expect <<-\EOF &&
+	Repo Guy (1):
+	      initial
 
-EOF
+	nick1 (1):
+	      second
 
-test_expect_success 'mailmap.file non-existent' '
-	rm internal_mailmap/.mailmap &&
-	rmdir internal_mailmap &&
+	EOF
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<\EOF
-Internal Guy (1):
-      second
+test_expect_success 'name entry after email entry' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
 
-Repo Guy (1):
-      initial
+	test_config mailmap.file internal.map &&
+	cat >internal.map <<-\EOF &&
+	<bugs@company.xy> <bugs@company.xx>
+	Internal Guy <bugs@company.xx>
+	EOF
 
-EOF
+	cat >expect <<-\EOF &&
+	Internal Guy (1):
+	      second
+
+	Repo Guy (1):
+	      initial
+
+	EOF
 
-test_expect_success 'name entry after email entry' '
-	mkdir -p internal_mailmap &&
-	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
-	echo "Internal Guy <bugs@company.xx>" >>internal_mailmap/.mailmap &&
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<\EOF
-Internal Guy (1):
-      second
+test_expect_success 'name entry after email entry, case-insensitive' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
 
-Repo Guy (1):
-      initial
+	test_config mailmap.file internal.map &&
+	cat >internal.map <<-\EOF &&
+	<bugs@company.xy> <bugs@company.xx>
+	Internal Guy <BUGS@Company.xx>
+	EOF
 
-EOF
+	cat >expect <<-\EOF &&
+	Internal Guy (1):
+	      second
+
+	Repo Guy (1):
+	      initial
+
+	EOF
 
-test_expect_success 'name entry after email entry, case-insensitive' '
-	mkdir -p internal_mailmap &&
-	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
-	echo "Internal Guy <BUGS@Company.xx>" >>internal_mailmap/.mailmap &&
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
-cat >expect << EOF
-$GIT_AUTHOR_NAME (1):
-      initial
+test_expect_success 'No mailmap files, but configured' '
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME (1):
+	      initial
 
-nick1 (1):
-      second
+	nick1 (1):
+	      second
 
-EOF
-test_expect_success 'No mailmap files, but configured' '
-	rm -f .mailmap internal_mailmap/.mailmap &&
+	EOF
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
@@ -205,11 +241,16 @@ test_expect_success 'setup mailmap blob tests' '
 	printf "Tricky Guy <$GIT_AUTHOR_EMAIL>" >no-newline &&
 	git add just-bugs both no-newline &&
 	git commit -m "my mailmaps" &&
-	echo "Repo Guy <$GIT_AUTHOR_EMAIL>" >.mailmap &&
-	echo "Internal Guy <$GIT_AUTHOR_EMAIL>" >internal.map
+
+	cat >internal.map <<-EOF
+	Internal Guy <$GIT_AUTHOR_EMAIL>
+	EOF
 '
 
 test_expect_success 'mailmap.blob set' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
+
 	cat >expect <<-\EOF &&
 	Blob Guy (1):
 	      second
@@ -223,6 +264,9 @@ test_expect_success 'mailmap.blob set' '
 '
 
 test_expect_success 'mailmap.blob overrides .mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
+
 	cat >expect <<-\EOF &&
 	Blob Guy (2):
 	      initial
@@ -250,6 +294,9 @@ test_expect_success 'mailmap.file overrides mailmap.blob' '
 '
 
 test_expect_success 'mailmap.blob can be missing' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
+
 	cat >expect <<-\EOF &&
 	Repo Guy (1):
 	      initial
@@ -267,11 +314,15 @@ test_expect_success 'mailmap.blob defaults to off in non-bare repo' '
 	(
 		cd non-bare &&
 		test_commit one .mailmap "Fake Name <$GIT_AUTHOR_EMAIL>" &&
-		echo "     1	Fake Name" >expect &&
+		cat >expect <<-\EOF &&
+		     1	Fake Name
+		EOF
 		git shortlog -ns HEAD >actual &&
 		test_cmp expect actual &&
 		rm .mailmap &&
-		echo "     1	$GIT_AUTHOR_NAME" >expect &&
+		cat >expect <<-EOF &&
+		     1	$GIT_AUTHOR_NAME
+		EOF
 		git shortlog -ns HEAD >actual &&
 		test_cmp expect actual
 	)
@@ -281,7 +332,9 @@ test_expect_success 'mailmap.blob defaults to HEAD:.mailmap in bare repo' '
 	git clone --bare non-bare bare &&
 	(
 		cd bare &&
-		echo "     1	Fake Name" >expect &&
+		cat >expect <<-\EOF &&
+		     1	Fake Name
+		EOF
 		git shortlog -ns HEAD >actual &&
 		test_cmp expect actual
 	)
@@ -300,50 +353,46 @@ test_expect_success 'mailmap.blob can handle blobs without trailing newline' '
 	test_cmp expect actual
 '
 
-test_expect_success 'cleanup after mailmap.blob tests' '
-	rm -f .mailmap
-'
-
 test_expect_success 'single-character name' '
-	echo "     1	A <$GIT_AUTHOR_EMAIL>" >expect &&
-	echo "     1	nick1 <bugs@company.xx>" >>expect &&
-	echo "A <$GIT_AUTHOR_EMAIL>" >.mailmap &&
 	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	A <$GIT_AUTHOR_EMAIL>
+	EOF
+
+	cat >expect <<-EOF &&
+	     1	A <$GIT_AUTHOR_EMAIL>
+	     1	nick1 <bugs@company.xx>
+	EOF
 	git shortlog -es HEAD >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'preserve canonical email case' '
-	echo "     1	$GIT_AUTHOR_NAME <AUTHOR@example.com>" >expect &&
-	echo "     1	nick1 <bugs@company.xx>" >>expect &&
-	echo "<AUTHOR@example.com> <$GIT_AUTHOR_EMAIL>" >.mailmap &&
 	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	<AUTHOR@example.com> <$GIT_AUTHOR_EMAIL>
+	EOF
+
+	cat >expect <<-EOF &&
+	     1	$GIT_AUTHOR_NAME <AUTHOR@example.com>
+	     1	nick1 <bugs@company.xx>
+	EOF
 	git shortlog -es HEAD >actual &&
 	test_cmp expect actual
 '
 
-# Extended mailmap configurations should give us the following output for shortlog
-cat >expect << EOF
-$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> (1):
-      initial
-
-CTO <cto@company.xx> (1):
-      seventh
-
-Other Author <other@author.xx> (2):
-      third
-      fourth
-
-Santa Claus <santa.claus@northpole.xx> (2):
-      fifth
-      sixth
-
-Some Dude <some@dude.xx> (1):
-      second
-
-EOF
-
 test_expect_success 'Shortlog output (complex mapping)' '
+	test_config mailmap.file complex.map &&
+	cat >complex.map <<-EOF &&
+	Committed <$GIT_COMMITTER_EMAIL>
+	<cto@company.xx> <cto@coompany.xx>
+	Some Dude <some@dude.xx>         nick1 <bugs@company.xx>
+	Other Author <other@author.xx>   nick2 <bugs@company.xx>
+	Other Author <other@author.xx>         <nick2@company.xx>
+	Santa Claus <santa.claus@northpole.xx> <me@company.xx>
+	Santa Claus <santa.claus@northpole.xx> <me@company.xx>
+	EOF
+
 	echo three >>one &&
 	git add one &&
 	test_tick &&
@@ -369,103 +418,119 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	test_tick &&
 	git commit --author "CTO <cto@coompany.xx>" -m seventh &&
 
-	mkdir -p internal_mailmap &&
-	echo "Committed <$GIT_COMMITTER_EMAIL>" > internal_mailmap/.mailmap &&
-	echo "<cto@company.xx>                       <cto@coompany.xx>" >> internal_mailmap/.mailmap &&
-	echo "Some Dude <some@dude.xx>         nick1 <bugs@company.xx>" >> internal_mailmap/.mailmap &&
-	echo "Other Author <other@author.xx>   nick2 <bugs@company.xx>" >> internal_mailmap/.mailmap &&
-	echo "Other Author <other@author.xx>         <nick2@company.xx>" >> internal_mailmap/.mailmap &&
-	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
-	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> (1):
+	      initial
+
+	CTO <cto@company.xx> (1):
+	      seventh
+
+	Other Author <other@author.xx> (2):
+	      third
+	      fourth
+
+	Santa Claus <santa.claus@northpole.xx> (2):
+	      fifth
+	      sixth
+
+	Some Dude <some@dude.xx> (1):
+	      second
+
+	EOF
 
 	git shortlog -e HEAD >actual &&
 	test_cmp expect actual
 
 '
 
-# git log with --pretty format which uses the name and email mailmap placemarkers
-cat >expect << EOF
-Author CTO <cto@coompany.xx> maps to CTO <cto@company.xx>
-Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
+test_expect_success 'Log output (complex mapping)' '
+	test_config mailmap.file complex.map &&
 
-Author claus <me@company.xx> maps to Santa Claus <santa.claus@northpole.xx>
-Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
+	cat >expect <<-EOF &&
+	Author CTO <cto@coompany.xx> maps to CTO <cto@company.xx>
+	Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
 
-Author santa <me@company.xx> maps to Santa Claus <santa.claus@northpole.xx>
-Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
+	Author claus <me@company.xx> maps to Santa Claus <santa.claus@northpole.xx>
+	Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
 
-Author nick2 <nick2@company.xx> maps to Other Author <other@author.xx>
-Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
+	Author santa <me@company.xx> maps to Santa Claus <santa.claus@northpole.xx>
+	Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
 
-Author nick2 <bugs@company.xx> maps to Other Author <other@author.xx>
-Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
+	Author nick2 <nick2@company.xx> maps to Other Author <other@author.xx>
+	Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
 
-Author nick1 <bugs@company.xx> maps to Some Dude <some@dude.xx>
-Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
+	Author nick2 <bugs@company.xx> maps to Other Author <other@author.xx>
+	Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
 
-Author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> maps to $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
-Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
-EOF
+	Author nick1 <bugs@company.xx> maps to Some Dude <some@dude.xx>
+	Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
+
+	Author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> maps to $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$GIT_COMMITTER_EMAIL>
+	EOF
 
-test_expect_success 'Log output (complex mapping)' '
 	git log --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
 	test_cmp expect actual
 '
 
-cat >expect << EOF
-Author email cto@coompany.xx has local-part cto
-Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
+test_expect_success 'Log output (local-part email address)' '
+	cat >expect <<-EOF &&
+	Author email cto@coompany.xx has local-part cto
+	Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
 
-Author email me@company.xx has local-part me
-Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
+	Author email me@company.xx has local-part me
+	Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
 
-Author email me@company.xx has local-part me
-Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
+	Author email me@company.xx has local-part me
+	Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
 
-Author email nick2@company.xx has local-part nick2
-Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
+	Author email nick2@company.xx has local-part nick2
+	Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
 
-Author email bugs@company.xx has local-part bugs
-Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
+	Author email bugs@company.xx has local-part bugs
+	Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
 
-Author email bugs@company.xx has local-part bugs
-Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
+	Author email bugs@company.xx has local-part bugs
+	Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
 
-Author email author@example.com has local-part author
-Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
-EOF
+	Author email author@example.com has local-part author
+	Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALNAME
+	EOF
 
-test_expect_success 'Log output (local-part email address)' '
 	git log --pretty=format:"Author email %ae has local-part %al%nCommitter email %ce has local-part %cl%n" >actual &&
 	test_cmp expect actual
 '
 
-cat >expect << EOF
-Author: CTO <cto@company.xx>
-Author: Santa Claus <santa.claus@northpole.xx>
-Author: Santa Claus <santa.claus@northpole.xx>
-Author: Other Author <other@author.xx>
-Author: Other Author <other@author.xx>
-Author: Some Dude <some@dude.xx>
-Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
-EOF
-
 test_expect_success 'Log output with --use-mailmap' '
+	test_config mailmap.file complex.map &&
+
+	cat >expect <<-EOF &&
+	Author: CTO <cto@company.xx>
+	Author: Santa Claus <santa.claus@northpole.xx>
+	Author: Santa Claus <santa.claus@northpole.xx>
+	Author: Other Author <other@author.xx>
+	Author: Other Author <other@author.xx>
+	Author: Some Dude <some@dude.xx>
+	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	EOF
+
 	git log --use-mailmap | grep Author >actual &&
 	test_cmp expect actual
 '
 
-cat >expect << EOF
-Author: CTO <cto@company.xx>
-Author: Santa Claus <santa.claus@northpole.xx>
-Author: Santa Claus <santa.claus@northpole.xx>
-Author: Other Author <other@author.xx>
-Author: Other Author <other@author.xx>
-Author: Some Dude <some@dude.xx>
-Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
-EOF
-
 test_expect_success 'Log output with log.mailmap' '
+	test_config mailmap.file complex.map &&
+
+	cat >expect <<-EOF &&
+	Author: CTO <cto@company.xx>
+	Author: Santa Claus <santa.claus@northpole.xx>
+	Author: Santa Claus <santa.claus@northpole.xx>
+	Author: Other Author <other@author.xx>
+	Author: Other Author <other@author.xx>
+	Author: Some Dude <some@dude.xx>
+	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	EOF
+
 	git -c log.mailmap=True log | grep Author >actual &&
 	test_cmp expect actual
 '
@@ -480,7 +545,7 @@ test_expect_success 'log.mailmap=false disables mailmap' '
 	Author: nick1 <bugs@company.xx>
 	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	EOF
-	git -c log.mailmap=False log | grep Author >actual &&
+	git -c log.mailmap=false log | grep Author >actual &&
 	test_cmp expect actual
 '
 
@@ -498,56 +563,66 @@ test_expect_success '--no-use-mailmap disables mailmap' '
 	test_cmp expect actual
 '
 
-cat >expect <<\EOF
-Author: Santa Claus <santa.claus@northpole.xx>
-Author: Santa Claus <santa.claus@northpole.xx>
-EOF
-
 test_expect_success 'Grep author with --use-mailmap' '
+	test_config mailmap.file complex.map &&
+
+	cat >expect <<-\EOF &&
+	Author: Santa Claus <santa.claus@northpole.xx>
+	Author: Santa Claus <santa.claus@northpole.xx>
+	EOF
 	git log --use-mailmap --author Santa | grep Author >actual &&
 	test_cmp expect actual
 '
-cat >expect <<\EOF
-Author: Santa Claus <santa.claus@northpole.xx>
-Author: Santa Claus <santa.claus@northpole.xx>
-EOF
 
 test_expect_success 'Grep author with log.mailmap' '
+	test_config mailmap.file complex.map &&
+
+	cat >expect <<-\EOF &&
+	Author: Santa Claus <santa.claus@northpole.xx>
+	Author: Santa Claus <santa.claus@northpole.xx>
+	EOF
+
 	git -c log.mailmap=True log --author Santa | grep Author >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'log.mailmap is true by default these days' '
+	test_config mailmap.file complex.map &&
 	git log --author Santa | grep Author >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'Only grep replaced author with --use-mailmap' '
+	test_config mailmap.file complex.map &&
 	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
 	test_must_be_empty actual
 '
 
-# git blame
-cat >expect <<EOF
-^OBJI ($GIT_AUTHOR_NAME     DATE 1) one
-OBJID (Some Dude    DATE 2) two
-OBJID (Other Author DATE 3) three
-OBJID (Other Author DATE 4) four
-OBJID (Santa Claus  DATE 5) five
-OBJID (Santa Claus  DATE 6) six
-OBJID (CTO          DATE 7) seven
-EOF
 test_expect_success 'Blame output (complex mapping)' '
+	test_config mailmap.file complex.map &&
+
+	cat >expect <<-EOF &&
+	^OBJI ($GIT_AUTHOR_NAME     DATE 1) one
+	OBJID (Some Dude    DATE 2) two
+	OBJID (Other Author DATE 3) three
+	OBJID (Other Author DATE 4) four
+	OBJID (Santa Claus  DATE 5) five
+	OBJID (Santa Claus  DATE 6) six
+	OBJID (CTO          DATE 7) seven
+	EOF
+
 	git blame one >actual &&
 	fuzz_blame actual >actual.fuzz &&
 	test_cmp expect actual.fuzz
 '
 
-cat >expect <<\EOF
-Some Dude <some@dude.xx>
-EOF
-
 test_expect_success 'commit --author honors mailmap' '
+	test_config mailmap.file complex.map &&
+
+	cat >expect <<-\EOF &&
+	Some Dude <some@dude.xx>
+	EOF
+
 	test_must_fail git commit --author "nick" --allow-empty -meight &&
 	git commit --author "Some Dude" --allow-empty -meight &&
 	git show --pretty=format:"%an <%ae>%n" >actual &&
-- 
2.29.2.222.g5d2a92d10f8

