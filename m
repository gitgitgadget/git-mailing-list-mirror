Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDB61F462
	for <e@80x24.org>; Sat, 15 Jun 2019 00:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfFOAmV (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 20:42:21 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:52603 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfFOAmV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 20:42:21 -0400
Received: by mail-vk1-f201.google.com with SMTP id l186so1275890vke.19
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 17:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eU/6vmDcEgz0Mza8pmxvvwqg4Td0kO5wtPJdy8PrWFM=;
        b=vL7T/uAVlA/CIkesy7GJlW3oZvEY4kpXLaMCBxL2UsC3VkGlMV36svDUzKkk1QAhhd
         nzynfrVEAFl5j5NAfOpW5Ht3HIyqsMiv8jkE53kccgGGudD9oEgDeMXNgJNiuJe8AIek
         XRdTdiNELVw6FEL7VQq6BqNgzczaYeRYg/Nc+t0xJx5LjlkcsVJg3zgBNZi+3dK5hCLC
         6HURtq8cUPOe+pWvVow1DY9myQwItpHQ76a9ksvq5i9XJVfLcw2jBOMAi2xIeemY3iv6
         pS8K8kU5GqA1hWSK/rBJl+Ic7EpBGAGTeejlhWrrq6gjFiPCvrlC+UbCjJVlgon82CyQ
         WQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eU/6vmDcEgz0Mza8pmxvvwqg4Td0kO5wtPJdy8PrWFM=;
        b=Ny4YMFCK1slh829lMaRqggPyuMYE9RnuRKKpiRqhDNBDE9S++ol9iyp0OUdH97+WH3
         VgP+WC51AB3UZC7KF2waH9L0yQnvQ1JWg08DEWQLmT7uUflEEFDxALpcPKGj76P6ZvXZ
         5ADLzaQ2z8VIVfPjGIxNuvs2y0eHxXkCN9ueXmbNwUZv/oBAKbXpj12Tmq6sDt+nccjm
         NBA15yFHahyVCnpaK+aRRgiZCDC53I3crb5n06Vc4v9v9wwfxnl0xHAZASIsP7e+N4rm
         m1XckPXKgEtCirCvFIAmm0gphlaI+bnnjau7U5FsV8i4CJjmz7JmBo/2+CtadrxAl38Z
         wlVw==
X-Gm-Message-State: APjAAAXlIaVVwmKMDyHMbnZ77zxUtzohY7qizL/8Gn9klHMuQoJ8pmYW
        LLC5mpXUrg6hKX8k/H0crvuWOvMFmbXU6GWT1YY1ceM15vW4mmbzpF3qGH6MohdqwK+9pJZ0tXg
        kBtyPY2HkObO44fNT3Q3nvvw3zN/MlCrcwdh802Ou7MuNbi9yKCdc1dK0gsc=
X-Google-Smtp-Source: APXvYqxJCzDQhYskCstEs9yLs/NVPCq7TjMFyV/PbDJj+y8XKqcyv2Q2LkG9eT/EcJK+xwTrcdtNBJ1P5PZV
X-Received: by 2002:a1f:ae4b:: with SMTP id x72mr23945337vke.10.1560559339775;
 Fri, 14 Jun 2019 17:42:19 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:40:13 -0700
In-Reply-To: <cover.1560558910.git.matvore@google.com>
Message-Id: <880570027ec7c4405f3342d00087c7ad4efd05f4.1560558910.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560558910.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 07/10] strbuf: give URL-encoding API a char predicate fn
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow callers to specify exactly what characters need to be URL-encoded
and which do not. This new API will be taken advantage of in a patch
later in this set.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 credential-store.c |  9 +++++----
 http.c             |  6 ++++--
 strbuf.c           | 15 ++++++++-------
 strbuf.h           |  7 ++++++-
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index ac295420dd..c010497cb2 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -65,29 +65,30 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 	parse_credential_file(fn, c, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to write credential store");
 }
 
 static void store_credential_file(const char *fn, struct credential *c)
 {
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "%s://", c->protocol);
-	strbuf_addstr_urlencode(&buf, c->username, 1);
+	strbuf_addstr_urlencode(&buf, c->username, is_rfc3986_unreserved);
 	strbuf_addch(&buf, ':');
-	strbuf_addstr_urlencode(&buf, c->password, 1);
+	strbuf_addstr_urlencode(&buf, c->password, is_rfc3986_unreserved);
 	strbuf_addch(&buf, '@');
 	if (c->host)
-		strbuf_addstr_urlencode(&buf, c->host, 1);
+		strbuf_addstr_urlencode(&buf, c->host, is_rfc3986_unreserved);
 	if (c->path) {
 		strbuf_addch(&buf, '/');
-		strbuf_addstr_urlencode(&buf, c->path, 0);
+		strbuf_addstr_urlencode(&buf, c->path,
+					is_rfc3986_reserved_or_unreserved);
 	}
 
 	rewrite_credential_file(fn, c, &buf);
 	strbuf_release(&buf);
 }
 
 static void store_credential(const struct string_list *fns, struct credential *c)
 {
 	struct string_list_item *fn;
 
diff --git a/http.c b/http.c
index 27aa0a3192..938b9e55af 100644
--- a/http.c
+++ b/http.c
@@ -506,23 +506,25 @@ static void var_override(const char **var, char *value)
 static void set_proxyauth_name_password(CURL *result)
 {
 #if LIBCURL_VERSION_NUM >= 0x071301
 		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
 			proxy_auth.username);
 		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
 			proxy_auth.password);
 #else
 		struct strbuf s = STRBUF_INIT;
 
-		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
+		strbuf_addstr_urlencode(&s, proxy_auth.username,
+					is_rfc3986_unreserved);
 		strbuf_addch(&s, ':');
-		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
+		strbuf_addstr_urlencode(&s, proxy_auth.password,
+					is_rfc3986_unreserved);
 		curl_proxyuserpwd = strbuf_detach(&s, NULL);
 		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
 #endif
 }
 
 static void init_curl_proxy_auth(CURL *result)
 {
 	if (proxy_auth.username) {
 		if (!proxy_auth.password)
 			credential_fill(&proxy_auth);
diff --git a/strbuf.c b/strbuf.c
index 0e18b259ce..60ab5144f2 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -767,55 +767,56 @@ void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
 		case '&':
 			strbuf_addstr(buf, "&amp;");
 			break;
 		case 0:
 			return;
 		}
 		s++;
 	}
 }
 
-static int is_rfc3986_reserved(char ch)
+int is_rfc3986_reserved_or_unreserved(char ch)
 {
+	if (is_rfc3986_unreserved(ch))
+		return 1;
 	switch (ch) {
 		case '!': case '*': case '\'': case '(': case ')': case ';':
 		case ':': case '@': case '&': case '=': case '+': case '$':
 		case ',': case '/': case '?': case '#': case '[': case ']':
 			return 1;
 	}
 	return 0;
 }
 
-static int is_rfc3986_unreserved(char ch)
+int is_rfc3986_unreserved(char ch)
 {
 	return isalnum(ch) ||
 		ch == '-' || ch == '_' || ch == '.' || ch == '~';
 }
 
 static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
-				 int reserved)
+				 char_predicate allow_unencoded_fn)
 {
 	strbuf_grow(sb, len);
 	while (len--) {
 		char ch = *s++;
-		if (is_rfc3986_unreserved(ch) ||
-		    (!reserved && is_rfc3986_reserved(ch)))
+		if (allow_unencoded_fn(ch))
 			strbuf_addch(sb, ch);
 		else
 			strbuf_addf(sb, "%%%02x", (unsigned char)ch);
 	}
 }
 
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
-			     int reserved)
+			     char_predicate allow_unencoded_fn)
 {
-	strbuf_add_urlencode(sb, s, strlen(s), reserved);
+	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	if (bytes > 1 << 30) {
 		strbuf_addf(buf, "%u.%2.2u GiB",
 			    (unsigned)(bytes >> 30),
 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
 	} else if (bytes > 1 << 20) {
 		unsigned x = bytes + 5243;  /* for rounding */
diff --git a/strbuf.h b/strbuf.h
index c8d98dfb95..346d722492 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -659,22 +659,27 @@ void strbuf_branchname(struct strbuf *sb, const char *name,
 		       unsigned allowed);
 
 /*
  * Like strbuf_branchname() above, but confirm that the result is
  * syntactically valid to be used as a local branch name in refs/heads/.
  *
  * The return value is "0" if the result is valid, and "-1" otherwise.
  */
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
+typedef int (*char_predicate)(char ch);
+
+int is_rfc3986_unreserved(char ch);
+int is_rfc3986_reserved_or_unreserved(char ch);
+
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
-			     int reserved);
+			     char_predicate allow_unencoded_fn);
 
 __attribute__((format (printf,1,2)))
 int printf_ln(const char *fmt, ...);
 __attribute__((format (printf,2,3)))
 int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
 char *xstrdup_toupper(const char *);
 
 /**
-- 
2.21.0

