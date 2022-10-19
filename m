Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E739DC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 01:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJSBDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 21:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSBDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 21:03:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37D2DED38
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:03:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n12so26380588wrp.10
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UQAfRP+M4Ne8vgylcRWj1IvISeS+gGHOFLT5WttF7M=;
        b=aci2eLZEs3yIoJXU+SNZfpPPsZZeeqWnXykwQaZdB/J7QXgASi3pw3/O749+YM50e4
         ZL097mlvNE+LNwv12LL1TV7aRLwTStX1npFPAVN1EsMc611bErWJyHo4C9SeRFoMMcOp
         AORfp3WBARYIakqVPovUXRuIBzKc4dHhRXPxIk8qQyaTq3Y7d28IJBfoM9ZCaHks0y6a
         ZjSybSTGSw5UNww7lv/tMthEFtHHWa2hPS8/BBpj+3huNlqnIhVnX9kTYDrFgjYRfigc
         G7WYbzlhCT7/lNoeQ21aGonZNWeGmPW3geHdlxMrIay/IvfZpYQAEXzOvja/hgAEi9F4
         Z1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UQAfRP+M4Ne8vgylcRWj1IvISeS+gGHOFLT5WttF7M=;
        b=HfZtUtNIef8kypfINSrJazJiQPGvjujevMpyzFtpbxmKW7TwG7gQkOO1Q8rIcuAA6j
         V9jT6WC2kS7LW9fT9R0+5FqGTMp7xG3l6tMxXtO31D0uehfxeJr1N3eaByfSJ05Av+gz
         PL4hR/aV+tlhfWWD2Z3+2FYX1F+uYSk4OvPnjmcDLHA1Uh3U2XDY1Yj1Ta/M79oexm/2
         MokyzHo/Xy2t2WCCAxCPWOnyqo/L7QTydeY85ME9JphuW9rk8O/ib3vRdCZViph/vLG+
         Te/3FA/SSa6VEq/TErjvTPzbASPTr6cbQHXhuSt+eHsLDWgiGu5x9LFxf9x32oWcTxlP
         TwIA==
X-Gm-Message-State: ACrzQf38lqyzQRY7bfHPbJvYGNi3DMqUWcBxIHgZWNpmHdRxf6o/AHDc
        LC2FyxPskPgRh1SPrAJOBBVTDoNZzSjl6g==
X-Google-Smtp-Source: AMsMyM6xt2X7P0U2Si7tNxKXcvhCgcGqPc+4OGnoFm6Y5dvq+Haoge9JZIR8zF7pajKAoMHWfUAhwg==
X-Received: by 2002:adf:8bc5:0:b0:22e:3873:276d with SMTP id w5-20020adf8bc5000000b0022e3873276dmr3258981wra.402.1666141410998;
        Tue, 18 Oct 2022 18:03:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3-20020a056000136300b0022e3cba367fsm12161315wrz.100.2022.10.18.18.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:03:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] fsmonitor OSX: compile with DC_SHA1=YesPlease
Date:   Wed, 19 Oct 2022 03:03:19 +0200
Message-Id: <patch-v2-1.4-392fabdb456-20221019T010222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcd4a685f0b1
In-Reply-To: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we'll address in subsequent commits the "DC_SHA1=YesPlease" is not
on by default on OSX, instead we use Apple Common Crypto's SHA-1
implementation.

In 6beb2688d33 (fsmonitor: relocate socket file if .git directory is
remote, 2022-10-04) the build was broken with "DC_SHA1=YesPlease" (and
probably other non-"APPLE_COMMON_CRYPTO" SHA-1 backends).

So let's extract the fix for this from [1] to get the build working
again with "DC_SHA1=YesPlease". In addition to the fix in [1] we also
need to replace "SHA_DIGEST_LENGTH" with "GIT_MAX_RAWSZ".

1. https://lore.kernel.org/git/c085fc15b314abcb5e5ca6b4ee5ac54a28327cab.1665326258.git.gitgitgadget@gmail.com/

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/fsmonitor/fsm-ipc-darwin.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index ce843d63348..d67b0ee50d3 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -10,10 +10,10 @@ static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
 const char *fsmonitor_ipc__get_path(struct repository *r)
 {
 	static const char *ipc_path = NULL;
-	SHA_CTX sha1ctx;
+	git_SHA_CTX sha1ctx;
 	char *sock_dir = NULL;
 	struct strbuf ipc_file = STRBUF_INIT;
-	unsigned char hash[SHA_DIGEST_LENGTH];
+	unsigned char hash[GIT_MAX_RAWSZ];
 
 	if (!r)
 		BUG("No repository passed into fsmonitor_ipc__get_path");
@@ -28,9 +28,9 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
 		return ipc_path;
 	}
 
-	SHA1_Init(&sha1ctx);
-	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
-	SHA1_Final(hash, &sha1ctx);
+	git_SHA1_Init(&sha1ctx);
+	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
+	git_SHA1_Final(hash, &sha1ctx);
 
 	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
 
-- 
2.38.0.1093.gcd4a685f0b1

