Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A373AC4320A
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D3A61075
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhHSRRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhHSRRP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 13:17:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB8CC06175F
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:16:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q11so10175051wrr.9
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q1b8hDmG3RfqlEeT+EHy5o265zi80OIjE3QpS5pO4/Y=;
        b=YqlUGFsU9Xq9+gA8pJiJXti/oxzXWpRexXW8IUsOEdDwUFc0DX1Q/WoJwCF5G8IvEt
         OuUBRQF3Q9uwgXcTH5LwzuCHN4ub19VmjPZWSk0YjsKx5fBhEIDc2DcvWoirlouKjs41
         dtqNSDDVQVpBCP2ftQ9YhiYHc51n/avJLzyq+EcPzxjyh2JfZvbCZYgG6hmz55nesMCS
         74D3iB0mn1HzE8HYaqom5JwgnRa9ozZpDJbr/p96IdGvn3Reb4x4aLS0oW4dHDFSyDyM
         bcZwMKm828S8LGHQiWetYasIxTyqZYGLq9IERG/V0g3M8nBwZhPmqxDWjnzwbHxVp9js
         8izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q1b8hDmG3RfqlEeT+EHy5o265zi80OIjE3QpS5pO4/Y=;
        b=FaDT7e2//22PjAurWU5YVkwr770i9ee1Gos+fP8jiSPkMwhStGd9n0QCDJYthqTY/M
         +vvxzYXhoo0hJLZ6Tihr/nq9Z9IgejHecfsaPMNRsP5ZPDeJDCwg3yXK/iZxuOIjEOo0
         B2DVMVzBH//P0lejyS3rdkYLvzE5Vxi/rAEQse+x0HjUhotxk6XqTAm22aeDaFn6sAsP
         3Bnu+b2uYEfilKdCu4j2EvjAhx9SqBjGFf0u8PpP5KZ3eHDhxTTjBlpTlnjsVI8taly1
         0wmyRZMNbjeNTv2dy6nGaN5/3RPxO9QweaDUVRH/HS6co30b3ZVlsSIWp+XK2JDGggNW
         x2NQ==
X-Gm-Message-State: AOAM532srdySxiiHGt4qef5VW6MjtFeahQFyp255kfQIt+dlhTaZ9wM9
        oyy4IZNNQuMR3COmy+oWp72U99XCRJ4=
X-Google-Smtp-Source: ABdhPJwWvCg0wHs2ASG72MtgwH9k3maKz4TNDNtk2ctKWN19r4iRjmA2LaEro0V0/a71wQiu1Ygwnw==
X-Received: by 2002:adf:979d:: with SMTP id s29mr5141823wrb.264.1629393397653;
        Thu, 19 Aug 2021 10:16:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm3414030wrx.38.2021.08.19.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:16:37 -0700 (PDT)
Message-Id: <bf916ad98ccc1526f5298d1c3e1740cabad093af.1629393395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Aug 2021 17:16:34 +0000
Subject: [PATCH 1/2] test-lib-functions: use user's SHELL, HOME and TERM for
 'test_pause'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The 'test_pause' function, which is designed to help interactive
debugging and exploration of tests, currently inherits the value of HOME
and TERM set by 'test-lib.sh': HOME="$TRASH_DIRECTORY" and TERM=dumb. It
also invokes the shell defined by SHELL_PATH, which defaults to /bin/sh.

Changing the value of HOME means that any customization configured in a
developers' shell startup files and any Git aliases defined in their
global Git configuration file are not available in the shell invoked by
'test_pause'.

Changing the value of TERM to 'dumb' means that colored output
is disabled for all commands in that shell.

Using /bin/sh as the shell invoked by 'test_pause' is not ideal since
some platforms (i.e. Debian and derivatives) use Dash as /bin/sh, and
this shell is usually compiled without readline support, which makes for
a poor interactive command line experience.

To make the interactive command line experience in the shell invoked by
'test_pause' more pleasant, save the values of HOME and TERM in
USER_HOME and USER_TERM before changing them in test-lib.sh, and use
these variables to invoke the shell in 'test_pause'. Also, invoke SHELL
instead of SHELL_PATH, so that developer's interactive shell is used.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 t/test-lib.sh           | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e28411bb75a..662cfc4c3e0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -139,7 +139,7 @@ test_tick () {
 # Be sure to remove all invocations of this command before submitting.
 
 test_pause () {
-	"$SHELL_PATH" <&6 >&5 2>&7
+	TERM="$USER_TERM" HOME="$USER_HOME" "$SHELL" <&6 >&5 2>&7
 }
 
 # Wrap git with a debugger. Adding this to a command can make it easier
diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d61..132618991e2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -585,8 +585,9 @@ else
 	}
 fi
 
+USER_TERM="$TERM"
 TERM=dumb
-export TERM
+export TERM USER_TERM
 
 error () {
 	say_color error "error: $*"
@@ -1380,9 +1381,10 @@ then
 fi
 
 # Last-minute variable setup
+USER_HOME="$HOME"
 HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
-export HOME GNUPGHOME
+export HOME GNUPGHOME USER_HOME
 
 # Test repository
 rm -fr "$TRASH_DIRECTORY" || {
-- 
gitgitgadget

