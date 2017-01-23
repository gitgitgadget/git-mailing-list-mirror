Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672E020A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbdAWUoJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:44:09 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35680 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdAWUoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:44:07 -0500
Received: by mail-pf0-f178.google.com with SMTP id f144so43786651pfa.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TWGS/PoyEpcgvW40GbEUlV3mHB9OSIZfrBAIaUKjzP8=;
        b=s+7I+en7xS24C556Bp1Qa2FAH/vEojrudQ/157B7pC4pOOUEJsvdWasEq6SBHb2X5H
         W8SPpfw+ANnBt2c8PlLh/1GkKHCVH7SYuG4RptMCSp3m7SMd/NRd/K0xZ3sIcYx+j1CJ
         sbUOEAafxRZJVAvoskksAGT6lRQmzTjT2NGHv1TAvF1xgvs2UX8vjXH8cGhY0lHR5Xio
         2pctYfU2BAeJvgdjVQhl1+hbRmWNH9p/3mJCeKzilXK+k/kZBP1cmmyt4a+7mSPTg8o9
         VdEA/wXBopt3DqpUnG/mJeCgcEQVqDs9nus1y0ku5R5WhLYawqoGfC2PDdytoWi4If7G
         OPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TWGS/PoyEpcgvW40GbEUlV3mHB9OSIZfrBAIaUKjzP8=;
        b=PuTTujHaCxVKjhrRpHxzl9UVyKWR2PG6ykmmNEK7ZflR9wimltvu8LTuMa56j5epsZ
         Q6HTNungGw31KFlXKR8P5DoUKYThCuC49Q3oLwQAAJ5C1QpogXgJs9btsdiSCEvt3XMR
         ghvBoJmzBs7G8fwPVWpPEjv1POxYof8/LnOymvCu7AE62a5aHnbRM7wDpeCsTwXFtLuA
         aVmSbUgNo1yHZraUNHtlCkP9fwkpC9rVP4RGHokmgg5ad3ZcylvlbS4Cp6Rl8jLxK8mL
         4FsWFWM0JHDGGhO11b36tLoFwAcANrl+4ts0LP5JP3MHcT5a7dZss/SSZwZZ1rp5mCMl
         bb/g==
X-Gm-Message-State: AIkVDXJTs1E9MdVgjvKh/D84G3yGuJWTRlBbMQVSsT9+cTV5fZRVGEqGAnUd0fdN//Edmncw
X-Received: by 10.98.51.70 with SMTP id z67mr26989789pfz.68.1485203775696;
        Mon, 23 Jan 2017 12:36:15 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:36:14 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v2 26/27] attr: push the bare repo check into read_attr()
Date:   Mon, 23 Jan 2017 12:35:24 -0800
Message-Id: <20170123203525.185058-27-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
index d64d1959e..c2ea5cb29 100644
--- a/attr.c
+++ b/attr.c
@@ -648,25 +648,28 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 
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
@@ -758,10 +761,7 @@ static void bootstrap_attr_stack(struct attr_stack **stack)
 	}
 
 	/* root directory */
-	if (!is_bare_repository() || direction == GIT_ATTR_INDEX)
-		e = read_attr(GITATTRIBUTES_FILE, 1);
-	else
-		e = xcalloc(1, sizeof(struct attr_stack));
+	e = read_attr(GITATTRIBUTES_FILE, 1);
 	push_stack(stack, e, xstrdup(""), 0);
 
 	/* info frame */
@@ -778,6 +778,7 @@ static void prepare_attr_stack(const char *path, int dirlen,
 			       struct attr_stack **stack)
 {
 	struct attr_stack *info;
+	struct strbuf pathbuf = STRBUF_INIT;
 
 	/*
 	 * At the bottom of the attribute stack is the built-in
@@ -824,54 +825,47 @@ static void prepare_attr_stack(const char *path, int dirlen,
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

