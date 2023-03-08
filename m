Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267A3C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 02:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCHCs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 21:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCHCsj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 21:48:39 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F291B66
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 18:48:38 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-176eae36feaso6659485fac.6
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 18:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678243718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9889KO9eTi+URkD6vLCwO1ALrLqz+PRXw+Q9gJSF6ig=;
        b=kBbI7n1jrRtQHB/aCtiOww1IEsA0eJJRtV/C6LiG51CIx8khMvtbUPTV8FdUHRZ879
         R9bx7qthwCONnNmCCzM82/tfo+btVWLn6Fl6Lb94bAdkfWXTM9f3PGj59zTAhHADgD0x
         m0VMHFPI5RjvBPXMqvKbMyuuE0Jka8QnFV5OVj/AxVNf5pi5E1uRWwCrCV1QejAbymxy
         tbmSDBfsI81A3fbvmmBcyWEdf3OmJFzDWstRpB5EovvzqeRatc701aDWzRSotfTOBgIj
         6XtRVy+2ZFHol+qodZIEtLNHqOWj0F64YuodihP8flsfQPauYcKpov7sCqCnecEyI7kk
         coOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678243718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9889KO9eTi+URkD6vLCwO1ALrLqz+PRXw+Q9gJSF6ig=;
        b=HEyJJvjnuYQOEL6qjOO73m5gyf8H5/DFahWmCPfmsk5uJoWfVj0VAO8LwgLETSJYTf
         cUMd88IT7xtLg6IT5kbBG8V4q3/zIO0hTO8EWuEcSseOd5qM7XRQRvg+GXw4cDWUW/l5
         YYItO8VW2bDiuIhwAvKZpOzjLVcqA3hnQqdQBC5edZehBe32j3lVrdeSXDHy/BPG043R
         H2ZD11LqpHQHEnbaHVK4ZlcF1Tn9HZz+5UBolEATkgROa4Ewddawn6GiDZBqGuNZNgi9
         vAMB5aRxYJQ/kGK3Y8k3f/Thjs+ulOOg7Q9jQ2hbkvM2M5fKyiUQ3vSbtXgEDvJpnZte
         Z/Ng==
X-Gm-Message-State: AO0yUKXrPJyDo6nlKy9mzfzS2Sc2OYBNrihSlRStYJoUrdyr/rqRIZhu
        dSpWEJPxLygHl/J3ZbgPFSnnDpb0m8g=
X-Google-Smtp-Source: AK7set/tkPjp9t1IwaovnQrGmCiMXZ1csDDAXoA3Zzm0TWXNT2xnk7vVwKj19wg3sHNDRtQMIvWolg==
X-Received: by 2002:a05:6870:40c3:b0:16d:fc22:b520 with SMTP id l3-20020a05687040c300b0016dfc22b520mr11293108oal.54.1678243718015;
        Tue, 07 Mar 2023 18:48:38 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id dx4-20020a056870768400b0017255c79736sm5716264oab.43.2023.03.07.18.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 18:48:37 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.tavb@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] advice: make diverging advice configurable
Date:   Tue,  7 Mar 2023 20:48:34 -0600
Message-Id: <20230308024834.1562386-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308024834.1562386-1-felipe.contreras@gmail.com>
References: <20230308024834.1562386-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/advice.txt | 2 ++
 advice.c                        | 4 +++-
 advice.h                        | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index a00d0100a8..c96b5b2e5d 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -136,4 +136,6 @@ advice.*::
 		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
 		is asked to update index entries outside the current sparse
 		checkout.
+	diverging::
+		Advice shown when a fast-forward is not possible.
 --
diff --git a/advice.c b/advice.c
index c3fb631f93..fbc59f9c6d 100644
--- a/advice.c
+++ b/advice.c
@@ -44,6 +44,7 @@ static struct {
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
 	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead", 1 },
+	[ADVICE_DIVERGING]				= { "diverging", 1 },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
@@ -217,7 +218,8 @@ void NORETURN die_conclude_merge(void)
 
 void NORETURN die_ff_impossible(void)
 {
-	advise(_("Diverging branches can't be fast-forwarded, you need to either:\n"
+	advise_if_enabled(ADVICE_DIVERGING,
+		_("Diverging branches can't be fast-forwarded, you need to either:\n"
 		"\n"
 		"\tgit merge --no-ff\n"
 		"\n"
diff --git a/advice.h b/advice.h
index 07e0f76833..41b5bc127c 100644
--- a/advice.h
+++ b/advice.h
@@ -21,6 +21,7 @@ struct string_list;
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
+	ADVICE_DIVERGING,
 	ADVICE_SUGGEST_DETACHING_HEAD,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_GRAFT_FILE_DEPRECATED,
-- 
2.39.2

