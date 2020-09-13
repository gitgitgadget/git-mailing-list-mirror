Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF003C433E2
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5362151B
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc7L3y8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgIMOy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgIMOyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 10:54:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8930CC061787
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so10442203pfi.4
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxKztw7Q/6AdB8llgxdlv0K+gwCJBhRRyClPI4IQ39U=;
        b=nc7L3y8AVIJMKTmo9DbneZV0vJiwhOvtpy3GFolskDJsVIOYG4vyKQdlhmdkOgZsU7
         SmDyhGPyRAtglBWXFRFk0wvYSJSIDG2n25oEpenNcP8AwZLbZxONhtq5ePbme0S1kYxn
         CGq/xfU9MT7rbCj6EfDw2B5RGPBxV5xqKyVMTIzgBSvs2Yogh9Jord711Or0ZCJNeitS
         sZIEPdjHyOQHokRYPPiXz1dDsee2P2xy3Nw5PjQOFGSsz3aT1pVEh/vC7rXWMNmJGlhN
         xvMNiP3HC6cWMKCEW3ilVo8Y/8u1lbjWdf90mMi8x4H3vYxUyHxIwRHxbKa4sTokhMHh
         Jd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxKztw7Q/6AdB8llgxdlv0K+gwCJBhRRyClPI4IQ39U=;
        b=ZAQLX95JWR+46jv/iZb7VXV7KYZ1WKdnghzk/ZRpXQc7DbLMlYKsxCyccRDN//RF4U
         gTvqah2zuRlwpNuqEQ3UaXWqXbFVxgRRb2XKAYdlIC/bP5GFdaTHcC5UuHrIW5yeL9Xz
         rDJwSaMcVFSybHvkDtvhltg7FhE0KCd3n/pCvC2V+wSSfj5M4oOAULoOGPG38lRIeFLP
         JfqdT6Oy/8dxjFT0OtJJyTJn3ITxCNEJTe8gxFTp0DKsN4akxI70mN87lC08jg1Y4PO5
         8stVdzYayiPJhHvl1AN+EhfvKRaKJrZL/qb3RJ6iIvBEv/GxKC5nrliad9KLhqHLVsl2
         64Ww==
X-Gm-Message-State: AOAM532HFkirXWDVJjj7qEWvV6vOz2qsZcbVdEO6pg6JjRPxeu+Hc316
        yahjy1mnBumIdMxzJmpvOqSHGcmtG5olsSUWHTg=
X-Google-Smtp-Source: ABdhPJxiVfVeRj98OYExelvAZKP7J5TdDytpMrvOCkKlEqvHwPwHD+uU338lBFJAENTIQ1VsSsey8w==
X-Received: by 2002:a63:4450:: with SMTP id t16mr7944583pgk.3.1600008874561;
        Sun, 13 Sep 2020 07:54:34 -0700 (PDT)
Received: from localhost.localdomain ([66.115.146.77])
        by smtp.gmail.com with ESMTPSA id z1sm2774650pfj.113.2020.09.13.07.54.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:54:33 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v3 3/7] send-pack: check ref status for "force-if-includes"
Date:   Sun, 13 Sep 2020 20:24:09 +0530
Message-Id: <20200913145413.18351-4-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update "print_helper_status" in send-pack to catch the ref
status ("REF_STATUS_REJECT_REMOTE_UPDATED") that is set if
checks for "--force-if-includes" fail, and add a string
equivalent of the ref status for printing.

Update "check_to_send_update" to catch the new ref status
when setting "CHECK_REF_STATUS_REJECTED".

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 builtin/send-pack.c | 5 +++++
 send-pack.c         | 1 +
 2 files changed, 6 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 2b9610f121..4d76727edb 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -69,6 +69,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "stale info";
 			break;
 
+		case REF_STATUS_REJECT_REMOTE_UPDATED:
+			res = "error";
+			msg = "remote ref updated since checkout";
+			break;
+
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			res = "error";
 			msg = "already exists";
diff --git a/send-pack.c b/send-pack.c
index 632f1580ca..956306e8e8 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -240,6 +240,7 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 	case REF_STATUS_REJECT_FETCH_FIRST:
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 	case REF_STATUS_REJECT_STALE:
+	case REF_STATUS_REJECT_REMOTE_UPDATED:
 	case REF_STATUS_REJECT_NODELETE:
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
-- 
2.28.0

