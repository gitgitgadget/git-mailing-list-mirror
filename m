Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7581F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390424AbeIUVrY (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:24 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:37594 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUVrY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:24 -0400
Received: by mail-lj1-f169.google.com with SMTP id v9-v6so12113456ljk.4
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=834Qk02aWwZS8GOZHqG2A9vgI9K0cTmHcwV+ppqEPR8=;
        b=Tbt0U2uWfanlwwblfmAxqsG07NlBX69WLVDtvlRIHSBOuMrEBMTQtlH5voYky8iR05
         S7w/q5ssktK+BLbnOHAUtOE13R/W2McW6XiM+/VI+VUKHoHJVGghC1Z2XnSjj82n9cie
         CgM8zqbiK6Hv99Y6pSADEwtriIZqkvelIHIuCfrvfSOGpmvortznHaxSREGukPZd3g+d
         BoOTPmG7chIaKqjfDQROuZI00RMxjQZv14ZHkQ/fYMcfdfuHCjG9+2bhTjMfaedz1WKH
         Z5ms5afEYxgxKZZAoT4MBC+K7O1G+WXNqWk6FOAPhtoR6JNIyFC88wzt/NUzfI+mE9vl
         xGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=834Qk02aWwZS8GOZHqG2A9vgI9K0cTmHcwV+ppqEPR8=;
        b=IWmtd+M3gpCVFrYzfE3hhH9p7rjZnOnI1UboxU7Qc5yQaO5hNndpbdbZ2ObDw0d8jJ
         urleoh1f79GpAwDUxrIZnC2TXsO08ejm+p3b2dhkGGzOlVu4VGd+pyTzQlNuAuyQ5AE6
         I03XqnMlWClqPYef5ZekRUfzSRwQnDjIqRhGLwzTsLQuHuy0Tc5KSaeGAH0NvZs/rgdX
         78Sa6GYA/LlQJpdrGB1MFkV8sqYoXE3GK2cQLM7Kzkn+9GT9ggrmFG3bHCED4KcChFCl
         d/LoVYeHzFDm0bVOaDTSadh6bSROYyEWvqaecdbeUPV1D7FywQ650+EEzzfFPE2/QGhM
         Y+SA==
X-Gm-Message-State: APzg51DIj/cZAkA1IQHY5vOMXLkbaeuHiBTvA83i1lZpH7TMvsdDk1x7
        RgvO5sEmM5aL4062Fcpvmg79M71O
X-Google-Smtp-Source: ACcGV62+nGBM4QzqMTox9pYsCNTvtIoHjSCflZX5aEJTDt2eB22CW1Xwl3A2WS4Tggsi1GjVsp7w2g==
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr2479605lji.140.1537545472508;
        Fri, 21 Sep 2018 08:57:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:57:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 04/23] combine-diff.c: remove implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:20 +0200
Message-Id: <20180921155739.14407-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.19.0.640.gcd3aa10a8a

