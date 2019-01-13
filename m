Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54CCC211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 13:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfAMN60 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 08:58:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41565 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfAMN6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 08:58:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so19944114wrs.8
        for <git@vger.kernel.org>; Sun, 13 Jan 2019 05:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gek1DIhEKb18CfFapWf/rJ77iRHw8xc19K7D3xMxyX4=;
        b=HeAV3CZh4E+UNwHqek2mK+nVAO4epBomaL/rnIsLRA6MUMOvDvsH28XU0LZB46DLZ8
         5xsda9AP2kadhhugWzito9rG+AePMpvZqSn9RIe1ZgJMp9e9tcWeT1+TQlFMUN4akNdH
         9gGMljGXE9rIfmfC9phqUagVxsUexTZUmcCm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gek1DIhEKb18CfFapWf/rJ77iRHw8xc19K7D3xMxyX4=;
        b=paRF26TOE6Tq5cBFYAfHdXer2iIVWSqARks88XEpWlG6diYTtJB17wjrwiql2rDZXP
         R1dCOmW58TBq2uhj4mfQOEO3KfuhUTkpQSLFFIzHQ1gDksstCmF1pfurLyzPWNKUajq5
         hUR49ZyVzSZSYFtHIe6esjZ1aN7BfHVQNGGxfqX/VgYo5AvajDVW+sfklS1OFdSREqdo
         VI7vARKNE2s6WhlvUul8VF5Yv4A/D+on8WcTmed5zpA/ns0PUrAG/14yzX0Cc2oVeR7S
         2NJ/m4FXXxhtwQIeI79lx64ibw79Ai/EMd484NOeyxXth02Mv75MEKJFAXi0MRpnGxfz
         GNcg==
X-Gm-Message-State: AJcUukcvZpKATNNLkdh68D1A0KYVV6oVU9V2bVAId/6BxVZNAIWN+7my
        KDj7zJzL4ImVXk47UO1KhIwY7Eu+9xI=
X-Google-Smtp-Source: ALg8bN7X0ta49G1TdKjgtH/nRrg5dM3VpwLbbayUygPYLwownFDmcduBYErh2L3HhHNzsG2eDQVlxQ==
X-Received: by 2002:adf:e707:: with SMTP id c7mr19563687wrm.196.1547387902932;
        Sun, 13 Jan 2019 05:58:22 -0800 (PST)
Received: from ethel.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id o5sm44186864wmg.25.2019.01.13.05.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 05:58:22 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org, viniciusalexandre@gmail.com,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>, amazo@checkvideo.com,
        aoakley@roku.com
Cc:     Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/2] git-p4: add failing test for shelved CL update involving move
Date:   Sun, 13 Jan 2019 13:58:14 +0000
Message-Id: <20190113135815.11286-2-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.100.g9ee79a14a8
In-Reply-To: <20190113135815.11286-1-luke@diamand.org>
References: <20190113135815.11286-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updating a shelved P4 changelist where one or more of the files have
been moved does not work. Add a test for this.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9807-git-p4-submit.sh | 53 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 2325599ee6..08dc8d2caf 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -500,6 +500,12 @@ test_expect_success 'submit --shelve' '
 	)
 '
 
+last_shelve() {
+	change=$(p4 -G changes -s shelved -m 1 //depot/... | \
+		marshal_dump change)
+	echo $change
+}
+
 make_shelved_cl() {
 	test_commit "$1" >/dev/null &&
 	git p4 submit --origin HEAD^ --shelve >/dev/null &&
@@ -533,12 +539,53 @@ test_expect_success 'submit --update-shelve' '
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

