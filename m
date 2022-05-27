Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF14C433FE
	for <git@archiver.kernel.org>; Fri, 27 May 2022 19:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354582AbiE0T4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354541AbiE0T42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 15:56:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87034BC26
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h126-20020a1c2184000000b003975cedb52bso2993731wmh.1
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZoyZMYYQppUo1e2ZmzfBK0zGXKt8HZawrNnFmaGnsU=;
        b=N5LmnNvZLZ+3MhiPWbecqOnw0s3c8UV2hoFM8QAG3U17Pj3OREzTEnb8BHfF61Mygk
         sjKfMT1qnzSKYHS7x5L9FL25zWkpouYWMdyPiDM+Owrl3Pt63JN0fuuxxLyR9wjSPPSb
         7JiZ3D+8UpqyTy8BSFd2LPOmFXrEwFIXA5GVhXMkkkgvSTSKufy+NFIJsTgAuBoVSAj7
         5V+nc1w2eOWvwC2e8aBnkQ25ismJLC67oV7ESzQd7WZuLv+6xodme+6eLAj0ejLod76Q
         /R6IRyY7uK/0UzPlIfQP7cqPotfJCChvQG+yIb5w82g17S7m2ATTnFInu1yag1QGc25o
         GmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZoyZMYYQppUo1e2ZmzfBK0zGXKt8HZawrNnFmaGnsU=;
        b=fOqFIaX6xpc8p5oKQJLJ+vgI+oRFLQMqV6ZPbhyFn57QPOXFcZgfmmWYrK8dor85oO
         IXiNfvntU38ZwoS81jGXfKKZuz4s2HSvB+kiXduAuy7wbaSC0F18U+JsjD0amMZnUas3
         GqmabIPYpIQ7oSZuP5VuSG8adY3OL8DwY/efVK9irdGWHb9nWVXm9ZrVFJ22sMONtM3L
         r+RlJ97cmAR7QVfz7IRmDJDRQQTpPVGgxTy+ljIPtIZqJdEv3lVo383h69zkU7xTBGNH
         muuYCLsQmA3dxB33uI9/FrS9D7n2Y/68hN1jblMgnzB3TXvrM+/tR4roo+zOS6pm/G4N
         ajTA==
X-Gm-Message-State: AOAM532/QkvWxPNpNBLwWj8MnV5U+QWFIenFZvQKQa742ZYwtliW8BVC
        Tc6aluvN3A13ttkiYYUxjEY=
X-Google-Smtp-Source: ABdhPJwHctxuVgZn4l+fNsyvWeW+VN0uBgDqZHW78lOsz0dAu5SxEUpTjcliPp5GJaKf+TvKV9s+DA==
X-Received: by 2002:a1c:19c3:0:b0:392:9cef:e32b with SMTP id 186-20020a1c19c3000000b003929cefe32bmr8403994wmz.116.1653681384045;
        Fri, 27 May 2022 12:56:24 -0700 (PDT)
Received: from jonathan-ubuntu.univ-lyon1.fr (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id 129-20020a1c0287000000b0039748be12dbsm3041350wmc.47.2022.05.27.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 12:56:23 -0700 (PDT)
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
To:     git.jonathan.bressat@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, cogoni.guillaume@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, guillaume.cogoni@gmail.com,
        jonathan.bressat@etu.univ-lyon1.fr
Subject: [PATCH v2 3/4] add configuration variable corresponding to --overwrite-same-content
Date:   Fri, 27 May 2022 21:55:44 +0200
Message-Id: <20220527195545.33984-4-git.jonathan.bressat@gmail.com>
X-Mailer: git-send-email 2.35.1.10.g88248585b1.dirty
In-Reply-To: <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
 <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Configuration variable merge.overwritesamecontent corresponding to
the --overwrite-same-content option.

This allow merge to overwrite untracked files that have the same
content, a configuration variable is interressant because some people
may want this activated as default to not have to use the option every
time

Signed-off-by: Jonathan Bressat <git.jonathan.bressat@gmail.com>
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 Documentation/config/merge.txt |  5 +++++
 builtin/merge.c                |  2 ++
 t/t7615-merge-untracked.sh     | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 99e83dd36e..2824dd19c7 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -89,6 +89,11 @@ merge.autoStash::
 	`--autostash` options of linkgit:git-merge[1].
 	Defaults to false.
 
+merge.overwritesamecontent::
+    When set to true, it will modify the behavior of git merge 
+    to overwrite untracked files that have the same name and 
+    content than files in the merged commit.	
+
 merge.tool::
 	Controls which merge tool is used by linkgit:git-mergetool[1].
 	The list below shows the valid built-in values.
diff --git a/builtin/merge.c b/builtin/merge.c
index fffae81068..936cb8480d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -658,6 +658,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "merge.autostash")) {
 		autostash = git_config_bool(k, v);
 		return 0;
+	} else if (!strcmp(k,"merge.overwritesamecontent")) {
+		overwrite_same_content = git_config_bool(k, v);
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
diff --git a/t/t7615-merge-untracked.sh b/t/t7615-merge-untracked.sh
index 05a34cf03f..cfefd8f473 100755
--- a/t/t7615-merge-untracked.sh
+++ b/t/t7615-merge-untracked.sh
@@ -60,4 +60,25 @@ test_expect_success 'merge fail when tracked file modification is unstaged' '
 	test_must_fail git merge --overwrite-same-content B
 '
 
+test_expect_success 'fastforward overwrite untracked file that has the same content with the configuration variable' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	test_config merge.overwritesamecontent true &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git checkout A &&
+	echo content >file &&
+	git merge B
+'
+
+test_expect_success 'normal merge overwrite untracked file that has the same content with the configuration variable' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	test_config merge.overwritesamecontent true &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git switch A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo content >file &&
+	git merge B
+'
+
 test_done
-- 
2.35.1.10.g88248585b1.dirty

