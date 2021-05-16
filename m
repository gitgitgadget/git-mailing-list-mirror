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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F31FC433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 20:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E6360C41
	for <git@archiver.kernel.org>; Sun, 16 May 2021 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhEPUjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 16:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhEPUjm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 16:39:42 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781AC061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 13:38:27 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so3893869otq.7
        for <git@vger.kernel.org>; Sun, 16 May 2021 13:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnVkSRyxpykR2vlm2BV6GmpIHVm5Z2uxB37bBUN3jzs=;
        b=Xx4FAk4KcV+yLAI/yWV78fK3inMKY77atDyFNE660JfydStf+qyp8FRFDrP3bXcLmw
         Jh9P3R+O/DmHSRi1tg3XW77/sXsdRfsacX0c12bgrQWqWmWwlziOsu9i5UzoCR3f8g7m
         P1SPfWfyfGlF7OgWPhUTFWPC3QQr7jrd/Qd1iBguPHl1Eq4Ba3WJ4CPwJP/FcBrXqVjb
         Drt1lVuX034P5SjNherf4tNcbnpa8YV9tqIs36xj5rt5GXNBpPMPyffmLNl/T/GeTHPX
         K9+7nOzwxTc2bi/Il6pApoOhjXbLvAIL30fS/EIvd4kBThkl25pgBe8J1c/xQ5mA6F7s
         kggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnVkSRyxpykR2vlm2BV6GmpIHVm5Z2uxB37bBUN3jzs=;
        b=tnI/S3jrIUDMWrw+Zwq3S0XsSeccWDgT0+uKIDTGE39kNZwQaRawUT19luuDx/dhrB
         UhOphQiGaCfqC27w7Rb2BBaCaKUB8+rvxJzKbnlOyieAkhg8f7F3eq+mNOsvTDswvZR2
         VY0/QPc7MtRx/a2KuOMH/mSqoWRVAX02qKNNdzSBnpoEuc2GM2i0i3stUtk1E7gaMwTk
         BLlaAqK2sMovOd+mm63FxpqEAar2d5z25+xTuGOR6SEc4JxmJsJmiOJV4ZjMzmRQG7U1
         Z3UzHNdWmHcNg/jeRscSsakYNZ8Dp//T7nXP7nMCBifq3bQkruIkzVqor680tmTr/4Hw
         getA==
X-Gm-Message-State: AOAM533PfLtG3TDA8Vgt+kqd6oz+QoYXufKK6EUiS09/zIdCCYyQweM0
        3J0LnqnqyY4H9bE7UwlGJ/gdPdjg+mvyVw==
X-Google-Smtp-Source: ABdhPJyhZ/++GCVnkzHJ8C3dQtzRzukm5MGcZU/+9hZ8asE1dZxIucb6j+v7M/rIpjdG8qeSFbDgpA==
X-Received: by 2002:a9d:2ac8:: with SMTP id e66mr5052751otb.360.1621197506602;
        Sun, 16 May 2021 13:38:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a7sm2752821ooo.9.2021.05.16.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 13:38:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: glossary: add entry for revision range
Date:   Sun, 16 May 2021 15:37:36 -0500
Message-Id: <20210516203736.1098072-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revision ranges are one of the most pervasive concepts in Git. It belongs
in the glossary.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/glossary-content.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 67c7a50b96..31151277ba 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -554,6 +554,10 @@ The most notable example is `HEAD`.
 [[def_revision]]revision::
 	Synonym for <<def_commit,commit>> (the noun).
 
+[[def_revision_range]]revision range::
+        A syntax to specify a list of commits, usually indicating the starting
+        and ending points. For example: `master..@`.
+
 [[def_rewind]]rewind::
 	To throw away part of the development, i.e. to assign the
 	<<def_head,head>> to an earlier <<def_revision,revision>>.
-- 
2.31.1

