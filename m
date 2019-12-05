Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF54C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6E22173E
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJcFwIhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfLEX6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:58:02 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:45766 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLEX6C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 18:58:02 -0500
Received: by mail-qk1-f178.google.com with SMTP id x1so4929864qkl.12
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 15:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3usFiUwIXpR2FyFUo+EvXFfeYKgh/HZKVsx9TxDbS74=;
        b=TJcFwIhSLYvd2wKwJ6CWFuT7sxu7uSyeLYkAqkRxJQxpYTwB7O9AsfIz/z+Os+uJ9D
         mtmpdv/tRu7h0RFFzrXdExoERahdwt5kFi3ND15e9YTMant/hpoq0HJgQoGTGyU9wQ1A
         sufvDwwf7n+UipQiYZ+qO9eIVjKMvNujD2yeX4NqKDMcpEB/Wdqbv5jp8BrKRftgVexS
         BtccswZ4797Mzr0+amx+8k1oBVxtYCOuCnoIGdopiVBTbfJrMXynxvFN1uLhmP/m+bP8
         IINfWQmDPTtkJUuTIU2rhrSEkn6neCCeyLinxG/Q6X/SO3FA9xnKRoLtSZbfG6G+47UO
         sb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3usFiUwIXpR2FyFUo+EvXFfeYKgh/HZKVsx9TxDbS74=;
        b=GU0FnpZ3FhJK7ypS9Nzb8H/NbE7L7yIWLy2qXn3wWrzr+1TWteqZha1lvwo2VRQbW8
         xTB628bnpI9Q4gQeW8G3PX9djxaQT1JBpbDhVO6+WbKn7W/wfVJfA+qSapULRzDo8T5f
         +OfmNQbTh67hIkduba/ol/oHxfKSc4u5wwYGO4RW57boCGBmHqjNb2yCPh5zT7D7Haxt
         8IW5731iLSaulYiclNFsE1qy6FOpEbBiU6zao2/9G4arVRY0wbP1aBr2U/BDrA4QkugK
         FCAriPaOIhofmVZGhWeLYA/ZExufJcEVJuiJBB/mdFEc5DJ+fkAX/RJI+X7NyiGV0bsU
         z/Yg==
X-Gm-Message-State: APjAAAU/AnnTA2lKTNiVajPyDSXcDgOKtoD/L+rkywyddRcTlqtpVfHt
        Ny7BE+wOYuOBMaUmoYL7WWtTy9qgMQM=
X-Google-Smtp-Source: APXvYqzieBs4HraPqfvaAg9e9WP2FdHRXR0zRU/kJlegHw6bG4aMKk8FZNPzchRp+X5VqRw+P7qiiA==
X-Received: by 2002:a37:9c52:: with SMTP id f79mr11294239qke.371.1575590280761;
        Thu, 05 Dec 2019 15:58:00 -0800 (PST)
Received: from alex-torok-7530.int.uberatc.com ([216.99.208.249])
        by smtp.googlemail.com with ESMTPSA id q34sm4641975qtc.33.2019.12.05.15.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:57:59 -0800 (PST)
From:   Alex Torok <alext9@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Torok <alext9@gmail.com>
Subject: [PATCH v2 1/2] rebase: refactor dwim_ref_or_die from merge-base.c
Date:   Thu,  5 Dec 2019 18:57:03 -0500
Message-Id: <20191205235704.31385-2-alext9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205235704.31385-1-alext9@gmail.com>
References: <20191205225322.5529-1-alext9@gmail.com>
 <20191205235704.31385-1-alext9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pull logic for getting the full dwim ref name from a passed in ref name
out of the handle_fork_point function of merge-base.c. This will allow
git-rebase --fork-point to use the same method for getting the full ref
name before calling get_fork_point.

I saw other *_or_die methods in other places and using that pattern
seemed sane here.

I'm not 100% sure about the name or signature of dwim_ref_or_die. I feel
like it should be named something like dwim_ref_name_or_die,
unique_dwim_ref_or_die, or should be including the object_id argument
even though it isn't used by the calling merge_base code, and won't be
used in rebase.

This is my first patch submission for git, and I'd appreciate some
feedback on naming/style wrt to this.

Signed-off-by: Alex Torok <alext9@gmail.com>
---
 builtin/merge-base.c |  9 +--------
 refs.c               | 14 ++++++++++++++
 refs.h               |  1 +
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e3f8da13b6..edd16f9fcd 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -118,14 +118,7 @@ static int handle_fork_point(int argc, const char **argv)
 	struct commit *derived, *fork_point;
 	const char *commitname;
 
-	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
-	case 0:
-		die("No such ref: '%s'", argv[0]);
-	case 1:
-		break; /* good */
-	default:
-		die("Ambiguous refname: '%s'", argv[0]);
-	}
+	dwim_ref_or_die(argv[0], strlen(argv[0]), &refname);
 
 	commitname = (argc == 2) ? argv[1] : "HEAD";
 	if (get_oid(commitname, &oid))
diff --git a/refs.c b/refs.c
index 1ab0bb54d3..3b778f2df9 100644
--- a/refs.c
+++ b/refs.c
@@ -639,6 +639,20 @@ int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 	return repo_dwim_ref(the_repository, str, len, oid, ref);
 }
 
+void dwim_ref_or_die(const char *str, int len, char **ref)
+{
+	struct object_id discard;
+	switch (dwim_ref(str, len, &discard, ref)) {
+	case 0:
+		die("No such ref: '%s'", str);
+	case 1:
+		break; /* good */
+	default:
+		die("Ambiguous refname: '%s'", str);
+	}
+}
+
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
diff --git a/refs.h b/refs.h
index 730d05ad91..a961662382 100644
--- a/refs.h
+++ b/refs.h
@@ -154,6 +154,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
+void dwim_ref_or_die(const char *str, int len, char **ref);
 /*
  * A ref_transaction represents a collection of reference updates that
  * should succeed or fail together.
-- 
2.17.1

