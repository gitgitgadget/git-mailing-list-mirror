Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD6F1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeDFXWJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:09 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38613 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeDFXWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id y69so1795491pfb.5
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K+oNQZp5CPaaNuuFCcdJ4swyM7D6CmSmCrQPdIrp1cg=;
        b=Er5cQFRC8Anx5Tg8J7J8bpzx8mm8lHVYAa21bHp6sitUlpztn7H3pF7SFS6ycA3Qp6
         ifW0JhyhSCK2l/z1D/fKLtWNaY5khp4ScjyYgf6Oz4vDF+nKPZTbWLjBD8KGRrVKljM+
         sFcOvmfhNI9TuEYuj4nQw++CBg1j4NilqnEq3X+TbAagAFmV7mZzmmTSy6SVeukE5n2k
         7Tv9Gsl+zF3cK48GWfp67CKhhhUciImppdCHMC7lxiD1TFzcqRAUww00wnSVGBo1Kys/
         bEstRHs15r46l9OUb3Dwdu2GmsFhGlsuNuSugsh08kTEc80SaQLXJpjgE/ZVyX9YNTm4
         hgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K+oNQZp5CPaaNuuFCcdJ4swyM7D6CmSmCrQPdIrp1cg=;
        b=OITIlLz9UOKWS7bvKhFujU6YBykdiySpn8Yr5yE9pFZgjxELqdL0ZB9CFu7zpkFe+O
         AwpRbjvqHKxo1JSJ9yONJpALqxxSulINVbsozIHWKydX3Z2th2aO/jt6OErCg6MtZGZo
         AT3ce4FlhunBP0M/42uZ4ZVfALNWtiJ41B14q3k3kx5UAv6bKuLaxmKf9RTr2U8FzAiu
         7vQP14xQpk4y8mE/FcHxtwkGZKFqgtsguFSzZGDdibjEc7x2Qn3fDxEIfxDbDpjcccpR
         eqyqRPYfqDspBi/yQDx0cB6AVTlhIVTI7+H/HMOBCtakpQxTHxGFuBMTilk3+F4I1Wxb
         hoFw==
X-Gm-Message-State: ALQs6tDxed96MKOIacy+sJlWeMO7hdf3kP8FusLshmuSjnqDdDLMY4XH
        qFWda+yJG1GvQzoyu9rOA25ghg==
X-Google-Smtp-Source: AIpwx4/4Vl52GAio/bjnPHntO2zQlfj9wOdUVvQlSwhQODsZPynVGLaauJSslJs/COVMe+Lu3GO1xA==
X-Received: by 10.99.123.71 with SMTP id k7mr7283146pgn.245.1523056927229;
        Fri, 06 Apr 2018 16:22:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b65sm23889728pfl.145.2018.04.06.16.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/19] replace-object: add repository argument to lookup_replace_object
Date:   Fri,  6 Apr 2018 16:21:29 -0700
Message-Id: <20180406232136.253950-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of lookup_replace_object
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/mktag.c  | 2 +-
 object.c         | 2 +-
 replace-object.h | 3 ++-
 sha1_file.c      | 6 +++---
 streaming.c      | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 5e40e2152f..3dd937d4ef 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -25,7 +25,7 @@ static int verify_object(const unsigned char *sha1, const char *expected_type)
 	enum object_type type;
 	unsigned long size;
 	void *buffer = read_sha1_file(sha1, &type, &size);
-	const unsigned char *repl = lookup_replace_object(sha1);
+	const unsigned char *repl = lookup_replace_object(the_repository, sha1);
 
 	if (buffer) {
 		if (type == type_from_string(expected_type))
diff --git a/object.c b/object.c
index 9f381c44eb..432a1b2b2a 100644
--- a/object.c
+++ b/object.c
@@ -247,7 +247,7 @@ struct object *parse_object(const struct object_id *oid)
 	unsigned long size;
 	enum object_type type;
 	int eaten;
-	const unsigned char *repl = lookup_replace_object(oid->hash);
+	const unsigned char *repl = lookup_replace_object(the_repository, oid->hash);
 	void *buffer;
 	struct object *obj;
 
diff --git a/replace-object.h b/replace-object.h
index dbb128f4c3..6a2d37d717 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -23,7 +23,8 @@ extern const unsigned char *do_lookup_replace_object_the_repository(const unsign
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
  */
-static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
+#define lookup_replace_object(r, s) lookup_replace_object_##r(s)
+static inline const unsigned char *lookup_replace_object_the_repository(const unsigned char *sha1)
 {
 	if (!check_replace_refs ||
 	    (the_repository->objects->replacements.prepared &&
diff --git a/sha1_file.c b/sha1_file.c
index 68f1735476..0dad6c211e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1236,7 +1236,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	struct pack_entry e;
 	int rtype;
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
-				    lookup_replace_object(sha1) :
+				    lookup_replace_object(the_repository, sha1) :
 				    sha1;
 	int already_retried = 0;
 
@@ -1374,8 +1374,8 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 	const struct packed_git *p;
 	const char *path;
 	struct stat st;
-	const unsigned char *repl = lookup_replace ? lookup_replace_object(sha1)
-						   : sha1;
+	const unsigned char *repl = lookup_replace ?
+		lookup_replace_object(the_repository, sha1) : sha1;
 
 	errno = 0;
 	data = read_object(repl, type, size);
diff --git a/streaming.c b/streaming.c
index 29632065d0..b36b3cc6b8 100644
--- a/streaming.c
+++ b/streaming.c
@@ -140,7 +140,7 @@ struct git_istream *open_istream(const unsigned char *sha1,
 {
 	struct git_istream *st;
 	struct object_info oi = OBJECT_INFO_INIT;
-	const unsigned char *real = lookup_replace_object(sha1);
+	const unsigned char *real = lookup_replace_object(the_repository, sha1);
 	enum input_source src = istream_source(real, type, &oi);
 
 	if (src < 0)
-- 
2.17.0.484.g0c8726318c-goog

