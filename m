Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED42EC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2AA206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx/14rRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgFOMua (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbgFOMu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4CEC08C5C2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so14528728wmj.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pB4Zzq+iSN46ZNzJn6oMCB4ZWQ4ZpdYh9fLS2uFvHro=;
        b=gx/14rRwmlMJi79bIqoljsNEPZraaGOCN3gpLVpKnAsre4r6ZXZ+ED8JaclhpD8OgV
         A6CrX+nSsw0DxQQc8eyNTRbhklLSXuJ9u22nHw6aCwNORHKnALxceT4tI2kcJCAPtFQ6
         yJn09g7cEQuCwhecrHIYv1Pph+vM9dIn2XTc+1JoVsdlORJjO5j1DEoJTFJ5VkaTPQS/
         sJ/KhvfwtVgm7HXS1H6EuIJ7TSBRUhzJ/zbBhQXxglOjuJHxX0aQUhDsA+xQI3VY0DHR
         h7sNrMhrE3dbZ5dZSiv4YUK93imTyLHMP/IfvBSLHspKzkNcnQl+yhdkyAgZVF4DGOxe
         FmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pB4Zzq+iSN46ZNzJn6oMCB4ZWQ4ZpdYh9fLS2uFvHro=;
        b=S3hv5RnxsWDeBZVBZE60WMUcRTR/ffPd1tUz/P/VzPOfq5h+q82gze3lZcdp4X1nrr
         McLh+qxynPk/yVWEYDx8NYUWrQVLK1Lned3CpAmKMEJe/lxrdFjDqAvLp8dfoAeEjqqh
         uPc4l7norWelmPX7MGQVLIlvzuGlbxoYSyJ4QFzWy2ao550NBedIv3CWntLex4XBQmzE
         7qMJdD/QqJP8sWJP9ddIH3Gn/7crGKDEBCd495dF2OHUitOkN2m47M9qKCOieD3OLtiD
         Gyp96tHDhJHdbVBy229SJKyGnvKvfBnzHWC4gBlmi51KOQFVitMmFx/koxgpF/2jcv8M
         IXPw==
X-Gm-Message-State: AOAM532bi/PdK5tpKUhRPAMK8l0AVlQg6WEzPqSQBQYpXsVBHx1dmWF2
        D87T/shSDdcsgi6i8Z+KxRvKZjGp
X-Google-Smtp-Source: ABdhPJyovDNAveuirDs9vidZptDXquTyrNTiIEmrhvAnhgByYNRmaeSD7NLVs+7RfytauR3ggjadGQ==
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr7125907wmj.169.1592225423147;
        Mon, 15 Jun 2020 05:50:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm23928571wrt.6.2020.06.15.05.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:22 -0700 (PDT)
Message-Id: <a3be4f39aa240e614a2e12756e1ea864c35137a2.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:09 +0000
Subject: [PATCH v2 05/12] fast-export: handle overridden main branch names
 correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When anonymizing commit history, we are careful to translate the main
branch name to `ref0`.

When the main branch name is overridden via the config, we will want
`git fast-export` to use that overridden name instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c            | 11 ++++++++++-
 t/t9351-fast-export-anonymize.sh |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1072bbf041f..deeb01b6937 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -515,14 +515,23 @@ static const char *anonymize_refname(const char *refname)
 	};
 	static struct hashmap refs;
 	static struct strbuf anon = STRBUF_INIT;
+	static char *main_branch;
 	int i;
 
 	/*
 	 * In certain circumstances, it might be interesting to be able to
 	 * identify the main branch. For that reason, let's force its name to
 	 * be anonymized to `ref0`.
+	 *
+	 * While the main branch name might often be `main` for new
+	 * repositories (and `master` for aged ones), and such well-known names
+	 * may not necessarily need anonymizing, it could be configured to use
+	 * a secret word that the user may not want to reveal.
 	 */
-	if (!strcmp(refname, "refs/heads/master"))
+	if (!main_branch)
+		main_branch = git_main_branch_name(MAIN_BRANCH_FULL_NAME);
+
+	if (!strcmp(refname, main_branch))
 		return "refs/heads/ref0";
 
 	strbuf_reset(&anon);
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 2415f0ec213..f42be635c2f 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -31,6 +31,12 @@ test_expect_success 'stream translates master to ref0' '
 	! grep master stream
 '
 
+test_expect_success 'respects configured main branch' '
+	git -c core.mainBranch=does-not-exist \
+		fast-export --anonymize --all >stream-without-ref0 &&
+	! grep ref0 stream-without-ref0
+'
+
 test_expect_success 'stream omits other refnames' '
 	! grep other stream &&
 	! grep mytag stream
-- 
gitgitgadget

