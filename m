Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082C0C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiKAWvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKAWvw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:51:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377CF1A20A
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:51:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so40754739ejb.13
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M+53OJgQ5NI2pDkE4sAYnMOh49d/aNJ2k94wOnKpLg=;
        b=E+hWiZiu7f3kres6xa6d1/wXErMT5yTKWfWkuRlvLBOdwWQ81QfzOohfvWOeTqOp9f
         mkJsZKDAeoLHoBKaM+Si363krodN9OICqaQu7l7r9eTh1AJG7aAB26ZZNHOkt5yC8VKt
         roRmX7xDlo7iPV5W7OLnSMGAIPoahGUIQOm8UQcCx5KIZ+LdY9Yxea10NdkixWuaA2FA
         cvtbXXQg3FD7IA7/3J0M9o79NL/O70qJPwN+hHMaJ56p8gJmhjJesW9/N7SPa61KkTf9
         /MdXUWVVbi4Zzm5vrj1L1wt3TIGmWQhHHe1T+pU6eL7BLrzppqYzQ+T7/y/VqcMr86Q5
         LEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2M+53OJgQ5NI2pDkE4sAYnMOh49d/aNJ2k94wOnKpLg=;
        b=UtS9q5XNe6HccoNW1/5ZFQrSh5BSDcQYfhBhpXEXJun57d9zjrzCd7M7nAxazi3Ju+
         J2AdKQ4dEzZwJKUBBTcCsWMr8gKutxsgoLfBilnHmz6i0fnW2XmDCbVsiBOjVNVNMC9v
         QymZZdRgtauQJ0G1uNIJ2DoN5F27NDYa4247eDOkJMXJumhR63/g59muOUrEDMLfvIBf
         ed/yhQD6VziKlk+xNot35JCGnLxedYK6iLOBISNt+vdIkVSznx4JuNiO6ClbrBWOFSJx
         jZ4I0N+D1tmit/e7g3PHcwjrYLYReKfXBEv6Ql2fx+Qpzm5PJZjm4qXNRZ5bR8FPDSMX
         PbXg==
X-Gm-Message-State: ACrzQf2wGIdZjA2igSkY8JFy7MnfC+29445UFwR+U50v6sOyB8w4xMfr
        i9WmpNZmrmR10Bfr93lbyFmVw83fRQblCA==
X-Google-Smtp-Source: AMsMyM42f6yJ+e3W52k/zP7yKN8BKANQDj3N644dlP5DfYq9kLw4qyCuH+tzw57E2uo1qAn4SUW3+g==
X-Received: by 2002:a17:906:7212:b0:7ad:bd4b:c41f with SMTP id m18-20020a170906721200b007adbd4bc41fmr16905306ejk.659.1667343109553;
        Tue, 01 Nov 2022 15:51:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/12] cmake: don't "mkdir -p" and "cd" in build instructions
Date:   Tue,  1 Nov 2022 23:51:25 +0100
Message-Id: <patch-v3-01.12-028fa1436d8-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "-S" and -B" flags instead of "mkdir -p" and "cd". The "-p"
flag to "mkdir" wasn't needed as "contrib/buildsystems" is tracked,
and the rest of this is now easier to copy/paste into a shell without
having one's directory changed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3957e4cf8cd..494da807c53 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -16,9 +16,7 @@ though, therefore the `File>Open>Folder...` option is preferred.
 
 Instructions to run CMake manually:
 
-    mkdir -p contrib/buildsystems/out
-    cd contrib/buildsystems/out
-    cmake ../ -DCMAKE_BUILD_TYPE=Release
+    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
 
 This will build the git binaries in contrib/buildsystems/out
 directory (our top-level .gitignore file knows to ignore contents of
@@ -36,8 +34,8 @@ NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual St
 this option is ignored
 
 This process generates a Makefile(Linux/*BSD/MacOS) , Visual Studio solution(Windows) by default.
-Run `make` to build Git on Linux/*BSD/MacOS.
-Open git.sln on Windows and build Git.
+Run `make -C contrib/buildsystems` to build Git on Linux/*BSD/MacOS.
+Open contrib/buildsystems/git.sln on Windows and build Git.
 
 NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
 to use another tool say `ninja` add this to the command line when configuring.
-- 
2.38.0.1280.g8136eb6fab2

