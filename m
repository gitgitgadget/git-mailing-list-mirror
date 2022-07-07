Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14032C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbiGGQRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbiGGQRA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:17:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419661114
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:16:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id n12so20426558pfq.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0vdM8K2mbm+Cl+ZkmE3Ne+ZLtrnbM0pblWcQvZ3JZY=;
        b=ZqmZNb1smqIwXoU0SRH2MCQA2nZ6e+4lpZJ4/1kWNKWVfnrMvjSyLQ0hLFCZdTwM6e
         +42/Rrj8E2KxJhEhUC86XCqjWDYWDwQefBJ4xtODrh5Dl0njeV24CbbnY+HuPEjsbevC
         k/TqMXailHta9vzJ880N0p+qZVgLDO0HYr0xot817bwnY6MKugLw99CDYvjtqexpFwG7
         dF4kS+Lmp4tNe5R4V+8OXEVwxzlhCP0Z7fdbXea9f6kqXqqsdaZrYqQI6KTtdMUzYvF2
         Q8ba6hTdb5q+4hEMRg6DQ5bCKXc9K85Fris/lUn9KpDbQzo/HtJaF4sT4QcNGwadN2Vs
         XYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0vdM8K2mbm+Cl+ZkmE3Ne+ZLtrnbM0pblWcQvZ3JZY=;
        b=scTmrrkrH4gd2j4KQN6a3kr/i5+EVkEWLwwyTdxNFQA3xFl/ubP07wf1oldPkqE99D
         bjomoAXarcbYnU76VW7ECtv2bnektOkfnKwSJB3UunXpZIh05WihySBkcOTiPekLyDPf
         HxODVj1KjLQeLhZLxyYV6s2cKX1u5YxeIlomhGeykuUDtZv6BkPS9j/BwWfumyt6EzX6
         phxgIHe9j0fXmMjgA1gTdGZc2mhPJW/ffO6xk47kZBv49PIwo6W+s0I8c5Ep8E6kb1qR
         5AJUg9+Uf2ZknIBlAt9A2ZeLWGd5PZpnjg9e1kkhVn/qN6MyQ6qDjPOuNgRuWIq7OLOm
         1kaA==
X-Gm-Message-State: AJIora8tg9ZGG2OckVfQ41iuXGUYG6oJxEPno3pGR6Xzizs1fGg71bYk
        nlgmeY84y7/FJFn4lMIrcLx1Qjp50+0UqmkI
X-Google-Smtp-Source: AGRyM1uIpjQwNSN1Qx392DmfZ17CPW71wsGEiXdPPczMESEImgDmgscTaVOF9sZO8+mVZth244icLQ==
X-Received: by 2002:a05:6a00:23ca:b0:525:28b4:9e3b with SMTP id g10-20020a056a0023ca00b0052528b49e3bmr52505496pfc.43.1657210618193;
        Thu, 07 Jul 2022 09:16:58 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b0015ee985999dsm27996199plr.97.2022.07.07.09.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:16:57 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: [PATCH v2 3/4] ident: rename commit_rewrite_person() to apply_mailmap_to_header()
Date:   Thu,  7 Jul 2022 21:45:53 +0530
Message-Id: <20220707161554.6900-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.ga6a61a26c1.dirty
In-Reply-To: <20220707161554.6900-1-siddharthasthana31@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220707161554.6900-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit_rewrite_person() takes a commit buffer and replaces the idents
in the header with their canonical versions using the mailmap mechanism.
The name "commit_rewrite_person()" is misleading as it doesn't convey
what kind of rewrite are we going to do to the buffer. It also doesn't
clearly mention that the function will limit itself to the header part
of the buffer. The new name, "apply_mailmap_to_header()", expresses the
functionality of the function pretty clearly.

We intend to use apply_mailmap_to_header() in git-cat-file to replace
idents in the headers of commit and tag object buffers. So, we will be
extending this function to take tag objects buffer as well and replace
idents on the tagger header using the mailmap mechanism.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 cache.h    | 6 +++---
 ident.c    | 2 +-
 revision.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index c9dbe1c29a..9edb7fefd3 100644
--- a/cache.h
+++ b/cache.h
@@ -1689,10 +1689,10 @@ struct ident_split {
 int split_ident_line(struct ident_split *, const char *, int);
 
 /*
- * Given a commit object buffer and the commit headers, replaces the idents
- * in the headers with their canonical versions using the mailmap mechanism.
+ * Given a commit or tag object buffer and the commit or tag headers, replaces
+ * the idents in the headers with their canonical versions using the mailmap mechanism.
  */
-void commit_rewrite_person(struct strbuf *buf, const char **commit_headers, struct string_list *mailmap);
+void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap);
 
 /*
  * Compare split idents for equality or strict ordering. Note that we
diff --git a/ident.c b/ident.c
index 26cc60b2e1..8503098f29 100644
--- a/ident.c
+++ b/ident.c
@@ -393,7 +393,7 @@ static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct
 	return 0;
 }
 
-void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
+void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap)
 {
 	size_t buf_offset = 0;
 
diff --git a/revision.c b/revision.c
index 49d15e74ff..b561d6b5b5 100644
--- a/revision.c
+++ b/revision.c
@@ -3791,7 +3791,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 			strbuf_addstr(&buf, message);
 
 		const char *commit_headers[] = { "author ", "committer ", NULL };
-		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
+		apply_mailmap_to_header(&buf, commit_headers, opt->mailmap);
 	}
 
 	/* Append "fake" message parts as needed */
-- 
2.37.0.6.ga6a61a26c1.dirty

