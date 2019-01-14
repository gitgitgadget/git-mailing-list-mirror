Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20C101F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 23:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfANXze (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 18:55:34 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42128 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfANXze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 18:55:34 -0500
Received: by mail-wr1-f47.google.com with SMTP id q18so923424wrx.9
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 15:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYt8PM5DOhFrKRNoJlEn9SLac5M/haqO57r/2k4EPlg=;
        b=XVp7Dpqr8kUANeobJcAT7unwkHgrnD+iFXzkz0uakhYZ7To+ZXQ5Ll+iRMlrCqyYrq
         bAeiQasgL7io8jddg9hthbGCyNcT2sqXTlwbIiPTzZQKnLuVDlZg6i+I2+6RPlastxos
         MR9tbWmVV9cl/huoK8bPmhlX/HypkDomV/Sn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYt8PM5DOhFrKRNoJlEn9SLac5M/haqO57r/2k4EPlg=;
        b=laTYSHW372odg04Im2RkxITCtpU21yvNvl+wnGDQbenbT7JwFBEcFNOm72A0faBEGl
         AOPxlU1myzjiQYum7jtBJU+xJU0MO+1TiADtd9AYQnh0SE65WOCMCXvs5RPoVafX56Tj
         FHNjKxjhq/ZHNAjRM+X78YZqHVlpSpNE5mbzU8+tENEEHZvM1ZVncZogzi8WF5azUczE
         VDsGBceB/ZHKgGuWUNiE33YF75jNJIYTIyuKCjYWUgOnQsUry6IyBAk7FhPv2SMZqON2
         Vfh89EW1g+GjkblnEq41EXFkxbi4v/o4KoiPPWe+Q4zxCgB3Qco0XfpeUqxTij0Wzg4H
         nChg==
X-Gm-Message-State: AJcUukcr6sikmp52vGQhAVPUyhXz8D/bjE9NJHqtfW8GkHi2DJr/18V/
        yxrnKTFk+CNQ79JD3sdWogKhDG6Mv5U=
X-Google-Smtp-Source: ALg8bN7nwLSIzxT0Utv3llb4xiOXQRpJinBD57WSMMW/TwJI8+1CROcy2F3tFULkEY4ge3MJ6NorYg==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr640866wrj.91.1547510132765;
        Mon, 14 Jan 2019 15:55:32 -0800 (PST)
Received: from ethel.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id x10sm89224806wrn.29.2019.01.14.15.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 15:55:32 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrew Oakley <aoakley@roku.com>,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/2] git-p4: add failing test for shelved CL update involving move
Date:   Mon, 14 Jan 2019 23:55:23 +0000
Message-Id: <20190114235524.3947-2-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.100.g9ee79a14a8
In-Reply-To: <20190114235524.3947-1-luke@diamand.org>
References: <20190114235524.3947-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updating a shelved P4 changelist where one or more files have
been moved does not work. Add a test for this.

The problem is that P4 requires a complete list of the files being
changed, and move/rename only includes the _source_ in the case of
updating a shelved changelist. This results in errors from Perforce
such as:

  //depot/src - needs tofile //depot/dst
  Submit aborted -- fix problems then use 'p4 submit -c 1234'

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9807-git-p4-submit.sh | 51 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 2325599ee6..c390af56ad 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -500,6 +500,10 @@ test_expect_success 'submit --shelve' '
 	)
 '
 
+last_shelve() {
+	p4 -G changes -s shelved -m 1 //depot/... | marshal_dump change
+}
+
 make_shelved_cl() {
 	test_commit "$1" >/dev/null &&
 	git p4 submit --origin HEAD^ --shelve >/dev/null &&
@@ -533,12 +537,53 @@ test_expect_success 'submit --update-shelve' '
 	) &&
 	(
 		cd "$cli" &&
-		change=$(p4 -G changes -s shelved -m 1 //depot/... | \
-			 marshal_dump change) &&
+		change=$(last_shelve) &&
 		p4 unshelve -c $change -s $change &&
 		grep -q updated-line shelf.t &&
 		p4 describe -S $change | grep added-file.t &&
-		test_path_is_missing shelved-change-1.t
+		test_path_is_missing shelved-change-1.t &&
+		p4 revert ...
+	)
+'
+
+test_expect_failure 'update a shelve involving a moved file' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$cli" &&
+		: >file_to_move &&
+		p4 add file_to_move &&
+		p4 submit -d "change1" &&
+		p4 edit file_to_move &&
+		echo change >>file_to_move &&
+		p4 submit -d "change2" &&
+		p4 opened
+	) &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		mkdir moved &&
+		git mv file_to_move moved/ &&
+		git commit -m "rename a file" &&
+		git p4 submit -M --shelve --origin HEAD^ &&
+		: >new_file &&
+		git add new_file &&
+		git commit --amend &&
+		git show --stat HEAD &&
+		change=$(last_shelve) &&
+		git p4 submit -M --update-shelve $change --commit HEAD
+	) &&
+	(
+		cd "$cli" &&
+		change=$(last_shelve) &&
+		echo change=$change &&
+		p4 unshelve -s $change &&
+		p4 submit -d "Testing update-shelve" &&
+		test_path_is_file moved/file_to_move &&
+		test_path_is_missing file_to_move &&
+		test_path_is_file new_file &&
+		echo "unshelved and submitted change $change" &&
+		p4 changes moved/file_to_move | grep "Testing update-shelve"
 	)
 '
 
-- 
2.20.1.100.g9ee79a14a8

