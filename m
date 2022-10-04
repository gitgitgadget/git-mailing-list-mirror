Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA73CC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiJDNZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJDNYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7458B52FD7
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id iv17so8878835wmb.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvNLdO6bDza8vpW9wL4E92rtVY8B5kjRahNzaicCUys=;
        b=iASp2ZmuP6MwJqTaHsWX08Cmklv+jC+RXx+JrEwFAIDYz3nYagOYadzBLr4E+EGda1
         XCsMBNh3+EA67K6QaE7k8Up8cBhBPD3quBSQA/WnCrq1dBnul3n5vcc9hr/1RtbyT7/F
         0N5vNzzsfdg/VrqD/7JFUIAw+QFYVY0+X3r682oJl3PWRNWinJJW3t0OjdcaRD9STN0b
         MY2+yUYAvBeLoRpCCUWHmVBeaT+ADCMh1TROFJ0eIG451OyMO2C8YK9m5j2b9NBc6zwc
         uHQXiooJhNHFohgGgx9aUv9UgnWez+38sfxDXzwepaE+7EE9qoO/+d2mXu11b0aw9W+D
         /XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvNLdO6bDza8vpW9wL4E92rtVY8B5kjRahNzaicCUys=;
        b=J7wlQ4BRWXfGV5f4swDgZz0ocG1bBmro+bu/+u1itOioYz8CvRdCyvzob2+2kNVztS
         tNkvz8txASgM3FEiopaF3k6QKI6Dt9An7DW1X2DBAEcgMyVGw4OHSVkL4w0eMSpvOdWG
         FEAmNKfq8dADIIGVDatIqj10qa51pA6i2pX+LMydA4ReiTS2oDv2ayC+bUjSQjOZL1Ni
         2sVi7McgJh6Km9ECMuVWYBJptHl2j43V+j1o+3yZiq4+AlO178n3GK0j339GV/UOLbQV
         roo9hc/8GCi9qyr2K5oeJ+k4QI9H8Rd1MDI9d6YFvZ0NZAkJy2lqsos4ocksTvoGV26H
         cQww==
X-Gm-Message-State: ACrzQf2EnPSJQ9CAQN5MGhPUkp6TlxTIx3PwL4A0VT0Ng0t09kko9vn5
        25ZhSwDAHBoNiSy5pnAigbYpJuKd8pAJLw==
X-Google-Smtp-Source: AMsMyM4RDYUcxOCk5gP8fxqxw5R/mC4kEM/VVIYpmXJQ+Bc3mpZb3AJFUL99oBttzUtCVNK+ZtT4zA==
X-Received: by 2002:a05:600c:310b:b0:3b4:c709:4322 with SMTP id g11-20020a05600c310b00b003b4c7094322mr9857771wmo.141.1664889860223;
        Tue, 04 Oct 2022 06:24:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 23/34] doc txt & -h consistency: use "git foo" form, not "git-foo"
Date:   Tue,  4 Oct 2022 15:23:37 +0200
Message-Id: <patch-v4-23.34-02e450ea39b-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "git cmd" form instead of "git-cmd" for both "git
receive-pack" and "git credential-cache--daemon".

For "git-receive-pack" we do have a binary with that name, even when
installed with SKIP_DASHED_BUILT_INS=YesPlease, but for the purposes
of the SYNOPSIS let's use the "git cmd" form like everywhere else. It
can be invoked like that (and our tests do so), the parts of our
documentation that explain when you need to use the dashed form do so,
and use it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-receive-pack.txt | 2 +-
 builtin/credential-cache--daemon.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 5c297db1a4b..65ff518ccff 100644
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
2.38.0.rc2.935.g6b421ae1592

