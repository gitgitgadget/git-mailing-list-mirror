Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A091FECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIPVAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIPVAG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 17:00:06 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD862CCA9
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 14:00:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v4so21406405pgi.10
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RhIgIKGLKJQi+3FQlkQ/ZtboquuaXKMe1tKM+0hN8Hs=;
        b=VDZfFVS6GDBGuJ95ccyTz+TJinQK3jR/uNTbYigUlLlYEh5GBDe6Xh+J72bye+8EBR
         KsP3mhP9hh84bZgmajvQR2aaqBvieeWXsyXE3BqoiCIB0yCa4b9WXy5Jx9QPsYwveHNo
         /ub0dh9hdA2CPFRdvl9g+LAGz9Ch/o2kDzjYibncISmjbh95DWS/n3+yqrFxhXQtTMS2
         XdIFV0pgkHkg+w12BEe4ZgypIAL+7jGaEKn6RKJW1zVKKebNQJ425ossp3StM0CAGcyu
         1KhEnqz4JfDYGVH4DGORDg14uRXLMlAu2/ODcpvb7o/c7YTEHV/hY9xLYtbwWAHowMbO
         ZpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RhIgIKGLKJQi+3FQlkQ/ZtboquuaXKMe1tKM+0hN8Hs=;
        b=PBEwUpD3e6QtmRurBEAqTtKfbvue4F9yDNPuHEZB9pVcHmm6AlUoFDG7jZzOGXAlQE
         LuCit8vQ17wjj60VB9UXxkkk1pe1DQf9saPd5T3UFgx5bRxLTlmG9AV6lcIJtrErfWhd
         /U/t8+URuNb/yjKJTuiElgkkqHBrM2/F1ocWLnUXWYHdvlK/l4tlVNvHAPcViXsAmWZ4
         SfbHuI/pUsOcRChwujF1uKZJgrG8ew8meJM+cn4XOcH2hwgA0LHFRsjVfIC/vK54nM4H
         YEzltXBS7ciZL76AHc6whBB0HaGZ4PdgsfM+H1Qp4lTFW8t0oYnbnG07C9C8HhlkZM6Y
         Occw==
X-Gm-Message-State: ACrzQf0U2kpevxS5K+vK3NpfisKWw9CdHOZBQLlIBGnLpF1BJ9/qe9cc
        QIg9HlvrX4zccTVJgS0uUNz6T3verTKx/w==
X-Google-Smtp-Source: AMsMyM6ZsSYvCM2j1UcOQmyXXGZmfoloqdRcxmVpvtijtFO0Z8FMtyZCq/sB1nvSkrDM0oLcyRJOPg==
X-Received: by 2002:a63:3e0e:0:b0:438:63d9:930e with SMTP id l14-20020a633e0e000000b0043863d9930emr6042331pga.17.1663362002073;
        Fri, 16 Sep 2022 14:00:02 -0700 (PDT)
Received: from HB2.. ([2409:4081:9e81:25b3:3dbb:95ec:385b:406f])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a3d0900b002002fb120d7sm1961568pjc.8.2022.09.16.13.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 14:00:01 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 1/3] doc/cat-file: allow --use-mailmap for --batch options
Date:   Sat, 17 Sep 2022 02:29:44 +0530
Message-Id: <20220916205946.178925-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0.3.g53c2677cac
In-Reply-To: <20220916205946.178925-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command git cat-file can now use the mailmap mechanism to replace
idents with their canonical versions for commit and tag objects. There
are several options like `--batch`, `--batch-check` and
`--batch-command` that can be combined with `--use-mailmap`. But, the
documentation for `--batch`, `--batch-check` and `--batch-command`
doesn't say so. This patch fixes that documentation.

Mentored-by: Christian Couder's avatarChristian Couder <christian.couder@gmail.com>
Mentored-by: John Cai's avatarJohn Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index ec30b5c574..5792f21a72 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -89,24 +89,22 @@ OPTIONS
 --batch::
 --batch=<format>::
 	Print object information and contents for each object provided
-	on stdin.  May not be combined with any other options or arguments
-	except `--textconv` or `--filters`, in which case the input lines
-	also need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	on stdin. May only be combined with `--use-mailmap`, `--textconv` or `--filters`.
+	In the case of `--textconv` or `--filters` the input lines also need to specify
+	the path, separated by whitespace. See the `BATCH OUTPUT` section below for details.
 
 --batch-check::
 --batch-check=<format>::
-	Print object information for each object provided on stdin.  May
-	not be combined with any other options or arguments except
-	`--textconv` or `--filters`, in which case the input lines also
-	need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	Print object information for each object provided on stdin.  May only be combined
+	with `--use-mailmap`, `--textconv` or `--filters`. In the case of `--textconv` or
+	`--filters` the input lines also need to specify the path, separated by whitespace.
+	See the `BATCH OUTPUT` section below for details.
 
 --batch-command::
 --batch-command=<format>::
 	Enter a command mode that reads commands and arguments from stdin. May
-	only be combined with `--buffer`, `--textconv` or `--filters`. In the
-	case of `--textconv` or `--filters`, the input lines also need to specify
+	only be combined with `--buffer`, `--textconv`, `--filters` or `--use-mailmap`.
+	In the case of `--textconv` or `--filters`, the input lines also need to specify
 	the path, separated by whitespace. See the section `BATCH OUTPUT` below
 	for details.
 +
-- 
2.38.0.rc0.3.g53c2677cac

