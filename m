Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFCFC433FE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 20:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1C66108B
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhILUa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhILUa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 16:30:27 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0E6C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 13:29:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id h133so11407081oib.7
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmNtHSy/GMWWSWYyuN31Hdw6EpmaUMUo5lKryn4UC8I=;
        b=G+3AGOZHaoSWn4H5y+kPiyIzUtWkrEy04g2xNGoGEuKjonbpSK25sqMPrQE9AYhbwL
         AzAMzjBBLRYx2Oo/pbT+PJhb/GfJJFdBoZOBNQI0k4C3J2CGEu8L8Yf+ji6HSruE3Iyf
         SN/Eh0HWQIeOKGHDsAKMABSFOXA3FsbjgMiODLLO7UJ6ncw8QYuA9r2iPUwWzZtOREaa
         3JlGjOV38/ICrzLcwiBbziy4/yWnUCDLCGNc2ers28tf4VYwNGCOeDmdUs3NNoYKzbNU
         zuZj/fQ7RB9NfAk14qsdmXfQlA3oPAb1JXgF1Mc23iLya3GOUO0X7OcsBkiHb0ELw5ME
         eV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmNtHSy/GMWWSWYyuN31Hdw6EpmaUMUo5lKryn4UC8I=;
        b=AcC1/U4LxJkAdBfhSByxq1PJMNh3TjKYfsJqcKxPj2aWMwdhfDql5TdHXyhLkUwYSx
         EoIcq+45ZdSSlgfafaxzu39W+/VU7tYA+msndJCIE7/AMpC87BdUJ8flB+9O+Jde48Wj
         pmKYzIeLXT0zYMIa89F1G7nDdn+1HaManJTTzdlRhkZyuWkpBPodkWxn0EVRHXvjYoEH
         carHtAxKBzQIPSoAFGp3tCZZU8Fr2kK8g5Z/tnIW9+6ZhyD0BcGNFRZQRp47aGSwuX8F
         O4gs7ODQPZ2cfpke4LM9P/c/FJa+jFRUOraubSYfqzGAvrLIszz6IKrydwxFGhKxhZKb
         4Jwg==
X-Gm-Message-State: AOAM531I05Qfs5j2psD6zQnSfrIBhkj66i8Ey54s9qc7hu/ZCzMXi7Ef
        gIYfxyyUp49YU025TavrfoTi5V8d01A=
X-Google-Smtp-Source: ABdhPJyT2rXKFyvWM5ZvVWneScWw48zn6i+MfKgrNOAshIEOM3zscbm72Uf/cY+0lXRXb/Ln68h0Cw==
X-Received: by 2002:aca:2206:: with SMTP id b6mr5292105oic.88.1631478552541;
        Sun, 12 Sep 2021 13:29:12 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w9sm1345162oti.35.2021.09.12.13.29.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Sep 2021 13:29:12 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     lehmacdj@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] t0301: fixes for windows compatibility
Date:   Sun, 12 Sep 2021 13:28:28 -0700
Message-Id: <20210912202830.25720-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210912202830.25720-1-carenas@gmail.com>
References: <20210912202830.25720-1-carenas@gmail.com>
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
test -f instead.

`mkdir -m` will always fail with permission problems, so instead
call mkdir followed by chmod.

The last invocation of mkdir would likely need the same treatment
but SYMLINK is unlikely to be enabled on Windows so it has been
punted for now.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0301-credential-cache.sh | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index ebd5fa5249..f5cce6c6a6 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -9,6 +9,17 @@ test -z "$NO_UNIX_SOCKETS" || {
 	test_done
 }
 
+# in Windows, Unix Sockets look just like regular files
+uname_s=$(uname -s)
+case $uname_s in
+*MINGW*)
+	FLAG=-f
+	;;
+*)
+	FLAG=-S
+	;;
+esac
+
 # don't leave a stale daemon running
 test_atexit 'git credential-cache exit'
 
@@ -21,7 +32,7 @@ test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
 		rmdir -p .cache/git/credential/
 	" &&
 	test_path_is_missing "$HOME/.git-credential-cache" &&
-	test -S "$HOME/.cache/git/credential/socket"
+	test $FLAG "$HOME/.cache/git/credential/socket"
 '
 
 XDG_CACHE_HOME="$HOME/xdg"
@@ -31,7 +42,7 @@ helper_test cache
 
 test_expect_success "use custom XDG_CACHE_HOME if set and default sockets are not created" '
 	test_when_finished "git credential-cache exit" &&
-	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
+	test $FLAG "$XDG_CACHE_HOME/git/credential/socket" &&
 	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
 	test_path_is_missing "$HOME/.cache/git/credential/socket"
 '
@@ -48,7 +59,7 @@ test_expect_success 'credential-cache --socket option overrides default location
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/dir/socket"
+	test $FLAG "$HOME/dir/socket"
 '
 
 test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
@@ -62,7 +73,7 @@ test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/.cache/git/credential/socket" &&
+	test $FLAG "$HOME/.cache/git/credential/socket" &&
 	XDG_CACHE_HOME="$HOME/xdg" &&
 	export XDG_CACHE_HOME &&
 	check approve cache <<-\EOF &&
@@ -71,7 +82,7 @@ test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$XDG_CACHE_HOME/git/credential/socket"
+	test $FLAG "$XDG_CACHE_HOME/git/credential/socket"
 '
 
 test_expect_success 'use user socket if user directory exists' '
@@ -79,14 +90,15 @@ test_expect_success 'use user socket if user directory exists' '
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
+	test $FLAG "$HOME/.git-credential-cache/socket"
 '
 
 test_expect_success SYMLINKS 'use user socket if user directory is a symlink to a directory' '
@@ -103,7 +115,7 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
 	username=store-user
 	password=store-pass
 	EOF
-	test -S "$HOME/.git-credential-cache/socket"
+	test $FLAG "$HOME/.git-credential-cache/socket"
 '
 
 helper_test_timeout cache --timeout=1
-- 
2.33.0.481.g26d3bed244

