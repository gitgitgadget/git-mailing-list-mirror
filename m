Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A0AC43217
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJMPld (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJMPkf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84FDEEE
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a3so3543000wrt.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHfFxV8VLBYE3kdihxmSxjKsJuy8gHchiGHdLsvXPuM=;
        b=bRGyl+0i2pTWVJNHZNyZhseoFvGNP+last90aFUuiQ7RheVJjUNR3p0C4ro64EYEUv
         ZetQtllba9J6oM+S4iwmTUtgGJQX4DaxbI39TNUv5Rve2dIPX+Y9aZPfHMkf/tG7Jy60
         I5iAufTjVI0hybrC5t5Wb+pjOa1wilzU0+ZaWVEo7lb88YeC8z/g044D7EdeoOOuyZI4
         iccjSVDKvKnsrSAyjPYzCMPafG/+iMWe/KVJwuJJ6PDhhvXLh9zeFoq9MAFRtSk4NB+Q
         UU7O+it1ltHTEP7UPWJ1MO9/Rq8DQWrkfZsGnPOButsWIx8fyllu9HDg1x8HVPJOGi1B
         +zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHfFxV8VLBYE3kdihxmSxjKsJuy8gHchiGHdLsvXPuM=;
        b=Uf/7pJJNgjbQZCv2hGvRWZsoj5kq1eXj0RQBkO75GeBDwX4tPDNgM/vEmzt2/6Oskr
         aw5ESCTUClvLv17mPeagDy3Jo5W0+cCnl3T7gfIjwkp4v1jxQvGF683FW93uE48/BVyD
         7CCAiUn/WlYLKdOQitOpopbDz6le57HtelA86fUVAKYffeCRxZWVemYsVrGufsOf9vfu
         HjGxb5LLT9jZVC1L49JZaI6doOdyYUqpvo0sy8aSJSl60v/KxKLvf6jeY3Cq3878o8sP
         /Hvd4ZA6zokmOs/zXHazVVoVMFne4U0PSxbJOJ8WwxDIdxKphCi0XVqpffXgT/1+EOyU
         1Nrw==
X-Gm-Message-State: ACrzQf3I/NlwQT47OiTOLs3lWK3kOorl9h6QcZvAFKdMsnaclTIeGtny
        M/g6KSuvo/hCvOSoP0k6wOvdIn9q0p18MA==
X-Google-Smtp-Source: AMsMyM6q84sFxCVyu0KHOfpoad3gNudGKnjH1Dpxgw+iCdA4BsFjXCg4sQzYEV7Pzy23tVZQmMr1VQ==
X-Received: by 2002:a05:6000:1885:b0:22e:7851:b257 with SMTP id a5-20020a056000188500b0022e7851b257mr401012wri.418.1665675598956;
        Thu, 13 Oct 2022 08:39:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:58 -0700 (PDT)
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
Subject: [PATCH v5 23/34] doc txt & -h consistency: use "git foo" form, not "git-foo"
Date:   Thu, 13 Oct 2022 17:39:17 +0200
Message-Id: <patch-v5-23.34-1a49bbd1f6a-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

