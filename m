Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2991C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352257AbiCaBOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348295AbiCaBN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:13:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCEE66222
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so31533020wrd.6
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pqKm6VmJSFgUuPrCZxs+ajeVxhUbnakSBJrb0HTSttg=;
        b=HL89k1ZrP7wR+tiJKEf2lYixqP6I82CQcMHPKXVpSLuLn4uXYnfgCx311Tc0MUYZQo
         XI0hvGvkwSEBOtIAZMZP7tYGQhP4QxYaiR+KGE4I8QpdsAXBnUDdiKG9SxoLPb6BJ8pE
         jyPdc2DE66fGgXnKJ1keJLOHSom2HdpEWpy0D1+LWDfPaxswehYSN+84MNrjcboqte4C
         oSIA4y7Yy0zhA+BhIT790zmX2WG/N53oXQgiN0IvJSWAohZ9V8n1OPHIVUkWsvQSwuxT
         iHKqWCYtrQ6W2YMZJfSFHkomKatZKK3RhG7alPQYdm1J7F8IyRzGqGze2bIxabSLbtjK
         RJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pqKm6VmJSFgUuPrCZxs+ajeVxhUbnakSBJrb0HTSttg=;
        b=mvOjK8IKrKfjt1GpTLM4es3aVnXXQdqCPI0iC1kGKiHlf88f4SAbtF/cy3Y8h5HInP
         y8zFIC/efrkuLQlDbixYBkGuRrOSfqWfAuwfrGhrz258wAbwad3T0UDe60oM+H+4pwC1
         NBmP4o0D62eDSMeDCWogTAorA6x6SH5buoD1jFB74HSdIknlPTFFWPzvVzQPwHpmYyTm
         O4XtVROLnlTgWUxrnIWo7vXV/NW8LnRRpkJvROWrM77fmcIF8og/IejSXzZn+QDFezDY
         +rIgaN06WWf9choLqM3OY3ypQjY5L9S82pT1ZMYFPHwBegmHSDSczl6TsZgQ6V0brwPT
         XWOQ==
X-Gm-Message-State: AOAM531VedmwbCmiB4r0gNpI4fmgbPQ0uCQgR0SxUNeJWfRxmyKPoDcW
        oiOqWhyZsj+IVWdGGE75kk1PT4D8TneXNQ==
X-Google-Smtp-Source: ABdhPJwtF5xIJeKf2Ys1um+tThDKfA5wO3q5uGKCbSV/oNbN31SoEBw7pxBPMp2iVD+gA5l6nV7LRg==
X-Received: by 2002:a5d:63c9:0:b0:203:e78a:248e with SMTP id c9-20020a5d63c9000000b00203e78a248emr1937244wrw.29.1648689129858;
        Wed, 30 Mar 2022 18:12:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/27] revision.[ch]: split freeing of revs->commit into a function
Date:   Thu, 31 Mar 2022 03:11:10 +0200
Message-Id: <patch-v4-05.27-2d0ed57ec2e-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the existing code for invoking free_commit_list() and setting
revs->commits to NULL into a new release_revisions_commit_list()
function. This will be used as part of a general free()-ing mechanism
for "struct rev_info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 7d435f80480..29f102cb83d 100644
--- a/revision.c
+++ b/revision.c
@@ -2923,6 +2923,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	return left;
 }
 
+static void release_revisions_commit_list(struct rev_info *revs)
+{
+	if (revs->commits) {
+		free_commit_list(revs->commits);
+		revs->commits = NULL;
+	}
+}
+
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
 {
 	struct commit_list *l = xcalloc(1, sizeof(*l));
@@ -4080,10 +4088,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	 * boundary commits anyway.  (This is what the code has always
 	 * done.)
 	 */
-	if (revs->commits) {
-		free_commit_list(revs->commits);
-		revs->commits = NULL;
-	}
+	release_revisions_commit_list(revs);
 
 	/*
 	 * Put all of the actual boundary commits from revs->boundary_commits
-- 
2.35.1.1557.g4e3e9cdb5e0

