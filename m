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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C02C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B4723B85
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgLJW6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 17:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393601AbgLJWzF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 17:55:05 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BB6C0611CD
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:38:48 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d3so6015833wmb.4
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wMOlFeqr3KyQUvif43DnFXMdTbT099ZsyX8APEFwt4M=;
        b=Wf3Pw0n+vwAGRQCCOaVtOTOyI5dafsa6shFxDgBbQo81jKdX2QtwWIjsd4UhYANHbr
         5SGa3xFg0rGa2nHP7Qj8OQ+e6jw948crrA55eoA455FSYGNnwWPAy0hcMR/rVDe3eIp0
         d+dgZg4DuY15N5OulzcqfEr39fzRI7t3G8OQXRlyC7eNi4X3zKvzn1A7rGpX+S5WmE1M
         A1xwOWdKja4IXbh0Jd02HA80RkcIQRzyp7Cr+CUPKljNfeo4N8IAPC6avPlND34Ngcj0
         mKvAA+s63B4STzXRT4ETW/IjZjUnV2XZum5EciTDBxWV3Cf4CIb3GxxZWRIQXKrN4oSx
         ih5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wMOlFeqr3KyQUvif43DnFXMdTbT099ZsyX8APEFwt4M=;
        b=NlHYzd2qMvCn52x3gp0YwdJ9vcgj11dROJXgQDbUUml358AkKmD92w92z4TO7Ony+9
         m4lY9beVTNsYO2QgUdi3qfW+Zps9YwST8JJWj8kI04B24FyiIvvEVmCRzh/stLxFsCzJ
         26S/UiBC6xQmoFIE96LjfTVYBTnVQ7NqqKK6QnnFj1RR7FklYGSudWHbf+2J8GKB3Y6B
         UTTIxjzvBulR9TCZZwa5pk9cchdk5ky5bWItJwRoTXzfCK3t34wFKmLh0iJJtuubOBUb
         hgHhVHFjJAP8po66QyhYl3D8zhpaEyrrKukDUA13b+4JoTVAd1BAKKFGLGJfc+UAWSRC
         BPgA==
X-Gm-Message-State: AOAM531vXGZdOOfAW9/bFCtttqL12LNB1G+Eulmoo4Dpt3C/lDodAC4B
        RMEBhpEJAgSdQoH1kNijwgbWY67vgUM=
X-Google-Smtp-Source: ABdhPJz3d7B1yMlDHP6CIxqxkYKO+yvpedCRaR1i3+v7vW/b1dTvGm2fVWLJKzHmjGz6AntbQ4Oc0g==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr10262617wmb.101.1607637520782;
        Thu, 10 Dec 2020 13:58:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p19sm13970854wrg.18.2020.12.10.13.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:58:40 -0800 (PST)
Message-Id: <6cbd6692c6a4d0586e3418225029e70b0001ffb1.1607637517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
        <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Dec 2020 21:58:34 +0000
Subject: [PATCH v4 2/4] branch -m: allow renaming a yet-unborn branch
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

