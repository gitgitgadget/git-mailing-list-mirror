Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F3C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 18:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23C220663
	for <git@archiver.kernel.org>; Fri, 22 May 2020 18:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmhdyuhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgEVSm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgEVSmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 14:42:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB873C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 11:42:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so3226084pju.3
        for <git@vger.kernel.org>; Fri, 22 May 2020 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8+RBYZpD8wmCFUHX4EO7ofGrL4ChRwiG/YXheoNar4=;
        b=hmhdyuhR23zD5SDhwC6JKoS55xIGbSehXFWN5F7oxjQ+iSlijtoVpNEHfYVgB1x18j
         WKQ1dNtBqCf65jbwzommo2uHYo9ZbgYAPjd4t9aZ0yM/9w93pcqZUQJgHc+EFA5bGeoV
         8m59PLZ61z3Wl2aYel21lrARumX5donzHNVO3rq5xyidmf3kes/6xA18ZsblKUNAhCAr
         S53uc5GiGj1ZfBpnz3LgQ09CUhNg5B3f3aeJfqaTh4PzFjBjSKH4bB+TQrk99OG1Ms4t
         iBGzptMu1jcoCWxOEBb5S3uzDkT/fXAx2D+O6694aVB3AM9OQoObay4B1AmxLzpxBeK6
         Gh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8+RBYZpD8wmCFUHX4EO7ofGrL4ChRwiG/YXheoNar4=;
        b=PHnOKoNBijIbAoSxxMqk5t+an4lKUOL/JbkvxwE1ngL71gkv4VF3s+scxKg52+k0gR
         r8CEjbG3OQlLiovEEN2PeZ+F5WHJau/d83vc+LcO2AQWZ4edLFJHVHeL0QZZo9UplokI
         O+63RiClEvL3YR9KgpyYm3MDHZf5K93/ujJVbhb4poQEX2+jUxQsFSnbvxbPvzhGHZ7x
         ZhOyJ5Ht91a0nUVWVOeA6/o3e8U1jDnt6EhMIFJAlGu5quAssScEgfCseX6trnKjGBDc
         ryoWRirTCskpbFWjDeAZjn0E0/83bA1/liOgjSTKgkAfIP1ATMfZcphodCXsIAZCd4Sb
         K7QQ==
X-Gm-Message-State: AOAM531l0w2xpppQz54CIN5CJ0AqXbiZKSWJjwkZTXIYfbETTiDqHLV3
        vKoHm/WxSxHSSTmVI+zdmomlCkTw
X-Google-Smtp-Source: ABdhPJwu9o68fYQ0+tuxggnltTlslhNCKOWX2jTs28bYjJYXmsQs90SQpCNYshantm46ndtnYPWTmg==
X-Received: by 2002:a17:90a:1542:: with SMTP id y2mr1142665pja.158.1590172943980;
        Fri, 22 May 2020 11:42:23 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id x191sm3569845pfd.37.2020.05.22.11.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 11:42:23 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] t5608: avoid say() and use "skip_all" instead for consistency
Date:   Fri, 22 May 2020 11:42:14 -0700
Message-Id: <20200522184214.40321-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.207.gb85828341f
In-Reply-To: <20200521230510.13077-1-carenas@gmail.com>
References: <20200521230510.13077-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Printing a message directly to stdout could affect TAP processing
and is not really needed, as there is a standard way to skip all
tests that could be used instead, while printing an equivalent
message.

While at it; update the message to better reflect that since
a85efb5985 (t5608-clone-2gb.sh: turn GIT_TEST_CLONE_2GB into a bool,
2019-11-22), the enabling variable should be a recognized boolean
(ex: true, false, 1, 0) and get rid of the prerequisite that used
to guard all the tests, since "skip_all" is just much faster and
idempotent.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
* improved commit message (per Johannes)

 t/t5608-clone-2gb.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index eee0842888..4c476d2fa1 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -5,12 +5,11 @@ test_description='Test cloning a repository larger than 2 gigabyte'
 
 if ! test_bool_env GIT_TEST_CLONE_2GB false
 then
-	say 'Skipping expensive 2GB clone test; enable it with GIT_TEST_CLONE_2GB=t'
-else
-	test_set_prereq CLONE_2GB
+	skip_all='expensive 2GB clone test; enable with GIT_TEST_CLONE_2GB=true'
+	test_done
 fi
 
-test_expect_success CLONE_2GB 'setup' '
+test_expect_success 'setup' '
 
 	git config pack.compression 0 &&
 	git config pack.depth 0 &&
@@ -38,13 +37,13 @@ test_expect_success CLONE_2GB 'setup' '
 
 '
 
-test_expect_success CLONE_2GB 'clone - bare' '
+test_expect_success 'clone - bare' '
 
 	git clone --bare --no-hardlinks . clone-bare
 
 '
 
-test_expect_success CLONE_2GB 'clone - with worktree, file:// protocol' '
+test_expect_success 'clone - with worktree, file:// protocol' '
 
 	git clone "file://$(pwd)" clone-wt
 
-- 
2.27.0.rc1.207.gb85828341f

