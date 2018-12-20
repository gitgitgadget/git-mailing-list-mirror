Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63561F405
	for <e@80x24.org>; Thu, 20 Dec 2018 16:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbeLTQZW (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 11:25:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38677 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732881AbeLTQZV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 11:25:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so2387605wrw.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MrFYQJslRk8r5lzRDnw7Evz+RXhOag00S7sLo/OJ1Vk=;
        b=S2nktbZC2VJ95MagzYMfyjKsA1FFsHLvh/gJs/M9y7ZVW5chKFA6VkaDM6tDNp/HhK
         bPCtsqdKqS38KgllzAlxPHy/UXd2e/iJPB5s5TZlxvGQoFSqDO+s76ZKrSbneyXIyJqi
         W4fzov4MFbYI13QV/ye+6V1qGwxp/SCCjTpBnnocnF4KWMhp4xjLBnfHV+HlZKQTwJy4
         B0UcyO24PQX6YkdIy71JG5y+S1e5DAmnKpng2FXBn8zqLtexVa0QiEHAZ6IFzNomDak2
         WVtMOkObMnvKyx3uBDeV1J56A7E6UM4sbi+6HWwfsb0qx29BXalqWa4y+GwAk7rBueOS
         uJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MrFYQJslRk8r5lzRDnw7Evz+RXhOag00S7sLo/OJ1Vk=;
        b=cRomAOxa15PUmwkA6TtCd1GUgkvCAf44itPdd58OBTX88bgBHHAnMPQWDjinflTmO5
         W0oJJyxx9mvpl7q/iuwDdTm/PBGQB0KHmlZhCbsGGiK9uw7+rHhIUrEKFWN29Qw42vau
         4qgRnMUd32MQe0XLL9q//+ng+xiDPDPfl6MCxqVmEYbG6N9suWpBQcDhivmk1pwvxHO+
         hDomsRc4AlA8kZel1+L3TQ4j5sUb7hoy0cys9IqWW9iniFS/h/CD8PnG3vP0k9TqGLDv
         880pjD5689xb+WoPJIfl1SnkyV5GipcjJGtRDAiKl8TvEWJFmzDd7HypEDuXUerNIpQo
         FiLQ==
X-Gm-Message-State: AA+aEWZnoq0PKudy8Lj4JqktkiMuq6D9tAaPHDi2T9zK4jzVupyH7FtI
        KQQ91ZCqdGNiSJaGVTY+iak=
X-Google-Smtp-Source: AFSGD/WV31JyawkdbG6b509Td7hE7eX9gfERGdHEgiSdoktrBfuYewSkkOSZkQJdxZMoQySB4sbIrw==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr23945240wrs.279.1545323118910;
        Thu, 20 Dec 2018 08:25:18 -0800 (PST)
Received: from localhost.localdomain (x4db1e5de.dyn.telefonica.de. [77.177.229.222])
        by smtp.gmail.com with ESMTPSA id 200sm8980566wmw.31.2018.12.20.08.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 08:25:18 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/5] .gitignore: ignore external debug symbols from GCC on macOS
Date:   Thu, 20 Dec 2018 17:24:49 +0100
Message-Id: <20181220162452.17732-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181220162452.17732-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git is build with a "real" GCC on macOS [1], or at least with GCC
installed via Homebrew, and CFLAGS includes the '-g' option (and our
default CFLAGS does), then by default GCC writes the debug symbols
into external files under '<binary>.dSYM/' directories (e.g.
'git-daemon.dSYM/', 'git.dSYM/', etc.).

Update '.gitignore' to ignore these directories, so they don't clutter
the output of 'git status'.  Furthermore, these build artifacts then
won't trigger build failures on Travis CI via b92cb86ea1 (travis-ci:
check that all build artifacts are .gitignore-d, 2017-12-31) once one
of the following patches updates our CI build scripts to use a real
GCC in the 'osx-gcc' build job.

[1] On macOS the default '/usr/bin/gcc' executable is not a real GCC,
    but merely a compatibility wrapper around Clang:

      $ gcc --version
      Configured with: --prefix=<...>
      Apple LLVM version 9.0.0 (clang-900.0.39.2)
      <...>

    So even though 'make CC=gcc' does indeed execute a command called
    'gcc', in the end Git will be built with Clang all the same.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..a9db568712 100644
--- a/.gitignore
+++ b/.gitignore
@@ -229,3 +229,4 @@
 *.pdb
 /Debug/
 /Release/
+*.dSYM
-- 
2.20.1.151.gec613c4b75

