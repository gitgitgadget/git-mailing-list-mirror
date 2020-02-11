Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E69AC3B186
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05966206DB
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTu9prxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgBKPCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:02:31 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:35852 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgBKPCa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 10:02:30 -0500
Received: by mail-wm1-f43.google.com with SMTP id p17so3970992wma.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 07:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LxIOHel/GrQEdfV1pU2kk0B7HIvV6BmOrw6SemV3RGg=;
        b=MTu9prxWYUqtV93C9arQx39vGxN2daru4d4gojK7TKK3dBjVcyaM071JAStenDhrJY
         XeItzgnEW7r/m1XiyKnz5D7N1kC9sJIK9i/04bF9imV8/mTCT5L57lCUI1y/9nWWUbnn
         yZcPuzAyznXwXfgTFJprcIX8Htn/rZW/Dufvpjs6wrtM/VUu8YXlIBiRzd1YeWNCYtte
         umpJhlzhAC4HbBVbKRsuyBxpjlTemNT0mlQuv8D/eP1Zy6R3wKk21M8LUPBpUyqnJ+CT
         yPqiCtnWbawzyoXNcWqnJrsP4AuxUOh91WzLMyweJFsE/hHdHX/akR3pnQyAEmOUfak+
         4Afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LxIOHel/GrQEdfV1pU2kk0B7HIvV6BmOrw6SemV3RGg=;
        b=l/wGqC5FWW0TbRHcplWrRooSjdmia4col+Q7f7ZNChMXX+TwgLcCtC2UChoqLbinn5
         qx8pX2flmL3O9TdriQXUN2AS/Sln5yXgjuWpE4rKqPPOd73CFSoDP+mcdFbm1Za9pCmZ
         SJTBG7oY763dqlDgjsy7Ipd//wJHeXBO9efSUY5tAyuX3eZLWp8rkD1cMW97BNOPnuRt
         3CuI4jEgpGGgvwx3XLyvm5fQa1uA4Y/hJmAxCH0XLA0kNTTw1TCUPbDDrXDo6ldgLulB
         2nZUBSUF2tgQTavLEJVMs0d5T98TZKXkLLmyhYXy9o30PWrFp8HPbm0JujjJZ1ti4Bbm
         xsVw==
X-Gm-Message-State: APjAAAU+zo2sAKU5dkXwW0p0fCv7YOuKW0krSuwJpnFAsKAOskc0QXhz
        pLsPkAqWZ9+FzFGKfEAl5WLBXK3j
X-Google-Smtp-Source: APXvYqxXikzxB4q+pZxjv5xtlm/UA7J+nz2HkQiDc8brq4EjkzI/w9G+421x/cE+aFhARkF02LJiTA==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr5936004wmg.140.1581433348532;
        Tue, 11 Feb 2020 07:02:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm5792295wrt.90.2020.02.11.07.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 07:02:27 -0800 (PST)
Message-Id: <f770df489849fa8379a9fa18c023bceb788fd96b.1581433344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.546.git.1581433344.gitgitgadget@gmail.com>
References: <pull.546.git.1581433344.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 15:02:24 +0000
Subject: [PATCH 4/4] sparse-checkout: work with Windows paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When using Windows, a user may run 'git sparse-checkout set A\B\C'
to add the Unix-style path A/B/C to their sparse-checkout patterns.
Normalizing the input path converts the backslashes to slashes before we
add the string 'A/B/C' to the recursive hashset.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          |  3 +++
 t/t1091-sparse-checkout-builtin.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index af9e3e5123..3e314e3358 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -394,6 +394,9 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 
 	strbuf_trim_trailing_dir_sep(line);
 
+	if (strbuf_normalize_path(line))
+		die(_("could not normalize path %s"), line->buf);
+
 	if (!line->len)
 		return;
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index f9265de5e8..c35cbdef45 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -497,4 +497,18 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped characters' '
 	test_cmp list-expect list-actual
 '
 
+test_expect_success MINGW 'cone mode replaces backslashes with slashes' '
+	git -C repo sparse-checkout set deep\\deeper1 &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
+	!/deep/*/
+	/deep/deeper1/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	check_files repo a deep &&
+	check_files repo/deep a deeper1
+'
+
 test_done
-- 
gitgitgadget
