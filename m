Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC4FC11F6A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F2C61369
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhGNAOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbhGNAOr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:14:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B715C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:11:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a13so863806wrf.10
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7gj+DZei8E9e0VwSCpLsMuOWMal2dpeeC+ggO3micU=;
        b=IbUXl64aSPABpwAgIeUE4mxHRTPqtUWzE6l/+xK2+MVOji3op2n+ZjFA4APEltgSwn
         +bDWxd795VSel2WapyiebwF5LNzJPNLE45I4n4mv6lCt+4pjyk533WzSo8+tcPx0V4yw
         CKHYTwSWaxYqAp67aTGGwgX7A7aMPy8ROHiPpR2AUjjx3hTBrfRYVf/wHpvvDCSAsuAO
         UDhMMhXJOjoWflmjrHASf3dW2jbfALvBVZz/bTQPgr4ZUykncAGKNqepDspFtay8o6aV
         z2l35o58/8xtuOsuwNUsg2bnY1SXAp7dw0Jl0iNnUJR/xuki+YNIEgehcClZGEqdgBXI
         UJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7gj+DZei8E9e0VwSCpLsMuOWMal2dpeeC+ggO3micU=;
        b=We41VkwWcV+xYxYT+2CrOa41jgX0bGJTsXRpi9PRO66O9q8YU4EIW/5YDzPHSnXrUE
         x/A2RzEnW2Zta4fL2gHnKmRMux96vJGZezu2guMEHykatAH4d+3F0jTMvys5QtcdqYvq
         z3kuucFy+PzJIEFeAN7MQxt8DVyrt5iJztu5mRpj+i52by/ysRIDVV2nMXnnnbRbBYpR
         xnIK5pRj7Ut6s+je2MzoXd/k8fkSrGbKLzR1pHVDo+2UuWhAcMvpiFs8ZV7MYY3/x9BG
         EEQ7rNkbZk6FyTJlnPsf091ZF6kS60XUYCDu2F9771dE52LrR2q3Dd+fe8RqUaA7fUIu
         GaUg==
X-Gm-Message-State: AOAM5323HzxFO/iVueVi/pWOpEpjEY4mTlUSYVisAJbN4NltQ9vaqM+c
        hIgbNW7ZxrCL4iUFE10GkznJk8NVu2YQ7yps
X-Google-Smtp-Source: ABdhPJwipcrZ9hyvLJbEduJAWaQrixebqSeTlJQHOIOpBLx9MW7V3FEzbZdP0r11TeRTJdGvPvi22g==
X-Received: by 2002:adf:de84:: with SMTP id w4mr9142873wrl.104.1626221515032;
        Tue, 13 Jul 2021 17:11:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x1sm442382wmc.31.2021.07.13.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:11:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] SANITIZE tests: fix leak in mailmap.c
Date:   Wed, 14 Jul 2021 02:11:49 +0200
Message-Id: <patch-4.4-b8062a09f9-20210714T001007Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
References: <87czsv2idy.fsf@evledraar.gmail.com> <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get closer to being able to run t4203-mailmap.sh by fixing a couple of
memory leak in mailmap.c.

In the free_mailmap_entry() code added in 0925ce4d49 (Add map_user()
and clear_mailmap() to mailmap, 2009-02-08) the intent was clearly to
clear the "me" structure, but while we freed parts of the
mailmap_entry structure, we didn't free the structure itself. The same
goes for the "mailmap_info" structure.
---
 mailmap.c          | 2 ++
 t/t4203-mailmap.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/mailmap.c b/mailmap.c
index d1f7c0d272..e1c8736093 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -36,6 +36,7 @@ static void free_mailmap_info(void *p, const char *s)
 		 s, debug_str(mi->name), debug_str(mi->email));
 	free(mi->name);
 	free(mi->email);
+	free(mi);
 }
 
 static void free_mailmap_entry(void *p, const char *s)
@@ -51,6 +52,7 @@ static void free_mailmap_entry(void *p, const char *s)
 
 	me->namemap.strdup_strings = 1;
 	string_list_clear_func(&me->namemap, free_mailmap_info);
+	free(me);
 }
 
 /*
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 0b2d21ec55..c7de4299cf 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -79,6 +79,12 @@ test_expect_success 'check-mailmap bogus contact --stdin' '
 	test_must_fail git check-mailmap --stdin bogus </dev/null
 '
 
+if test_have_prereq SANITIZE_LEAK
+then
+	skip_all='skipping the rest of mailmap tests under SANITIZE_LEAK'
+	test_done
+fi
+
 test_expect_success 'No mailmap' '
 	cat >expect <<-EOF &&
 	$GIT_AUTHOR_NAME (1):
-- 
2.32.0-dev

