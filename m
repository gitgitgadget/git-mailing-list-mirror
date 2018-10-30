Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3571F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeJaHEa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:30 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:47088 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeJaHE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:29 -0400
Received: by mail-io1-f74.google.com with SMTP id e144-v6so5314625iof.13
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=77KwkQnTpoDihUcPr5v1lgZeXr80vh4ZlKHFCgn/I1U=;
        b=ilGCl9dQjL8kjVOp9rXXo6JxVAmUH4g5Grzd3MY9Bz197W2AQqtMqS5EJHK78ElLqf
         HORBsN96Fb9kfuRVeYZ3T6HPUYQikFQClMXCMaJ+mKJnOBc7pPSNlE4wpdOn3ZjRHFmS
         rs/vtfONKetMTEoaaNgnTNyhmM9EPeM1j2IrDwqlYk+rx/4mkvNFi7N6i2JV0Q49eIzh
         wAJ7L81m97ATP83mGRBZzqSPNLLHurh7ONWKxMG8Owq2dAkn4Pti0ZJ8qi2MkVmjLyeR
         JH8i1eUL+A2WLh25xgC/kR+1XBVjzm+NsXGifuxoCFW60JTvl5sbvE01kLiFQdIXOiL3
         05Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=77KwkQnTpoDihUcPr5v1lgZeXr80vh4ZlKHFCgn/I1U=;
        b=pYOlc16LgNdTvRArpliuT27L0ZdNA7I12Zbcew8wI8qphk6c+JUIx/W2Njq5jHYRZq
         gNcZDzDL2JLjDtDSxYC/8g0cQekIFLOiUN/Lx9rDhvNMbuqweYwhEOxlnzwWi0uKZHYO
         aYhiZTRTf3DXWBZWxXUZOuUKXFY0vdfCq3ZkyKDoXNDOO1KQuEKdP0m/BKcZmoVVZoUe
         8VOJzFK+Bt/lUlCHum+LGIMxl+j00qmKhO6ygXmukMr7gPfGzfIcBW5/RrbtBPsSlsUx
         140VuzhSgESUZYWSGP2Vh53yARwvBpAyixCsIbZg9auY7GKTf372b6FEf1VLvRTGrUHO
         7aWw==
X-Gm-Message-State: AGRZ1gLzvkNbkJ+7dQ5XrOs/NliwOmiFzlzcv0AK8Vye2bKC6R2mEvVY
        jFcHd2lpgR62lLbRq41n/Qla1OJzECYh3IG7tU6fnoi5EOyvMzz/AD56t5b6SgTHM/vr9N0NOR0
        44cculE/FJLGLEYLDWV4fN9KQ5HTE691sf5XWu/A9ILP1zGpm+g7Rr2+fuGqk
X-Google-Smtp-Source: AJdET5fX3pjqkN3Njv5gprB6q5/FHzv/SNoO99qn+Wz5/TnFfD0msxRw+uVdQYj+NiYKWzU8YpHrlXrCkfjL
X-Received: by 2002:a24:8044:: with SMTP id g65-v6mr346597itd.10.1540937353986;
 Tue, 30 Oct 2018 15:09:13 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:10 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-18-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 17/24] commit: prepare logmsg_reencode to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h                                        |  8 ++++++++
 contrib/coccinelle/the_repository.pending.cocci |  9 +++++++++
 pretty.c                                        | 13 +++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/commit.h b/commit.h
index 57375e3239..2e6b799b26 100644
--- a/commit.h
+++ b/commit.h
@@ -180,6 +180,14 @@ extern int has_non_ascii(const char *text);
 extern const char *logmsg_reencode(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
+const char *repo_logmsg_reencode(struct repository *r,
+				 const struct commit *commit,
+				 char **commit_encoding,
+				 const char *output_encoding);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define logmsg_reencode(c, enc, out) repo_logmsg_reencode(the_repository, c, enc, out)
+#endif
+
 extern const char *skip_blank_lines(const char *msg);
 
 /** Removes the first commit from a list sorted by date, and adds all
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 516f19ffee..f5b42cfc62 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -123,3 +123,12 @@ expression F;
 - unuse_commit_buffer(
 + repo_unuse_commit_buffer(the_repository,
   E, F);
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- logmsg_reencode(
++ repo_logmsg_reencode(the_repository,
+  E, F, G);
diff --git a/pretty.c b/pretty.c
index 8ca29e9281..b359b68750 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,14 +595,15 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	return strbuf_detach(&tmp, NULL);
 }
 
-const char *logmsg_reencode(const struct commit *commit,
-			    char **commit_encoding,
-			    const char *output_encoding)
+const char *repo_logmsg_reencode(struct repository *r,
+				 const struct commit *commit,
+				 char **commit_encoding,
+				 const char *output_encoding)
 {
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
 	char *encoding;
-	const char *msg = get_commit_buffer(commit, NULL);
+	const char *msg = repo_get_commit_buffer(r, commit, NULL);
 	char *out;
 
 	if (!output_encoding || !*output_encoding) {
@@ -630,7 +631,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 * the cached copy from get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
-		if (msg == get_cached_commit_buffer(the_repository, commit, NULL))
+		if (msg == get_cached_commit_buffer(r, commit, NULL))
 			out = xstrdup(msg);
 		else
 			out = (char *)msg;
@@ -644,7 +645,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 */
 		out = reencode_string(msg, output_encoding, use_encoding);
 		if (out)
-			unuse_commit_buffer(commit, msg);
+			repo_unuse_commit_buffer(r, commit, msg);
 	}
 
 	/*
-- 
2.19.1.930.g4563a0d9d0-goog

