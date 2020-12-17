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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22438C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF25023741
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgLQFqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 00:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgLQFqH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 00:46:07 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A232C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 21:45:27 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id j20so21698293otq.5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 21:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUSAYZjCXkoiyyFQlpoBCUWL0G7jA0+UUvvaeP8PLUc=;
        b=I/k6a/8tBSYnNe8E78gWiqBnLsuxgC4QyeG8/kNtTyBTmnl89ZX3w72gegzhg7tsjA
         CcO4zkX357qbJBx4J8QoeSQ1V1CAK7d4EVwynWFRl6iGLzjE24c106vDxC33tucQA2A/
         4rgzEbcIq0/cFXpxUaRZxqSraacAGEVdVbo3ENU/M9GXJ4voRTQqb+vexplAZU7F6a7e
         jeuIWeu0PsSXZcXujE6WuJqZDf2nVT2IhkFMBRuRNaxmQK9kSw52HcRTtYAuCPB5fb7H
         09KGoR7lRe9RxO9w7InfmlShVKssbWz+dVrY2OqDNqDy8QXL3J6ol2GfTWhtndfuUsEp
         ZRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUSAYZjCXkoiyyFQlpoBCUWL0G7jA0+UUvvaeP8PLUc=;
        b=UjoeIp3OG0NzBSLJgNF/533JPQdVZ3oyCfOto1is+ADkTn1/KfUBXRqJipHdTwRJ2A
         daCs318I/+MyMWfFR8IfQS1xa5S5ZAdQ90dfYj7b/QpMdZY2VQRkr3MOo0+KVMZ+wVJp
         MGhhFXGpGuNyanujBOQs5We9ju873w+IxSo30J7uaUxAtsVZZT4E3RYIq2itoeadmSX6
         qYKZWPEvjT765k0Fs39tevo37Z/EAgViqhnr/ePT9w6v35NOOt0pV2xCFe9fR3lgYpKs
         pkaixT17sOX/j0lWlEMOVRtsV3m0IIr8yFg9uenpHlhWtd+s9f+tqgKZiCAo9DCvVO2W
         05+w==
X-Gm-Message-State: AOAM532nQEEOEPv7KX8cjVMDO6l0eMyDH6gKG2Ak0tLT3hDCRJx1DN+0
        UH+jFMW13ciid+JVrSBVDT7XsKMAcYAOVQ==
X-Google-Smtp-Source: ABdhPJzHkAtw4v4ZbhwgBh3VJfQREP3HzIzO/t0ns8mfY2fGsIHAscU5xuNyXxzUpvPZyMS4VdTZzA==
X-Received: by 2002:a05:6830:1257:: with SMTP id s23mr24602645otp.69.1608183926422;
        Wed, 16 Dec 2020 21:45:26 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s204sm66042oib.42.2020.12.16.21.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 21:45:25 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3] mergetool: add automerge configuration
Date:   Wed, 16 Dec 2020 23:45:24 -0600
Message-Id: <20201217054524.856258-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It doesn't make sense to display easily-solvable conflicts in the
different views of all mergetools.

Only the chunks that warrant conflict markers should be displayed.

In order to unobtrusively do this, add a new configuration:
mergetool.autoMerge.

See Seth House's blog post [1] for the idea, and the rationale.

[1] https://www.eseth.org/2020/mergetools.html

Original-idea-by: Seth House <seth@eseth.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/mergetool.txt |  3 +++
 git-mergetool.sh                   | 10 ++++++++++
 t/t7610-mergetool.sh               | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 16a27443a3..43af7a96f9 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -61,3 +61,6 @@ mergetool.writeToTemp::
 
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
+
+mergetool.autoMerge::
+	Automatically resolve conflicts that don't require user intervention.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e3f6d543fb..6e86d3b492 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -274,6 +274,7 @@ merge_file () {
 		BASE=${BASE##*/}
 	fi
 
+	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
 	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
 	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
 	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
@@ -322,6 +323,15 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
+	if test "$(git config --bool mergetool.autoMerge)" = "true"
+	then
+		git merge-file --diff3 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
+		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
+		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
+		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
+		rm -- "$DIFF3"
+	fi
+
 	if test -z "$local_mode" || test -z "$remote_mode"
 	then
 		echo "Deleted merge conflict for '$MERGED':"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 70afdd06fa..b75c91199b 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mergetool automerge' '
+	test_config mergetool.automerge true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test${test_count}_b master &&
+	echo -e "base\n\na" >file1 &&
+	git commit -a -m "base" &&
+	echo -e "base\n\nc" >file1 &&
+	git commit -a -m "remote update" &&
+	git checkout -b test${test_count}_a HEAD~ &&
+	echo -e "local\n\nb" >file1 &&
+	git commit -a -m "local update" &&
+	test_must_fail git merge test${test_count}_b &&
+	yes "" | git mergetool file1 &&
+	echo -e "local\n\nc" >expect &&
+	test_cmp expect file1 &&
+	git commit -m "test resolved with mergetool"
+'
+
 test_done
-- 
2.30.0.rc0

