Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA10C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764F761159
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbhHFTNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbhHFTNl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 15:13:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525CFC061799
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 12:13:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c9so12278248wri.8
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3fZVBo9SQFqaHWUWLrML56EaNrnLV8DwTX0JbMq8g8=;
        b=Af5zCusEj1qarDUIdZ3rf8YPOoYZeK5vcary1q9NxeCvOjWPyFU06nv+lkONP/UR9y
         8mkAGWGYynreWxlLnzYdkHXcp6JTOOODeWqB0xHVKWgqRY6IyQE8p50ta9tf7St09GwJ
         MVwWMyy5dtlhYh4UyzLOR6N198W350il/8ZmDX5ebxCuKSAk4g3+SkMdRltNFzY1/EIK
         DYdjCPaCIcf5uwh331J1ehEYfLeN8UIU+uT6qzBF5WKFD8AOftskTcaY8bDNRU3kuMB+
         HCuCczkExKZsZck4qASzF8F1L5SCG1AMWbT0o48Dn4ka2+Kj5LEZh3bUq3fqHFEX9feg
         AGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3fZVBo9SQFqaHWUWLrML56EaNrnLV8DwTX0JbMq8g8=;
        b=j27qk8vqszwYnq8HkVXlUHTu9klk+m/p3+ZhJDZV5mABeu0UxegUmXEsmb74j13rE5
         zwjdeeJKSBpYgxBfv3ooIahOvYclbCWposU/OIiZt9LnmJ6/7dYa5DRcEMeBlxpfS5W+
         ami6MOVvwmQO+OrYMiwIsv26ygh6wpvlP3arQujeHgpuqTpauZQH9RLWcSeAmZJU/nSo
         hFeuLJRjZ6nYbxRGwY1N2ntepG22yyxV9A4UWtLdjNvVjC8AGilz3p8xSWVjxXnnTByA
         Kd2YoEeDF2sGn08fLIZcUnOWSFfFSaH07lPkR5syhqEgzrElQ5ZBsjrrTpaRG3D1+Mn1
         WTqQ==
X-Gm-Message-State: AOAM531ci3icNj8aPlxcaDHmEGWxoDZj+XV7XO6iAyAsCRo3/yQ3dsfk
        x7kpsxOT1f+K+h09HeuC6Nfz3VOVj6RStw==
X-Google-Smtp-Source: ABdhPJxg0TwIaX7ipKfgCFYr2U3DYnY8wKuWqutTVpgXDDHvOCvY/w0kbYaQ7a055s8EqTQ6c1ADyw==
X-Received: by 2002:a05:6000:18cc:: with SMTP id w12mr12198426wrq.96.1628277202718;
        Fri, 06 Aug 2021 12:13:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12sm11039849wrn.31.2021.08.06.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 12:13:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v3 3/4] advice: remove use of global advice_add_embedded_repo
Date:   Fri,  6 Aug 2021 21:13:17 +0200
Message-Id: <RFC-patch-v3-3.4-02613d0f30-20210806T191231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.680.gf07173a897a
In-Reply-To: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
References: <20210805230321.532218-1-mathstuf@gmail.com> <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The external use of this variable was added in 532139940c9 (add: warn
when adding an embedded repository, 2017-06-14), for the use-case it's
more straightforward to track whether we've adviced in
check_embedded_repo() than setting the global variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c      | 2 --
 advice.h      | 1 -
 builtin/add.c | 7 ++++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/advice.c b/advice.c
index b18833bc80..41cfea82d0 100644
--- a/advice.c
+++ b/advice.c
@@ -4,7 +4,6 @@
 #include "help.h"
 #include "string-list.h"
 
-int advice_add_embedded_repo = 1;
 int advice_graft_file_deprecated = 1;
 
 static int advice_use_color = -1;
@@ -38,7 +37,6 @@ static struct {
 	const char *name;
 	int *preference;
 } advice_config[] = {
-	{ "addEmbeddedRepo", &advice_add_embedded_repo },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 };
 
diff --git a/advice.h b/advice.h
index ed51db0f05..4b754f4c62 100644
--- a/advice.h
+++ b/advice.h
@@ -5,7 +5,6 @@
 
 struct string_list;
 
-extern int advice_add_embedded_repo;
 extern int advice_graft_file_deprecated;
 
 /*
diff --git a/builtin/add.c b/builtin/add.c
index cf29b302d4..8a5dd29f3f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -419,6 +419,7 @@ static const char embedded_advice[] = N_(
 static void check_embedded_repo(const char *path)
 {
 	struct strbuf name = STRBUF_INIT;
+	static int adviced_on_embedded_repo = 0;
 
 	if (!warn_on_embedded_repo)
 		return;
@@ -430,10 +431,10 @@ static void check_embedded_repo(const char *path)
 	strbuf_strip_suffix(&name, "/");
 
 	warning(_("adding embedded git repository: %s"), name.buf);
-	if (advice_add_embedded_repo) {
+	if (!adviced_on_embedded_repo &&
+	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
 		advise(embedded_advice, name.buf, name.buf);
-		/* there may be multiple entries; advise only once */
-		advice_add_embedded_repo = 0;
+		adviced_on_embedded_repo = 1;
 	}
 
 	strbuf_release(&name);
-- 
2.33.0.rc0.680.gf07173a897a

