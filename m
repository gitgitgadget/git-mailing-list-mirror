Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF7E71F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfARJhH (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:37:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44036 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJhG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:37:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so14152563wrt.11
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LsDK8LmcVBHf9NabS0oPyUSkiDSZnKhW9HInYec0TVQ=;
        b=BXGLZhi84dmGZy00H6IR1ioejkr0EtA+12+KZMTxsi/SomjOayA7ScpwLOiHd2/Fm6
         UY7I3OIUvAF8uoMCqo2AQQtqvl0T8zdYlt68qGARxQBOCfx4Yki5lBRDiQVu3NjSYNjR
         e05mz6MbipA+TfsMErBWV+utuLRSE4gcPXEOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LsDK8LmcVBHf9NabS0oPyUSkiDSZnKhW9HInYec0TVQ=;
        b=Zus8fVS8fqpJnysZgkC8uaP7ZsZH4nWNc25A+mBqypvBuM2VNrM3PJqpfGhSB8FA5V
         RfNW7Zv/34Bdij5s0PVLpOvdkv8hA7cIh7s5ghylO3YIdVihLGcX5YvyRIU+8v7Wa52H
         a5xrax3WT8aWUEweSvfYYXrQLUJ2GILUHDK8iwk3LS4q1ONDVHiI6yc5Ld4oTB+uYMIW
         fqn5N4lh3o8EWEBonsU8/XzahjzHhK3GYV8sHaTEP6peNFFY+ogh3LNriFR3mUinyMOa
         62ydVrJ6ZFJEHXBIhx/AmL7hJ20tWoKvbbAiuLJqd79+i+WleiRY/xs3G3BnHASq77CL
         OqJQ==
X-Gm-Message-State: AJcUukenUbMGDxyOHbNr6RB078orSacJLARYtDMmcCIPoloW9eKI2098
        n1grqXlYUuKZsntBD7oyGkc24bUbcto=
X-Google-Smtp-Source: ALg8bN4+igO6dP4QubGsUO2nQZJArhYRJcLEMlGQe7oRL5Rwa3H5GFZFkifZ/SrlYX4VpUE84Y195Q==
X-Received: by 2002:adf:82f1:: with SMTP id 104mr16439202wrc.131.1547804224883;
        Fri, 18 Jan 2019 01:37:04 -0800 (PST)
Received: from ethel.local.diamand.org (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id x10sm103962059wrn.29.2019.01.18.01.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 01:37:04 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrew Oakley <aoakley@roku.com>,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 1/2] git-p4: add failing test for shelved CL update involving move/copy
Date:   Fri, 18 Jan 2019 09:36:55 +0000
Message-Id: <20190118093656.16521-2-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.100.g9ee79a14a8
In-Reply-To: <20190118093656.16521-1-luke@diamand.org>
References: <20190118093656.16521-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updating a shelved P4 changelist where one or more files have
been moved or copied does not work. Add a test for this.

The problem is that P4 requires a complete list of the files being
changed, and move/copy only includes the _source_ in the case of
updating a shelved changelist. This results in errors from Perforce
such as:

  //depot/src - needs tofile //depot/dst
  Submit aborted -- fix problems then use 'p4 submit -c 1234'

Signed-off-by: Luke Diamand <luke@diamand.org>
Acked-by: Andrey Mazo <amazo@checkvideo.com>
---
 t/t9807-git-p4-submit.sh | 57 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 2325599ee6..2ad3d801cc 100755
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
@@ -533,12 +537,59 @@ test_expect_success 'submit --update-shelve' '
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
+test_expect_failure 'update a shelve involving moved and copied files' '
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
+		git config git-p4.detectCopies true &&
+		git config git-p4.detectRenames true &&
+		git config git-p4.skipSubmitEdit true &&
+		mkdir moved &&
+		cp file_to_move copy_of_file &&
+		git add copy_of_file &&
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
+		test_path_is_file copy_of_file &&
+		test_path_is_file moved/file_to_move &&
+		test_path_is_missing file_to_move &&
+		test_path_is_file new_file &&
+		echo "unshelved and submitted change $change" &&
+		p4 changes moved/file_to_move | grep "Testing update-shelve" &&
+		p4 changes copy_of_file | grep "Testing update-shelve"
 	)
 '
 
-- 
2.20.1.100.g9ee79a14a8

