Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E624C4332F
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiAVV4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiAVV4L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3C7C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso17123541wmh.4
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bDgafxTbt4Tmcf/t0AffhGAhMG7KX/dE6Xhg2Tw+H+c=;
        b=XpP7B9BJlxh7Vovzhn+T16jLMYVXoo2+Ro//x1Fr9LooVjwRJhoQtgq+em/q6vSQT2
         m7MHMh44eKaJUSE3gLQrfe4+cuzheaDwCGzAf4EdDMiRoaAvZE2813XMjgcI1N274QBc
         Os2tllqVGVkfJmoJXAOBIUeDafU9bOl/8No91dp0RzLduVHvbZ18Y3lA3eDK0L0XlaQr
         R0ceO8oc95LuAtemccKFAidmUD4o8AVhKLwhwC529YL/mhTyfuVqm4X8lRn+jnjrw0RX
         lRkNKWXdpdnkensrR7f2JYANXnKwMBIBiaVtDCD4+Y4i67zyMXdzptnFZqxN9NSJsQ0/
         reJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bDgafxTbt4Tmcf/t0AffhGAhMG7KX/dE6Xhg2Tw+H+c=;
        b=m7BjYuUZyUS3gNZDoFZAVK885km30RLrW1NwyRpUEP+uWI+KE78jkqL/XNQGgUjTVw
         +BxJs+Yk0iprI9Xys6CykRARoB43WCZheGs/HBF5l7hJpPRSbPuAh+wimRnxvAnbUM+n
         vDnErb3C07d+Tzc8msr2vLNx+qwkel26TGTWBqdVek5WuxD6k6G7HpV4RxMrYi79ceuy
         9VZ6o7bw5Kub/BVLxXSNkqAxYjwty4tORh7JjQnEeoF27NLCWBjwnz0ha4IL53j6wwxb
         AcZK4BNzd8pcr/XJuGNrDXNf/WC28ycPB4U5zTGy5LtSG/tR72+P5v/aP8MgIvOVpw2N
         Y4nA==
X-Gm-Message-State: AOAM531opPN6vEmXK0MBmRI6QYhbi0fYMzbJowBZSJNwD5EWkfsik0VS
        3X4QKFGmSu4jY6jcTHWu+C6G2HMg8Vw=
X-Google-Smtp-Source: ABdhPJzeVsBtszwGwSq2TLtY55yCOI6GwAx1jzInd9uvZzkbcj50fM5mHhl+jozxWOKZF5wBEp8z2Q==
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr5878327wmc.127.1642888569553;
        Sat, 22 Jan 2022 13:56:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm10094661wrj.23.2022.01.22.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:09 -0800 (PST)
Message-Id: <e3ef17eb46fdfd759030761ab6d7c35fbf24ee0f.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:56 +0000
Subject: [PATCH 06/12] merge-ort: allow update messages to be written to
 different file stream
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This modifies the new display_update_messages() function to allow
printing to somewhere other than stdout.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 7 ++++---
 merge-ort.h | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index f9e35b0f96b..b78dde55ad9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4236,7 +4236,8 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 }
 
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result)
+				   struct merge_result *result,
+				   FILE *stream)
 {
 	struct merge_options_internal *opti = result->priv;
 	struct hashmap_iter iter;
@@ -4263,7 +4264,7 @@ void merge_display_update_messages(struct merge_options *opt,
 	for (i = 0; i < olist.nr; ++i) {
 		struct strbuf *sb = olist.items[i].util;
 
-		printf("%s", sb->buf);
+		fprintf(stream, "%s", sb->buf);
 	}
 	string_list_clear(&olist, 0);
 
@@ -4313,7 +4314,7 @@ void merge_switch_to_result(struct merge_options *opt,
 	}
 
 	if (display_update_msgs)
-		merge_display_update_messages(opt, result);
+		merge_display_update_messages(opt, result, stdout);
 
 	merge_finalize(opt, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index e5aec45b18f..d643b47cb7c 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -86,7 +86,8 @@ void merge_switch_to_result(struct merge_options *opt,
  * so only call this when bypassing merge_switch_to_result().
  */
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result);
+				   struct merge_result *result,
+				   FILE *stream);
 
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
-- 
gitgitgadget

