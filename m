Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3ADC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852A760FBF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbhIMI5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbhIMI5p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 04:57:45 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447E0C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 01:56:30 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id w9so5565723qvs.12
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTlyFSc3JDK1hmbg2FuCO4DgQxRbXW/SyuP028wIBEA=;
        b=ZqbD8AtxmdJOZJH1Fgqo+oyOAVyzwotKzB+4ILlOf2ibqQqTytQGrvtcp18pUaZXCK
         EnB3zl16WRG4xxrM0vjSw5m2Ua8UMBrOqpN+OYFAerkYCUEXVTrsIeRWsDQkRst6dDUb
         LhLUZFwr2JvwXKXp6Ao6ohoDToy4APQu3+hchDBXvqs+gCXjKulO6rWr2ooHzU/SN2+G
         p6EZIUoOXUiCmEiEdHV+ghr4KakrMKfRqXxNzyCAAXa6HWAj5Ghv282zpY5FbVhB9zeo
         9VA+PrqctpAGNrRX/bQ98jE/pd3Jv0hcF7Z0S0j1Z1LM0Xm85/vkEpSuOhdtRPHn4mYY
         Xu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTlyFSc3JDK1hmbg2FuCO4DgQxRbXW/SyuP028wIBEA=;
        b=k4EcZIO4OXP9ARXLzLevSPuvudOVpgN4CSj9qk30cIImPwFE7i5MktJcTITRx4xhfo
         BGlqvEIT8waVHuj31I4+zCRo0vRqf9hpsSWITYK36LEgqFqKShLwrRiPq50kdwXRIT9v
         3hXFTBOoh1iUdB5p7NlHIMni4PpxUtPsV9yKxYcBKVn1HA1sXxDcC2phgTn7fShRQSIk
         Kbjzk2J+IL4tLIBeSdltjrKyV9cGZL6SA7ikI0t6OdVSHdA2KyLJ3SQFv0VcVnuc6/Vx
         62Xxk/QSw4lcwrjQcVge7styankCY5GYHulAMPDtIGfKvTNqNFIMpo97Uk9XP7OOxjM1
         J2SA==
X-Gm-Message-State: AOAM530f4JJoVV2hNdAYz3hWiwiQ5KuaOEYxmwlAKL9Y8jIWyOd9n6wy
        o8yk7tkinT1B3QZMXrDdbgmlKJ775ik=
X-Google-Smtp-Source: ABdhPJxSC9kORUEpad0wsNwxGpHROVHfhHVrdt1SrHmz8Dr5+KGoeFhCpVQbsA/RnvclggoAnfcsjw==
X-Received: by 2002:ad4:46ab:: with SMTP id br11mr8325670qvb.15.1631523389247;
        Mon, 13 Sep 2021 01:56:29 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q10sm4994321qke.108.2021.09.13.01.56.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 01:56:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 1/3] t0301: fixes for windows compatibility
Date:   Mon, 13 Sep 2021 01:55:58 -0700
Message-Id: <20210913085600.35506-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210913085600.35506-1-carenas@gmail.com>
References: <20210912202830.25720-1-carenas@gmail.com>
 <20210913085600.35506-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a future patch that will allow building with
Unix Sockets in Windows, workaround a couple of issues from the
Mingw-W64 compatibility layer.

test -S is not able to detect that a file is a socket, so use
test -e instead (through a library function).

`mkdir -m` will always fail with permission problems, so instead
call mkdir followed by chmod.

The last invocation of mkdir would likely need the same treatment
but SYMLINK is unlikely to be enabled on Windows so it has been
punted for now.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
* avoid the confusing -f test as suggested by Bagas
* try to help casual readers as suggested by Junio

 t/t0301-credential-cache.sh | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index ebd5fa5249..1f7b1e29e6 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -9,6 +9,21 @@ test -z "$NO_UNIX_SOCKETS" || {
 	test_done
 }
 
+test_path_is_socket () {
+	test -S "$1"
+}
+
+# in Windows, Unix Sockets look just like regular files
+uname_s=$(uname -s)
+case $uname_s in
+*MINGW*)
+	test_socket_exist=test_path_exists
+	;;
+*)
+	test_socket_exist=test_path_is_socket
+	;;
+esac
+
 # don't leave a stale daemon running
 test_atexit 'git credential-cache exit'
 
@@ -21,7 +36,7 @@ test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
 		rmdir -p .cache/git/credential/
 	" &&
 	test_path_is_missing "$HOME/.git-credential-cache" &&
-	test -S "$HOME/.cache/git/credential/socket"
+	$test_socket_exist "$HOME/.cache/git/credential/socket"
 '
 
 XDG_CACHE_HOME="$HOME/xdg"
@@ -31,7 +46,7 @@ helper_test cache
 
 test_expect_success "use custom XDG_CACHE_HOME if set and default sockets are not created" '
 	test_when_finished "git credential-cache exit" &&
-	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
+	$test_socket_exist "$XDG_CACHE_HOME/git/credential/socket" &&
 	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
 	test_path_is_missing "$HOME/.cache/git/credential/socket"
 '
@@ -48,7 +63,7 @@ test_expect_success 'credential-cache --socket option overrides default location
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/dir/socket"
+	$test_socket_exist "$HOME/dir/socket"
 '
 
 test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
@@ -62,7 +77,7 @@ test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/.cache/git/credential/socket" &&
+	$test_socket_exist "$HOME/.cache/git/credential/socket" &&
 	XDG_CACHE_HOME="$HOME/xdg" &&
 	export XDG_CACHE_HOME &&
 	check approve cache <<-\EOF &&
@@ -71,7 +86,7 @@ test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$XDG_CACHE_HOME/git/credential/socket"
+	$test_socket_exist "$XDG_CACHE_HOME/git/credential/socket"
 '
 
 test_expect_success 'use user socket if user directory exists' '
@@ -79,14 +94,15 @@ test_expect_success 'use user socket if user directory exists' '
 		git credential-cache exit &&
 		rmdir \"\$HOME/.git-credential-cache/\"
 	" &&
-	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
+	mkdir -p "$HOME/.git-credential-cache/" &&
+	chmod 700 "$HOME/.git-credential-cache/" &&
 	check approve cache <<-\EOF &&
 	protocol=https
 	host=example.com
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/.git-credential-cache/socket"
+	$test_socket_exist "$HOME/.git-credential-cache/socket"
 '
 
 test_expect_success SYMLINKS 'use user socket if user directory is a symlink to a directory' '
@@ -103,7 +119,7 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/.git-credential-cache/socket"
+	$test_socket_exist "$HOME/.git-credential-cache/socket"
 '
 
 helper_test_timeout cache --timeout=1
-- 
2.33.0.481.g26d3bed244

