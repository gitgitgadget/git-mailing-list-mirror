Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40331C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 06:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B430C2083B
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 06:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsKKZibH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgJHGou (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 02:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHGou (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 02:44:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D3C0613D2
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 23:44:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so3455003pgi.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 23:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jvV9JS8vP+U4SNrFdLzFRwh6DlfZaqFCMp2TSNRdqyM=;
        b=QsKKZibHFNDS/cPLKNI24Sf1lQmLTBE/9MYQDE0wqQPgP3s5PH+aR+aI0TJit+yHff
         3vlH/5PFpS7AQf51LHkHLgVYYB1tWMftRFsamBO1pmcKX0rc7/PsaWU3RatSHnslHPaw
         vqJs3e/mJ15iiemZjTDbUBHy6x0gx/RxPFdDcgGqeeRjjru2e0wm9YdxvVjhyGuG5PM0
         74RYld2M2UE2UDnvY6C3RoXt7l6uoS5a0852iDDBCOLMYA5Zhbr6UMUNPzl6kE/FAD0U
         f0DkatK/oU60YCaSVNjFEijJ202e3taB5jpmOZyecoqh4V/8TNOhs3JSntv9AibisB9Y
         w0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvV9JS8vP+U4SNrFdLzFRwh6DlfZaqFCMp2TSNRdqyM=;
        b=cv0ltObVs7FvFiWKlw3t4H3yi207/X4Fy4O/b+46NBm/cQdENyQwWiGH7t7AjC7DZs
         kUV5ygx9NOszkuJ0FGx9UXxGVDLIVGwggJ/eUYJFvjB+KXE06w9BSaL8fk0TFxES86V+
         Wcf+V1jAhDziFRB6Qsm1QYu8PP2/4TLSV96qGA0t445G5GT/GS7wypLse8LzNYCKZTYJ
         nwPe8tSr+hi56T94JwSD6x3BKqbxXqqs/t11p03VplEdJnPZuGi/R/7uFXkcNbmE8NO0
         Xpai5hiGbW7GBihphMTYRcnMxQ/42UtvvoHlPQHRUieoNwtugIqQj3TyAQwTPt1giBD8
         QA6w==
X-Gm-Message-State: AOAM530xfIVdBuGAddOwisLM3DYR3uJzcu6LUy2zWH2rHZKICoSAtJlf
        IzEYRNU92/tz5RuAiyUtqFXZ1tq1ld8=
X-Google-Smtp-Source: ABdhPJyMkgz7bqtY9gdA+5BlSrea5IUTSk3iBex2j1Hx2enO1gCzg+36MsY/hvp16dFPhzSvV5gXBA==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr6202203pjb.133.1602139489419;
        Wed, 07 Oct 2020 23:44:49 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id u6sm5228232pjy.37.2020.10.07.23.44.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 23:44:48 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] contrib/git-resurrect.sh: indent with tabs
Date:   Wed,  7 Oct 2020 23:44:39 -0700
Message-Id: <5f5f1763043e80cbae6f9d4286aa5ba1960d32e0.1602139448.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0.261.g7178c9af9c
In-Reply-To: <cover.1602139448.git.liu.denton@gmail.com>
References: <cover.1602139448.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the git-resurrect script, there are a few lines that are mistakenly
indented with spaces. Replace these lines with tabs.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/git-resurrect.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
index 8c171dd959..57a77c03f9 100755
--- a/contrib/git-resurrect.sh
+++ b/contrib/git-resurrect.sh
@@ -27,7 +27,7 @@ n,dry-run            don't recreate the branch"
 
 search_reflog () {
 	sed -ne 's~^\([^ ]*\) .*	checkout: moving from '"$1"' .*~\1~p' \
-                < "$GIT_DIR"/logs/HEAD
+		< "$GIT_DIR"/logs/HEAD
 }
 
 search_reflog_merges () {
@@ -41,9 +41,9 @@ _x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
 search_merges () {
-        git rev-list --all --grep="Merge branch '$1'" \
-                --pretty=tformat:"%P %s" |
-        sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
+	git rev-list --all --grep="Merge branch '$1'" \
+		--pretty=tformat:"%P %s" |
+	sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
 }
 
 search_merge_targets () {
-- 
2.29.0.rc0.261.g7178c9af9c

