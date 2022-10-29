Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8966CC433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 09:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJ2JZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 05:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJ2JZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 05:25:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6464B69EC0
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 02:25:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d10so6724331pfh.6
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7J85vDF1PWvUrfXJMRguqV+YAFXPk/9FLn7s6Dc8i8=;
        b=nNDnRkSf6TCtVvxEIOIUuWw9mb085PHC2RATBxcKJzCql3H+ZEvXoTi/mmLEMkHdxv
         6w2heOy3p309BbuF6g+aNye0WBLfrsf9fytKsyigNGeGS8hXCUv2byuFM+b16BhzLnZH
         yg9KDHGo+JbS+f3JctfsxyWI7SMzesCYpFv/hyqL8gVBIZsAxyWZvJR04CVGeYkXe2YS
         79lnety0tZuLOQbGe+eceeZX0VN38XTyOCl/nwE4RPIfF9ZCZXN+/UCmxpV9suT2CN96
         mE+LADub7wBFnioH2uSSshux/hLbPXM2m5nvUh3EDgdvILBva64mR+7nBlMchzVJWl26
         alxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7J85vDF1PWvUrfXJMRguqV+YAFXPk/9FLn7s6Dc8i8=;
        b=U2oIaZSz/7GyeXWcLmqYYy/cwGD5e3MlSSf1NskcS7C1qfCU5pDRChmWrXzK7fz+rJ
         D2T1MTOr2DXSZpX7kYqi4bibX3MuNG3vQ0UaEdTaTD0y73q0U/V5mNuoo17tR7K9ReHZ
         j5kXKywAdZoGoHerkSVXLTAO+WnBsaHKhytKCI8LwgYL+yWbIyWid2nVAXbZM7o949UW
         3UGgJ4NGffzUJhJKrxZBO6kU0vD03Q6zZxUEOwAwBdnnTmL8Bf+A/AAfCCWHSIw5QlQZ
         53mBhihVMG3XmiAvbOoWtZ/Ov9UElgRKK+GvVcjIRQx5rYQJFnERNFPex6zKtdWJYIHp
         QvMA==
X-Gm-Message-State: ACrzQf18D3ZFcyQp5IgzY39FTdmbdPlpgq/9p8GCmdgfwRNBq5whzNSL
        Hr54uZiwmSn3N6cMhBKVR3UEHx1QGwy5Nw==
X-Google-Smtp-Source: AMsMyM4u8KCtFefzhe4k9hONs7laz6GgTG4izvsS3ksznHxuOGx4/+IolXweIX0fzyscYafGsHduwQ==
X-Received: by 2002:a63:87c7:0:b0:46b:3cf1:e163 with SMTP id i190-20020a6387c7000000b0046b3cf1e163mr3429697pge.112.1667035523312;
        Sat, 29 Oct 2022 02:25:23 -0700 (PDT)
Received: from HB2.. ([223.190.251.111])
        by smtp.gmail.com with ESMTPSA id 100-20020a17090a09ed00b0020ab246ac79sm678091pjo.47.2022.10.29.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:25:22 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
Date:   Sat, 29 Oct 2022 14:55:13 +0530
Message-Id: <20221029092513.73982-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.281.g0b8e165806.dirty
In-Reply-To: <20220923193543.58635-1-siddharthasthana31@gmail.com>
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---

This patch was previously sent as the first patch of a 3 patch series for 
adding the mailmap support in git cat-file options:
https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@gmail.com/

Changes in v2:
- Fixed the names in trailers in the commit message
- Updated the documentation to clearly state that the `--batch-check`,
  `--batch-command` and `--batch` options can only be used with
  `--textconv`, `--filters` or `--use-mailmap`.
- Fixed formatting

Changes in v3:
- Fixed formatting

Changes in v4:
- Fixed some grammatical errors

 Documentation/git-cat-file.txt | 45 ++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index ec30b5c574..db2bba9b65 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -89,26 +89,45 @@ OPTIONS
 --batch::
 --batch=<format>::
 	Print object information and contents for each object provided
-	on stdin.  May not be combined with any other options or arguments
-	except `--textconv` or `--filters`, in which case the input lines
-	also need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	on stdin. May not be combined with any other options or arguments
+	except --textconv, --filters, or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines
+	  must specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, the info command shows the size
+	  of the object as if the identities recorded in it were replaced
+	  by the mailmap mechanism.
 
 --batch-check::
 --batch-check=<format>::
-	Print object information for each object provided on stdin.  May
-	not be combined with any other options or arguments except
-	`--textconv` or `--filters`, in which case the input lines also
-	need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	Print object information for each object provided on stdin. May not be
+	combined with any other options or arguments except --textconv, --filters
+	or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	 specify the path, separated by whitespace. See the section
+	 `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, the info command shows the size
+	  of the object as if the identities recorded in it were replaced
+	  by the mailmap mechanism.
 
 --batch-command::
 --batch-command=<format>::
 	Enter a command mode that reads commands and arguments from stdin. May
-	only be combined with `--buffer`, `--textconv` or `--filters`. In the
-	case of `--textconv` or `--filters`, the input lines also need to specify
-	the path, separated by whitespace. See the section `BATCH OUTPUT` below
-	for details.
+	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
+	`--filters`.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	  specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, the info command shows the size
+	  of the object as if the identities recorded in it were replaced
+	  by the mailmap mechanism.
+
 +
 `--batch-command` recognizes the following commands:
 +
-- 
2.38.1.281.g0b8e165806.dirty

