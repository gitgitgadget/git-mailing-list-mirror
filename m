Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D9D1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeICWbh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:37 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37175 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeICWbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:36 -0400
Received: by mail-lf1-f41.google.com with SMTP id j8-v6so1034805lfb.4
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OCHO1Mbm6XXhoAeo7cGOonXxLrOWJeQM0VzBOeAzNYg=;
        b=A+YqX11+h7IRjkXbWINoPf8dQU2PVuSpBy1tIoRyYcqXV85qg4u+3CABvTXPvR13q2
         ta4ZBm1ycMxUflOAE620T1H/q+G2EGATVnMB0nczmZF22kimgwsq8hderCs0KmeIMLKo
         rI4p+gW90RMG8581rHuCCnd+2VWRVTA/04Pf+8VYnjV41n+Py/SF48/VmWZ27HPun14H
         9G/gzUiZbg38uJqxEM/4YQkzjYRzTgBdj4+fISoi5dTXG5O6eJVfbIpkf/Smo1bp6wZ1
         8fmwOklOLMT8Btk1B9RbrP5/J+J3ymnS1wE3dwAFA7mNULFDEeWzq+WirssR5bSQgvPo
         oogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OCHO1Mbm6XXhoAeo7cGOonXxLrOWJeQM0VzBOeAzNYg=;
        b=bk9ovqavaa0B5vDTJDuxJKL6GIxOURYOr+nhX1RcXjHpCBTKWe0dK7D27FGE2YWqTq
         t13UnudiNI/wbw79kdWrOjckrirctbXdGgQjpzyU1l/aGS8igEDIhIPyD7dx2hxpTVsF
         tYPBA4SmiVYnp/vJAw6q+al+db5vf96gPS+HMOTbGAkG9EfKI5dmJfXFv9Vy4yPUOWKL
         nDKsCGFfS0Jao0FLLInhL+elc1U06L9LEUSev/9Tf1e2ns3YdrpZHneECIDlHBIcGfOP
         gqCOwUHXIy08EcQLA5oo+snMig4q/BUz83TmNSFhLUvpArSJueCW2cgMRGer2/OdZ+pN
         ixSg==
X-Gm-Message-State: APzg51BWSorLBCgE4qmDEckvu45WEP542kbpU9JZKVeRjSFbeLh1q3AH
        38evrzWd2xQOUmLPZRwrwYk=
X-Google-Smtp-Source: ANB0VdZD62u9efgIgg9lAmZv5rz1ddGcj/su78RSMGwXA6gjDTgg3ysj8GnG8nzoRcdP5UT8gUwRSQ==
X-Received: by 2002:a19:a141:: with SMTP id k62-v6mr11770648lfe.18.1535998215754;
        Mon, 03 Sep 2018 11:10:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 04/24] combine-diff.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:12 +0200
Message-Id: <20180903180932.32260-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 combine-diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index de7695e728..4fa7707b57 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1054,7 +1054,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(&the_index, elem->path, result, len, &buf, global_conv_flags_eol)) {
+				if (convert_to_git(rev->diffopt.repo->index,
+						   elem->path, result, len, &buf, global_conv_flags_eol)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
-- 
2.19.0.rc0.337.ge906d732e7

