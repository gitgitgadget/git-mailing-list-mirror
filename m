Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AE2C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A9E613AE
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhFVKtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhFVKtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 06:49:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EE9C061756
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:46:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e22so19515628wrc.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iIHpID61+VRgX/A+OvxxbUV/OSl+bBqeTaBjmveStM8=;
        b=oDX3qnsu6+xRIyeB7ix1gzpNlyEsUB1iMkR3bLDcAuS/yDZCle96nKud9XzlhuhvIa
         vs8r+utmREtQmnNXUefe1zg+ILxlZ1+XJy7xV7hzYv4Row1hjLEj6557CgMnVZHKht+c
         JY0WT/V3SabFCJhSxEHpFjtEmg+aEyLG1fizq3Q59HZAuzVXqlRtIjyAoWo+3RF2VT0a
         aEbERArpVqbZdtbO52EXujHUTfoiv9ebLOmozVHNM+BLOhFWLMfI+2u87zHHC0Oa7rfr
         /egqmgUdyxR+wzPC7lFGY18oHku/lucn6YGLd5j7yS22SswaDXR4o4Ai82OwgWomh1Ue
         wwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iIHpID61+VRgX/A+OvxxbUV/OSl+bBqeTaBjmveStM8=;
        b=sAtWk/BbXWccct2XOVLpyudJWxik3i8ttLf0sFgAQrHQsYF44Mwbm7YieHmAInkgaI
         zFr0xFMz+4aXLC8drdgsHrBlAk0+XLNifr0KVpOq0Mfzo5Yzp5PgIS4tykViGb5DGhWb
         LnQSDNpvMylcO55Ne15YDb+Wgn7rw3SBKy/6ome3POSr/SoZ1sL8N8KaynNljt6R9Cjo
         0PN5zIKXNWOrOsZ4SwO9SxmMG65v+/co3w9GKgYSPvQj2AkbDJGJ0gXwjF2GhSpN8M/0
         03seqKsA0Xvbi8o600JPwEwd783EHyQubKxH/WqI2o1cQn9NuKT+XaotzXVy7VzpseDh
         mPvg==
X-Gm-Message-State: AOAM5316E5OKmL9qmmPzf4j7PkAAujEhau8fxGcX7NqUF+l+SH69obRD
        AkIBrGt9amOi5nHr5S0GKFhRnEnPz+M=
X-Google-Smtp-Source: ABdhPJwZWOmPTgVGpRAnzf60PBBR5zVQtxNbb7OySo7GmK0grRXvPdcDOOOrau1w0dbXISaGElzZ3Q==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr3952480wrv.373.1624358810753;
        Tue, 22 Jun 2021 03:46:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e38sm1926951wmp.4.2021.06.22.03.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 03:46:50 -0700 (PDT)
Message-Id: <996316dc382dbe164ae40e8bcf2e61efa3581b62.1624358809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.984.git.1624358809.gitgitgadget@gmail.com>
References: <pull.984.git.1624358809.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 10:46:46 +0000
Subject: [PATCH 1/3] mingw: move Git for Windows' system config where users
 expect it
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows' prefix is `/mingw64/` (or `/mingw32/` for 32-bit
versions), therefore the system config is located at the clunky location
`C:\Program Files\Git\mingw64\etc\gitconfig`.

This moves the system config into a more logical location: the `mingw64`
part of `C:\Program Files\Git\mingw64\etc\gitconfig` never made sense,
as it is a mere implementation detail. Let's skip the `mingw64` part and
move this to `C:\Program Files\Git\etc\gitconfig`.

Side note: in the rare (and not recommended) case a user chooses to
install 32-bit Git for Windows on a 64-bit system, the path will of
course be `C:\Program Files (x86)\Git\etc\gitconfig`.

Background: During the Git for Windows v1.x days, the system config was
located at `C:\Program Files (x86)\Git\etc\gitconfig`. With Git for
Windows v2.x, it moved to `C:\Program Files\Git\mingw64\gitconfig` (or
`C:\Program Files (x86)\Git\mingw32\gitconfig`). Rather than fixing it
back then, we tried to introduce a "Windows-wide" config, but that never
caught on.

Likewise, we move the system `gitattributes` into the same directory.

Obviously, we are cautious to do this only for the known install
locations `/mingw64` and `/mingw32`; If anybody wants to override that
while building their version of Git (e.g. via `make prefix=$HOME`), we
leave the default location of the system config and gitattributes alone.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index cb443b4e023a..0587a23c1cb1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -437,6 +437,11 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
+ifeq (/mingw64,$(subst 32,64,$(prefix)))
+	# Move system config into top-level /etc/
+	ETC_GITCONFIG = ../etc/gitconfig
+	ETC_GITATTRIBUTES = ../etc/gitattributes
+endif
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -671,6 +676,11 @@ else
 		USE_LIBPCRE= YesPlease
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
+		ifeq (/mingw64,$(subst 32,64,$(prefix)))
+			# Move system config into top-level /etc/
+			ETC_GITCONFIG = ../etc/gitconfig
+			ETC_GITATTRIBUTES = ../etc/gitattributes
+		endif
 	else
 		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO
 		NO_CURL = YesPlease
-- 
gitgitgadget

