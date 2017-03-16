Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991CA202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 05:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdCPFUa (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 01:20:30 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36823 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdCPFUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 01:20:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id n37so4468640qtb.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 22:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k7jGpo8PewfQJjztb2rO7lfOaniWq1Raj/KPd8RAV3s=;
        b=fkC4E5f3+5hqOwlgfHemf4r/rrtHcm0MqymJIIGR9goiSu9vL5tXLDqzJ+pA7sooUn
         zofDjeu03rVSe7ReyDraAaflinUqhI6FR9+X7gYyTjR4scHK6gV1ixMWREXnTzGIdraR
         coL+kAC/rmxVEg1kJdcamrjJuS++BvBUKDB2TVPB/+wJPbU6sh88s5yMbR5hgPj2g4gC
         dYWZKTWPqAooH7JCjBqt3Tyi9e+CCINzzKfS8M8Jeh2ggHiJHcrTBwplNLwuTuRcwcwk
         CXYkAWSTzLbj5re7BE2DHfy9LmpgKnzBEkI+L6tNnR+s6yrGW3bFekpiRsyDLvmEaPOK
         P3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k7jGpo8PewfQJjztb2rO7lfOaniWq1Raj/KPd8RAV3s=;
        b=LTIpsJHdKNEZpupdcmlBp7YrrH+WBzHWXx94/fg4c+1or2sn9UKSfaLLsFD0rRui+L
         0nyY7iwbvulYMDYcl21NlVS7EtHR4wzJ9EJEU3luyz1+l4+WyTTAIPrmysIz2rBqQbTp
         CmWlGxlB3uJELs4rI2a5hdFXrL+vZ4zyacd9vS4l3Wj+yuG44g7ByFcjvp8oA2z5oxfH
         mMhhP9zsyefNk6Hq299IPdYWr6xSQJk3sjsl4VqwjSyO0IcmsfK8Ao1k5abxmzreHdlr
         pDEXMGt1W3gTDS2Ty0qOo1CmjFhkO2/BdxrrGYUlkhMyv1zIVrFASy1WgpQ1iXJ5ttlk
         ttLg==
X-Gm-Message-State: AFeK/H02dOKgBa7ljJwYZ/LGYZz/1mOjmCWFzcmMspc310RcHWzwjh6kLEIFDhBZ0Oexgg==
X-Received: by 10.200.4.168 with SMTP id s40mr7159326qtg.283.1489641516989;
        Wed, 15 Mar 2017 22:18:36 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-52.cit.cornell.edu. [128.84.124.52])
        by smtp.googlemail.com with ESMTPSA id y52sm2913833qty.60.2017.03.15.22.18.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 22:18:36 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [GSoC][PATCH v4 2/4] dir: add directory_exists
Date:   Thu, 16 Mar 2017 01:18:25 -0400
Message-Id: <20170316051827.97198-3-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170316051827.97198-1-lehmacdj@gmail.com>
References: <20170314003246.71586-4-lehmacdj@gmail.com>
 <20170316051827.97198-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

file_exists currently only does an lstat to see if anything is at the
path. For some purposes it would be better to ensure that a path
is a certain type of file. Add function directory_exists that checks if
a path exists and is a directory.

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 dir.c | 7 +++++++
 dir.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/dir.c b/dir.c
index aeeb5ce10..f6c23ecd2 100644
--- a/dir.c
+++ b/dir.c
@@ -2055,6 +2055,13 @@ int file_exists(const char *f)
 	return lstat(f, &sb) == 0;
 }
 
+int directory_exists(const char *path)
+{
+	struct stat sb;
+	int ret = lstat(path, &sb);
+	return ret == 0 && S_ISDIR(sb.st_mode);
+}
+
 static int cmp_icase(char a, char b)
 {
 	if (a == b)
diff --git a/dir.h b/dir.h
index bf23a470a..9f8278795 100644
--- a/dir.h
+++ b/dir.h
@@ -247,6 +247,7 @@ extern void add_exclude(const char *string, const char *base,
 extern void clear_exclude_list(struct exclude_list *el);
 extern void clear_directory(struct dir_struct *dir);
 extern int file_exists(const char *);
+extern int directory_exists(const char *);
 
 extern int is_inside_dir(const char *dir);
 extern int dir_inside_of(const char *subdir, const char *dir);
-- 
2.11.0

