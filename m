Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D37C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7282208E0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="UxUliOcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgD2Wjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2Wjm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 18:39:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C64C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so1832993pfa.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9p4GzULsIw7Ze3ZZseCqf4KsvtZHdtvnA7ukG6lznSU=;
        b=UxUliOcYdgnxuGn9y0NSWrTAGbml0cVo0l6db92jlwaRIdILRdKRcTwPGDkUSFTNL/
         420lq/1+7vh4cIlZOba1D+Bwn1f4bsSuX7RsqMuN9WB3WgjWBGSZmx4Nnqwe0nDXtwh5
         EuiJGdpOI71LGRlSVCzyAfYKzPCte+3zZx9aZw8/8WreON1dDwsFQPkAziq8lr8sUKjL
         UVWYdorg78/yliuGjfXwXsB1LJZikGv3iwvPKTVqo+CS4YyQJdzzx69JqHajILwId820
         RvyKFq1kJIifQOpYvGGpSn7wiqVeLlAwOhEZ0ahqownIknNuL8M95f7RAX586Kz/7v1P
         ameg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9p4GzULsIw7Ze3ZZseCqf4KsvtZHdtvnA7ukG6lznSU=;
        b=KCPkhLiSg1WUDt+JhVIsO1OPY5Vya5GSSMDIb6B/JdRK4/ySYfH4ZisSrMy3MhyrZr
         NElXm48M4+db4aBrqNgPgSMxQ6R0JWWWSLppM4BJNQZ/tY2C/2IvziWvJG75TOJqj5JY
         FQuebGFObWTj2zVViiP9L+1XHCeYpxrUbx/qlH8Twe2jYiwsRFNzD6xL07iklRTsuwHR
         2Tc2GfIUa/QvDe3fQ41T/SimDj8QjH+9K5yolJtFR+OnVw4RDQe7x3vnuXamZ7OBR7UR
         3AfJ7gGTfzwBRM8DjQxe5PQ2Xp1p+HcVToCswqozBKNmm4l4zMinSXeenJU49tU0Vzqj
         ibAA==
X-Gm-Message-State: AGi0PubWWppyA0I7vIpXF7wsYokK0r8rHCC/8esioLbN/mYNZEWO1hHb
        sP9296IMle9Mzyw1FH0IPo4gplirSSEaLWOi
X-Google-Smtp-Source: APiQypJFoPvSxASMJ5SKEjSfhMktLyp6alMoV8PjlmI4ppFT6NDc7wXHMUBNefbOonuYk3vWVYS1Ig==
X-Received: by 2002:a63:c70e:: with SMTP id n14mr395388pgg.249.1588199980330;
        Wed, 29 Apr 2020 15:39:40 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g25sm1801571pfo.150.2020.04.29.15.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:39:39 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:39:38 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH 3/5] commit: move 'unregister_shallow' to 'shallow.h'
Message-ID: <65ecfeaba56807926fbe532f94921c98298e50d5.1588199705.git.me@ttaylorr.com>
References: <cover.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588199705.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the last commit, we introduced a header for the functions defined in
'shallow.c'. There is one remaining shallow-related function in
commit.c which should be moved, too. This patch moves that function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit.c  | 13 -------------
 shallow.c | 13 +++++++++++++
 shallow.h |  1 +
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/commit.c b/commit.c
index eebfbeb45d..87686a7055 100644
--- a/commit.c
+++ b/commit.c
@@ -246,19 +246,6 @@ int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 	return ret;
 }
 
-int unregister_shallow(const struct object_id *oid)
-{
-	int pos = commit_graft_pos(the_repository, oid->hash);
-	if (pos < 0)
-		return -1;
-	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
-		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
-			   the_repository->parsed_objects->grafts + pos + 1,
-			   the_repository->parsed_objects->grafts_nr - pos - 1);
-	the_repository->parsed_objects->grafts_nr--;
-	return 0;
-}
-
 struct commit_buffer {
 	void *buffer;
 	unsigned long size;
diff --git a/shallow.c b/shallow.c
index d0191c7609..76e00893fe 100644
--- a/shallow.c
+++ b/shallow.c
@@ -39,6 +39,19 @@ int register_shallow(struct repository *r, const struct object_id *oid)
 	return register_commit_graft(r, graft, 0);
 }
 
+int unregister_shallow(const struct object_id *oid)
+{
+	int pos = commit_graft_pos(the_repository, oid->hash);
+	if (pos < 0)
+		return -1;
+	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
+		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
+			   the_repository->parsed_objects->grafts + pos + 1,
+			   the_repository->parsed_objects->grafts_nr - pos - 1);
+	the_repository->parsed_objects->grafts_nr--;
+	return 0;
+}
+
 int is_repository_shallow(struct repository *r)
 {
 	FILE *fp;
diff --git a/shallow.h b/shallow.h
index 14dd748625..b50a85ed7e 100644
--- a/shallow.h
+++ b/shallow.h
@@ -8,6 +8,7 @@
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override);
 int register_shallow(struct repository *r, const struct object_id *oid);
+int unregister_shallow(const struct object_id *oid);
 int is_repository_shallow(struct repository *r);
 int commit_shallow_file(struct repository *r, struct lock_file *lk);
 void rollback_shallow_file(struct repository *r, struct lock_file *lk);
-- 
2.26.0.113.ge9739cdccc

