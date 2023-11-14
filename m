Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC133072
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vjf70H7J"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AEEC9
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:49:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af9b0850fdso91427947b3.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699998577; x=1700603377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LT/irDkzy7/hYVjEbpSmhuzZ9a+tp7jOZh5n6OUkGw=;
        b=Vjf70H7JO30BGT/I/XWp5zxNNpJ6lqouiNaRKFU2D9qigzWvnxIlF66LUzAgCcGcQZ
         Lo6OpLqe2H1VhPs+nebh4FmtAXkIb+6uojZR9R92nnz+Z1YBA2PqR1xJCwq5s4ynEpWc
         Q2kNNPt9okp5fOxrqhGjH8MrILtMZZjH0VI3itxUsmn09Yb5uU3wL2e7mi1H+2q1IZs8
         QsXzNlpNWprgQShwthnP/Lgpk7P7xY4GsWhUYnAVYYvuwr5QZnZ7t9mMce5k5kOlx5z2
         TafVJF5blljVvAJUaRdeV5IMpZGMvlXMlssxK2IOxy0JMLUVcsp0+ORASBNvmuFMCi95
         pPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998577; x=1700603377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LT/irDkzy7/hYVjEbpSmhuzZ9a+tp7jOZh5n6OUkGw=;
        b=iwSL+d4XByXkIibjkzrNxUCWiA8b+byrN6aWd5ZG5G71FJaNVfBq/tTOAHXXg/pWrS
         A3EEdz05elRuqSoFGP/SdduX5I/V+fQM4OP68okei/iSvoxkxrqabrg2IeVLLcsqAd1w
         520EdumfRQBr3sFQ7h2ib/t+fna3d2Ywg6jQ2Y6CzcAKcOn4EGdbvnLWwYvrFTY0CLq1
         dBweImU4+3WhP9+5cDeDkBu7klI4tm70P9Q0O5YUhg47FmIZjzaOw0VQAAd4kXMV181C
         kOZEw1A8fs6t/6zEvjdF1x+FfL5m7p+WqF8B9o9PJZ/GpfCL29NDxOWAL7cBisTj9xlY
         a0Hg==
X-Gm-Message-State: AOJu0YxO6AR7pTBnehKohPVtN176lazrm6rj7Ub6R8fODMj0uOLUN4O1
	dl2fLgyE80sepn75I4PeGZdZQZxIKQeS
X-Google-Smtp-Source: AGHT+IGZuRMoo6s6D2sPbGZwojwVBcBQ9nEbT7avTS+fvinmheNny5ai9mym2ZPCq2MJXZHm/PqYL85aVOEA
X-Received: from jojwang1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3b1d])
 (user=jojwang job=sendgmr) by 2002:a81:6d4d:0:b0:576:af04:3495 with SMTP id
 i74-20020a816d4d000000b00576af043495mr307351ywc.9.1699998577144; Tue, 14 Nov
 2023 13:49:37 -0800 (PST)
Date: Tue, 14 Nov 2023 21:49:34 +0000
In-Reply-To: <xmqqbkbx11x2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqqbkbx11x2.fsf@gitster.g>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231114214934.3484892-1-jojwang@google.com>
Subject: [PATCH 1/1] attr: add builtin objectmode values support
From: Joanna Wang <jojwang@google.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org, jojwang@google.com, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"

Gives all paths builtin objectmode values based on the paths' modes
(one of 100644, 100755, 120000, 040000, 160000). Users may use
this feature to filter by file types. For example a pathspec such as
':(attr:builtin_objectmode=160000)' could filter for submodules without
needing to have `builtin_objectmode=160000` to be set in .gitattributes
for every submodule path.

These values are also reflected in `git check-attr` results.
If the git_attr_direction is set to GIT_ATTR_INDEX or GIT_ATTR_CHECKIN
and a path is not found in the index, the value will be unspecified.

This patch also reserves the builtin_* attribute namespace for objectmode
and any future builtin attributes. Any user defined attributes using this
reserved namespace will result in a warning. This is a breaking change for
any existing builtin_* attributes.
Pathspecs with some builtin_* attribute name (excluding builtin_objectmode)
will behave like any attribute where there are no user specified values.

Signed-off-by: Joanna Wang <jojwang@google.com>
---

>But the usual practice is *not* to cover all paths with explicit
> attribute definition, isn't it?
Got it, the breaking change is that we're giving mode a value when
user may expect no value.

>When checking things out of the index, the index should be the
>source of the truth.  If something is not in the index, is there a
>point in falling back to the workint tree state to decide if the
>thing should be checked out of the index?
I don't think working tree objectmode fallback makes sense for
GIT_ATTR_CHECKOUT and GIT_ATTR_INDEX. Updated patch implements
without fallback.

>                static struct git_attr mode_attr;
>
>                if (!mode_attr)
>                        mode_attr = git_attr("mode");
Is there an idiomatic way to check if this git_attr (struct or pointer)
has been initialized? I could not find an anything for C but maybe I've
missed a common way to do this in the codebase.

I also addressed the style nits. Thanks for the review/fedback so far. 

 Documentation/gitattributes.txt | 14 +++++++
 attr.c                          | 67 +++++++++++++++++++++++++++++++--
 t/t0003-attributes.sh           | 44 ++++++++++++++++++++++
 t/t6135-pathspec-with-attrs.sh  | 25 ++++++++++++
 4 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8c1793c148..84bad3e741 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -100,6 +100,20 @@ for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
 
+RESERVED BUILTIN_* ATTRIBUTES
+-----------------------------
+
+builtin_* is a reserved namespace for builtin attribute values. Any
+user defined attributes under this namespace will result in a warning.
+
+`builtin_objectmode`
+^^^^^^^^^^^^^^^^^^^^
+This attribute is for filtering files by their file bit modes (40000,
+120000, 160000, 100755, 100644). e.g. ':(attr:builtin_objectmode=160000)'.
+You may also check these values with `git check-attr builtin_objectmode -- <file>`.
+If the object is not in the index `git check-attr --cached` will return unspecified.
+
+
 EFFECTS
 -------
 
diff --git a/attr.c b/attr.c
index e62876dfd3..8493f2c5c0 100644
--- a/attr.c
+++ b/attr.c
@@ -17,6 +17,7 @@
 #include "utf8.h"
 #include "quote.h"
 #include "read-cache-ll.h"
+#include "refs.h"
 #include "revision.h"
 #include "object-store-ll.h"
 #include "setup.h"
@@ -183,6 +184,15 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	}
 }
 
+/*
+ * Atribute name cannot begin with "builtin_" which
+ * is a reserved namespace for built in attributes values.
+ */
+static int attr_name_reserved(const char *name)
+{
+	return !strncmp(name, "builtin_", strlen("builtin_"));
+}
+
 static int attr_name_valid(const char *name, size_t namelen)
 {
 	/*
@@ -315,7 +325,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			cp++;
 			len--;
 		}
-		if (!attr_name_valid(cp, len)) {
+		if (!attr_name_valid(cp, len) || attr_name_reserved(cp)) {
 			report_invalid_attr(cp, len, src, lineno);
 			return NULL;
 		}
@@ -379,7 +389,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		name += strlen(ATTRIBUTE_MACRO_PREFIX);
 		name += strspn(name, blank);
 		namelen = strcspn(name, blank);
-		if (!attr_name_valid(name, namelen)) {
+		if (!attr_name_valid(name, namelen) || attr_name_reserved(name)) {
 			report_invalid_attr(name, namelen, src, lineno);
 			goto fail_return;
 		}
@@ -1240,6 +1250,57 @@ static struct object_id *default_attr_source(void)
 	return &attr_source;
 }
 
+static const char *builtin_object_mode_attr(struct index_state *istate, const char *path)
+{
+	unsigned int mode;
+	struct strbuf sb = STRBUF_INIT;
+	
+	if (direction == GIT_ATTR_CHECKIN) {
+		struct object_id oid;
+		struct stat st;
+		if (lstat(path, &st))
+			die_errno(_("unable to stat '%s'"), path);
+		mode = canon_mode(st.st_mode);
+		if (S_ISDIR(mode)) {
+			/* `path` is either a directory or it is a submodule,
+			 * in which case it is already indexed as submodule
+			 * or it does not exist in the index yet and we need to
+			 * check if we can resolve to a ref.
+			*/
+			int pos = index_name_pos(istate, path, strlen(path));
+			if (pos >= 0) {
+				 if (S_ISGITLINK(istate->cache[pos]->ce_mode))
+					 mode = istate->cache[pos]->ce_mode;
+			} else if (resolve_gitlink_ref(path, "HEAD", &oid) == 0)
+				mode = S_IFGITLINK;
+		}
+	} else {
+		/*
+		 * For GIT_ATTR_CHECKOUT and GIT_ATTR_INDEX we only check
+		 * for mode in the index.
+		 */
+		int pos = index_name_pos(istate, path, strlen(path));
+		if (pos >= 0)
+			mode = istate->cache[pos]->ce_mode;
+		else 
+			return ATTR__UNSET;
+	}
+	strbuf_addf(&sb, "%06o", mode);
+	return sb.buf;
+	
+}
+
+
+static const char *compute_builtin_attr(struct index_state *istate,
+					  const char *path,
+					  const struct git_attr *attr) {
+	const struct git_attr *object_mode_attr = git_attr("builtin_objectmode");
+	
+	if (attr == object_mode_attr)
+		return builtin_object_mode_attr(istate, path);
+	return ATTR__UNSET;
+}
+
 void git_check_attr(struct index_state *istate,
 		    const char *path,
 		    struct attr_check *check)
@@ -1253,7 +1314,7 @@ void git_check_attr(struct index_state *istate,
 		unsigned int n = check->items[i].attr->attr_nr;
 		const char *value = check->all_attrs[n].value;
 		if (value == ATTR__UNKNOWN)
-			value = ATTR__UNSET;
+			value = compute_builtin_attr(istate, path, check->all_attrs[n].attr);
 		check->items[i].value = value;
 	}
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index aee2298f01..25aa3fbd05 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -19,6 +19,16 @@ attr_check () {
 	test_must_be_empty err
 }
 
+attr_check_object_mode () {
+	path="$1" &&
+	expect="$2" &&
+	check_opts="$3" &&
+	git check-attr $check_opts builtin_objectmode -- "$path" >actual 2>err &&
+	echo "$path: builtin_objectmode: $expect" >expect &&
+	test_cmp expect actual
+	test_must_be_empty err
+}
+
 attr_check_quote () {
 	path="$1" quoted_path="$2" expect="$3" &&
 
@@ -558,4 +568,38 @@ test_expect_success EXPENSIVE 'large attributes file ignored in index' '
 	test_cmp expect err
 '
 
+test_expect_success 'native object mode attributes work' '
+	>exec && chmod +x exec && attr_check_object_mode exec 100755 &&
+	>normal && attr_check_object_mode normal 100644 &&
+	mkdir dir && attr_check_object_mode dir 040000 &&
+	>to_sym ln -s to_sym sym && attr_check_object_mode sym 120000
+'
+
+test_expect_success 'native object mode attributes work with --cached' '
+	>normal && attr_check_object_mode normal unspecified --cached &&
+	git add normal && attr_check_object_mode normal 100644 --cached
+'
+
+test_expect_success 'check object mode attributes work for submodules' '
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		mv .git .real &&
+		echo "gitdir: .real" >.git &&
+		test_commit first
+	) &&
+	attr_check_object_mode sub 160000 &&
+	attr_check_object_mode sub unspecified --cached &&
+	git add sub &&
+	attr_check_object_mode sub 160000 --cached
+'
+
+test_expect_success 'we do not allow user defined builtin_* attributes' '
+	echo "foo* builtin_foo" >.gitattributes &&
+	git add .gitattributes 2>actual &&
+	echo "builtin_foo is not a valid attribute name: .gitattributes:1" >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index a9c1e4e0ec..b08a32ea68 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -295,4 +295,29 @@ test_expect_success 'reading from .gitattributes in a subdirectory (3)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pathspec with builtin_objectmode attr can be used' '
+	>mode_exec_file_1 &&
+
+	git status -s ":(attr:builtin_objectmode=100644)mode_exec_*" >actual &&
+	echo ?? mode_exec_file_1 >expect &&
+	test_cmp expect actual &&
+
+	git add mode_exec_file_1 && chmod +x mode_exec_file_1 &&
+	git status -s ":(attr:builtin_objectmode=100755)mode_exec_*" >actual &&
+	echo AM mode_exec_file_1 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'builtin_objectmode attr can be excluded' '
+	>mode_1_regular &&
+	>mode_1_exec  && chmod +x mode_1_exec &&
+	git status -s ":(exclude,attr:builtin_objectmode=100644)" "mode_1_*" >actual &&
+	echo ?? mode_1_exec >expect &&
+	test_cmp expect actual &&
+
+	git status -s ":(exclude,attr:builtin_objectmode=100755)" "mode_1_*" >actual &&
+	echo ?? mode_1_regular >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0.rc0.421.g78406f8d94-goog

