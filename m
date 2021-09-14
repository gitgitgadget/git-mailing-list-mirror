Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52DC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 07:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46A2610E6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 07:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbhINH1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbhINH1g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 03:27:36 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62391C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 00:26:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b64so13776756qkg.0
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBSw8XwOL5FGrDuxMlZDSuYJB8nW1nvDjmIyTojcJDA=;
        b=lwYSq2m2+xYtzVOgWiNILk/7Jahf85bHQV4faxOf9S9+LL+2wn0EK1lY0vKLecaa5q
         KEPccbIJU3RaaBWcsph9mvEZhxc+OiV086Euj+KmQTp9eWdwsEF2MVPWjr12fgN64pId
         GwO+Ix1qUWu5XDXr9PYJ0Vc6gh0v6c7nLPQlvkSFcJ4uzbgCqjdlDEYk8klth0S6ICDw
         4TUdqlEvl+2L96izkLru2L0/snzjGW7ivZ5HvyNns7w4gQkeGcIc0/yVCAe870n+TQMQ
         ceyUvvkUZyMS69O2ERbgkgkAk1Odtk5iyH0xJKeh0wAsx5h/IN85j7bjRmBOuO3u34Jb
         tHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBSw8XwOL5FGrDuxMlZDSuYJB8nW1nvDjmIyTojcJDA=;
        b=ZK+9Y3DRTlYaXQpuVwaiOgcIzUKMUd7dBYgjk1/mUkpanJEMF9pgC1905zZsrgpR5u
         TEVLLtcaj9KrO79edF+Z2HQcT+QmzfFc3dxXrJk+RI8YC2GIJLa38gxkiKV7DpCau3x5
         /ORM9b/i7XZ2pLwf6jA9KSONmkAJwQ0kq+tnk6OUi5gBs3PiAaDR5rhrdsdWSHc5ZODy
         FnnY8yKhsBACglR+9j5P1F+hmUTyq6Ji6B4SR6j3D/JdpwibYR5ZBlr9f6nMy7UGWT/2
         rBgq7dI+C8mzZf4Us9D+p5Igwr/40CLuq4DBz7YvMb5gTt51YsI+fqgvCyITXBcV6dCr
         dkJg==
X-Gm-Message-State: AOAM532G5kGpYUpQ1B1n/SiS03eQDn5Bb+wL1BTS4z5EjhscE+t4XEHs
        Cu+PshbJBoySuLnP+7NGyWb1bn8I5AI=
X-Google-Smtp-Source: ABdhPJy+5FZn166uSEVoH+Oz8z0hRNaxkuOP+vkDkUOQDwEfUsaVPuG36Cpwc62mP13vbzcczsU8nQ==
X-Received: by 2002:a37:781:: with SMTP id 123mr3683541qkh.193.1631604378345;
        Tue, 14 Sep 2021 00:26:18 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o12sm5486554qtt.94.2021.09.14.00.26.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:26:18 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 1/3] t0301: fixes for windows compatibility
Date:   Tue, 14 Sep 2021 00:25:58 -0700
Message-Id: <20210914072600.11552-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210914072600.11552-1-carenas@gmail.com>
References: <20210913085600.35506-1-carenas@gmail.com>
 <20210914072600.11552-1-carenas@gmail.com>
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

`mkdir -m` can't represent a valid ACL directly and fails with
permission problems, so instead call mkdir followed by chmod, which
has been enhanced to do so.

The last invocation of mkdir would likely need the same treatment
but SYMLINK is unlikely to be enabled on Windows so it has been
punted for now.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v3:
* avoid using a variable to hold the function for testing and instead
  use the cleaner syntax suggested by Dscho
v2:
* avoid the confusing -f test as suggested by Bagas
* no more FLAG variable as suggested by Junio

 t/t0301-credential-cache.sh | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index ebd5fa5249..698b7159f0 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -9,6 +9,21 @@ test -z "$NO_UNIX_SOCKETS" || {
 	test_done
 }
 
+uname_s=$(uname -s)
+case $uname_s in
+*MINGW*)
+	test_path_is_socket () {
+		# `test -S` cannot detect Win10's Unix sockets
+		test_path_exists "$1"
+	}
+	;;
+*)
+	test_path_is_socket () {
+		test -S "$1"
+	}
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
+	test_path_is_socket "$HOME/.cache/git/credential/socket"
 '
 
 XDG_CACHE_HOME="$HOME/xdg"
@@ -31,7 +46,7 @@ helper_test cache
 
 test_expect_success "use custom XDG_CACHE_HOME if set and default sockets are not created" '
 	test_when_finished "git credential-cache exit" &&
-	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
+	test_path_is_socket "$XDG_CACHE_HOME/git/credential/socket" &&
 	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
 	test_path_is_missing "$HOME/.cache/git/credential/socket"
 '
@@ -48,7 +63,7 @@ test_expect_success 'credential-cache --socket option overrides default location
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/dir/socket"
+	test_path_is_socket "$HOME/dir/socket"
 '
 
 test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
@@ -62,7 +77,7 @@ test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/.cache/git/credential/socket" &&
+	test_path_is_socket "$HOME/.cache/git/credential/socket" &&
 	XDG_CACHE_HOME="$HOME/xdg" &&
 	export XDG_CACHE_HOME &&
 	check approve cache <<-\EOF &&
@@ -71,7 +86,7 @@ test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$XDG_CACHE_HOME/git/credential/socket"
+	test_path_is_socket "$XDG_CACHE_HOME/git/credential/socket"
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
+	test_path_is_socket "$HOME/.git-credential-cache/socket"
 '
 
 test_expect_success SYMLINKS 'use user socket if user directory is a symlink to a directory' '
@@ -103,7 +119,7 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/.git-credential-cache/socket"
+	test_path_is_socket "$HOME/.git-credential-cache/socket"
 '
 
 helper_test_timeout cache --timeout=1
-- 
2.33.0.481.g26d3bed244

