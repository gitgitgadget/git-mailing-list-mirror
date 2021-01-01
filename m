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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC704C433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F122076C
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbhAACRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbhAACRv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:51 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F602C06179B
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:36 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j20so19301079otq.5
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1OvwvSaPbcju0K9Lw23EMlod2d+0ovSPHyqMRPckSA=;
        b=aEApIACdtONc0nibzPP3HdCFwsEP58q4Lx6rTLbgNsAEWZ0b15TH6sJJ5z5tBdnI3U
         oHzy9aXHGWIU4qdjoQV+iItE6kbyidb3xUtLh2EPjLenynYqZnXcwv8rbVuC+fwyokXT
         DHxSHnZS88SLOzIbrU51nnqPMz+T32vNZoydelpEeQLVOMMHkHrB2IRkDCeIzWkBQIif
         nMSBPkMG7KIrHvT3YjHiETHXbyeFIsAbD72tZVGQTyKl0IytjJeXddKMtooH99Dso6Wa
         KQiMu5DuFRdwVRRMMT6e8tviFk1BOhml/7jsE8XJ+buvoiemGrrG8IoTekX8q5cwIjMJ
         wSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1OvwvSaPbcju0K9Lw23EMlod2d+0ovSPHyqMRPckSA=;
        b=uJyLb1oMq5l7c5dO1DWecCEpN3W9T8+AddC+cKm0OMTGnGNIJaVyZTvJmKEwySBq7/
         7osn4xBSdSVgSc7aO5SbNKyTbobyfFZZ1p6VFb/8MVD48YuYWmGswX+aSoN9JQxO/+Ig
         bZaKhPxVXMQJLU8+mSpA5TfguuheZUl25G8XSLbApRrGTNqhsUIRsADs5KjQugyfCOQ9
         qLqrMu/gG7SwwA5xMQtL/sanZQ95C3ZmU73Tob6kYGG+poEXepCVt6/qRcqK5oaJCLP6
         d3z0/DnybsNAmvKrJdD1qiFIzb6mVFbsFBqsTIocgFleCQ3YoN9mTBdJuimmBnlGtz6o
         VBGg==
X-Gm-Message-State: AOAM533Tzzw3PlneCLLWpY2EKZDl+qtQXB3zTRyqei6DR1eoQkRnpuad
        RX/nnEs/BhNmvanOOTmtAhHWYayQwaywSQ==
X-Google-Smtp-Source: ABdhPJwElkhucJsNo337VKux/s1wrH6ipoK9d8kJx3BgmrWtxOJvvUUrenSM4W6+FZC9MBHitIOY8w==
X-Received: by 2002:a05:6830:1c24:: with SMTP id f4mr42554734ote.108.1609467455391;
        Thu, 31 Dec 2020 18:17:35 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w9sm11775404otq.44.2020.12.31.18.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:34 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 45/47] test: completion: add tests for __git_complete
Date:   Thu, 31 Dec 2020 20:16:20 -0600
Message-Id: <20210101021622.798041-46-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index 6366242408..01984692bb 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2379,4 +2379,12 @@ test_expect_success 'sourcing the completion script clears cached --options' '
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

