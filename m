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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CE0C07D5B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9997F23123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438077AbhALVhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436873AbhALUTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C8C0617A9
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r7so3844897wrc.5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=maAeeEQVtyl0NBRV/WsprOcQIO71et3ouvCpkbhWTK4=;
        b=fbGEbhjBuHqohPGiozyshKkAm91rZ6HVSgLYe55f0zDmoKpcU3v6GJhLKWkbR7AqJb
         I/sOzSkZXGpIn9J0BoRYyHDumXWqlvQlvcMly34KvPz7VDNEvJhM/mLzuv0fY2O5r1Cn
         5kdMHSCzQXnc8ZlRS+LH5MhxO1MzkrUooMi2Mwwnzxi1HyiKOEXVa7LtHY0dwdRIWWtT
         IuuKGhvmF+G6h7dFPuNEklS0wiXBRlMlJ6Jw6mQe8bzAET9T+UKB4gZq+PKS5oD6f5ui
         mBzEtOEwpmVS2z/kNVILjW9NtLA8YmV6fdh+CIpC3W5f6WlzxmU5F7Z27CeYsBQpmolL
         SyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=maAeeEQVtyl0NBRV/WsprOcQIO71et3ouvCpkbhWTK4=;
        b=ESppSWuDrX/1Dc7tz18gXcgafbreLXjJUjmbiUvjG5S38Bo/xj3UfrSFedryMPNbrS
         aH3qhwtLouU3D+G1JO55brfBjTadv7x/PMVR+J3W2MUM98y73MUBDYhVI0uBwIMmUQzX
         4J4MpfY/7ocvJC8OUT4zcUYAqk8zEmW0KZB1smxYUfzgsxN3v+HRPT6LC2bTajOEGVRr
         9j940wJUrKset7qAEttC1fDmQV+JIdjYfDFJwW3HwjTZGNgUKQFo0MwIY9312ZZvq90G
         hx63RvWSh66XD8TOwGvXzErytyfjFJWT9QiLNdLXiuwnJsbbupkWFT8grkRvklNwCaqN
         gzEQ==
X-Gm-Message-State: AOAM533YHIITZk+GzNRwMiL9rOaypMrsmDT3RAdtjy1Hnyz+fmGpbCjZ
        pXURGNpYXUjyVt0IoVwzCISmeByTEg0Vog==
X-Google-Smtp-Source: ABdhPJxFn/R3aP+iKMgOPnYpr0c77PzFq6r73FKlaRc1LnqeX49vc0liXvVLm9hKPn5FdtRbHOH9oQ==
X-Received: by 2002:adf:e348:: with SMTP id n8mr572242wrj.148.1610482710838;
        Tue, 12 Jan 2021 12:18:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/22] mailmap tests: get rid of overly complex blame fuzzing
Date:   Tue, 12 Jan 2021 21:17:54 +0100
Message-Id: <20210112201806.13284-11-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a test that used a custom fuzzing function since
bfdfa3d414 (t4203 (mailmap): stop hardcoding commit ids and dates,
2010-10-15) to just use the "blame --porcelain" output instead.

We could use the same pattern as 0ba9c9a0fb (t8008: rely on
rev-parse'd HEAD instead of sha1 value, 2017-07-26) does to do this,
but there wouldn't be any point. We're not trying to test "blame"
output here in general, just that "blame" pays attention to the
mailmap.

So it's sufficient to get the blamed line(s) and authors from the
output, which is much easier with the "--porcelain" option.

It would still be possible for there to be a bug in "blame" such that
it uses the mailmap for its "--porcelain" output, but not the regular
output. Let's test for that simply by checking if specifying the
mailmap changes the output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 50 +++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 78d56e0566..a42b454756 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -4,14 +4,6 @@ test_description='.mailmap configurations'
 
 . ./test-lib.sh
 
-fuzz_blame () {
-	sed "
-		s/$_x05[0-9a-f][0-9a-f][0-9a-f]/OBJID/g
-		s/$_x05[0-9a-f][0-9a-f]/OBJI/g
-		s/[-0-9]\{10\} [:0-9]\{8\} [-+][0-9]\{4\}/DATE/g
-	" "$@"
-}
-
 test_expect_success 'setup commits and contacts file' '
 	echo one >one &&
 	git add one &&
@@ -630,24 +622,42 @@ test_expect_success 'Only grep replaced author with --use-mailmap' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'Blame output (complex mapping)' '
+test_expect_success 'Blame --porcelain output (complex mapping)' '
 	test_config mailmap.file complex.map &&
 
 	cat >expect <<-EOF &&
-	^OBJI ($GIT_AUTHOR_NAME     DATE 1) one
-	OBJID (Some Dude    DATE 2) two
-	OBJID (Other Author DATE 3) three
-	OBJID (Other Author DATE 4) four
-	OBJID (Santa Claus  DATE 5) five
-	OBJID (Santa Claus  DATE 6) six
-	OBJID (CTO          DATE 7) seven
-	EOF
-
-	git blame one >actual &&
-	fuzz_blame actual >actual.fuzz &&
+	1 1 1
+	A U Thor
+	2 2 1
+	Some Dude
+	3 3 1
+	Other Author
+	4 4 1
+	Other Author
+	5 5 1
+	Santa Claus
+	6 6 1
+	Santa Claus
+	7 7 1
+	CTO
+	EOF
+
+	git blame --porcelain one >actual.blame &&
+	grep -E \
+		-e "[0-9]+ [0-9]+ [0-9]+$" \
+		-e "^author .*$" \
+		actual.blame >actual.grep &&
+	cut -d " " -f2-4 <actual.grep >actual.fuzz &&
 	test_cmp expect actual.fuzz
 '
 
+test_expect_success 'Blame output (complex mapping)' '
+	git -c mailmap.file=complex.map blame one >a &&
+	git blame one >b &&
+	test_file_not_empty a &&
+	! cmp a b
+'
+
 test_expect_success 'commit --author honors mailmap' '
 	test_config mailmap.file complex.map &&
 
-- 
2.29.2.222.g5d2a92d10f8

