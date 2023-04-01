Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D5C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjDAIqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjDAIqq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:46 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1671D938
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:40 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w13so7037717oik.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBrcaWeKXD8fS8LWKYgvLIk/E2ugz0dBaeZpddjiLK4=;
        b=DneFT4uQxkoYgK96r4mq7tLNa5ph8ou6I2MDok7vSBxj6+47z3K7j3DAVw0YWp6XXC
         919LyJOz4JQcBWHMUTA0mUx/Mzol7ijJvdTfaALSb2/ig79YYu91ASM6ZTxY0VVdI1cd
         SdKafN5azcstTb3NuVjy93acFMqbRnB2F6oN8u/1rXzGtrGYI6O2NkeoHZL/qltisEA/
         MC8QygTr27lYypSG4u+IgY5NvhlbFbcLFfbcCeKl4BDp7wRxxuXHR0Q3kO38VR4K18Fr
         XKRdXYj61xjVLoVPjLxpwVYf9VUQWjnkvNXIoercaelC+sSYcozA59SKMIcH13TGhKK3
         719g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBrcaWeKXD8fS8LWKYgvLIk/E2ugz0dBaeZpddjiLK4=;
        b=A7Tbd3RWUjAiFPN+nyIXPZ5JT557RaIB44WMPCI/eLwZHdx8sLzx3LpcxMifU1Nth6
         0t4phH3rai/lRsuYiOLSa0tOglbWg54PacKGeahazueXRF0ixo/i+l2fVDWnJQxiH3f3
         Sz3bQZ/lBff9WtEm/GTM1HVE+eLF8KnIRGvRHpc7U4DxPE6z3PrFg+IyLtNWIoCJlRyx
         oxVH8MDH4Kyu9fqzK6FBF1PHCeRl3fxz7DSEIDgk08TQnhgzRcIlf23E/odVkXDQ+c3/
         hgVhcd/jSpptsmcRJQIMaz0xToJRovdaIVqNC4UCAc02zMXZhixWKWMa8U36HwJuxoEG
         GKWw==
X-Gm-Message-State: AAQBX9f5+QHaMSJYedoGir2MrkpYydn7X4er2/yOlmRgena9RQr3LwIB
        quBs7PRY9oQv6bYI9oleBELVmyDW13A=
X-Google-Smtp-Source: AKy350ajDf8FpIxCYwC5BxV1559kX+/vbisJCI6VEVGjrmc0jgzx0oxEDfbfVR9lRXvYr81uO9ji4Q==
X-Received: by 2002:a54:400a:0:b0:389:9c8:7747 with SMTP id x10-20020a54400a000000b0038909c87747mr10147142oie.21.1680338799236;
        Sat, 01 Apr 2023 01:46:39 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o128-20020a4a2c86000000b0053b8ae294f3sm1774218ooo.11.2023.04.01.01.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 08/49] test: completion: use global config
Date:   Sat,  1 Apr 2023 02:45:45 -0600
Message-Id: <20230401084626.304356-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aliases are supposed to be global.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh     | 8 ++++----
 t/t9904-completion-zsh.sh | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 561f06b46a..6c3cfe7e5a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2233,7 +2233,7 @@ test_expect_success 'git --help completion' '
 '
 
 test_expect_success 'completion.commands removes multiple commands' '
-	test_config completion.commands "-cherry -mergetool" &&
+	test_config_global completion.commands "-cherry -mergetool" &&
 	git --list-cmds=list-mainporcelain,list-complete,config >out &&
 	! grep -E "^(cherry|mergetool)$" out
 '
@@ -2430,7 +2430,7 @@ test_expect_success "recursive alias" '
 '
 
 test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
-	test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
+	test_config_global alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
 	test_completion "git co m" <<-\EOF
 	main Z
 	mybranch Z
@@ -2439,7 +2439,7 @@ test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cm
 '
 
 test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val git <cmd> ... }' '
-	test_config alias.co "!f () { VAR=val git checkout ... ; } f" &&
+	test_config_global alias.co "!f () { VAR=val git checkout ... ; } f" &&
 	test_completion "git co m" <<-\EOF
 	main Z
 	mybranch Z
@@ -2448,7 +2448,7 @@ test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val
 '
 
 test_expect_success 'completion used <cmd> completion for alias: !f() { : git <cmd> ; ... }' '
-	test_config alias.co "!f() { : git checkout ; if ... } f" &&
+	test_config_global alias.co "!f() { : git checkout ; if ... } f" &&
 	test_completion "git co m" <<-\EOF
 	main Z
 	mybranch Z
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index 65bdaa011e..cb123261ab 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -1008,7 +1008,7 @@ test_expect_success "recursive alias" '
 '
 
 test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
-	test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
+	test_config_global alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
 	test_completion "git co m" <<-\EOF
 	main Z
 	mybranch Z
@@ -1017,7 +1017,7 @@ test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cm
 '
 
 test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val git <cmd> ... }' '
-	test_config alias.co "!f () { VAR=val git checkout ... ; } f" &&
+	test_config_global alias.co "!f () { VAR=val git checkout ... ; } f" &&
 	test_completion "git co m" <<-\EOF
 	main Z
 	mybranch Z
@@ -1026,7 +1026,7 @@ test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val
 '
 
 test_expect_success 'completion used <cmd> completion for alias: !f() { : git <cmd> ; ... }' '
-	test_config alias.co "!f() { : git checkout ; if ... } f" &&
+	test_config_global alias.co "!f() { : git checkout ; if ... } f" &&
 	test_completion "git co m" <<-\EOF
 	main Z
 	mybranch Z
-- 
2.33.0

