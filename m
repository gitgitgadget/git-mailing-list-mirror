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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA062C07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C86613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhGEMe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhGEMe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:34:59 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C74C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:22 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s17so20656702oij.0
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1E5rqjXig626tmXGeF5NX3O3EHxKT4Bio0ij+D3RcF0=;
        b=XvFVdRqEEVlXLGCFLrPjWz9umyPLJHk3iLwtr+AHsUpyiIujSehuV3lGXgKXYTlV7a
         lVO6d2szIW96Nsp54fdg+60Bq0EnRGaQosxgBW/4uxGOFAG+CA5g1JUz+1YPTkisapVF
         Tnj/iiLLMs5YUZ14hcgCiJ92l919f0KxtO80ufcE6F5NcUla7pwmtT9koUNU3DNhppsK
         nfCw5QoKt1uO35//sWaAEhJZXFB+XxHNnwP7n4W4wTCyJTDzcBoT4r1rccbCDjNDCGzZ
         kS1bcg/cF1r6Tsz0Lqe4/15wKzOtsXPJy+YzkyqFCTP84InmKg+NFScRDiSQv44hFZAq
         hs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1E5rqjXig626tmXGeF5NX3O3EHxKT4Bio0ij+D3RcF0=;
        b=qvhVeat7nCt/1neV4bSVFcN/SOHg5N5XHGERcXANdUxvId+Z/76WAmjLj07nHAkFbQ
         dwJzYspXK0lUtnwvjZ4wovtaT681ePHiuRNIPFBZN9UyFXpNnUA05MHXIj/JbK3S5JV6
         IFAv26JX+LXLa6+As8F/8V11crd/4xtwGrrmrTANhigYRHewP6qIDoQEyZv6O9nDaQK9
         Gg5NbEVjWtw/v5BBeNRlDxL6V2tANTImMtd/rRXrI0w6uSs/0qOJEaBeO3WM+o/BCEI3
         uC4563BWa4q1JK3fNBnQzagSn5MwghscpJbGf7Wc/jmZOJHUf/a+Gi4e/bTgrENekdYJ
         +wiw==
X-Gm-Message-State: AOAM531j9PRzcz6/AuQP+zXsC5OsN29+7oc64HGWJs8RvSTe9RDCpRIZ
        igRjdFYQVQ2FDkjK8mB1UIdwe9PfhIhxGA==
X-Google-Smtp-Source: ABdhPJw2/ay9Sz62jExdfUDIf5+5q2iA0VYsDyZyhXlCVG+HC49MNS7lttkEmNqCpGVawN0bQ043pQ==
X-Received: by 2002:aca:da86:: with SMTP id r128mr10454019oig.150.1625488341563;
        Mon, 05 Jul 2021 05:32:21 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 104sm576634otm.55.2021.07.05.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 06/35] fast-forward: make the advise configurable
Date:   Mon,  5 Jul 2021 07:31:40 -0500
Message-Id: <20210705123209.1808663-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With advice.diverging.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/advice.txt | 2 ++
 advice.c                        | 4 +++-
 advice.h                        | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 8b2849ff7b..dae85310dc 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -123,4 +123,6 @@ advice.*::
 		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
 		is asked to update index entries outside the current sparse
 		checkout.
+	diverging::
+		Advice shown when a fast-forward is not possible.
 --
diff --git a/advice.c b/advice.c
index 8f068c8be9..60de7fbc4e 100644
--- a/advice.c
+++ b/advice.c
@@ -110,6 +110,7 @@ static struct {
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
+	[ADVICE_DIVERGING]				= { "diverging", 1 },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
@@ -329,7 +330,8 @@ void detach_advice(const char *new_name)
 
 void diverging_advice(void)
 {
-	advise(_("Diverging branches can't be fast-forwarded, you need to either:\n"
+	advise_if_enabled(ADVICE_DIVERGING,
+		_("Diverging branches can't be fast-forwarded, you need to either:\n"
 		"\n"
 		"\tgit merge\n"
 		"\n"
diff --git a/advice.h b/advice.h
index 6ce967c962..695f5a62bb 100644
--- a/advice.h
+++ b/advice.h
@@ -49,6 +49,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
+	ADVICE_DIVERGING,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_GRAFT_FILE_DEPRECATED,
 	ADVICE_IGNORED_HOOK,
-- 
2.32.0.36.g70aac2b1aa

