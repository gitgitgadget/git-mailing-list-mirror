Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6782BC2BBD4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1940A23A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgLRFwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgLRFwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597ABC0617B0
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 3so1214151wmg.4
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z7fgkyh1UyUiX/qF3rRPmjr7ypy84zpeUgU7ex7QbZg=;
        b=Jo3Cz10ThrWS1YIny8B8xa6+ekrTpj+SJwul75ASFZT7obhFmv1a6XTiHDA6n3G0Ts
         WssD/No/gj358UzvwzdGcb1E3uHzGjhev06xL0QMGGlC07f4G0cmPxc7GfGgFiBBMm7h
         t10CYxOppEwbsz/M1OWyRGf/08NQb3xwCKlHQDXDWD/oNB4ue2kT3UzSRC+pYykoWHsj
         88m0CyYSssLaamRkoe26fFiKNdQBoPji0ReIzAa/MZpRrwPw2U7CtHV+EKyvnXBUcJGD
         /87JwOUSt2NTnVfQY9DjTma7LUY0UdVdn8Ov3ASGCY/Oc9BajJyEk0nkzE+tqN/9sh6t
         54UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z7fgkyh1UyUiX/qF3rRPmjr7ypy84zpeUgU7ex7QbZg=;
        b=OrBTJQlBF24pvOKyo9ocIVolKutsNaWRA400Qp+weB9QAjn0NpwO1wH861YWsEH95p
         OTxMIXSR8G0n2BmrikffAhZKXyArJCtfZU9k1aQHc/hGW4UyPv0Uxk0tLrPRGLAsPKd9
         umYY7rzijd+iclOzp89CshJ40snAj44j6rbRNMpyfMCJnjeFqoZ3Z46RSl2RkrCD6xS9
         RWGmwn0cKTuFkml9wwF3Dmlr/7I0MWoiAvzF0XyjImzSoP+cKMvrltQlkjoVP2z9CbIe
         t7mJcxtjPUDmT4Hmz3tU/vLnsJ4kRobeuFedQQC5PwM4VIJ9FedOiq2eklvt4+/ySJ2r
         24BA==
X-Gm-Message-State: AOAM533JbuuwHncbPlgMeLgMbuHoWqM5lYpwytbjGbnHBISvHnuwCutz
        3y5Ekqu3E2Is2FitJeeL6ZNTPNvX5ts=
X-Google-Smtp-Source: ABdhPJwHyhrV/GsCZWwF6XT0Ul9yTHXOAcaFufhcehjIK8TxKAZ24ONy8vdsuGmXvCfsvqlp6KlUsQ==
X-Received: by 2002:a1c:f706:: with SMTP id v6mr2508945wmh.85.1608270689876;
        Thu, 17 Dec 2020 21:51:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12sm13363666wrh.71.2020.12.17.21.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:29 -0800 (PST)
Message-Id: <382a009c18efc8a46a9c0210754f2266c3116ee4.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:18 +0000
Subject: [PATCH 01/10] merge-ort: handle D/F conflict where directory
 disappears due to merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When one side has a directory at a given path and the other side of
history has a file at the path, but the merge resolves the directory
away (e.g. because no path within that directory was modified and the
other side deleted it, or because renaming moved all the files
elsewhere), then we don't actually have a conflict anymore.  We just
need to clear away any information related to the relevant directory,
and then the subsequent process_entry() handling can handle the given
path.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 414e7b7eeac..f9a79eb25e6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -976,14 +976,35 @@ static void process_entry(struct merge_options *opt,
 		assert(ci->df_conflict);
 	}
 
-	if (ci->df_conflict) {
+	if (ci->df_conflict && ci->merged.result.mode == 0) {
+		int i;
+
+		/*
+		 * directory no longer in the way, but we do have a file we
+		 * need to place here so we need to clean away the "directory
+		 * merges to nothing" result.
+		 */
+		ci->df_conflict = 0;
+		assert(ci->filemask != 0);
+		ci->merged.clean = 0;
+		ci->merged.is_null = 0;
+		/* and we want to zero out any directory-related entries */
+		ci->match_mask = (ci->match_mask & ~ci->dirmask);
+		ci->dirmask = 0;
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			if (ci->filemask & (1 << i))
+				continue;
+			ci->stages[i].mode = 0;
+			oidcpy(&ci->stages[i].oid, &null_oid);
+		}
+	} else if (ci->df_conflict && ci->merged.result.mode != 0) {
 		die("Not yet implemented.");
 	}
 
 	/*
 	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
 	 *       which the code goes through even for the df_conflict cases
-	 *       above.  Well, it will once we don't die-not-implemented above.
+	 *       above.
 	 */
 	if (ci->match_mask) {
 		ci->merged.clean = 1;
-- 
gitgitgadget

