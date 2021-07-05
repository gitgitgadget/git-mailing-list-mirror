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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F422BC07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58F5613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhGEMe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhGEMe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:34:57 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C6FC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:20 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id r29so4176015oiw.13
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zUFu2zuIjC4xz1tJv3wiAI3LhueGdoPq4NGJJM+hK+U=;
        b=JjU6Ry8xAJUJ3w31f5P6jziDw2rdVVyByBQ3iz2spjCW3k8HlBTqzPK3q0L3NpvdNb
         o2VgBHhgJuNKvvxjiaOWPu24nEh/x5wvcqu/aQ/4/91aiMe6u8w8yerOoV+qSfH2/MQv
         m9WOIukrCU5cC3PFJ8QWgdzIfF5/FNBFfS5ksXkiInHXWbufGgYco9ShYoTYA2MgLs81
         PtHlaz3s/mzAQK2sWEestiPhsV+f9IQUkGWzkiYhhbTtV8C7QyUbXquDv1799vOetRvX
         ReNdGIVBu7Bm+MZPkzz6gUw07lO/BJ/BXdAU3kTCDiiV3QjC5zi33rNCgxQiYiwPDx5w
         Q2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUFu2zuIjC4xz1tJv3wiAI3LhueGdoPq4NGJJM+hK+U=;
        b=ZFD9in4aFsup63upXgwLPISEtYonVA3kFONhlsZzyLF6MebidggXibgihNo/lcC5QK
         mShZXLBjsLfajTyjcOcPYC/S2Pp9y+jxpEjd8bLa2g3b+Tcj1j+fuqwOHZaHV6TEu02j
         UM7di6XHIvAATNXNtAFe9S8dvqKHGqJ7teoqmqTj+oJVL/RVVnn9HPRrfWIoAT3kVNBO
         swcka+FSyItdRY6fAEFFYJnMUyEePRugsrYfNJKEky1CIuCUjfQGuL7/ANLSWpzD4SUq
         clEnMvTuKmJuEGIgRoEjUA0fXEnCxoxDeUNPCPddFFJ/IDYueBIPJotclkv/XTH+vfCs
         dJcg==
X-Gm-Message-State: AOAM532EjM+9qzwBx3zIAoLccLtj1y6c3WRsv00gqTGcxRnjRY6s5HZI
        +VEquC1U2Qbsnxpw7/RH+Dul9gJKdomdHw==
X-Google-Smtp-Source: ABdhPJwjJ91824XHAZEthsbKgP77RtllSe4R0TlnsKwxagnRXpcAqCQDX1Srv2u/AkOGYzAVSfWSgg==
X-Received: by 2002:a05:6808:2115:: with SMTP id r21mr5508716oiw.10.1625488339919;
        Mon, 05 Jul 2021 05:32:19 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id e18sm2631729oiw.27.2021.07.05.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 05/35] fast-forward: add advice for novices
Date:   Mon,  5 Jul 2021 07:31:39 -0500
Message-Id: <20210705123209.1808663-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It doesn't hurt showing it on `git merge --ff-only` too.

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
index e396943d37..1836f98f82 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1625,8 +1625,10 @@ static int merge_common(int argc, const char **argv, const char *prefix,
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
2.32.0.36.g70aac2b1aa

