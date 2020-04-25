Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B111CC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8ED20661
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWeIM5vC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDYMy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDYMy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 08:54:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE97C09B04B
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 05:54:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so14822772wml.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xQ/Pv98vzlHiGQ0pBo5HXCSOw4kSZYRKY9BTEKh4Y4M=;
        b=nWeIM5vCV+NHwO2bMB555V0/pKwvK6YhOGtTt58MH2hHk5m8rdFqdaWiiYiSD121kE
         B0NcPSP0oREtyCzDppVtQ0vw2jj7EBj5qHMyM8XUe0jdGP1X3HDdPceMuHrbpupoSZ6C
         k9rxwiOiwVUhqxeQ9gOSoGOEgm0CpXx2O7OrUsnvcwARA5tvBjBpStGgYRh0HQTbkQKY
         ZMD+V9hzVXwnd3BNbiCamMT1jEz3eAgjVGNi0DlcbkWglwq1NaENk9c2DfZ7UxoqnF6a
         07fFOp10CZvuuYXuzWrLXSRag1PoD+weL/60KURaN336qRMbagnfmLkcjhMO1Ys/lnHv
         7UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xQ/Pv98vzlHiGQ0pBo5HXCSOw4kSZYRKY9BTEKh4Y4M=;
        b=Q07Vm0FG2vmtqZt4YUfn2T6z2RPCor2dJ6ipl4Ebvsuj71qT/qK8BbkMpPkumBJPZx
         BaH6ZCZ/WT+DshN4pjXxKXrsLcAW0fd45ybXBp0WcA+viYirw0Smp0F6pYSfxu78JbQZ
         rHy5MXxvVt9u87L1tLBvZTeIPBr8iVomQ5xGBRwnMG4hqXHPM2F4BPPlcdApq6n/Pcw/
         VrDV2fwwWLxguqY6rM9Sk0mHA1FH66MahEtOmr8DdUHdEXKL+9pU3XOii8beUXt/xP1k
         3sG4w5OxAOkPgbHcgI33ZtNAH0XQ038jObRu3zi9cyCSwjCaGkhqGmTCw55lHwXXlled
         6MOQ==
X-Gm-Message-State: AGi0PuZHa5E82K3PsApIxaz8uFV1FunJbQyB/x/t/j1xcGFsywsdD5FK
        IBGoO8jq+mEjk15Ov1HkwX9+NOLN
X-Google-Smtp-Source: APiQypK5VbzVTegYs3vVAalSkfkBm6ndNuqI8pDwfWxp5RBC8Dat3UrL+RE/KptWeDTYeJtacoNAVQ==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr16434592wml.45.1587819267432;
        Sat, 25 Apr 2020 05:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm7614887wmi.0.2020.04.25.05.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 05:54:26 -0700 (PDT)
Message-Id: <pull.616.v2.git.1587819266388.gitgitgadget@gmail.com>
In-Reply-To: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Apr 2020 12:54:26 +0000
Subject: [PATCH v2] macos: do let the build find the gettext
 headers/libraries/msgfmt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Apparently a recent Homebrew update now installs `gettext` into a
subdirectory under /usr/local/, requiring the CFLAGS/LDFLAGS to list
explicit directories _even_ when asking to force-link the `gettext`
package.

Likewise, the `msgfmt` tool is no longer in the `PATH`.

While it is unclear which change is responsible for this breakage (that
most notably only occurs on CI build agents that updated very recently),
https://github.com/Homebrew/homebrew-core/pull/53489 should fix it.

Nevertheless, let's work around this issue, as there are still quite a
few build agents out there that need some help in this regard: we
explicitly do not call `brew update` in our CI/PR builds anymore.

Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Prepare for Homebrew changing the gettext package
    
    In an early Azure Pipelines preview of what is to come, I saw the 
    osx-clang and osx-gcc jobs fail consistently.
    
    This patch tries to prevent that from affecting our CI/PR builds.
    
    Changes since v1:
    
     * Described a bit better what the issue is, and that there is a
       "de-keg" change that should fix this (but as we no longer call brew
       update, some build agents, that won't matter for slightly out of date
       agents).
     * Guarded the added flags behind a check whether the directory exists
       in the first place.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-616%2Fdscho%2Fbrew-gettext-update-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-616/dscho/brew-gettext-update-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/616

Range-diff vs v1:

 1:  c56a2321f62 ! 1:  1aa1b049e5c macos: do let the build find the gettext headers/libraries/msgfmt
     @@ Commit message
      
          Likewise, the `msgfmt` tool is no longer in the `PATH`.
      
     -    Let's work around this issue.
     +    While it is unclear which change is responsible for this breakage (that
     +    most notably only occurs on CI build agents that updated very recently),
     +    https://github.com/Homebrew/homebrew-core/pull/53489 should fix it.
      
     +    Nevertheless, let's work around this issue, as there are still quite a
     +    few build agents out there that need some help in this regard: we
     +    explicitly do not call `brew update` in our CI/PR builds anymore.
     +
     +    Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
     @@ config.mak.uname: ifeq ($(uname_S),Darwin)
       	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
      -	BASIC_CFLAGS += -I/usr/local/include
      -	BASIC_LDFLAGS += -L/usr/local/lib
     -+	BASIC_CFLAGS += -I/usr/local/include -I/usr/local/opt/gettext/include
     -+	BASIC_LDFLAGS += -L/usr/local/lib -L/usr/local/opt/gettext/lib
     -+	ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
     -+		MSGFMT = /usr/local/opt/gettext/bin/msgfmt
     ++
     ++	# Workaround for `gettext` being keg-only and not even being linked via
     ++	# `brew link --force gettext`, should be obsolete as of
     ++	# https://github.com/Homebrew/homebrew-core/pull/53489
     ++	ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
     ++		BASIC_CFLAGS += -I/usr/local/include -I/usr/local/opt/gettext/include
     ++		BASIC_LDFLAGS += -L/usr/local/lib -L/usr/local/opt/gettext/lib
     ++		ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
     ++			MSGFMT = /usr/local/opt/gettext/bin/msgfmt
     ++		endif
      +	endif
       endif
       ifeq ($(uname_S),SunOS)


 config.mak.uname | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 0ab8e009383..1ea16e89288 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -133,8 +133,17 @@ ifeq ($(uname_S),Darwin)
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
-	BASIC_CFLAGS += -I/usr/local/include
-	BASIC_LDFLAGS += -L/usr/local/lib
+
+	# Workaround for `gettext` being keg-only and not even being linked via
+	# `brew link --force gettext`, should be obsolete as of
+	# https://github.com/Homebrew/homebrew-core/pull/53489
+	ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
+		BASIC_CFLAGS += -I/usr/local/include -I/usr/local/opt/gettext/include
+		BASIC_LDFLAGS += -L/usr/local/lib -L/usr/local/opt/gettext/lib
+		ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
+			MSGFMT = /usr/local/opt/gettext/bin/msgfmt
+		endif
+	endif
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease

base-commit: e870325ee8575d5c3d7afe0ba2c9be072c692b65
-- 
gitgitgadget
