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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E89AC56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18817206F9
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8+5w9YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389588AbgKXPHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389084AbgKXPHg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 10:07:36 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C7C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:35 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so22629589wrc.8
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qaLCsUupMWieXeT+MBb9mlGZ7Zq+Czs7uQzFOxGjNMk=;
        b=m8+5w9YVN8QJ7P2+z0/UKkjcNIL3/FYNhJJW8VBcBwWC+/u+jLghYk8rmUrTh3KPV8
         2ofzJVoSpDSU4sWANwdai8Ylf1geohjDL+oIZBy72U2KgmpRFxt9f2oYed+1ovsKnU7k
         oYWWpfQ8C4LPDcuki2KNHRIfRMy5Y2My5ZkxsgZCca0lu1iLVBF+MpFeuTKGLmO9dY9f
         XunZR0VO+XH5M2WovxfMQJUb2GYQpxdhZStXRujbbRqIAxDfIzmTHg/f6NFSIEkEGVfI
         pZ1R4mgiiHyeNs7lsVmLK3qyfk95FhYgQAuR6reXdmTvHPZZXpvHI+BOooMjehIbq8FX
         zL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qaLCsUupMWieXeT+MBb9mlGZ7Zq+Czs7uQzFOxGjNMk=;
        b=gr/udVcDNuxeLWTcVs23AW6EjXu/tXDr9n+1Z9eZvHx/3Uz0m+ptpZZaHtrGWquyHn
         mKqEVV3aEySp+nyfwm/XwsTQWrsQ14zbQNLykcM0zX543hviv3by0PYPPh0f1CAErXeB
         92opAkJQKGW0wC2/aruZ+faMiCUOqiuY5C0Yc/MobIuYiZQX5waFEAW0nv08egBa11Zu
         pxYYpkkOGujh+The6ELR+bdVqR8glBg/oAwGCCTRcYVfkekzYBs+u6CWG6r9LTORq/da
         818hvaTzM4u1y3zv8hgLes+dW1ZEIaA0aptZ6bAfZ2MtJUtKDNVn+XS/f+CXjo73dBYa
         Cc9w==
X-Gm-Message-State: AOAM5318ane3wXLTSc6hRfziOhYWkQME5WSCWhQTazDGXi8HqTuM3hMI
        o12nCO3lqMFG8/RKlOMft/H5gJZoGPg=
X-Google-Smtp-Source: ABdhPJyJ+Ji2UktVRHEXbGauUAS2Ji2JOYc+bzTLA6Jk/3r2SqO1+qra1Knwqx5CYQv6vhgaO0IXkw==
X-Received: by 2002:adf:ea47:: with SMTP id j7mr5727910wrn.126.1606230454279;
        Tue, 24 Nov 2020 07:07:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z189sm6069311wme.23.2020.11.24.07.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:07:33 -0800 (PST)
Message-Id: <6cbd6692c6a4d0586e3418225029e70b0001ffb1.1606230450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
References: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 15:07:27 +0000
Subject: [PATCH v3 2/4] branch -m: allow renaming a yet-unborn branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
index efb30b8820..200da319f1 100644
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
index 69a320489f..bb23e56a16 100755
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

