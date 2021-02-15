Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C8C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCF364DF0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhBOQB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhBOPrs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D74C061A29
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so9461965wrx.4
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLZN820R2lIhKBZ10T9FWH0oLLmYxDlFo9ieSKz4meQ=;
        b=BcX3jPHozDMBepLpha4l6CrG2PNuVPtI14itPybXS89+Hpb3uDjFZa+lPWCs7wOU6z
         6x/9dbAp1Rpt3ukHx8ggHGr8DnAYxUUZf8wfoTg+4zN/AkmcR8seH6/jf/68TAgeIO3h
         yvxOiCZXoOGKnCNKp47jrTeuFHlTazkXRxTaaa4gVMe/wDbKr6m6MqCjbVsD0G7JJW1f
         5fdxOWBzgwrXEt5aC83FVAEBZ4wIdRbBglTQpR3i80Uukd1PbW3f85Uvz/HMNxynaRbx
         KVLso1mTPTOqEfSVkhQ817V+MHVp0kwvHSrA4k/b+kUw/CsdGm4uNgp6Vj5Y6xvrmyxz
         jWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLZN820R2lIhKBZ10T9FWH0oLLmYxDlFo9ieSKz4meQ=;
        b=O2WNge9Egkqy5U6Qyuas54BfCLgdpP48cvLynrMIGTQ6OOksXSn5nuKQXMZHLZGXh1
         k2C+vFnv19gb1/owrItmtuvexRPh1Px9LS+/bzfjVLyE4Lskey5U5bPJx7lakB3Y2y6d
         xSieIIGrCIKg8Ug+ZgwQ7Q+4C7Cz5ZrOTdqrdWaiGnzfU5eP9IErqd2GZZ9t0QTB2Ohx
         1IMZJzoAAvVrFiSuql6mk2OUsndw+4p7jNaOhKkx5xhJO36FiFOrNVPSQkZMUTdLOJI4
         2DqGgcBfO+S6KDiRKvtVlwGWZU0kEegqby5osUSf+kZfPfwp1A9fF3ovnQj/02suBf9a
         ZnTw==
X-Gm-Message-State: AOAM532jrdQLokru0QaFu+6YaqkrmPVTVMZxc0EWpyB4Hse2FIV/H2C2
        4/D6i98j33ZCprAgG8w27NHgkK/6z14okA==
X-Google-Smtp-Source: ABdhPJyEbZrQ8VP3WLdoNcT9Db9H0ucp9+EzkkDuxJ/S0nCw2SfqsmN3oGXFIlVPOEBp153+tB2Yeg==
X-Received: by 2002:a05:6000:114b:: with SMTP id d11mr3540250wrx.318.1613403907966;
        Mon, 15 Feb 2021 07:45:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:07 -0800 (PST)
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
Subject: [PATCH v2 26/27] userdiff tests: add basic test for ada
Date:   Mon, 15 Feb 2021 16:44:26 +0100
Message-Id: <20210215154427.32693-27-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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
 t/t4018/ada.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 t/t4018/ada.sh

diff --git a/t/t4018/ada.sh b/t/t4018/ada.sh
new file mode 100755
index 0000000000..45fc2c7a3b
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

