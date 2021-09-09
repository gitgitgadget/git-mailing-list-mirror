Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311BDC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E6161166
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349094AbhIIB0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 21:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhIIB0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 21:26:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE7FC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 18:25:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q26so33058wrc.7
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 18:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCPrH6MouebGxzLKZ7REVg8mhS80aIpbKisPkm0DsnQ=;
        b=VqRHHxkvfXYq0PqCfa+fAA9kANFClCImOCGgiH/wblw//jSYUnR5RZluYXRl001dCT
         1JL+34cD+b5llcyWGGTOdqz+frP28NfI0WVVY+bj2p1NmT6uxnU7/qWTMFR/l7eaAOha
         6rKjkRGk1PEUjGDMr7QzqYNQyTh/h+XDw6W30jN6ScyHv+KQKkXbVJnkwNSNZuLY1LRw
         yevObWiERJtdFJA4klHdvMQk7+3+UaBoJabN/e5iSOzZtin4kvzeNBvORT/pF45FYUDf
         BCQnYC6wwYXbHbpS4AM5vuTPgSkzzJRM6zDlAVSSxoiR6kMsSjrY7LqaG/nanU0Ej41x
         4peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TCPrH6MouebGxzLKZ7REVg8mhS80aIpbKisPkm0DsnQ=;
        b=od1zp13ssI+ToJCrRisZnKtMDo+B8YQDPWGKZVhp6qaV8eE6Mw4FhIEdYUkSKu9Qfz
         g6HDP3piWJezCPssVCE8RYpwdlKggbg5R2HmV1BABuyY5HVWxTR0XlO80WmwbX3IPjm/
         xOaXSwtsQkDzAKtLNSTbSaJHp0wO1CRPQ3SXcjkNKWBxlcFsY5HjigtyMsOC9G6dkmY2
         Xo1Gt6W4IIzC48t4fsc6Ul2o1/Z0UARc/3F1Ga7Ghl+2zAlehmHCM+VxHvpVkKRD6ls5
         oPO4woeFdMMnZiehTnpVJV0eJfRAS33GrWRZqvdo3Yr5CVjJuMvXGfn7XxPdZ/H6rmwa
         UrTA==
X-Gm-Message-State: AOAM532BCSvlBh5ZDPGo8RqMCUJaun1WuQ3uHwmOEnlKOLQ8RlD3bxKx
        8sqFw8rMaCudS7GwF+SwOc4dvWkehQ+PeQ==
X-Google-Smtp-Source: ABdhPJwdwLXwQ3AufTxLtg4irKITOvg1nvIIiUPGm1fR8r888zhBk8LwH0ju+tZ5c18ATTK+zmhibA==
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr463081wrm.430.1631150709866;
        Wed, 08 Sep 2021 18:25:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm238693wrc.16.2021.09.08.18.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 18:25:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] gc: remove unused launchctl_get_uid() call
Date:   Thu,  9 Sep 2021 03:25:05 +0200
Message-Id: <patch-1.1-93adb856b0c-20210909T012244Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.gdc3f7a2a6c7
In-Reply-To: <b0d6bb0b07f29e68f5bcdf4c69d3d726d77882c0.1629819840.git.gitgitgadget@gmail.com>
References: <b0d6bb0b07f29e68f5bcdf4c69d3d726d77882c0.1629819840.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the launchctl_boot_plist() function was added in
a16eb6b1ff3 (maintenance: skip bootout/bootstrap when plist is
registered, 2021-08-24), an unused call to launchctl_get_uid() was
added along with it. That call appears to have been copy/pasted from
launchctl_boot_plist().

Since we can remove that, we can also get rid of the "result"
variable, whose only purpose was allow for the free() between its
assignment and the return. That pattern also appears to have been
copy/pasted from launchctl_boot_plist().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I happen to have a local topic that refactored the launchctl_get_uid()
function away, that didn't compile with the updated "master", I
figured I'd need to add it back since it had a new user, but as it
turns out that hopefully won't be needed.

 builtin/gc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 9a48eb535fb..b024f0e04e9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1602,9 +1602,7 @@ static int launchctl_remove_plists(const char *cmd)
 
 static int launchctl_list_contains_plist(const char *name, const char *cmd)
 {
-	int result;
 	struct child_process child = CHILD_PROCESS_INIT;
-	char *uid = launchctl_get_uid();
 
 	strvec_split(&child.args, cmd);
 	strvec_pushl(&child.args, "list", name, NULL);
@@ -1615,12 +1613,8 @@ static int launchctl_list_contains_plist(const char *name, const char *cmd)
 	if (start_command(&child))
 		die(_("failed to start launchctl"));
 
-	result = finish_command(&child);
-
-	free(uid);
-
 	/* Returns failure if 'name' doesn't exist. */
-	return !result;
+	return !finish_command(&child);
 }
 
 static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule, const char *cmd)
-- 
2.33.0.825.gdc3f7a2a6c7

