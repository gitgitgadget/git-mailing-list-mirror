Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C7C433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC25D61A40
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352640AbhKOXbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352973AbhKOXSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A6C03E03C
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so892741wme.4
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBTHFeF2xuht99TkFxVGmjMkaaVfBTSRSLeznh60UMg=;
        b=C+Lwq5dqnJZ8cYDVNUG9RLGAr76BQjPPdz1fkbUxiC4dbSf9CnIIbPK7mN3wkltirV
         X/T/4QA7zMs7jhvpkqjU2err2rnUWhYFZ2flQWrAmXyBuh2pZZWOjk+rlAcCr7a2jXJ3
         /6po/ViyURwbnLq2gIT7w5vsN3C8zO91Py5RlNxOPSn/q9nesNNV7KgxQohTUjVA4mn3
         hTXEgnHfJivVeqMZOkpL3IShhIyUQ7pW7QQlpBcfEcAzmk1RuH4eNEWInkUNG4SoPvcL
         UfHGEqwSMtH4kbT9mbzcSizz7ugJ5DF7bQwbpCnKML1VsD8uqvo41hkFAOl1QP64RdLW
         KrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBTHFeF2xuht99TkFxVGmjMkaaVfBTSRSLeznh60UMg=;
        b=xXLSVtH7i7dmP00LABqohrkeITE5S9fjaPsHRvDNWlV7WO2DxRWVa5/5fSvxjbmNO8
         bo1NEVi8X9NXy7uZOR05IRLQ1knegN8OUd9jlj5+VlMXKcIkzDxYj/QdYX9qkMUrvsHt
         n6iAiTLp0euefePM7U/SIsVidHx0TIAUuuGViWeLrhjeoJwNWwLDk0qxd1LwOIq7ZjLT
         NTeTVACTSe1sB6+zJwPpyfNy3BAwMLVz5nLct9V036Rg/9O2dO1lVQfDqGNEVBfFkqre
         +7cEfJ5gQYfK+F0K+6JfRMnvZCRfotAEF2KfyjtfhFWZtoQQPOvOYRsb3gYGONFLS+9Z
         8w9w==
X-Gm-Message-State: AOAM532f9vEZU2OEvLZttYVRIwHfxUl2K6Fm/nrURxVVUiEI0/VlDpYk
        fST349Onet68U/x5plA8JTmwEC+52VepOQ==
X-Google-Smtp-Source: ABdhPJx7UqSCi1sL3vK64Pyn6BltVgRrOSx5bmN3ux1TZWPkEGVMbKuDbwUTtyR8jgAYBSKQk25FAg==
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr62490831wmq.109.1637014724847;
        Mon, 15 Nov 2021 14:18:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 15/21] usage.[ch] API users: use report_fn, not hardcoded prototype
Date:   Mon, 15 Nov 2021 23:18:25 +0100
Message-Id: <RFC-patch-15.21-d5b84097bf3-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a couple of users of "report_fn" that hardcoded a definition of
it to use the definition of report_fn instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.h       | 4 ++--
 run-command.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/apply.h b/apply.h
index da3d95fa509..8dca3703d3b 100644
--- a/apply.h
+++ b/apply.h
@@ -106,8 +106,8 @@ struct apply_state {
 	 * set_error_routine() or set_warn_routine() to install muting
 	 * routines when in verbosity_silent mode.
 	 */
-	void (*saved_error_routine)(const char *err, va_list params);
-	void (*saved_warn_routine)(const char *warn, va_list params);
+	report_fn saved_error_routine;
+	report_fn saved_warn_routine;
 
 	/* These control whitespace errors */
 	enum apply_ws_error_action ws_error_action;
diff --git a/run-command.c b/run-command.c
index a790fe9799d..4792d170be7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -362,10 +362,9 @@ static void NORETURN child_die_fn(const char *err, va_list params)
 /* this runs in the parent process */
 static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 {
-	static void (*old_errfn)(const char *err, va_list params);
+	report_fn old_errfn = get_error_routine();
 	report_fn die_message_routine = get_die_message_routine();
 
-	old_errfn = get_error_routine();
 	set_error_routine(die_message_routine);
 	errno = cerr->syserr;
 
-- 
2.34.0.rc2.809.g11e21d44b24

