Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A6181F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdA1CDb (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:31 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35225 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdA1CDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:03:10 -0500
Received: by mail-pf0-f169.google.com with SMTP id f144so77056284pfa.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ng/qacloRJ3VBlnlmeHxppfw+U5TCJw02T1mBC/JTfE=;
        b=Gb2QobozPL+0uaBgca9jYhwR8Dtrnd8qFZccdgkDbbfXPdQMu/jRg3KY9wqWJet1h4
         vZVoCDUgwCeCWL83s+/DFNUnmPeXzKMuKS97MqF/v03g6P07HIEIfrSRgttYH1uQHrAR
         mjTmfHjhva11xhal/pUI6KQpDVnMS6AnZYAvbOD5GCnrVQnZgoppH9WrLVnXXRlfFNxF
         DYDHZxjwBM9+HkxEITP6mjhdPi/dHGFvU3uTzwAlj7S288gdQl5m+Yg0teyYI21H/wfs
         w7th75E3um1cV6DJnyg3WKwuFBsHmWhQYR2qVstZ+G38pl0acvfvbJAxHlfjFpxJm+Z8
         V+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ng/qacloRJ3VBlnlmeHxppfw+U5TCJw02T1mBC/JTfE=;
        b=K9HJAMm7vDAxOsgoSCtZI7Iu5S95BUkrqyqHJ5ujIyPUj5rXqKz7FpH0Bz81M0UNVO
         weKXRrazg9llSiCWboOj6mlAi9GlHe9pVWirBtUH55DF4nlsROPpdNwHCJ0ltmDyplt7
         /ixYsDwu4vkSAFO/smrouKFdx9/4Y7S5RPgd7GDyg2g9WC2Fivm8Vx3TpQT1+/RJSSL/
         9PQ3U2dMxRZKad6fHXD1LtgOdPsLLOXKI1m/8cy5xV9ynBGCdphfPpTbGLxeVY2JnzQs
         BqIXdFXzZdY+RAGr8Rpcv7Dezb6Qfuo9m3Qzx5w92dLZIItAU0XM3rKpiUJaR7UWa1ze
         ArpA==
X-Gm-Message-State: AIkVDXIBJo0XZy1flQUb6sJ7YjWaui142HgfycY+R9Oocnf8LsXsVaWEf8XirHGkuI7h+kDw
X-Received: by 10.98.67.72 with SMTP id q69mr12140153pfa.14.1485568989003;
        Fri, 27 Jan 2017 18:03:09 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:03:07 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v3 26/27] attr: push the bare repo check into read_attr()
Date:   Fri, 27 Jan 2017 18:02:06 -0800
Message-Id: <20170128020207.179015-27-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Push the bare repository check into the 'read_attr()' function.  This
avoids needing to have extra logic which creates an empty stack frame
when inside a bare repo as a similar bit of logic already exists in the
'read_attr()' function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 114 +++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 54 insertions(+), 60 deletions(-)

diff --git a/attr.c b/attr.c
index bcee0921d..62298ec2f 100644
--- a/attr.c
+++ b/attr.c
@@ -747,25 +747,28 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 
 static struct attr_stack *read_attr(const char *path, int macro_ok)
 {
-	struct attr_stack *res;
+	struct attr_stack *res = NULL;
 
-	if (direction == GIT_ATTR_CHECKOUT) {
+	if (direction == GIT_ATTR_INDEX) {
 		res = read_attr_from_index(path, macro_ok);
-		if (!res)
-			res = read_attr_from_file(path, macro_ok);
-	}
-	else if (direction == GIT_ATTR_CHECKIN) {
-		res = read_attr_from_file(path, macro_ok);
-		if (!res)
-			/*
-			 * There is no checked out .gitattributes file there, but
-			 * we might have it in the index.  We allow operation in a
-			 * sparsely checked out work tree, so read from it.
-			 */
+	} else if (!is_bare_repository()) {
+		if (direction == GIT_ATTR_CHECKOUT) {
 			res = read_attr_from_index(path, macro_ok);
+			if (!res)
+				res = read_attr_from_file(path, macro_ok);
+		} else if (direction == GIT_ATTR_CHECKIN) {
+			res = read_attr_from_file(path, macro_ok);
+			if (!res)
+				/*
+				 * There is no checked out .gitattributes file
+				 * there, but we might have it in the index.
+				 * We allow operation in a sparsely checked out
+				 * work tree, so read from it.
+				 */
+				res = read_attr_from_index(path, macro_ok);
+		}
 	}
-	else
-		res = read_attr_from_index(path, macro_ok);
+
 	if (!res)
 		res = xcalloc(1, sizeof(*res));
 	return res;
@@ -857,10 +860,7 @@ static void bootstrap_attr_stack(struct attr_stack **stack)
 	}
 
 	/* root directory */
-	if (!is_bare_repository() || direction == GIT_ATTR_INDEX)
-		e = read_attr(GITATTRIBUTES_FILE, 1);
-	else
-		e = xcalloc(1, sizeof(struct attr_stack));
+	e = read_attr(GITATTRIBUTES_FILE, 1);
 	push_stack(stack, e, xstrdup(""), 0);
 
 	/* info frame */
@@ -877,6 +877,7 @@ static void prepare_attr_stack(const char *path, int dirlen,
 			       struct attr_stack **stack)
 {
 	struct attr_stack *info;
+	struct strbuf pathbuf = STRBUF_INIT;
 
 	/*
 	 * At the bottom of the attribute stack is the built-in
@@ -923,54 +924,47 @@ static void prepare_attr_stack(const char *path, int dirlen,
 	}
 
 	/*
-	 * Read from parent directories and push them down
+	 * bootstrap_attr_stack() should have added, and the
+	 * above loop should have stopped before popping, the
+	 * root element whose attr_stack->origin is set to an
+	 * empty string.
 	 */
-	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
-		/*
-		 * bootstrap_attr_stack() should have added, and the
-		 * above loop should have stopped before popping, the
-		 * root element whose attr_stack->origin is set to an
-		 * empty string.
-		 */
-		struct strbuf pathbuf = STRBUF_INIT;
-
-		assert((*stack)->origin);
-		strbuf_addstr(&pathbuf, (*stack)->origin);
-		/* Build up to the directory 'path' is in */
-		while (pathbuf.len < dirlen) {
-			size_t len = pathbuf.len;
-			struct attr_stack *next;
-			char *origin;
-
-			/* Skip path-separator */
-			if (len < dirlen && is_dir_sep(path[len]))
-				len++;
-			/* Find the end of the next component */
-			while (len < dirlen && !is_dir_sep(path[len]))
-				len++;
-
-			if (pathbuf.len > 0)
-				strbuf_addch(&pathbuf, '/');
-			strbuf_add(&pathbuf, path + pathbuf.len,
-				   (len - pathbuf.len));
-			strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
-
-			next = read_attr(pathbuf.buf, 0);
-
-			/* reset the pathbuf to not include "/.gitattributes" */
-			strbuf_setlen(&pathbuf, len);
-
-			origin = xstrdup(pathbuf.buf);
-			push_stack(stack, next, origin, len);
-
-		}
-		strbuf_release(&pathbuf);
+	assert((*stack)->origin);
+
+	strbuf_addstr(&pathbuf, (*stack)->origin);
+	/* Build up to the directory 'path' is in */
+	while (pathbuf.len < dirlen) {
+		size_t len = pathbuf.len;
+		struct attr_stack *next;
+		char *origin;
+
+		/* Skip path-separator */
+		if (len < dirlen && is_dir_sep(path[len]))
+			len++;
+		/* Find the end of the next component */
+		while (len < dirlen && !is_dir_sep(path[len]))
+			len++;
+
+		if (pathbuf.len > 0)
+			strbuf_addch(&pathbuf, '/');
+		strbuf_add(&pathbuf, path + pathbuf.len, (len - pathbuf.len));
+		strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
+
+		next = read_attr(pathbuf.buf, 0);
+
+		/* reset the pathbuf to not include "/.gitattributes" */
+		strbuf_setlen(&pathbuf, len);
+
+		origin = xstrdup(pathbuf.buf);
+		push_stack(stack, next, origin, len);
 	}
 
 	/*
 	 * Finally push the "info" one at the top of the stack.
 	 */
 	push_stack(stack, info, NULL, 0);
+
+	strbuf_release(&pathbuf);
 }
 
 static int path_matches(const char *pathname, int pathlen,
-- 
2.11.0.483.g087da7b7c-goog

