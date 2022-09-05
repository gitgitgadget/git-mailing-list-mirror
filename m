Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A34ECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbiIEI2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbiIEI1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E13AB01
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso7337982wmh.5
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f9lctbNeidCBl7w3aDxh66mufSyDtcg5s5Y3oLMpYwU=;
        b=gLnoP5v7J6v4cP0Y9GWP46+IW9nJD3ShxyjcwjFpC+1eycHfRznbyuVlB3mo8mU9KH
         weRz4eAbAY7ARjZVGYMLMikoO3NfaeCqshxfH0k6DXcLvosNAb0k3T4SsmobrjFDzNdg
         29lIw8yKvmPxNqCoGzU5fvbu2v7CigbEl6g+Ma3M2kdTAfuWmkjnFzJWJ+CGPGNXVqYb
         KQTbepv7lyxvdmCiuNmVBIUtX1tD2rQo4CKtkWMAUiWr4Yc3akXOvlwzlDvIXRu0GgUa
         QT8ZM9bU33PRfxV+nT8DUPBaUGABG3XqdZdptHA5R8sSU2f2ZeWxRLKltsO6jQXqxiiH
         c2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f9lctbNeidCBl7w3aDxh66mufSyDtcg5s5Y3oLMpYwU=;
        b=tjD+/WQGQTc3LWnUAzbUMhJuajgNT3bfZ3C/8iNdSy7RZFL8z0rO+NNflvZszzwayC
         0zjinAnfWjUzXlphNMxP2rl+xVzMqGFcJ4OpN2SFOur1vOsE2KPMn+CiNBWRk8ifE0Mi
         A/NssobedTDJiotwRdrmCKTGfObwy2Rc3UjTSbFgnc4gFE7XqvSTG/wldw9NAr58XpfU
         qulqbAAqXjgoaIv+Hy0hYne7RstVV3LAQ8vrrkWN0V/3mKGtQXrtoLLoPRmlGOl0mP6N
         6zp59PqCm5EaYiDBjKKs5NMl6bziv2xx5Z+/rfjKpitVutWV6xccjyGczXGBe/3BM60T
         F5tg==
X-Gm-Message-State: ACgBeo1jxnjVbSbJjkqqZkJzHrPGuWzKBKYob/531wGWxXr9fw38fkil
        QIkW99GOxoade6iGXc0ii2hxPwIM8EZ4nQ==
X-Google-Smtp-Source: AA6agR4erDqRfDLEPdkZEP0/wudusXcnMearwS7bOKUnmthEF3RH5rx7bM/kl2eaXHHFVIayOA1iDA==
X-Received: by 2002:a05:600c:35d0:b0:3a8:3f16:2c38 with SMTP id r16-20020a05600c35d000b003a83f162c38mr10477823wmq.162.1662366435229;
        Mon, 05 Sep 2022 01:27:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 24/34] doc txt & -h consistency: use "git foo" form, not "git-foo"
Date:   Mon,  5 Sep 2022 10:26:35 +0200
Message-Id: <patch-24.34-8cc52c68b67-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "git cmd" form instead of "git-cmd" for both "git
receive-pack" and "git credential-cache--daemon".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-receive-pack.txt | 2 +-
 builtin/credential-cache--daemon.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index eec1268b10f..92452334ac4 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -9,7 +9,7 @@ git-receive-pack - Receive what is pushed into the repository
 SYNOPSIS
 --------
 [verse]
-'git-receive-pack' <git-dir>
+'git receive-pack' <git-dir>
 
 DESCRIPTION
 -----------
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index d4eb0097d24..f3c89831d4a 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -267,7 +267,7 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 	const char *socket_path;
 	int ignore_sighup = 0;
 	static const char *usage[] = {
-		"git-credential-cache--daemon [--debug] <socket-path>",
+		"git credential-cache--daemon [--debug] <socket-path>",
 		NULL
 	};
 	int debug = 0;
@@ -305,7 +305,7 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 {
 	const char * const usage[] = {
-		"git credential-cache--daemon [options] <action>",
+		"git credential-cache--daemon [--debug] <socket-path>",
 		"",
 		"credential-cache--daemon is disabled in this build of Git",
 		NULL
-- 
2.37.3.1425.g73df845bcb2

