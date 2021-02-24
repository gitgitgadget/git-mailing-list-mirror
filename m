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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DA0C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CED64F07
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhBXT6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhBXTyN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B9C061A2A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 7so3057077wrz.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ca/3zP1uvWPzwHNhntK47F35wSo5USpHIJyKPA7UgRc=;
        b=uMXjZGJ1BR6Oe9wwcCLNuDSPP9CXOgmHqODDa7p57Ye3I7TuJ47sUhXx6rYxiiSWMZ
         mSmhwNjNMSU5v+Di3OZ/jB4ezqrK4xLrkndwIFZJolQMVD3gld3HiN48FIESofjHpyQw
         sxq8uEpB9Crd76GXXP0OdHHLwz0sZxYXNah7PpnxWrBucP/yE1g5fMxQ1Yr+YE8ho0zP
         UzOG5mXqVeH+cFb0apGnNX8WYGW1IdvPlyRSKdD1sQbrbJOEdz+wy2XYuGNHja0MIzmV
         FmWiqUxvo8N801jRIErT35FFO29FVz4+Y1/s8YWvzBfNygLHrEyF28fx7nKnwBSuvwXK
         Nr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ca/3zP1uvWPzwHNhntK47F35wSo5USpHIJyKPA7UgRc=;
        b=RewZCspDkJl9FSNdV/Qd3HGQ92p3FGBYCLuNrt5QnhiXemlTwFEYJwAmx+5f9+z7WK
         PVTvNqgursrHZxLHyLXD+afcsz6tbbKh4IQ0Des/K0dMx03khBmHDfbZnwLsWIcEe3PG
         7IVhX5nrLbu6YVyRHqI4F4iLyiY2QKwmvNpZd+soIPSk8texbpd45l/H0tV9XBbsRetj
         5823CmANYdT8uhuX9WMKoR0nB9irp8S5C5iTPKUrHdfU+h2Szl1wIMrHa4NcFG9IywVz
         g3E7ALhriQDYHsULw+/RsuhNmmeuaPChL3qxDxTZE8K6I9Oy4UoGcV2YcN6pYPw6j5YU
         QRKA==
X-Gm-Message-State: AOAM5311/tuu4fCUXXBsd26rK/6TlnKKPztVnjReY07BqYtQK0Dd/k9e
        IVuQ2yePp7Iwikv+hl3OizeUQOMOXNuAGw==
X-Google-Smtp-Source: ABdhPJwTYQisDvWOvuXW7kD/30YYzs3ROpBdjk7PFH4OpExAPbG0i47GjfdwaEXZCUagL8EbagGgLw==
X-Received: by 2002:a05:6000:1101:: with SMTP id z1mr33845760wrw.110.1614196341558;
        Wed, 24 Feb 2021 11:52:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 34/35] userdiff tests: add basic test for ada
Date:   Wed, 24 Feb 2021 20:51:28 +0100
Message-Id: <20210224195129.4004-35-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test for the ada userdiff pattern added in e90d065e64 (Add
userdiff patterns for Ada, 2012-09-16).

I don't know the ada language itself, I just stole a couple of
examples of code that used tokens we're matching[1][2]. Both test
examples stress our negative and positive matching rules.

1. https://rosettacode.org/wiki/99_bottles_of_beer#Ada
2. https://en.wikibooks.org/wiki/Ada_Programming/Tasking
---
 t/t4018-diff-funcname.sh |  1 -
 t/t4018/ada.sh           | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100755 t/t4018/ada.sh

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index ba10d1f5313..b0c2782d067 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -18,7 +18,6 @@ test_expect_success 'setup' '
 	# Do not add anything to this list. New built-in drivers should have
 	# tests
 	cat >drivers-no-tests <<-\EOF &&
-	ada
 	bibtex
 	csharp
 	html
diff --git a/t/t4018/ada.sh b/t/t4018/ada.sh
new file mode 100755
index 00000000000..45fc2c7a3b2
--- /dev/null
+++ b/t/t4018/ada.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'ada: "procedure" over "with"' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+procedure Bottles is
+EOF_HUNK
+with Ada.Text_Io; use Ada.Text_Io;
+ procedure Bottles is
+ begin
+    for X in reverse 1..99 loop
+       Put_Line(Integer'Image(X) & " bottles of beer on the wall");
+       Put_Line(Integer'Image(X) & " bottles of beer"); -- ChangeMe
+       Put_Line("Take one down, pass it around");
+       Put_Line(Integer'Image(X - 1) & " bottles of beer on the wall");
+       New_Line;
+    end loop;
+ end Bottles;
+EOF_TEST
+
+test_diff_funcname 'ada: "task" over "procedure"' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+task body Check_CPU is
+EOF_HUNK
+procedure Housekeeping is
+  task Check_CPU;
+  task Backup_Disk;
+
+  task body Check_CPU is
+    -- Comment for spacing with
+    -- the above "task" for -U1
+    ChangeMe
+  end Check_CPU;
+end Housekeeping;
+EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

