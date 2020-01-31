Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E4BC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26421214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpj5l+OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgAaV6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:58:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56050 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAaV6U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:58:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so9639566wmj.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 13:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dG7WSJ4uoNLxdjXeoy82EGkz/4mMq86QcJn2e1yuw/c=;
        b=Zpj5l+OXzxzyie/meop29i6UgdfNmsIvzdg6fk1Z8O0vrH89IF/c4CjEo/a0O+FCDf
         0hRvn4IAZ1JX39CPawYX77f5c/cU5FXclay75BUCjJOdqZe4lJLA6NDV6GScqUA6xYWX
         unPrbU3QPcXH507hC28uarIqLx6BiQ0mqih+WSQPDKxzp1BoTieSbstj+WA6hhugREIM
         EsAgsbJ7k5KoYSSX/nm5ez8vWraCyZmDWajNVSvVyLELrg586HYwtnrPFXj+ywMKHPUY
         7nb/t1m56s6Z/+Mig74VmWHqJ2DvsGtSJ94xuhvHIo5mYNH+njsLu9ChgPEqZ7LUgs/0
         Y6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dG7WSJ4uoNLxdjXeoy82EGkz/4mMq86QcJn2e1yuw/c=;
        b=H+2ERJjJOCEKaczIi63P6zHJzRxvcldjJ5MkCxnwn2AbDuSshQZycKP+Ns2vb93C2p
         mn3AiAZp/eK9hraAs/5pAb75hF3EGDHmeFKrGhAQNpdjYYvMo7l74ZCa0K65J7AcCqZD
         Sv6g8MrJmH9Fkh+0ZL4X5mJtTg2ZSHNAqW+4NKO8jlnsbOz1yH9Ip6yDW1Cz4AJ/bp4+
         mZdiaftU4XQYpbssoTlX0iijVo01/91FBmXiB8+rmQMFi8/6z5J7yzXmfBqiBZVYZyhH
         MXyHmi2JFX2GjjLZC6EIJc3S8UcYcC9yMP7y4t56w/LImPrA1sOeLiiXmG1ZwSatAU19
         ZYQA==
X-Gm-Message-State: APjAAAULBnNM7FLUMSuWCVu294ispVA214g2ESv3VQaBVKn6MjTGLL7K
        Vek8wvl+St9KKIYwAMy/Tcqqc6YP
X-Google-Smtp-Source: APXvYqz7S0s2aYp/1Qd3HlD7HkjSt7SOjV6az6u3RvanldAkmiXGMwlve/Ie6mn9EErwxEcJ0W+10A==
X-Received: by 2002:a1c:38c7:: with SMTP id f190mr13662641wma.94.1580507898754;
        Fri, 31 Jan 2020 13:58:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10sm11853355wmk.31.2020.01.31.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 13:58:18 -0800 (PST)
Message-Id: <1bdcdc4c18b9d8fa3cc5a9c846fb855182330d05.1580507895.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 21:58:14 +0000
Subject: [PATCH v2 3/4] git-p4: add hook p4-pre-edit-changelist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Add an additional hook to the git-p4 command to allow a hook to modify
the text of the changelist prior to displaying the p4editor command.

This hook will be called prior to checking for the flag
"--prepare-p4-only".

The hook is optional, if it does not exist, it will be skipped.

The hook takes a single parameter, the filename of the temporary file
that contains the P4 submit text.

The hook should return a zero exit code on success or a non-zero exit
code on failure.  If the hook returns a non-zero exit code, git-p4
will revert the P4 edits by calling p4_revert(f) on each file that was
flagged as edited and then it will return False so the calling method
may continue as it does in existing failure cases.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 4e481b3b55..61cfd1c1ae 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2030,6 +2030,17 @@ def applyCommit(self, id):
         tmpFile.write(submitTemplate)
         tmpFile.close()
 
+        # Run the pre-edit hook to allow programmatic update to the changelist
+        hooks_path = gitConfig("core.hooksPath")
+        if len(hooks_path) <= 0:
+            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
+
+        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
+            for f in editedFiles:
+                p4_revert(f)
+            return False
+
         if self.prepare_p4_only:
             #
             # Leave the p4 tree prepared, and the submit template around
-- 
gitgitgadget

