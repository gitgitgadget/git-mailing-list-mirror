Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A093C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 00:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387700AbiEFA4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 20:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387714AbiEFA4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 20:56:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01725E772
        for <git@vger.kernel.org>; Thu,  5 May 2022 17:52:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m62so3572797wme.5
        for <git@vger.kernel.org>; Thu, 05 May 2022 17:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=17JncA1UqmPzconxBo4ZSLLykrmIkMxYtYVFOmCZKOU=;
        b=tIW1hSO8n6lbDuf7D7LMjfOR/hz7o/+bfgAPrQoLtgyEY1HN7EzNrugQ9mQKWBKMeI
         6yiYvsj/4O+SE6GdEdNo1VmvJ1eO4PhBlbf8phKFOm8WZ9HeWOFpGxYc85ycosjp4lsc
         ra5vNcYs1F5DRXjNb9o8VS+ZVjXUBrRMEh0WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=17JncA1UqmPzconxBo4ZSLLykrmIkMxYtYVFOmCZKOU=;
        b=VlnM2uOD2kha/aflX/3Vd8lfatwygymmEoY2BUwa/5z8i+QJYPTNNBrzqZyMVqU0k9
         UuYku6yeHG+Hn8s7lbRUgCtWHEttrjrueJYriRBoxMTLQQmgyHctpp2pOZodYjvyv8Pz
         F4krpXM2nqe5o1frPrtosuqh1NmTD897+vbIuiS07tKAyzjzlhGfL+JqDXkYwHMSCCVB
         KMdI/+spJnnXI98KBXp+R/SRPndihKfMVjZ2GF+lnZZgT6CWSU0SoPQd1Y6TiB81lcDs
         YryVi7e0KoeGhQZmKVxhxIM21u8hP61HjaG6NJa7LGYoKdNvYJgUhmL7EriDA+bWu7ff
         P32g==
X-Gm-Message-State: AOAM533HxSEf2iv578KLRz7es2xRVqvRV3Sux9XJZPOqXuu2cHuAL7jX
        yyV+eA996IFGDW3Ib0SsZOyIfhoHDO/6JBWraFI=
X-Google-Smtp-Source: ABdhPJyjSQjAC2VwfC5+hAG1iXDi/ucRO0kTmgo2KxYiNu/PVHhZYfKll7ENPnhpVVPL5pbYXB8H8Q==
X-Received: by 2002:a05:600c:3b93:b0:394:57c8:5901 with SMTP id n19-20020a05600c3b9300b0039457c85901mr776841wms.77.1651798375751;
        Thu, 05 May 2022 17:52:55 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id d21-20020a05600c34d500b00394431ac1a3sm2753748wmq.17.2022.05.05.17.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 17:52:54 -0700 (PDT)
Date:   Fri, 6 May 2022 01:52:54 +0100
From:   Chris Down <chris@chrisdown.name>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
Message-ID: <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
References: <cover.1651796862.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651796862.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows seeing the current intermediate status without adding a new
good or bad commit:

    $ git bisect log | tail -1
    # status: waiting for bad commit, 1 good commit known

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 builtin/bisect--helper.c    | 25 ++++++++++++++++++++-----
 t/t6030-bisect-porcelain.sh |  9 +++++++--
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9d583f651c..ef75f0a0ce 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -404,6 +404,21 @@ static struct bisect_state bisect_status(const struct bisect_terms *terms)
 	return bs;
 }
 
+__attribute__((format (printf, 1, 2)))
+static void bisect_log_printf(const char *fmt, ...)
+{
+	va_list ap;
+	char buf[1024];
+
+	va_start(ap, fmt);
+	if (vsnprintf(buf, sizeof(buf), fmt, ap) < 0)
+		*buf = '\0';
+	va_end(ap);
+
+	printf("%s", buf);
+	append_to_file(git_path_bisect_log(), "# %s", buf);
+}
+
 static void bisect_print_status(const struct bisect_terms *terms)
 {
 	const struct bisect_state bs = bisect_status(terms);
@@ -413,13 +428,13 @@ static void bisect_print_status(const struct bisect_terms *terms)
 		return;
 
 	if (!bs.nr_good && !bs.nr_bad)
-		printf(_("status: waiting for both good and bad commits\n"));
+		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
 	else if (bs.nr_good)
-		printf(Q_("status: waiting for bad commit, %d good commit known\n",
-			  "status: waiting for bad commit, %d good commits known\n",
-			  bs.nr_good), bs.nr_good);
+		bisect_log_printf(Q_("status: waiting for bad commit, %d good commit known\n",
+				     "status: waiting for bad commit, %d good commits known\n",
+				     bs.nr_good), bs.nr_good);
 	else
-		printf(_("status: waiting for good commit(s), bad commit known\n"));
+		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
 }
 
 static int bisect_next_check(const struct bisect_terms *terms,
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a02587d1a7..d16730a2e2 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1029,18 +1029,23 @@ test_expect_success 'bisect state output with multiple good commits' '
        git bisect reset &&
        git bisect start >output &&
        grep "waiting for both good and bad commits" output &&
+       git bisect log | grep "waiting for both good and bad commits" &&
        git bisect good "$HASH1" >output &&
        grep "waiting for bad commit, 1 good commit known" output &&
+       git bisect log | grep "waiting for bad commit, 1 good commit known" &&
        git bisect good "$HASH2" >output &&
-       grep "waiting for bad commit, 2 good commits known" output
+       grep "waiting for bad commit, 2 good commits known" output &&
+       git bisect log | grep "waiting for bad commit, 2 good commits known"
 '
 
 test_expect_success 'bisect state output with bad commit' '
        git bisect reset &&
        git bisect start >output &&
        grep "waiting for both good and bad commits" output &&
+       git bisect log | grep "waiting for both good and bad commits" &&
        git bisect bad "$HASH4" >output &&
-       grep -F "waiting for good commit(s), bad commit known" output
+       grep -F "waiting for good commit(s), bad commit known" output &&
+       git bisect log | grep -F "waiting for good commit(s), bad commit known"
 '
 
 test_done
-- 
2.36.0

