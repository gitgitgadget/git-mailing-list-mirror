Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7751E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeBFAcC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:32:02 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45584 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeBFAb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:31:56 -0500
Received: by mail-pg0-f68.google.com with SMTP id m136so171136pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J7rdB73xJy8eMEtrkrC009Oii47d5bX7s9OBFHkz58Y=;
        b=Th+zjBIuXcncyCYvpCHGsELQz5yICrfV7rG/p58h99cgps0YJkzU9BMB4kJ064ZLDO
         jOcbgEBvkKgLLzqUAM12vK7StrNJo59liBdaj35LQj42dK6QnsnV35stYVpeZauS8kca
         pOT/l112WK3dHgryT3MR6diFG3c3qk4ds5JaXyDadZvLs51yXpxArzVcqC44qwCuKGy3
         BLnblq9/BGi9sSSCbFHinm0HZMEdf4rPI38C6jwHyZDQIJC+kov5hkwAPZOSvefSyQA2
         Lc91A1abyw+IvjmaqHILJvagBFswj/muzICxQpr6uOTQcUaQeBezwetfTUMTi4hFZeo6
         TQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J7rdB73xJy8eMEtrkrC009Oii47d5bX7s9OBFHkz58Y=;
        b=inbWFBgdafEZvMaXucZJ639goMc236ndPQARPMWSBtt89Rqc8u7jSjdw5D83kLVclI
         4DH5q1WLPRz6/6GPRwSXgDNRlQa3AK0eXykt0mh5B0sGZB4hSp+Pn+kArtTB87Zw2DdQ
         I8a4x5qMyN/22q29cdGh4PGvgmlfuAE720noTbwMh66Wv4o31ZCp6UJhRJaxR3NEUz//
         pWn8nozwi++IyvwgSfU/kw4Tk0FtMvgu7KDeNYxiV1nrA5od/kQu/VK112r338Be+eHy
         kwTuxMF51HvB0rYkFiZ1mHENFE4iecnjAqSgUUBPDxQGNAG+DOJSrgF49Ju85jL78C3I
         /hJw==
X-Gm-Message-State: APf1xPArNhcn5BAQxHeJzmPjJCGGdTB0Fi6hiJYRprtDWTteMijnlcQH
        JOCfMunE3gl2tX/QuavlIzj4s2Q5UjU=
X-Google-Smtp-Source: AH8x225iyhz2s1ZCgqFIX3uC7bxBY7CuBWI+cygUsqsj1o0CN3aF7N31juNo0znrU3p+21pvsEGMrw==
X-Received: by 10.99.122.2 with SMTP id v2mr443983pgc.151.1517877115585;
        Mon, 05 Feb 2018 16:31:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l64sm19547546pfi.46.2018.02.05.16.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:31:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 186/194] pretty: allow logmsg_reencode to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:41 -0800
Message-Id: <20180206001749.218943-88-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.h | 3 +--
 pretty.c | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit.h b/commit.h
index 77e131d15b..7bdc808018 100644
--- a/commit.h
+++ b/commit.h
@@ -129,8 +129,7 @@ void free_commit_list(struct commit_list *list);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 extern int has_non_ascii(const char *text);
-#define logmsg_reencode(r, c, e, o) logmsg_reencode_##r(c, e ,o)
-extern const char *logmsg_reencode_the_repository(const struct commit *commit,
+extern const char *logmsg_reencode(struct repository *r, const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
 extern const char *skip_blank_lines(const char *msg);
diff --git a/pretty.c b/pretty.c
index 30d53369b5..6dce4bb3c0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,14 +595,14 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	return strbuf_detach(&tmp, NULL);
 }
 
-const char *logmsg_reencode_the_repository(const struct commit *commit,
+const char *logmsg_reencode(struct repository *r, const struct commit *commit,
 			    char **commit_encoding,
 			    const char *output_encoding)
 {
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
 	char *encoding;
-	const char *msg = get_commit_buffer(the_repository, commit, NULL);
+	const char *msg = get_commit_buffer(r, commit, NULL);
 	char *out;
 
 	if (!output_encoding || !*output_encoding) {
@@ -630,7 +630,7 @@ const char *logmsg_reencode_the_repository(const struct commit *commit,
 		 * the cached copy from get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
-		if (msg == get_cached_commit_buffer(the_repository, commit, NULL))
+		if (msg == get_cached_commit_buffer(r, commit, NULL))
 			out = xstrdup(msg);
 		else
 			out = (char *)msg;
@@ -644,7 +644,7 @@ const char *logmsg_reencode_the_repository(const struct commit *commit,
 		 */
 		out = reencode_string(msg, output_encoding, use_encoding);
 		if (out)
-			unuse_commit_buffer(the_repository, commit, msg);
+			unuse_commit_buffer(r, commit, msg);
 	}
 
 	/*
-- 
2.15.1.433.g936d1b9894.dirty

