Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C57C3DA7A
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiL1SBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiL1SA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20984E0D
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:47 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso11786817wmb.0
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vxc1r2VMMf1AcPqEB+7kqDSs6wiBRkSxcD1PYJY90Zk=;
        b=JNp9MXZ6C+rJkve5pAHvlmIeUbxndEmnHaRulSs5m18Gj32QVXpUcW/vIebOGr9JH7
         tUi7klJ+vNxfhbRXQD6Ln6Q7sLmYCBOWxBDytkXjwf5bYphgGLfCYiVCHU1zco3ziiSC
         nHgkyMtqY90LD2/qZl2EfahJX3Hs8STafNbXUAx/wNUAUJDQmOeH0vb0N9MXEgqNMCod
         bPQ5cqfkJ5+Iy6biPy0x8EP+g6woF7X67jMj4BCjEbgbuQA/FJKTaNE4ahxS69rBnMYd
         +RNTMwlBtpXpSjn5UiWYP/e8vRsgyqcT//7hEsyRPfhq+jGR/qB1L5/8zjerbkA2n7dt
         mPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vxc1r2VMMf1AcPqEB+7kqDSs6wiBRkSxcD1PYJY90Zk=;
        b=m8So+XzwuyiSkd4LWGnAxbSwXp81DUq2FjPxdMNcRSvBMO5kv9x4fGg/3yXawkxcci
         ucQk3Ng01cWtVuLYCaq07jzdixA2MYULYytb85acXNOzpCngP/RxtdcuzleAg85P971/
         75AUQX2H7BJ8w8bkAMuGBHOm6TOwEHGhBHao5IBSO8ZKEP+OtQb62iPKI/IYpO8A+USE
         otg7fLzWnYeLqzeWCv/wtbzWRW6vfq7wfVVd6MCJb/u/CjAgH5tm1tglQ1R2uakB8XYN
         izwXekq7vPV1Bqf+0jVWepCpMz2aaZmkGclqmf0r9l4EqMJJhYFKJyphO2XBpXXIeVf+
         zfig==
X-Gm-Message-State: AFqh2kq1FbNTptFNQ6L6RPzH6Yxfkg7jtQLbOaGHXkUIJdHqZpp3QFJm
        MZSdSMJ8O0NyFlwRcfAuVbNN1eu2+nxDRw==
X-Google-Smtp-Source: AMrXdXvQkFACPYor25PXmA/4DVKI/czDfpnXZFNQySZE2m3fELUeYPoEj2FyNkytuqEJy8lp8ZlUNw==
X-Received: by 2002:a05:600c:601e:b0:3c6:e61e:ae71 with SMTP id az30-20020a05600c601e00b003c6e61eae71mr23439436wmb.1.1672250445313;
        Wed, 28 Dec 2022 10:00:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/20] grep API: plug memory leaks by freeing "header_list"
Date:   Wed, 28 Dec 2022 19:00:20 +0100
Message-Id: <patch-20.20-8ecc68c3e93-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "header_list" struct member was added in [1] it wasn't made
to free the list using loop added for the adjacent "pattern_list"
member, see [2] for when we started freeing it.

Let's start doing o by splitting up the loop in free_grep_patterns()
into a utility function. This makes e.g. this command leak-free when
run on git.git:

	./git -P log -1 --color=always --author=A origin/master

1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
   not union, 2010-01-17)
2. b48fb5b6a95 (grep: free expressions and patterns when done.,
   2006-09-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index ca75514f8f6..c908535e0d8 100644
--- a/grep.c
+++ b/grep.c
@@ -769,11 +769,11 @@ static void free_pattern_expr(struct grep_expr *x)
 	free(x);
 }
 
-void free_grep_patterns(struct grep_opt *opt)
+static void free_grep_pat(struct grep_pat *pattern)
 {
 	struct grep_pat *p, *n;
 
-	for (p = opt->pattern_list; p; p = n) {
+	for (p = pattern; p; p = n) {
 		n = p->next;
 		switch (p->token) {
 		case GREP_PATTERN: /* atom */
@@ -790,6 +790,12 @@ void free_grep_patterns(struct grep_opt *opt)
 		}
 		free(p);
 	}
+}
+
+void free_grep_patterns(struct grep_opt *opt)
+{
+	free_grep_pat(opt->pattern_list);
+	free_grep_pat(opt->header_list);
 
 	if (opt->pattern_expression)
 		free_pattern_expr(opt->pattern_expression);
-- 
2.39.0.1153.gb0033028ca9

