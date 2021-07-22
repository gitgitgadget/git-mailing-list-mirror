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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35774C6377B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185F361244
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhGUX22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGUX21 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:28:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91591C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:02 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so3714409otq.11
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNngWaWxSosnim3ZT5QbxKb5RKsuTOMO6GT6Fy3AMrw=;
        b=JSLR7smtfjyPZhy+Fro1S63KpHPPqDYYSJKDshlcSIhoNWD1qOQla49C7jekaNDbJQ
         AT/NIQJ1+iA/X9dluqDdTLnprG5GRW7SVnRJ3PhpBZhaY7t222McXnuj542QhYB4/b0X
         rqPmnzF8X9s/zCBTBd4UoPEn3gq3vRub1n78aG6H2ZNt7YsTo0PjoJyCrBacoZWf7Toy
         mt/3CWC2WQ2VEAoDGKt5KBv8avZZi2tWdJUm1+l+LKesSM1jgJBxIcL+RhTfOSHtXxhG
         qF1YfWOqXs1mtfG9IOOGNtUMCpHlclSi97y0ieYduwU/08iSNoJ68+Vhwn38eAYUfHlJ
         rYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNngWaWxSosnim3ZT5QbxKb5RKsuTOMO6GT6Fy3AMrw=;
        b=PkuTEtriY1fRJYGfpFKlHs7hSsWD91r/Hb1+ieKlrRuUhin2y3boVHOU4WpY89L0hy
         WqD2WGqKmeKMfEyr07Hmnl7A6JFgwW6wLFF6MfQNph8oKAadSPSu+vj2AeKp9UdIio7k
         Q0otrkRAYMgoMvaE3VS1mlZxbGI7kvIyMAMVMb2ARPAK+B2Nw83b7wvC4QJRjR2j5UoT
         9wOKPPslB27bbX7IiJNZ0gdYQZ4jN0Jd0qdhBVMtxoBclzVOFAcKruEdtjfm6Nt72Otq
         OUvEpSn4mnjoYd+qjCeGOft1NVuR4HnP5sS+RdPJ3ilVKesMsY2VPHh/e8VSSbrQk0+U
         FEWQ==
X-Gm-Message-State: AOAM5313F73kzryD9oWxZkcQYliC6pkGugP9UXHJ07BwqU3xX3PXQRZ8
        5iOdgfPs+SxvGSSpeRLivcVxq160nFqnWQ==
X-Google-Smtp-Source: ABdhPJxHka3AqfGEE2Bs+YyAFD3XeXz8z6/CHspg7E0J+ZVw3WXTz7QXAghYazrjqRvsx4ThLkOufg==
X-Received: by 2002:a05:6830:19f6:: with SMTP id t22mr13459050ott.32.1626912541785;
        Wed, 21 Jul 2021 17:09:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 68sm4851514otd.74.2021.07.21.17.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:09:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/7] merge: add diverging advice for novices
Date:   Wed, 21 Jul 2021 19:08:49 -0500
Message-Id: <20210722000854.1899129-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210722000854.1899129-1-felipe.contreras@gmail.com>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diverging branches is one of the most confusing aspects of distributed
version control systems for novices, so a little help explaining what to
do on those situations will come in handy.

Right now this advice will be displayed only when the user does
`git merge --ff-only`, `git pull --ff-only`, or has configured
`pull.ff=only` for `git pull`, but in the future it's expected that
--ff-only will be the default for `git pull`, and a proposed `git
fast-forward` command will imply --ff-only, in addition to `git update`.

So it makes sense to add the advice in preparation for those future
changes, although even currently it helps.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 advice.c        | 11 +++++++++++
 advice.h        |  1 +
 builtin/merge.c |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 0b9c89c48a..8f068c8be9 100644
--- a/advice.c
+++ b/advice.c
@@ -326,3 +326,14 @@ void detach_advice(const char *new_name)
 
 	fprintf(stderr, fmt, new_name);
 }
+
+void diverging_advice(void)
+{
+	advise(_("Diverging branches can't be fast-forwarded, you need to either:\n"
+		"\n"
+		"\tgit merge\n"
+		"\n"
+		"or:\n"
+		"\n"
+		"\tgit rebase\n"));
+}
diff --git a/advice.h b/advice.h
index bd26c385d0..6ce967c962 100644
--- a/advice.h
+++ b/advice.h
@@ -97,5 +97,6 @@ void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
+void diverging_advice(void);
 
 #endif /* ADVICE_H */
diff --git a/builtin/merge.c b/builtin/merge.c
index 05e631229d..56a526f42c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1619,8 +1619,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (fast_forward == FF_ONLY)
+	if (fast_forward == FF_ONLY) {
+		diverging_advice();
 		die(_("unable to fast-forward"));
+	}
 
 	if (autostash)
 		create_autostash(the_repository,
-- 
2.32.0.40.gb9b36f9b52

