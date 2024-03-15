Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A054901
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541607; cv=none; b=fTSnf1uG/mj+yMWFGkompGQvlMtnzUEFWZpVFhWCknFFLYIVqAHE0KB7FUquJI6v64Q6wnEsVfqYx07mAorGWvLdRxjZ/ERkLZxT9hfmQ7RVar/YmB7XCuYdws+aRiA2PsBs58rhFX2nTKWw9B1Rori3tuEJ8lAGqofq+alQKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541607; c=relaxed/simple;
	bh=ShFQy87s1zzfGps7k87f3bWicWeU9w/Kbn3VTcBCFnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JMW+1nsgCsMJBHZH/qvUKGoczHuldloXjufc58+tsJg6OCzLdnqhvXP2HSqGHWxbjBTEHRcVyVupWyd1N4UMQ6DBll/sIUK+v2BqSq6opYuMdPSBe72jOe1NJQiJWkDzYG2HVd4GizGiVUs8AJBro+tPW5oPyW/iyBllAthB8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DA/ESLzK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DA/ESLzK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C9681EB489;
	Fri, 15 Mar 2024 18:26:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ShFQy87s1zzfGps7k87f3bWicWeU9w/Kbn3VTc
	BCFnw=; b=DA/ESLzK9QxnDjPn2wVolZbxAd4LbQOFxsqqyG4FyAXdSk4dVexi+E
	pSjpIkT2m5Lys2ctZiy6PHTNkMobQ+jZoBudnM+VkWw+fCV3hh1rNWyCpUvFgp88
	o5//O8U+h0UHgsK9xK839L97kdJ2BbyH1KiAU/8FSXLPxrX9vDrS4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 848041EB488;
	Fri, 15 Mar 2024 18:26:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB78A1EB487;
	Fri, 15 Mar 2024 18:26:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: rsbecker@nexbridge.com,  Dragan Simic <dsimic@manjaro.org>,  Chris Torek
 <chris.torek@gmail.com>,  Ralph Seichter <github@seichter.de>,  "Ralph
 Seichter via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/1] config: allow tweaking whitespace between value and
 comment
In-Reply-To: <xmqq8r2jp2eq.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	15 Mar 2024 15:15:41 -0700")
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
	<xmqq8r2jp2eq.fsf@gitster.g>
Date: Fri, 15 Mar 2024 15:26:40 -0700
Message-ID: <xmqq4jd7p1wf.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 191A0CFE-E31B-11EE-9FB2-25B3960A682E-77302942!pb-smtp2.pobox.com

Extending the previous step, this allows the whitespace placed after
the value before the "# comment message" to be tweaked by tweaking
the preprocessing rule to:

 * If the given comment string begins with one or more whitespace
   characters followed by '#', it is passed intact.

 * If the given comment string begins with '#', a Space is
   prepended.

 * Otherwise, " # " (Space, '#', Space) is prefixed.

 * A string with LF in it cannot be used as a comment string.

Unlike the previous step, which unconditionally added a space after
the value before writing the "# comment string", because the above
preprocessing already gives a whitespace before the '#', the
resulting string is written immediately after copying the value.

And the sanity checking rule becomes

 * comment string after the above massaging that comes into
   git_config_set_multivar_in_file_gently() must

   - begin with zero or more whitespace characters followed by '#'.
   - not have a LF in it.

I personally think this is over-engineered, but since I thought
things through anyway, here it is in the patch form.  The logic to
tweak end-user supplied comment string is encapsulated in a new
helper function, git_config_prepare_comment_string(), so if new
front-end callers would want to use the same massaging rules, it is
easily reused.

Unfortunately I do not think of a way to tweak the preprocessing
rules further to optionally allow having no blank after the value,
i.e. to produce

	[section]
		variable = value#comment

(which is a valid way to say section.variable=value, by the way)
without sacrificing the ergonomics for the more usual case, so this
time I really stop here.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is [3/1] as the one attached to my review of the single
   patch is [2/1].

 Documentation/git-config.txt | 12 +++++--
 builtin/config.c             |  7 +---
 config.c                     | 69 ++++++++++++++++++++++++++++++------
 config.h                     |  2 ++
 t/t1300-config.sh            |  6 ++++
 5 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index af374ee2e0..e4f2e07926 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -89,9 +89,15 @@ OPTIONS
 
 --comment <message>::
 	Append a comment at the end of new or modified lines.
-	Unless _<message>_ begins with "#", a string "# " (hash
-	followed by a space) is prepended to it. The _<message>_ must not
-	contain linefeed characters (no multi-line comments are permitted).
+
+	If _<message>_ begins with one or more whitespaces followed
+	by "#", it is used as-is.  If it begins with "#", a space is
+	prepended before it is used.  Otherwise, a string " # " (a
+	space followed by a hash followed by a space) is prepended
+	to it.  And the resulting string is placed immediately after
+	the value defined for the variable.  The _<message>_ must
+	not contain linefeed characters (no multi-line comments are
+	permitted).
 
 --get::
 	Get the value for a given key (optionally filtered by a regex
diff --git a/builtin/config.c b/builtin/config.c
index e859a659f4..0015620dde 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -841,12 +841,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		flags |= CONFIG_FLAGS_FIXED_VALUE;
 	}
 
-	if (comment) {
-		if (strchr(comment, '\n'))
-			die(_("no multi-line comment allowed: '%s'"), comment);
-		if (comment[0] != '#')
-			comment = xstrfmt("# %s", comment);
-	}
+	comment = git_config_prepare_comment_string(comment);
 
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
diff --git a/config.c b/config.c
index 15019cb9a5..f1d4263a68 100644
--- a/config.c
+++ b/config.c
@@ -3044,7 +3044,7 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
 		}
 
 	if (comment)
-		strbuf_addf(&sb, "%s %s\n", quote, comment);
+		strbuf_addf(&sb, "%s%s\n", quote, comment);
 	else
 		strbuf_addf(&sb, "%s\n", quote);
 
@@ -3172,6 +3172,62 @@ void git_config_set(const char *key, const char *value)
 	trace2_cmd_set_config(key, value);
 }
 
+/*
+ * The ownership rule is that the caller will own the string
+ * if it receives a piece of memory different from what it passed
+ * as the parameter.
+ */
+const char *git_config_prepare_comment_string(const char *comment)
+{
+	size_t leading_blanks;
+
+	if (!comment)
+		return NULL;
+
+	if (strchr(comment, '\n'))
+		die(_("no multi-line comment allowed: '%s'"), comment);
+
+	/*
+	 * If it begins with one or more leading whitespace characters
+	 * followed by '#", the comment string is used as-is.
+	 *
+	 * If it begins with '#', a SP is inserted between the comment
+	 * and the value the comment is about.
+	 *
+	 * Otherwise, the value is followed by a SP followed by '#'
+	 * followed by SP and then the comment string comes.
+	 */
+
+	leading_blanks = strspn(comment, " \t");
+	if (leading_blanks && comment[leading_blanks] == '#')
+		; /* use it as-is */
+	else if (comment[0] == '#')
+		comment = xstrfmt(" %s", comment);
+	else
+		comment = xstrfmt(" # %s", comment);
+
+	return comment;
+}
+
+static void validate_comment_string(const char *comment)
+{
+	size_t leading_blanks;
+
+	if (!comment)
+		return;
+	/*
+	 * The front-end must have massaged the comment string
+	 * properly before calling us.
+	 */
+	if (strchr(comment, '\n'))
+		BUG("multi-line comments are not permitted: '%s'", comment);
+
+	leading_blanks = strspn(comment, " \t");
+	if (!leading_blanks || comment[leading_blanks] != '#')
+		BUG("comment must begin with one or more SP followed by '#': '%s'",
+		    comment);
+}
+
 /*
  * If value==NULL, unset in (remove from) config,
  * if value_pattern!=NULL, disregard key/value pairs where value does not match.
@@ -3211,16 +3267,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	size_t contents_sz;
 	struct config_store_data store = CONFIG_STORE_INIT;
 
-	if (comment) {
-		/*
-		 * The front-end must have massaged the comment string
-		 * properly before calling us.
-		 */
-		if (strchr(comment, '\n'))
-			BUG("multi-line comments are not permitted: '%s'", comment);
-		if (comment[0] != '#')
-			BUG("comment should begin with '#': '%s'", comment);
-	}
+	validate_comment_string(comment);
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
diff --git a/config.h b/config.h
index a85a827169..f4966e3749 100644
--- a/config.h
+++ b/config.h
@@ -338,6 +338,8 @@ void git_config_set_multivar(const char *, const char *, const char *, unsigned)
 int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, const char *, unsigned);
 
+const char *git_config_prepare_comment_string(const char *);
+
 /**
  * takes four parameters:
  *
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index d5dfb45877..cc050b3c20 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -74,6 +74,8 @@ cat > expect << EOF
 	penguin = gentoo # Pygoscelis papua
 	disposition = peckish # find fish
 	foo = bar #abc
+	spsp = value # and comment
+	htsp = value	# and comment
 [Sections]
 	WhatEver = Second
 EOF
@@ -82,6 +84,10 @@ test_expect_success 'append comments' '
 	git config --replace-all --comment="Pygoscelis papua" section.penguin gentoo &&
 	git config --comment="find fish" section.disposition peckish &&
 	git config --comment="#abc" section.foo bar &&
+
+	git config --comment="and comment" section.spsp value &&
+	git config --comment="	# and comment" section.htsp value &&
+
 	test_cmp expect .git/config
 '
 
-- 
2.44.0-248-g4f9b731bde

