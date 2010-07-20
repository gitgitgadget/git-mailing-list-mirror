From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 0/2] Add -e/--exclude to git clean.
Date: Tue, 20 Jul 2010 11:23:22 -0700
Message-ID: <7v630am2qt.fsf@alter.siamese.dyndns.org>
References: <e257dd98b7493dcd72de9cf62d5847116e030ed0.1279564639.git.jaredhance@gmail.com> <cover.1279643093.git.jaredhance@gmail.com> <AANLkTinzavHKSVs4BYGtc-T1IKAS21yk-yzybn7G7IaZ@mail.gmail.com> <7vaapmm3ow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Crane <git@aaroncrane.co.uk>, git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 20:23:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHTj-00014R-Mb
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761317Ab0GTSXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 14:23:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761205Ab0GTSXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 14:23:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA4B9C61BC;
	Tue, 20 Jul 2010 14:23:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bcyQd53TVex6S8BNd+6oxK6vaGU=; b=caeTJP
	GrJu+TUqNWcMzXv0FQ6OxwwYBVuZXESgJODrjZ8ImM2hNOfXS0oZ9VxL3CMQ3LB6
	t0U23f7QkKBkgZllAmt6cODIhllE+OPMwRaGDIEgj0TUioVdY2rlzOJfzHsts07h
	Hwv6a2XHc/HDnBA1tXQLAwPwmp7dHC3q5Z674=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uqk1SRXd7ZHNqrZQXQJXI2TshEjR17q9
	RzkP1ULeQ7GSIHhAFTZX1UG6uo1J+cmHNNJpLWvh3k7FjU6sTvX43TqRluFfASjX
	SPC8CtS6Nc++RzYjnycFJu2BcZ6K9FUrAZtr5hJ7J52g4ldQWFTGLqXPVp/uIasG
	vaSLPijPsCQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84F4FC61BB;
	Tue, 20 Jul 2010 14:23:28 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5037FC61B9; Tue, 20 Jul
 2010 14:23:24 -0400 (EDT)
In-Reply-To: <7vaapmm3ow.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 20 Jul 2010 11\:02\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4A8B3E6-942B-11DF-89F6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151343>

Junio C Hamano <gitster@pobox.com> writes:

> Aaron Crane <git@aaroncrane.co.uk> writes:
>
>> Jared Hance <jaredhance@gmail.com> wrote:
>>> This is the fourth round of patches for git clean -e.
>>> Since this patch seems to be somewhat controversial, I've marked it as
>>> PATCH/RFC. I would like some ideas on what to use for separators
>>
>> Rather than stuffing multiple exclusions into a single option, how
>> about requiring one -e option per exclusion?
>>
>> git clean -e foo -e bar
>
> I find it a lot saner.
>
> Sorry, Jared, I should have thought of it and suggested it during the
> first review round.

The fix-up should look something like this, on top of your patch.

Note that I did this on top of applying your patch to 'maint', and you may
need to adjust the parameter order of string-list functions if you want to
forward port it to 'master'.

Untested, of course ;-)


 Documentation/git-clean.txt |   11 ++++++-----
 builtin/clean.c             |   36 +++++++++++++++---------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 488e103..60e38e6 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-n] [-q] [-e] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -45,10 +45,11 @@ OPTIONS
 	Be quiet, only report errors, but not the files that are
 	successfully removed.
 
--e <files>::
---exclude=<files>::
-	Specify special exceptions to not be cleaned. Separate with a space.
-	Globs, like that in $GIT_DIR/info/excludes, should be used.
+-e <pattern>::
+--exclude=<pattern>::
+	Specify special exceptions to not be cleaned.  Each <pattern> is
+	the same form as in $GIT_DIR/info/excludes and this option can be
+	given multiple times.
 
 -x::
 	Don't use the ignore rules.  This allows removing all untracked
diff --git a/builtin/clean.c b/builtin/clean.c
index b1da923..58c9c06 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -10,13 +10,13 @@
 #include "cache.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "string-list.h"
 #include "quote.h"
 
 static int force = -1; /* unset */
-static const char *excludes;
 
 static const char *const builtin_clean_usage[] = {
-	"git clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
+	"git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>...",
 	NULL
 };
 
@@ -27,6 +27,13 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int exclude_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct string_list *exclude_list = opt->value;
+	string_list_append(arg, exclude_list);
+	return 0;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -37,8 +44,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf excludes_buf = STRBUF_INIT;
-	struct strbuf **excludes_split = NULL;
+	struct string_list exclude_list = { NULL, 0, 0, 0 };
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
@@ -47,7 +53,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('f', "force", &force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
-		OPT_STRING('e', "exclude", &excludes, "EXCLUDES", "specify files not to clean"),
+		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, "pattern",
+		  "exclude <pattern>", PARSE_OPT_NONEG, exclude_cb },
 		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
 		OPT_BOOLEAN('X', NULL, &ignored_only,
 				"remove only ignored files"),
@@ -85,16 +92,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	if (excludes) {
-		strbuf_addstr(&excludes_buf, excludes);
-		excludes_split = strbuf_split(&excludes_buf, ' ');
-		for (i = 0; excludes_split[i]; i++) {
-			if (excludes_split[i]->buf[excludes_split[i]->len - 1] == ' ') {
-				strbuf_remove(excludes_split[i], excludes_split[i]->len - 1, 1);
-			}
-			add_exclude(excludes_split[i]->buf, "", 0, dir.exclude_list);
-		}
-	}
+	for (i = 0; i < exclude_list.nr; i++)
+		add_exclude(exclude_list.items[i].string, "", 0, dir.exclude_list);
 
 	pathspec = get_pathspec(prefix, argv);
 
@@ -182,11 +181,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	free(seen);
 
 	strbuf_release(&directory);
-	if (excludes) {
-		strbuf_release(&excludes_buf);
-		for (i = 0; excludes_split[i]; i++) {
-			strbuf_release(excludes_split[i]);
-		}
-	}
+	string_list_clear(&exclude_list, 0);
 	return (errors != 0);
 }
