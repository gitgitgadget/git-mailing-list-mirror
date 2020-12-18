Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA8EC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8792D23A5B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLRMts (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 07:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgLRMts (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 07:49:48 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7775C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 04:49:07 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 11so1753899oty.9
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 04:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sR1JdT/A8q0q92bcxMpiy0u0rMlSfTKu8ufKh40YbpM=;
        b=bEUO1FGp5nInNYUa12pxdc6pqoXTkvi+R9x4BeCKYvvUpTQfggptCQJFl+FesEeaf+
         6kuQoFgkdDmGdW/62jtyds9ildRnGstyOK3f5MuKqXN35jFXdIKxHu60Q/mQt5txOn6Q
         /e4iVdDrYMKWDSGLI8pfak2RqhLm0CrC2jJfk0X7ffJfwEq3OgjP2eJFKiiO0RyJLk7q
         zr/L0eyWoI7GM+4oWji7DUi/AExZvXKovZkbo8MwMTqAKj6bybVJzpi7HKkUTDeevudh
         cwCAQRd3S9qtBIbjWVVlL7zZyaXGReF5srYejaMB0A657T+GoOOcy2it0r1IOZsT72FW
         M1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sR1JdT/A8q0q92bcxMpiy0u0rMlSfTKu8ufKh40YbpM=;
        b=b8VaW9o5G2MN0c0H0K/hEgMQqw24ZYgrVbN7NbbWiv+xLmnRWmlw0RmL3sqe50OnaV
         TytO/GANKGg3jqroIfyVqR/M9L6YDzD3gSzFj5KT8wtShrAxQ3LUzIUfCCfxtw77m+Jb
         zsGybvPJJAq4XnB8ftK6tHWDd+dy0pUy5/rkvGZw9P3DqfQfj9VHXE3pSGghoPpFy4c2
         ww29T1h/nfycszNeJKGURLHxy+duMDnMalkB1bZNzyJqV96lmcM0Oprdz7aC0x7q6QLI
         NV2t1nSzIBrMr+5Gy2TkqYVN7R3mqyHCX9cJ4sqcBrOU1+NtJblzxtJ8ccs7hsFBCWCS
         uZUg==
X-Gm-Message-State: AOAM531P19C7SkZXYkIqZxO9w/aFmRQ7Y+9kpac98vTlXzDIVkhg4SUO
        VWhOs9FNwVGdmRN3m3cAzUpVdosn5XYY3g==
X-Google-Smtp-Source: ABdhPJweofxw+epjqYwp9uD94VvpyNScDHij26aVTf86gN7RCT+xKsDXt8WxwTsLjcCNz8DPRQ3t7A==
X-Received: by 2002:a9d:12c:: with SMTP id 41mr2634703otu.77.1608295746977;
        Fri, 18 Dec 2020 04:49:06 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v23sm1865206otj.68.2020.12.18.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 04:49:06 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/1] mergetool: add configuration to remove unconflicted lines
Date:   Fri, 18 Dec 2020 06:49:04 -0600
Message-Id: <20201218124905.1072514-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's not much to say other that what the commit message of the patch says.

Changes since v3:

 * Turned on by default
 * Added a check for binary files since Junio brought them up
 * Added the marker-size implicitly as Junio requested
 * Changed the way files are generated in the tests, as Junio said
 * Improved the documentation

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 43af7a96f9..7ce6d0d3ac 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -63,4 +63,4 @@ mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
 
 mergetool.autoMerge::
-	Automatically resolve conflicts that don't require user intervention.
+	Remove lines without conflicts from all the files. Defaults to `true`.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 6e86d3b492..f4db0cac8d 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -239,6 +239,17 @@ checkout_staged_file () {
 	fi
 }
 
+auto_merge () {
+	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
+	if test -s "$DIFF3"
+	then
+		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
+		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
+		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
+	fi
+	rm -- "$DIFF3"
+}
+
 merge_file () {
 	MERGED="$1"
 
@@ -323,13 +334,9 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
-	if test "$(git config --bool mergetool.autoMerge)" = "true"
+	if test "$(git config --bool mergetool.autoMerge)" != "false"
 	then
-		git merge-file --diff3 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
-		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
-		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
-		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
-		rm -- "$DIFF3"
+		auto_merge
 	fi
 
 	if test -z "$local_mode" || test -z "$remote_mode"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index b75c91199b..ccabd04823 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -832,16 +832,16 @@ test_expect_success 'mergetool automerge' '
 	test_config mergetool.automerge true &&
 	test_when_finished "git reset --hard" &&
 	git checkout -b test${test_count}_b master &&
-	echo -e "base\n\na" >file1 &&
+	test_write_lines >file1 base "" a &&
 	git commit -a -m "base" &&
-	echo -e "base\n\nc" >file1 &&
+	test_write_lines >file1 base "" c &&
 	git commit -a -m "remote update" &&
 	git checkout -b test${test_count}_a HEAD~ &&
-	echo -e "local\n\nb" >file1 &&
+	test_write_lines >file1 local "" b &&
 	git commit -a -m "local update" &&
 	test_must_fail git merge test${test_count}_b &&
 	yes "" | git mergetool file1 &&
-	echo -e "local\n\nc" >expect &&
+	test_write_lines >expect local "" c &&
 	test_cmp expect file1 &&
 	git commit -m "test resolved with mergetool"
 '

Felipe Contreras (1):
  mergetool: add automerge configuration

 Documentation/config/mergetool.txt |  3 +++
 git-mergetool.sh                   | 17 +++++++++++++++++
 t/t7610-mergetool.sh               | 18 ++++++++++++++++++
 3 files changed, 38 insertions(+)

-- 
2.30.0.rc0

