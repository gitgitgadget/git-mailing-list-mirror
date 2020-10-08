Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF24AC43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 07:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722262173E
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 07:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUdfZTWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgJHHbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 03:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJHHbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 03:31:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120BEC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 00:31:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b26so3280760pff.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opJcOU49FvPcMH0Zakz5rDRSpMUaulUUbtuFhBAfh50=;
        b=jUdfZTWf8msUJMkHYUkQSFjmSWsVLQLnmXzbeA89wbb/V0kvEgYZDx7+NIPBU1hH2c
         oIirGwwVCO3GzxwzdMOI1J9SFLxA7kGoIrQQ1KooQl0cjCokm5JBfqCsTg+NlRaelTuD
         kdHuDhN7C08TC4flIuPz5iqSW4FpiO885Ts3/BOlSlskFBfU6JxmuvzhKLo8kwYuMZgi
         iUxLs2AWu1HhOP3wlJF58qpG0VurOR5yS53M00rkIs+MdIg51g5J5zrVfcEXKdLT9Tcr
         yoKHxRhhnqHQi+6Sur8OimLlzaOHUVHjxGCkVDD1bbhc7Hmd36UHt497Wy3cdogOn2Me
         ZnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opJcOU49FvPcMH0Zakz5rDRSpMUaulUUbtuFhBAfh50=;
        b=Xj7DP8ny4lQ2YuQNcZm0aiw1Z2MijVEEIA3tswR1GUqS99Yxe3wvMvK4zvx5F0UlRd
         Z5TCmZX77Z+yPG9b8y/bZ/2X3XMqHYox7APlKxOMJ6pySHHyQFz7r94HSt1bBYwF3q3U
         fcozeAB+VXr2O1/jxRnfH9vuZCohXVY4l55wJ/PUEtg5/2igx3U0hwu6XG9Y0Nqnqhbo
         6/A2WjB6v9xHMR+kVTlvFCCbw2vV1Rnmm4rh+obK8hAj4wNWDipjQ85eklyUMAw5QQ7P
         EhBX4El19he+lkLSafa9O8jcBW/45nMMV3ZnuhB5bLtcEbljvrHw6/mi8KtaBpj7OuCp
         Emsg==
X-Gm-Message-State: AOAM531qnt5Wn9sE2ev+VgA6SMxnbszbgrkL6+7dyNJHU/ddEjVhpFFC
        ZrBYtwzuGEXlkVy8ksETY/Mav1l6HqY=
X-Google-Smtp-Source: ABdhPJyGVU5qCqYv98+mXKqsAm5XaVFbv4oljrjhzvBMpiDRk69/0gLIAftce7V5VpBmcOSN85leWw==
X-Received: by 2002:a17:90a:2ec8:: with SMTP id h8mr6951181pjs.173.1602142271253;
        Thu, 08 Oct 2020 00:31:11 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id n12sm2111250pjt.16.2020.10.08.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:31:10 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC PATCH] Makefile: create externcheck target
Date:   Thu,  8 Oct 2020 00:30:55 -0700
Message-Id: <1c2ee1c40ccde18a008262aeaf23a17da2064eae.1602142232.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0.261.g7178c9af9c
In-Reply-To: <9e5a8625cab217bd6aaba68da081bc801354b903.1602059508.git.liu.denton@gmail.com>
References: <9e5a8625cab217bd6aaba68da081bc801354b903.1602059508.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b199d7147a (*.[ch]: remove extern from function declarations using
sed, 2019-04-29), we used sed to remove extern from function
definitions. In order to help find and remove future instances of this,
teach Makefile the `externcheck` target which runs the sed script
included in that commit on all applicable source files.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    I run this target periodically to ensure that no new instances of extern
    function definitions are introduced. Is this something that we want to
    consider adding for real?

 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 5311b1d2c4..791faa24cf 100644
--- a/Makefile
+++ b/Makefile
@@ -2885,6 +2885,9 @@ COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 	fi
 coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/coccinelle/*.cocci)))
 
+externcheck: $(filter-out $(THIRD_PARTY_SOURCES),$(filter %.c %.h,$(shell $(FIND_SOURCE_FILES))))
+	sed -i 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/' $^
+
 # See contrib/coccinelle/README
 coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
 
-- 
2.29.0.rc0.261.g7178c9af9c

