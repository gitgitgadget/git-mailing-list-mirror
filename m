Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B85C00144
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 22:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiGZWVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 18:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGZWVN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 18:21:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56865B4A2
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 15:21:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h8so21901056wrw.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=UMybk96apffNw9hwQlU5TgUldb4jbTNLpUIUhEQn1ls=;
        b=aFT7RLq72rI7ZfdVpKC1Ifo/i+RNctsgySJLFY5dAEmFnkgSFx3ontT5ua70kvpTtf
         0LKbkB7Wp3/9kIj1y89weBay7HGSdlf2E41fjwmxTAlruvB+SqjsLz3TU2eiblMHCOY2
         GcGYbrqLfBy+QSmPEEynq7Nlq7LmogsdSSFj70c8xRXIXGYzr0ddxrVEVmavhX7zPXik
         LE0uK7RxOIjj+n5Lmu6VDSgeOFeMWWXQMs/mUBnNG2xhOrCm8S4JVh0/Y7EKSdnQCaum
         +a8eD8/0VtAUk2GMJWh4rSfYKwvOaDrNlbKYIpJ5eU7Ori7+FwHv2hGJeuKlf1cbkOmH
         ihZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=UMybk96apffNw9hwQlU5TgUldb4jbTNLpUIUhEQn1ls=;
        b=4YQOpeAY4MgLEkAetn2VufpbpWGt9vUd3iar7i0kFHPO56SYtoXpPpjYO4X3cjJthd
         qxaFPcXwiHDn468DZcou1jDxI6ZvNYloyq2DetrK2VVsDocuFpNMeqK1GJrhO2k3Xb/O
         BCHjNfjz5Q06cdFG6wWOeUZGOoQ2SEsFkArtG9Ui1+A17dNRk/cKFFZH2LohjZ88cQXX
         tNDvxvK70NjJ+CjLgnpMArGdrcz6O8kFFNUlY++1P0E8M4Pb1zRmiybpd03dgsTdhcC7
         nk2d8U/psWYBRbYUv0FjVVrnPDegwIQsIzVNcDfpb5elusGCriwNLcOOhQ4DHxqqwaq+
         atRA==
X-Gm-Message-State: AJIora8gN2bDrVsPV9xdzVrlPA+a2mtB0UxFL/YlsflExDRWLoaL2pnw
        6sUIzQYWSqIFB3Tz8qDXyxnmKWtvTLE=
X-Google-Smtp-Source: AGRyM1u0i9j1dyM6RokHVh3O0Tm1LL5Spu8VwalXYBa8EoemiDhiIkUpMbodzbMD7PZDysog5cgEAg==
X-Received: by 2002:adf:f70c:0:b0:21e:492c:34ae with SMTP id r12-20020adff70c000000b0021e492c34aemr12388669wrp.482.1658874068343;
        Tue, 26 Jul 2022 15:21:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bt26-20020a056000081a00b0021e084d9133sm1121938wrb.27.2022.07.26.15.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 15:21:07 -0700 (PDT)
Message-Id: <pull.1299.v2.git.git.1658874067077.gitgitgadget@gmail.com>
In-Reply-To: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jul 2022 22:21:06 +0000
Subject: [PATCH v2] config.c: NULL check when reading protected config
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

In read_protected_config(), check whether each file name is NULL before
attempting to read it, and add a BUG() call to
git_config_from_file_with_options() to make this error easier to catch
in the future.

The NULL checks mirror what do_git_config_sequence() does (which
read_protected_config() is modeled after). Without these NULL checks,
multiple tests fail with "make SANITIZE=address", e.g. in the final test
of t4010, xdg_config is NULL causing us to call fopen(NULL).

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
    config.c: NULL check when reading protected config
    
    This fixes the SANITIZE=address failure on master, That was introduced
    by gc/bare-repo-discovery. Thanks again to Ævar for the original report
    [1] and for proposing a way to catch this in CI [2].
    
    Changes in v2:
    
     * Fix typo
     * Add BUG() to git_config_from_file_with_options()
    
    [1]
    https://lore.kernel.org/git/220725.861qu9oxl4.gmgdl@evledraar.gmail.com
    [2]
    https://lore.kernel.org/git/patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1299%2Fchooglen%2Fconfig%2Ffix-sanitize-address-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1299/chooglen/config/fix-sanitize-address-v2
Pull-Request: https://github.com/git/git/pull/1299

Range-diff vs v1:

 1:  17b4a489c69 ! 1:  ba51078418a config.c: NULL check when reading protected config
     @@ Commit message
          config.c: NULL check when reading protected config
      
          In read_protected_config(), check whether each file name is NULL before
     -    attempting to read it. This mirrors do_git_config_sequence() (which
     -    read_protected_config() is modelled after).
     +    attempting to read it, and add a BUG() call to
     +    git_config_from_file_with_options() to make this error easier to catch
     +    in the future.
      
     -    Without these NULL checks,
     -
     -     make SANITIZE=address test T=t0410*.sh
     -
     -    fails because xdg_config is NULL, causing us to call fopen(NULL).
     +    The NULL checks mirror what do_git_config_sequence() does (which
     +    read_protected_config() is modeled after). Without these NULL checks,
     +    multiple tests fail with "make SANITIZE=address", e.g. in the final test
     +    of t4010, xdg_config is NULL causing us to call fopen(NULL).
      
          Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## config.c ##
     +@@ config.c: int git_config_from_file_with_options(config_fn_t fn, const char *filename,
     + 	int ret = -1;
     + 	FILE *f;
     + 
     ++	if (!filename)
     ++		BUG("filename cannot be NULL");
     + 	f = fopen_or_warn(filename, "r");
     + 	if (f) {
     + 		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
      @@ config.c: static void read_protected_config(void)
       	system_config = git_system_config();
       	git_global_config(&user_config, &xdg_config);


 config.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 015bec360f5..e8ebef77d5c 100644
--- a/config.c
+++ b/config.c
@@ -1979,6 +1979,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 	int ret = -1;
 	FILE *f;
 
+	if (!filename)
+		BUG("filename cannot be NULL");
 	f = fopen_or_warn(filename, "r");
 	if (f) {
 		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
@@ -2645,9 +2647,12 @@ static void read_protected_config(void)
 	system_config = git_system_config();
 	git_global_config(&user_config, &xdg_config);
 
-	git_configset_add_file(&protected_config, system_config);
-	git_configset_add_file(&protected_config, xdg_config);
-	git_configset_add_file(&protected_config, user_config);
+	if (system_config)
+		git_configset_add_file(&protected_config, system_config);
+	if (xdg_config)
+		git_configset_add_file(&protected_config, xdg_config);
+	if (user_config)
+		git_configset_add_file(&protected_config, user_config);
 	git_configset_add_parameters(&protected_config);
 
 	free(system_config);

base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
-- 
gitgitgadget
