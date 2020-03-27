Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE9C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBECE206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPDE5ssl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgC0AtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34993 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgC0AtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so10606454wmi.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oRl/+uTmfJN6FxLa/jXKO0a4rPGDCzDcacd+tS7ExEU=;
        b=QPDE5sslJQdANtpEL1PoTPiO8McqVGvwXF+dpmxxUkeYD9A7ZVDmaq8FJVPAQo1k6r
         T5Ey/eaW/rdyDe3RLp1e1PuudZ52KJx/vuTKHTExUJ+VUCHWAiiyUX9jl4eZPo4zc/H7
         GWYzr2taBiqjmR7+dIdcTEx3Qvp6TcHj8z6z70RzyFyxabNytMsj1KQ10Hpl9ohXVvOm
         pZolrTYsRjktcNZZ1kPXCG3qN+xMMbbZY0t6RqFGcR2/Wp/nMsoMV7gd6pE54Jpw13Pe
         thiw6t13b/u/cDmWejMs1YPZ80tyocURab3+6OFwRzKK9IA9zA8DSVm2bNeq/uvC7Wch
         0xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oRl/+uTmfJN6FxLa/jXKO0a4rPGDCzDcacd+tS7ExEU=;
        b=RHhhXwhR3i77k3FZuipZw6TqDOSac6+/2U+QqUCIGRzsOEpL4yTUUPBkQ3gbRnU4cW
         NMd39OTG8swvtoM5dcv7gYIIWjb0+5Yh+QfbIbd0xBwuIoJbC0wcUGO8racoysR2Cd/U
         DTHhpBJnarFRusko1nJHFfejW8sZbV2qbwOwLaJVyUUkosSz8HLUZOEfI+GdZTGjaEQm
         rGB00TEc1l5qoDHPa0xl2/yuYUet4HNsUJn/IbmguOT7bh2H0RHmDQMHNVCsrLbqr2Oy
         SzSN1eymDXmzoHNbUdHtLWqKP2IK4zPJvmT97zehFUVRomQBRimMwnH0pGWm7C5jgETG
         ZL5w==
X-Gm-Message-State: ANhLgQ3Ur5avv07SI36XRv4hmne7h+oTxCHbHP7y2MX3K1AlMUzqThm9
        WlB3RS+zGBWQT08DWFdZzQ2mFozt
X-Google-Smtp-Source: ADFU+vtpXiJWZbdiRdgGBl0efMek6MnjCR2FrDTBfMnP+VjLWkzKGYsV3HoH9Y+xWXYwMhYQNcAf6w==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr2499201wmf.157.1585270147937;
        Thu, 26 Mar 2020 17:49:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n124sm5461157wma.11.2020.03.26.17.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:07 -0700 (PDT)
Message-Id: <555eedf538030b9c9560a2f9d3cbd0ad1db026d5.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:49 +0000
Subject: [PATCH v3 06/18] unpack-trees: allow check_updates() to work on a
 different index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

check_updates() previously assumed it was working on o->result.  We want
to use this function in combination with a different index_state, so
take the intended index_state as a parameter.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index d2863fa0310..dde50047a82 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -353,12 +353,12 @@ static void report_collided_checkout(struct index_state *index)
 	string_list_clear(&list, 0);
 }
 
-static int check_updates(struct unpack_trees_options *o)
+static int check_updates(struct unpack_trees_options *o,
+			 struct index_state *index)
 {
 	unsigned cnt = 0;
 	int errs = 0;
 	struct progress *progress;
-	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
 	int i;
 
@@ -1665,7 +1665,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 	}
 
-	ret = check_updates(o) ? (-2) : 0;
+	ret = check_updates(o, &o->result) ? (-2) : 0;
 	if (o->dst_index) {
 		move_index_extensions(&o->result, o->src_index);
 		if (!ret) {
-- 
gitgitgadget

