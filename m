Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A840C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FA660F46
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhILA0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhILA0G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:26:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068EC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:24:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y132so3890996wmc.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEn3BJ2ZYKA4YBuZqI2wPc6q3yrQGGSTi8uD1Iay6to=;
        b=G4RCUOVDFUVh4Ays6skj9sw7qfigdVD+bL5SpB/RRLPBFoH33s5uvpTmuUDlSCvxOp
         rC9Efcoowzj2Q5ucCNbi8yzZHX41wQNwh20fxDaIthhAZi2Hx48w9x4tgDJcLP1QCUXI
         sILQZekcEPMcCKmprYM5lIh3b8q8pGPuzipHVY9HgK4eevjBiV1r4IxCTn5Sqv4gIwmV
         gkw5KF4Cjl7KbwyvkoqcZnte5NSjvvklXVg6IAQZRlK2gV/IX71dQL/95RJ5e8X31AVz
         rGCfCSIpVn539xNgmVsA2EcN/qjjHlAp76lo1nvL2vqGhL2qeVOtgIV4O49Pa1PF3EmI
         JFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEn3BJ2ZYKA4YBuZqI2wPc6q3yrQGGSTi8uD1Iay6to=;
        b=57rWzs7gkF8fWLaB3ZmhkNwk0DRYGrRx9rS/MMA+AEAfnchZ2dIXbud/uTniKwmSzZ
         WZKARDTy44Sl2LzmlaOAr7o+O6kl42E3hmMWNqIh9VRVG/5wKUwAMJqwe8HBX2as2pKZ
         3oE1zLbV7quavD03bOGmk7+tEFCMy2eOqF0iEYmUe/08w3p9nAo1KJAsQehcD1XcJtxh
         YyykrvvOUYyivlTGguGsl8RczMx92tvUW2p9cOzNjBYulxjQBqyvDJq5ZYHeEwY43Et8
         fdYQebGNEKuFlK9mU8v/l9A7Mqzd4ZO8bSvRW9w0ed7jB7fwEbpKln6t/iv5iJOmlBRL
         2Pjw==
X-Gm-Message-State: AOAM53331e/sKl5EVfVXOLb0JV2vgMrMa6oOgH270/PrKtsRgxPPWQn0
        Zybv6RY4wTl7u/fBj1g9ZqQqMDpzO0XGQA==
X-Google-Smtp-Source: ABdhPJz7e1Gp+y74SRWA2xkdUsGtf5qWOD8V21khE3eOCps5TLSFTxz0Dsoxnm4Hleol/NOoC92tVw==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr4641883wmm.57.1631406291194;
        Sat, 11 Sep 2021 17:24:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c14sm2697701wme.6.2021.09.11.17.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:24:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] gc: remove unused launchctl_get_uid() call
Date:   Sun, 12 Sep 2021 02:24:40 +0200
Message-Id: <patch-v2-1.1-794e68e7722-20210912T002334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.998.ga4d44345d43
In-Reply-To: <87bl52dkv1.fsf@evledraar.gmail.com>
References: <87bl52dkv1.fsf@evledraar.gmail.com>
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

As the patch shows the returned value from launchctl_get_uid() wasn't
used at all in this function. The launchctl_get_uid() function itself
just calls xstrfmt() and getuid(), neither of which have any subtle
global side-effects, so this removal is safe.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Addresses a comment about the clarity of the commit message in v1:
https://lore.kernel.org/git/87bl52dkv1.fsf@evledraar.gmail.com/

Range-diff against v1:
1:  93adb856b0c ! 1:  794e68e7722 gc: remove unused launchctl_get_uid() call
    @@ Commit message
         assignment and the return. That pattern also appears to have been
         copy/pasted from launchctl_boot_plist().
     
    +    As the patch shows the returned value from launchctl_get_uid() wasn't
    +    used at all in this function. The launchctl_get_uid() function itself
    +    just calls xstrfmt() and getuid(), neither of which have any subtle
    +    global side-effects, so this removal is safe.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/gc.c ##

 builtin/gc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 43c36024cbe..db76af4f31c 100644
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
2.33.0.998.ga4d44345d43

