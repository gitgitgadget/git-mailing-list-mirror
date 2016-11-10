Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB40E20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935691AbcKJUei (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:38 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35128 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933893AbcKJUeh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:37 -0500
Received: by mail-pf0-f174.google.com with SMTP id i88so151076839pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXS/5vSjN+bXJoBjC3aYmqt7BV6UQ0rKQIZmUjjTmlQ=;
        b=WkixigtnpuUwix1zA3Ar2EEsKK232QDfL1L+GZw/ORhmByS2BhQcj6HaJUeE2pLQen
         8V8PR7EYSYjvykdBfJ3VvQHM/JDE4TQWpnj6NxAQVVzhWUDC/CKPyt46r5L8sBIMXFn7
         gJnEL2GV1qm8Zg9+W6zsmvI7QD1DwJh+mzYva0JCipPokxhsydKTKEaR1wtIbpziYb7w
         3oe7Dkdn1xJOZUrfvDSA9sfWSov2Bn/5C6o6rWbnkxSQzUODERVliqj29d6MZa9pB8g2
         0ehspSFbApR65/3c18hTax6CuGyLE+JrUCnqJj5BBgsLGPPXh4p4kmnVmjatB9sr/znY
         civg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXS/5vSjN+bXJoBjC3aYmqt7BV6UQ0rKQIZmUjjTmlQ=;
        b=LXLFe/9DppXvYNy2NZqycU2cGHKdNDLBNLHmkRf5UFVjj6SQALdAd98UhYOmX0Yc6R
         /1yts4vTpfG8L6ag8Jm1YnudQks4WHd/ACRr1RQR3c1pKh5BMSnCd+kEaVzocH9FzXJz
         ZDF4X+6s8xTyuC3GEA2QXSiqONFzbAcqCz44WqHfmJnB/1KQXLmwtbJ863bYtAh90JkS
         3hm7b34lM9JUxwo0xlHSYodMkuk6Ox6cU5rk856qO3hh6FQDAshAeIFe59UqOFGxgtId
         /W2Tv+7CeT3hAK4XtgwGaNbNina42Z3aNtQWB/AX0CZxWC/EJO51QPW3WTdSZs81DnJK
         Jh9w==
X-Gm-Message-State: ABUngveaACsPzAiK1/4Ekf0YsGbcK5sVhCnPXOpZgAbXyGI72MZy3TB9LccPWr7zf7m6Vb88
X-Received: by 10.98.77.1 with SMTP id a1mr13546883pfb.160.1478810076044;
        Thu, 10 Nov 2016 12:34:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id a7sm9253698pfl.87.2016.11.10.12.34.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 00/35] Revamp the attr subsystem!
Date:   Thu, 10 Nov 2016 12:33:53 -0800
Message-Id: <20161110203428.30512-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous discussion: https://public-inbox.org/git/20161028185502.8789-1-sbeller@google.com/

Changes since v2:
* dropped one patch (that exposes git_attr_counted, nobody uses
  it throughout the series )
* added pathspec guarding and added a test with git-add to see if it works.
* squashed "SQUASH" commits.
* changed test for multithreaded tests as git-status makes use of pathspec
  code that doesn't support this new magic yet. 

interdiff to currently queued at the bottom of this email.

v2 was:
previous discussion at https://public-inbox.org/git/20161022233225.8883-1-sbeller@google.com

This implements the discarded series':
jc/attr
jc/attr-more
sb/pathspec-label
sb/submodule-default-paths

This includes
* The fixes for windows
* Junios latest suggestion to use git_attr_check_initv instead of
  alloc/append.

* I implemented the thread safe attr API in patch 27 (attr: convert to new threadsafe API)
* patch 28 (attr: keep attr stack for each check) makes it actually possible
  to run in a multithreaded environment.
* I added a test for the multithreaded when it is introduced in patch 32
  (pathspec: allow querying for attributes) as well as a test to disallow
  multiple "attr"s in a pathspec.

Thanks,
Stefan


Junio C Hamano (23):
  commit.c: use strchrnul() to scan for one line
  attr.c: use strchrnul() to scan for one line
  attr.c: update a stale comment on "struct match_attr"
  attr.c: explain the lack of attr-name syntax check in parse_attr()
  attr.c: complete a sentence in a comment
  attr.c: mark where #if DEBUG ends more clearly
  attr.c: simplify macroexpand_one()
  attr.c: tighten constness around "git_attr" structure
  attr.c: plug small leak in parse_attr_line()
  attr: rename function and struct related to checking attributes
  attr: (re)introduce git_check_attr() and struct git_attr_check
  attr: convert git_all_attrs() to use "struct git_attr_check"
  attr: convert git_check_attrs() callers to use the new API
  attr: retire git_check_attrs() API
  attr: add counted string version of git_check_attr()
  attr: expose validity check for attribute names
  attr.c: add push_stack() helper
  attr.c: pass struct git_attr_check down the callchain
  attr.c: rename a local variable check
  attr.c: correct ugly hack for git_all_attrs()
  attr.c: introduce empty_attr_check_elems()
  attr.c: always pass check[] to collect_some_attrs()
  attr.c: outline the future plans by heavily commenting

Nguyễn Thái Ngọc Duy (1):
  attr: support quoting pathname patterns in C style

Stefan Beller (11):
  attr: make git_check_attr_counted static
  attr: convert to new threadsafe API
  attr: keep attr stack for each check
  Documentation: fix a typo
  pathspec: move long magic parsing out of prefix_pathspec
  pathspec: move prefix check out of the inner loop
  pathspec: allow querying for attributes
  pathspec: allow escaped query values
  submodule update: add `--init-default-path` switch
  clone: add --init-submodule=<pathspec> switch
  completion: clone can initialize specific submodules

 Documentation/config.txt                      |   5 +
 Documentation/git-clone.txt                   |  23 +-
 Documentation/git-submodule.txt               |  17 +-
 Documentation/gitattributes.txt               |  10 +-
 Documentation/glossary-content.txt            |  20 +
 Documentation/technical/api-gitattributes.txt | 140 ++++---
 archive.c                                     |  25 +-
 attr.c                                        | 517 ++++++++++++++++++--------
 attr.h                                        |  71 ++--
 builtin/check-attr.c                          |  74 ++--
 builtin/clone.c                               |  36 +-
 builtin/pack-objects.c                        |  27 +-
 commit.c                                      |   3 +-
 common-main.c                                 |   2 +
 contrib/completion/git-completion.bash        |   1 +
 convert.c                                     |  46 ++-
 dir.c                                         |  41 +-
 git-submodule.sh                              |  21 +-
 hashmap.h                                     |   2 +
 ll-merge.c                                    |  35 +-
 pathspec.c                                    | 228 ++++++++++--
 pathspec.h                                    |  19 +-
 t/t0003-attributes.sh                         |  26 ++
 t/t6134-pathspec-with-labels.sh               | 201 ++++++++++
 t/t7400-submodule-basic.sh                    | 134 +++++++
 userdiff.c                                    |  21 +-
 ws.c                                          |  19 +-
 27 files changed, 1354 insertions(+), 410 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

-- interdiff to current origin/sb/attr:

diff --git a/attr.c b/attr.c
index cf15e76..979bd3c 100644
--- a/attr.c
+++ b/attr.c
@@ -135,7 +135,7 @@ static void report_invalid_attr(const char *name, size_t len,
 	strbuf_release(&err);
 }
 
-struct git_attr *git_attr_counted(const char *name, size_t len)
+static struct git_attr *git_attr_internal(const char *name, int len)
 {
 	unsigned hval = hash_name(name, len);
 	unsigned pos = hval % HASHSIZE;
@@ -171,7 +171,7 @@ struct git_attr *git_attr_counted(const char *name, size_t len)
 
 struct git_attr *git_attr(const char *name)
 {
-	return git_attr_counted(name, strlen(name));
+	return git_attr_internal(name, strlen(name));
 }
 
 /* What does a matched pattern decide? */
@@ -259,7 +259,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 		else {
 			e->setto = xmemdupz(equals + 1, ep - equals - 1);
 		}
-		e->attr = git_attr_counted(cp, len);
+		e->attr = git_attr_internal(cp, len);
 	}
 	return ep + strspn(ep, blank);
 }
@@ -320,7 +320,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		      sizeof(struct attr_state) * num_attr +
 		      (is_macro ? 0 : namelen + 1));
 	if (is_macro) {
-		res->u.attr = git_attr_counted(name, namelen);
+		res->u.attr = git_attr_internal(name, namelen);
 		res->u.attr->maybe_macro = 1;
 	} else {
 		char *p = (char *)&(res->state[num_attr]);
diff --git a/attr.h b/attr.h
index e7534da..ab381ae 100644
--- a/attr.h
+++ b/attr.h
@@ -2,7 +2,7 @@
 #define ATTR_H
 
 /*
- * Must be called on platforms that do not support static initialisation
+ * Must be called on platforms that do not support static initialization
  * of mutexes.
  */
 extern void attr_start(void);
diff --git a/dir.c b/dir.c
index 3ec9117..c56d2ee 100644
--- a/dir.c
+++ b/dir.c
@@ -140,7 +140,8 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
 
 	for (n = 0; n < pathspec->nr; n++) {
 		size_t i = 0, len = 0, item_len;
@@ -349,7 +350,8 @@ static int do_match_pathspec(const struct pathspec *ps,
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
 
 	if (!ps->nr) {
 		if (!ps->recursive ||
diff --git a/pathspec.c b/pathspec.c
index 8ea5dcb..d702803 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -232,6 +232,7 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 			char *attr_body = xmemdupz(body, len - strlen("attr:"));
 			parse_pathspec_attr_match(item, attr_body);
 			free(attr_body);
+			*magic |= PATHSPEC_ATTR;
 			continue;
 		}
 
diff --git a/pathspec.h b/pathspec.h
index ebef4bf..c2d046d 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -8,13 +8,15 @@
 #define PATHSPEC_GLOB		(1<<3)
 #define PATHSPEC_ICASE		(1<<4)
 #define PATHSPEC_EXCLUDE	(1<<5)
+#define PATHSPEC_ATTR		(1<<6)
 #define PATHSPEC_ALL_MAGIC	  \
 	(PATHSPEC_FROMTOP	| \
 	 PATHSPEC_MAXDEPTH	| \
 	 PATHSPEC_LITERAL	| \
 	 PATHSPEC_GLOB		| \
 	 PATHSPEC_ICASE		| \
-	 PATHSPEC_EXCLUDE)
+	 PATHSPEC_EXCLUDE	| \
+	 PATHSPEC_ATTR)
 
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
index 3d03e0a..5aafc0c 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -160,7 +160,23 @@ test_expect_success 'fail on multiple attr specifiers in one pathspec item' '
 '
 
 test_expect_success 'checking attributes in a multithreaded process' '
-	git status ":(attr:labelB)"
+	cat <<-EOF >expect &&
+	fileA:A
+	EOF
+	echo A >fileA &&
+	echo A >fileB &&
+	git grep A -- ":(attr:labelA)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fail if attr magic is used places not implemented' '
+	# The main purpose of this test is to check that we actually fail
+	# when you attempt to use attr magic in commands that do not implement
+	# attr magic. This test does not advocate git-add to stay that way,
+	# though, but git-add is convenient as it has its own internal pathspec
+	# parsing.
+	test_must_fail git add ":(attr:labelB)" 2>actual &&
+	test_i18ngrep "unsupported magic" actual
 '
 
 test_expect_success 'abort on giving invalid label on the command line' '



-- 
2.10.1.469.g00a8914

