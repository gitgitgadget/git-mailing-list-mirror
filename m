From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] grep: rip out support for external grep
Date: Tue, 12 Jan 2010 22:48:10 -0800
Message-ID: <7v4omqv6tx.fsf_-_@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
 <7v63774tfd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 07:48:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx1q-0007U9-W0
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab0AMGs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909Ab0AMGs1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:48:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab0AMGs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:48:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2A290F13;
	Wed, 13 Jan 2010 01:48:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2urNiRhoQGBta+r4ZSH1bG0ANxY=; b=cvi8t9
	uuRbc3cs/c/x8E0A0s/W0WedV8uocZYWmM3upas4/T37JYABY+Z3KlFOBr9EG994
	dnu1rsqa1aCqaepNkIN4jdFXliQDoq/QjsppsKwvO8TkVBeJys1+M5cogr62m7cY
	YDaXOXsRM7f3s0X1L+cSvTgFwuVWyQSniszow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c1L8FHnKX1ZGx8fOT+zySI1IG+xBrn3z
	2+9U5S/jjqFz1YwwocWnn6ck/Iof6fqmLHDGJJecPlWikCidMx2YLq8VetrBuD+1
	qzLBgbl88rg8/u8YzJQBzsp7OtHdZ2ZfsSJxehhW2GCyCP/N3LdS9MBWbEbtWA8c
	hrn96i3sclg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35F7090F0F;
	Wed, 13 Jan 2010 01:48:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8166590F0D; Wed, 13 Jan
 2010 01:48:11 -0500 (EST)
In-Reply-To: <7v63774tfd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 12 Jan 2010 00\:29\:58 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1B54D0C-000F-11DF-9B93-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136771>

We still allow people to pass --[no-]ext-grep on the command line,
but the option is ignored.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Junio C Hamano <gitster@pobox.com> writes:

 > Linus Torvalds <torvalds@linux-foundation.org> writes:
 >
 >> Ack. Works for me. And with that, I'd love for it to go in, and get rid of 
 >> the external grep.
 > ...
 > Before going forward, I found two small nits that should go to maint.

 These nits out-of-way, we can now start doing this.

 Makefile        |   10 --
 builtin-grep.c  |  305 +------------------------------------------------------
 t/t7002-grep.sh |    6 +-
 3 files changed, 8 insertions(+), 313 deletions(-)

diff --git a/Makefile b/Makefile
index 4a1e5bc..a4b922e 100644
--- a/Makefile
+++ b/Makefile
@@ -185,10 +185,6 @@ all::
 # is a simplified version of the merge sort used in glibc. This is
 # recommended if Git triggers O(n^2) behavior in your platform's qsort().
 #
-# Define NO_EXTERNAL_GREP if you don't want "git grep" to ever call
-# your external grep (e.g., if your system lacks grep, if its grep is
-# broken, or spawning external process is slower than built-in grep git has).
-#
 # Define UNRELIABLE_FSTAT if your system's fstat does not return the same
 # information on a not yet closed file that lstat would return for the same
 # file after it was closed.
@@ -777,7 +773,6 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
-	NO_EXTERNAL_GREP = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
@@ -895,7 +890,6 @@ ifeq ($(uname_S),IRIX)
 	# NO_MMAP.  If you suspect that your compiler is not affected by this
 	# issue, comment out the NO_MMAP statement.
 	NO_MMAP = YesPlease
-	NO_EXTERNAL_GREP = UnfortunatelyYes
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH = /usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
@@ -915,7 +909,6 @@ ifeq ($(uname_S),IRIX64)
 	# NO_MMAP.  If you suspect that your compiler is not affected by this
 	# issue, comment out the NO_MMAP statement.
 	NO_MMAP = YesPlease
-	NO_EXTERNAL_GREP = UnfortunatelyYes
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
@@ -1322,9 +1315,6 @@ endif
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
-ifdef NO_EXTERNAL_GREP
-	BASIC_CFLAGS += -DNO_EXTERNAL_GREP
-endif
 ifdef UNRELIABLE_FSTAT
 	BASIC_CFLAGS += -DUNRELIABLE_FSTAT
 endif
diff --git a/builtin-grep.c b/builtin-grep.c
index a5b6719..4adb971 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -15,14 +15,6 @@
 #include "grep.h"
 #include "quote.h"
 
-#ifndef NO_EXTERNAL_GREP
-#ifdef __unix__
-#define NO_EXTERNAL_GREP 0
-#else
-#define NO_EXTERNAL_GREP 1
-#endif
-#endif
-
 static char const * const grep_usage[] = {
 	"git grep [options] [-e] <pattern> [<rev>...] [[--] path...]",
 	NULL
@@ -215,292 +207,12 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	return i;
 }
 
-#if !NO_EXTERNAL_GREP
-static int exec_grep(int argc, const char **argv)
-{
-	pid_t pid;
-	int status;
-
-	argv[argc] = NULL;
-	pid = fork();
-	if (pid < 0)
-		return pid;
-	if (!pid) {
-		execvp("grep", (char **) argv);
-		exit(255);
-	}
-	while (waitpid(pid, &status, 0) < 0) {
-		if (errno == EINTR)
-			continue;
-		return -1;
-	}
-	if (WIFEXITED(status)) {
-		if (!WEXITSTATUS(status))
-			return 1;
-		return 0;
-	}
-	return -1;
-}
-
-#define MAXARGS 1000
-#define ARGBUF 4096
-#define push_arg(a) do { \
-	if (nr < MAXARGS) argv[nr++] = (a); \
-	else die("maximum number of args exceeded"); \
-	} while (0)
-
-/*
- * If you send a singleton filename to grep, it does not give
- * the name of the file.  GNU grep has "-H" but we would want
- * that behaviour in a portable way.
- *
- * So we keep two pathnames in argv buffer unsent to grep in
- * the main loop if we need to do more than one grep.
- */
-static int flush_grep(struct grep_opt *opt,
-		      int argc, int arg0, const char **argv, int *kept)
-{
-	int status;
-	int count = argc - arg0;
-	const char *kept_0 = NULL;
-
-	if (count <= 2) {
-		/*
-		 * Because we keep at least 2 paths in the call from
-		 * the main loop (i.e. kept != NULL), and MAXARGS is
-		 * far greater than 2, this usually is a call to
-		 * conclude the grep.  However, the user could attempt
-		 * to overflow the argv buffer by giving too many
-		 * options to leave very small number of real
-		 * arguments even for the call in the main loop.
-		 */
-		if (kept)
-			die("insanely many options to grep");
-
-		/*
-		 * If we have two or more paths, we do not have to do
-		 * anything special, but we need to push /dev/null to
-		 * get "-H" behaviour of GNU grep portably but when we
-		 * are not doing "-l" nor "-L" nor "-c".
-		 */
-		if (count == 1 &&
-		    !opt->name_only &&
-		    !opt->unmatch_name_only &&
-		    !opt->count) {
-			argv[argc++] = "/dev/null";
-			argv[argc] = NULL;
-		}
-	}
-
-	else if (kept) {
-		/*
-		 * Called because we found many paths and haven't finished
-		 * iterating over the cache yet.  We keep two paths
-		 * for the concluding call.  argv[argc-2] and argv[argc-1]
-		 * has the last two paths, so save the first one away,
-		 * replace it with NULL while sending the list to grep,
-		 * and recover them after we are done.
-		 */
-		*kept = 2;
-		kept_0 = argv[argc-2];
-		argv[argc-2] = NULL;
-		argc -= 2;
-	}
-
-	if (opt->pre_context || opt->post_context) {
-		/*
-		 * grep handles hunk marks between files, but we need to
-		 * do that ourselves between multiple calls.
-		 */
-		if (opt->show_hunk_mark)
-			write_or_die(1, "--\n", 3);
-		else
-			opt->show_hunk_mark = 1;
-	}
-
-	status = exec_grep(argc, argv);
-
-	if (kept_0) {
-		/*
-		 * Then recover them.  Now the last arg is beyond the
-		 * terminating NULL which is at argc, and the second
-		 * from the last is what we saved away in kept_0
-		 */
-		argv[arg0++] = kept_0;
-		argv[arg0] = argv[argc+1];
-	}
-	return status;
-}
-
-static void grep_add_color(struct strbuf *sb, const char *escape_seq)
-{
-	size_t orig_len = sb->len;
-
-	while (*escape_seq) {
-		if (*escape_seq == 'm')
-			strbuf_addch(sb, ';');
-		else if (*escape_seq != '\033' && *escape_seq  != '[')
-			strbuf_addch(sb, *escape_seq);
-		escape_seq++;
-	}
-	if (sb->len > orig_len && sb->buf[sb->len - 1] == ';')
-		strbuf_setlen(sb, sb->len - 1);
-}
-
-static int external_grep(struct grep_opt *opt, const char **paths, int cached)
-{
-	int i, nr, argc, hit, len, status;
-	const char *argv[MAXARGS+1];
-	char randarg[ARGBUF];
-	char *argptr = randarg;
-	struct grep_pat *p;
-
-	if (opt->extended || (opt->relative && opt->prefix_length))
-		return -1;
-	len = nr = 0;
-	push_arg("grep");
-	if (opt->fixed)
-		push_arg("-F");
-	if (opt->linenum)
-		push_arg("-n");
-	if (!opt->pathname)
-		push_arg("-h");
-	if (opt->regflags & REG_EXTENDED)
-		push_arg("-E");
-	if (opt->ignore_case)
-		push_arg("-i");
-	if (opt->binary == GREP_BINARY_NOMATCH)
-		push_arg("-I");
-	if (opt->word_regexp)
-		push_arg("-w");
-	if (opt->name_only)
-		push_arg("-l");
-	if (opt->unmatch_name_only)
-		push_arg("-L");
-	if (opt->null_following_name)
-		/* in GNU grep git's "-z" translates to "-Z" */
-		push_arg("-Z");
-	if (opt->count)
-		push_arg("-c");
-	if (opt->post_context || opt->pre_context) {
-		if (opt->post_context != opt->pre_context) {
-			if (opt->pre_context) {
-				push_arg("-B");
-				len += snprintf(argptr, sizeof(randarg)-len,
-						"%u", opt->pre_context) + 1;
-				if (sizeof(randarg) <= len)
-					die("maximum length of args exceeded");
-				push_arg(argptr);
-				argptr += len;
-			}
-			if (opt->post_context) {
-				push_arg("-A");
-				len += snprintf(argptr, sizeof(randarg)-len,
-						"%u", opt->post_context) + 1;
-				if (sizeof(randarg) <= len)
-					die("maximum length of args exceeded");
-				push_arg(argptr);
-				argptr += len;
-			}
-		}
-		else {
-			push_arg("-C");
-			len += snprintf(argptr, sizeof(randarg)-len,
-					"%u", opt->post_context) + 1;
-			if (sizeof(randarg) <= len)
-				die("maximum length of args exceeded");
-			push_arg(argptr);
-			argptr += len;
-		}
-	}
-	for (p = opt->pattern_list; p; p = p->next) {
-		push_arg("-e");
-		push_arg(p->pattern);
-	}
-	if (opt->color) {
-		struct strbuf sb = STRBUF_INIT;
-
-		grep_add_color(&sb, opt->color_match);
-		setenv("GREP_COLOR", sb.buf, 1);
-
-		strbuf_reset(&sb);
-		strbuf_addstr(&sb, "mt=");
-		grep_add_color(&sb, opt->color_match);
-		strbuf_addstr(&sb, ":sl=:cx=:fn=:ln=:bn=:se=");
-		setenv("GREP_COLORS", sb.buf, 1);
-
-		strbuf_release(&sb);
-
-		if (opt->color_external && strlen(opt->color_external) > 0)
-			push_arg(opt->color_external);
-	} else {
-		unsetenv("GREP_COLOR");
-		unsetenv("GREP_COLORS");
-	}
-	unsetenv("GREP_OPTIONS");
-
-	hit = 0;
-	argc = nr;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		char *name;
-		int kept;
-		if (!S_ISREG(ce->ce_mode))
-			continue;
-		if (!pathspec_matches(paths, ce->name, opt->max_depth))
-			continue;
-		name = ce->name;
-		if (name[0] == '-') {
-			int len = ce_namelen(ce);
-			name = xmalloc(len + 3);
-			memcpy(name, "./", 2);
-			memcpy(name + 2, ce->name, len + 1);
-		}
-		argv[argc++] = name;
-		if (MAXARGS <= argc) {
-			status = flush_grep(opt, argc, nr, argv, &kept);
-			if (0 < status)
-				hit = 1;
-			argc = nr + kept;
-		}
-		if (ce_stage(ce)) {
-			do {
-				i++;
-			} while (i < active_nr &&
-				 !strcmp(ce->name, active_cache[i]->name));
-			i--; /* compensate for loop control */
-		}
-	}
-	if (argc > nr) {
-		status = flush_grep(opt, argc, nr, argv, NULL);
-		if (0 < status)
-			hit = 1;
-	}
-	return hit;
-}
-#endif
-
-static int grep_cache(struct grep_opt *opt, const char **paths, int cached,
-		      int external_grep_allowed)
+static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 {
 	int hit = 0;
 	int nr;
 	read_cache();
 
-#if !NO_EXTERNAL_GREP
-	/*
-	 * Use the external "grep" command for the case where
-	 * we grep through the checked-out files. It tends to
-	 * be a lot more optimized
-	 */
-	if (!cached && external_grep_allowed) {
-		hit = external_grep(opt, paths, cached);
-		if (hit >= 0)
-			return hit;
-		hit = 0;
-	}
-#endif
-
 	for (nr = 0; nr < active_nr; nr++) {
 		struct cache_entry *ce = active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
@@ -697,8 +409,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
 	int cached = 0;
-	int external_grep_allowed = 1;
 	int seen_dashdash = 0;
+	int external_grep_allowed__ignored;
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
@@ -780,13 +492,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
-#if NO_EXTERNAL_GREP
-		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed,
-			"allow calling of grep(1) (ignored by this build)"),
-#else
-		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed,
-			"allow calling of grep(1) (default)"),
-#endif
+		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
+			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 		OPT_END()
@@ -837,8 +544,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		argc--;
 	}
 
-	if ((opt.color && !opt.color_external) || opt.funcname)
-		external_grep_allowed = 0;
 	if (!opt.pattern_list)
 		die("no pattern given.");
 	if (!opt.fixed && opt.ignore_case)
@@ -884,7 +589,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
-		return !grep_cache(&opt, paths, cached, external_grep_allowed);
+		return !grep_cache(&opt, paths, cached);
 	}
 
 	if (cached)
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index abd14bf..c369cdb 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -302,8 +302,8 @@ test_expect_success 'grep -C1, hunk mark between files' '
 	test_cmp expected actual
 '
 
-test_expect_success 'grep -C1 --no-ext-grep, hunk mark between files' '
-	git grep -C1 --no-ext-grep "^[yz]" >actual &&
+test_expect_success 'grep -C1 hunk mark between files' '
+	git grep -C1 "^[yz]" >actual &&
 	test_cmp expected actual
 '
 
@@ -359,7 +359,7 @@ test_expect_success 'log grep (6)' '
 test_expect_success 'grep with CE_VALID file' '
 	git update-index --assume-unchanged t/t &&
 	rm t/t &&
-	test "$(git grep --no-ext-grep test)" = "t/t:test" &&
+	test "$(git grep test)" = "t/t:test" &&
 	git update-index --no-assume-unchanged t/t &&
 	git checkout t/t
 '
-- 
1.6.6.292.ge84ea.dirty
