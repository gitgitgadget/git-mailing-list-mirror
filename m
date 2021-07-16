Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC3CC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 07:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F2A613ED
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 07:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhGPHqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhGPHqg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 03:46:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA3C061762
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 00:43:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso5206718wmj.4
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OYtjDf5ZNOvyAvpw0m92RYLwbyb4hTJv8srCTz7kdGo=;
        b=FOj5hej64ftxn4sjIiGQk1WrPa2R8kWJ3vrz9Gi99rc+Wdff6R/XqgVRZoM3Fi9b8V
         2SqDL96RsINS4ejySARTAzOGRsCfaZbitbbJEPyXyf3rSmH9xZ743Sh68hCgdtzokLCm
         PeGQEVG8whscWJFu96p2eexaFBQC73eWaNm4lCAhSnu5jiJCqyBYSJpg7mbainQW0gAs
         M1SaZctnK0ypYRfSZAnwdmMYAHYykevvvAVj22UEVqzou4vb7cQIBbGjJ67vJtIeq29F
         11haseldN2WWbqKtuExYsDM/I7WQ8WgU+zbMI3N+vYj0xCGzVQpnCUq7SQNseiPOg4GD
         dnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OYtjDf5ZNOvyAvpw0m92RYLwbyb4hTJv8srCTz7kdGo=;
        b=eKB6vAHNYhoQypoMarr7ViWcExBzLkCet956JPVAhSHMK3e+h+4YxYQilcuSRnh4ne
         KRpidK7AAzpQOHXmm+RLgK2Pt0tYE2NDf9zRqHw8G/2NpNsHoHCgF5oJx4WcHxdrahZq
         +6IOREH6dTuX1adjX0JatNu9dDjgGhbznuXUrWkWW760jqvs8S5+C/Clkoxw6Kt/QtVL
         K1GpRYDmY0GZhSxsci0cLoIdpibKuCEn/GFmarx14ywQwTmj9phUlYjTdWYHm7J1Yqpi
         neSpI6ftIuci5DsIgAD0BE8bL2TiRMykS5JBk9QiPteex8em3jxA4XQR930L4lxcxKgQ
         WyrQ==
X-Gm-Message-State: AOAM533/idKaQj1orb9iA1AxnzqRfrASXot6FSaOZ6TfwY4YzeZSKH6s
        xAQSWQvMchkGwjjvLguneww4JFf7nJ4=
X-Google-Smtp-Source: ABdhPJyPAU6ILt/QO9qKAhBXvA/9V8/kiABEFKr5Bz2S7VS5nFMN5cS4YUuxhomBhS6e3uQEijVNnA==
X-Received: by 2002:a05:600c:5107:: with SMTP id o7mr9051067wms.184.1626421419307;
        Fri, 16 Jul 2021 00:43:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24sm10241985wmi.30.2021.07.16.00.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 00:43:38 -0700 (PDT)
Message-Id: <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
From:   "Luca Weiss via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 07:43:36 +0000
Subject: [PATCH 2/2] merge: make sure to terminate message with newline
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, Luca Weiss <luca@z3ntu.xyz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luca Weiss <luca@z3ntu.xyz>

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 builtin/merge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f54..646bb49367f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -867,6 +867,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	}
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
+	strbuf_complete_line(&msg);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
-- 
gitgitgadget
