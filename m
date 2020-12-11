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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E254C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643CE23EF6
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391060AbgLKLi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403930AbgLKLhn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 06:37:43 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8DC061794
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:37:02 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so7285469wmd.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wMOlFeqr3KyQUvif43DnFXMdTbT099ZsyX8APEFwt4M=;
        b=PIZDGz8RUoE/VE8TmqENZdhqwUSyPgLFuPTeii6C+o29lV88LyYUqZvUHW6uegyDGA
         jaOWiSGwy036+FFrK8KYEy7mSKFFYngH0H3SCtzcoOLW0znV0uo6m/0FQOFKnNTnNrvN
         iDos6nh8ir8V6DEY3JpeRK9U0h5/kpV9TYEQmgJaplPPjxD+w2j3hmnFZ9RSrF7AMrAZ
         qB6BgFvGxbamaL3YhdL1EMDNwC1nknmZDkDNydV0gOvMrkOLeZWcPmBQWEv0OXokD/R+
         8voHbbmugsiVTG1l0jlmNtyZ4l15DTWqwYvpGxINmuAX4JY9Tgem0LccD0sswIIIkq0p
         5MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wMOlFeqr3KyQUvif43DnFXMdTbT099ZsyX8APEFwt4M=;
        b=NP3pCE7kkk3zjqxnOkvuE0TNtdD/2uUyKMoDDAMIgpXSZtB/yGf4N/RfDtAq+XlKEL
         3OkHwjhqDZxH3H/PXqfROdctHVTBU2aNQto3+CSQeSmi934S067ceYDCxnuoBejtvlkn
         3W1OUWjIDVDGuGz0EK5mebqx6VUvHMPrnTP9YvGrFkMdltXbUBZJ9EIK2h6aXpUMbWc/
         LzWZ6BU+Sq4m17iK36ubGATalUBxq+wvw5OkG9AO7qPtJS35tsgV1Q1OhzQ2NJeMcvr/
         F9+OGY0F3ko6ocec24ELkmZoLstAn5ku1aBsMa3RfJb979j6zSxAbFHEObWFXLnNiXFl
         S9Qw==
X-Gm-Message-State: AOAM530QIfoFxRLPrfBJYXpZKZ1cr1RRIVTOE0xTH0CBWcHCZW2TYGwI
        Uh2qhBqCKZL6a/28LWDRM7CoVmUJA64=
X-Google-Smtp-Source: ABdhPJyV5ExBTfYOQFb2hR9LP3CFKEoYBC/8Cz802EdBPeOra7NmcZs0TlLZaUjDedEvGO0HEMWlxQ==
X-Received: by 2002:a1c:2182:: with SMTP id h124mr13089712wmh.25.1607686621158;
        Fri, 11 Dec 2020 03:37:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r20sm14701399wrg.66.2020.12.11.03.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 03:37:00 -0800 (PST)
Message-Id: <ac7b352a0ba604f9b10a5a5ce5487d1002169443.1607686618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
References: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
        <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 11:36:55 +0000
Subject: [PATCH v5 2/4] branch -m: allow renaming a yet-unborn branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In one of the next commits, we would like to give users some advice
regarding the initial branch name, and how to modify it.

To that end, it would be good if `git branch -m <name>` worked in a
freshly initialized repository without any commits. Let's make it so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch.c | 4 +++-
 t/t0001-init.sh  | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index efb30b88206..200da319f1d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -538,7 +538,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
 
-	if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
+	if (!copy &&
+	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
+	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch copy failed"));
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 69a320489fc..bb23e56a165 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -571,4 +571,12 @@ test_expect_success 'invalid default branch name' '
 	test_i18ngrep "invalid branch name" err
 '
 
+test_expect_success 'branch -m with the initial branch' '
+	git init rename-initial &&
+	git -C rename-initial branch -m renamed &&
+	test renamed = $(git -C rename-initial symbolic-ref --short HEAD) &&
+	git -C rename-initial branch -m renamed again &&
+	test again = $(git -C rename-initial symbolic-ref --short HEAD)
+'
+
 test_done
-- 
gitgitgadget

