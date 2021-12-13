Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229CCC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhLMQCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbhLMQB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:01:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14297C061756
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p18so12265793wmq.5
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=bVw+zQ/iIx2nr6oVwjCIb0EbFYT4hokgRuw4UuUOOAltcgUqgfkhfbjHXqfgoCB4fp
         1o5TTVHIH2WTOhVD5EJliKovVqJPC1h/Xtv93jJ8sGiOGb2e+l3ZORnrV0mm/wnAjJ8Z
         Pa7XcMzOUuHGt+RNt8AY0fContsxAU+lX5PHwyt3dnz1NqV/HQicdXLQwN5eCEi20dQz
         yqZY3g7N5CByla3J0EK9BKSZaiRsa1rPxgCv8XqieQvOCTh60UsTnpQzFW3tsQzMW3fJ
         YRSfeLKin9cJIi69J42IEg4PaYDJYHr+m1HTsRu5XN3/H8JzwRU+FI41kpTBT48GLGpp
         zXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=SNqz5bCHWjfIgd9RYBOToojKOelOr5wOfFTJoYTO06NIsMvr2R97zqakEq95YrYsau
         piBzkUWOc25gHWfNfFE3F+/L7IwWyQ6jjRxTishMxgjbGcPSMsWutWSoJq8FGDXsVvG7
         gRCjVLx3DYqky21DMMlbiGrevKhGl1tKOjYPk9DrUidO2BuqJEltm0jMHS+/5QB3Xxs2
         jzJ+gi+QXYOgYQxigzGxF2UrRszbbixp2PVsNzEMNSsNOHeElejKuGfCdToY1JFZJeIn
         dvEFK9AQ9tzxCV7vnsWeucScoCHhlYWEDUtQNGF24CrXBzzTvzJZMQvH6o2tDXDOuTbt
         VBIw==
X-Gm-Message-State: AOAM530cu0eFLY4syzPsh7SkffjUJWn+LX6ZzvZ9eZsZfel0oAyJrigb
        CXhUMkShdgsef2nRG5Dbh712slwkDxQ=
X-Google-Smtp-Source: ABdhPJylZinJnhIQLXCQNv284EESxlUqWFMJ1gj6x4inCkWSYY97LV+RXu1dsTfrEzx6hwh5u3zHQA==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr38788125wmj.76.1639411317461;
        Mon, 13 Dec 2021 08:01:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm7512907wma.37.2021.12.13.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:57 -0800 (PST)
Message-Id: <36858e2070badcc057c53c630553ae731c0c7552.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:43 +0000
Subject: [PATCH v3 05/11] reftable: ignore remove() return value in
 stack_test.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

If the cleanup fails, there is nothing we can do.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d628420e63a..4b7292945c3 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -89,7 +89,7 @@ static void test_read_file(void)
 		EXPECT(0 == strcmp(want[i], names[i]));
 	}
 	free_names(names);
-	remove(fn);
+	(void) remove(fn);
 }
 
 static void test_parse_names(void)
-- 
gitgitgadget

