Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F37C433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570CF22209
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgL2RJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 12:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2RJY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 12:09:24 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C10C061793
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 09:08:44 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d20so12378121otl.3
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 09:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHfDTQko7xjogX2qIZ9vgKqkR01FLXLg1Z25DmZlx8U=;
        b=BrPv6Y4ptUNwqT83A7Ny1c130RpQb8/NrbVlAoKANdMYnCRuR+aEBi8RwzY6l1ggrb
         PvS3FFuuRs+sagpo1dsbhT8ZAnhDJhEZBT1MWwGIZmuIP+DLYZflOHJJd+W1zfe8SJkG
         OjddNH/c3U+z75fuNwfAwX25d6YGCX64rFaJ001QXObQQ5otPVCPQzEEDuR7iRyGa+3F
         NbOrYtXhAr5VK9XcqAEuO7lzHNfyOVMtxNJIBKGmyAfrxz2hE9IpSFylYTtjpORtEhC0
         WkvpNa01ZLDusl3BCODavckNaiek0rYbFm+r8SvZD+6f6g1+SXAEc6GmtwXSBwHTDz43
         5UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHfDTQko7xjogX2qIZ9vgKqkR01FLXLg1Z25DmZlx8U=;
        b=XvE10KEdrbUv+UbHre31FQ3ls8Yg/8Rh62vtx7X0GLQp5ZCAe/xagXB91sgpHp2z8d
         kFlqNRG7k+J19tnDjOXcA6Pl1zNC+ggnZgBRXFHC3X1kpj0yu8j6gCgEdWA4jd7AutPV
         Zf49cjfQ0Pk9+kf/TcfhN//z/xjmrasgSr3gn/yAuL1ezWqfHoxuUixFvKWG/urDYLaw
         S3/rUvXssPSY9f/ytEL62WpMIYoJVRZxWV+m6j7Ul/fh9flVARwXOPIFdZIYgO8zDUw0
         zzAgDuq/Pr9EwFdCaDg0EkNwbSfQOjrm66M64Q20MFRAcar7dlAzhD0reuJkp07XPLyC
         EwIQ==
X-Gm-Message-State: AOAM533bbRID289d6oSarcdL2VijnEaPja0+83CbbfbNjIQRhHrFpIvq
        SkQ8nplDDs73TGgMeru117FRMg66c9Wgaw==
X-Google-Smtp-Source: ABdhPJwzppEH3lJ7Mdl7QaF16g+oIsGymR4Gxg8uZNSc11DWJGWgAufNJLQYoFjkPvwfEhidcoj/YA==
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr36698115otd.208.1609261723591;
        Tue, 29 Dec 2020 09:08:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z38sm9723824ooi.34.2020.12.29.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:08:43 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/3] test: completion: add tests for __git_complete
Date:   Tue, 29 Dec 2020 11:08:36 -0600
Message-Id: <20201229170837.297857-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20201229170837.297857-1-felipe.contreras@gmail.com>
References: <20201229170837.297857-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the function was marked as not public, it's already used in
the wild.

We should at least test basic functionality.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a1c4f1f6d4..c0b4380eae 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2380,4 +2380,12 @@ test_expect_success 'sourcing the completion script clears cached --options' '
 	verbose test -z "$__gitcomp_builtin_notes_edit"
 '
 
+test_expect_success '__git_complete' '
+	unset -f __git_wrap__git_main &&
+	__git_complete foo __git_main &&
+	__git_have_func __git_wrap__git_main &&
+	__git_complete gf _git_fetch &&
+	__git_have_func __git_wrap_git_fetch
+'
+
 test_done
-- 
2.30.0

