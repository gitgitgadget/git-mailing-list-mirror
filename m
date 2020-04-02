Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B6EC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7223A2074D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub26qUQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgDBKPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:15:54 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34597 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBKPx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 06:15:53 -0400
Received: by mail-pj1-f66.google.com with SMTP id q16so3183619pje.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lFOxQZ86Db5FgkGzox2I2XZR8EePvBiNFsM/bdHIF8=;
        b=Ub26qUQIGDpstViViQJTFdNjmWreS/TlIicR5PjE5+wLkC0U1Y5Gp4vmNiZ0ceHDk9
         ULt0sVxsjmZDHtZfh4ewXj9IoUZQ0XHb50haiYa+lrTZmZYrjerAXaigpbV2gtWTTtCg
         UtZyes/k7iRrfxMAt0STlM93ZHAZ88ke0rhC/Q4PgZJk+1h2SZ0FyoWV+zul5hx6ewOe
         o1dVFvuJU+950Zi7IKxI1we+oRaT51ulwemCwQlbImiWcgkumEqyJVbWC4u23CPvulqh
         LVpQzf1QDz1nb/xZ1nxLR6m3fQlR46eXHYPe2sNrcGfer/ZnMHaYdJSk+sas0AiSh7uQ
         hioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lFOxQZ86Db5FgkGzox2I2XZR8EePvBiNFsM/bdHIF8=;
        b=dSZrUxJzuQTNZ4d9OKW/qZuoLWufaMEXPyN5kPB6pwc/v9qUKW5Z1fbVOmO/FMQGKd
         VDk0JBUTR8/ioMRA/aMMcV32YvbeM/9RujFN4MvcIfwhe/OZ4IGWwUIO2sbraycx9XZn
         2yho3taYYqEkyWqEKS8Ur7ZLO9OkNaiQU4zn31AHcKFTHM6qE/mmDRnevm+HVDoJkWZ+
         kElbJYaDpuPAtcsmZyFLfmJyqRRpPjbQKh+fNI0IlP5C8R2tMx6ryKdZy+p8wXE8FtTu
         6+K8DLnjnHdN9wPvbz2mSijo9DLZ160UBss6Z+y7d/mKn2yoUOesdmfyAj9hUc5F3whS
         YvDA==
X-Gm-Message-State: AGi0PuZIyL8MYL06OUX+OZ4X4W5dsRYG4OvSfT1axyIccft3gHT++Ugb
        bkqPtdW+fGq6DjhRuXnCElyPAJjf
X-Google-Smtp-Source: APiQypKqsGbVXM3kZrWOroy6fT7ggL06PsSqk+2xMeM+U2E0ZOeoorrR1PD5W031koEecgMZubVNSg==
X-Received: by 2002:a17:90a:14f:: with SMTP id z15mr2847182pje.137.1585822552193;
        Thu, 02 Apr 2020 03:15:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id nu13sm3599948pjb.22.2020.04.02.03.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 03:15:51 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 4/5] Documentation: reword commit --no-gpg-sign
Date:   Thu,  2 Apr 2020 17:15:33 +0700
Message-Id: <c15f9d54cb9f25f9d8a7721882bf8c93de4a12a2.1585821581.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585821581.git.congdanhqx@gmail.com>
References: <20200331064456.GA15850@danh.dev> <cover.1585821581.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Merge with --gpg-sign option, and clarify that --no-gpg-sign also
override earlier --gpg-sign.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-commit.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 13f653989f..6f6c06028b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -350,11 +350,9 @@ changes to tracked files.
 --gpg-sign[=<keyid>]::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
-
---no-gpg-sign::
-	Countermand `commit.gpgSign` configuration variable that is
-	set to force each and every commit to be signed.
+	stuck to the option without a space. "--no-gpg-sign" is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier "--gpg-sign".
 
 \--::
 	Do not interpret any more arguments as options.
-- 
2.26.0.334.g6536db25bb

