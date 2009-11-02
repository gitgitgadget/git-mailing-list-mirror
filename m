From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit -c/-C/--amend: acquire authorship and restamp
 time  with --claim
Date: Sun, 01 Nov 2009 19:07:20 -0800
Message-ID: <7vskcxwro7.fsf@alter.siamese.dyndns.org>
References: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com>
 <1257101127-8196-1-git-send-email-erick.mattos@gmail.com>
 <7vr5sixbd1.fsf@alter.siamese.dyndns.org>
 <55bacdd30911011257m22ee85f2wc5d51865f7f2aadd@mail.gmail.com>
 <7vbpjlycqc.fsf@alter.siamese.dyndns.org>
 <55bacdd30911011654k22eb6b13r28897bf71fc5e11b@mail.gmail.com>
 <7v1vkhy6n4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 04:12:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4nL7-0001gC-Gc
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 04:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbZKBDHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 22:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbZKBDHX
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 22:07:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbZKBDHW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 22:07:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D6DE8E43A;
	Sun,  1 Nov 2009 22:07:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=54zTMsYcp77qk3tPVXGafp1uQes=; b=nKtDqy
	5lCO2thZxhVFgkdHLwgyf4UEJaXTF50S/E4OFAGpRVGgQKQQ7WHIYx3UmJOoUIwu
	K3LFmOxfoZKIvkqtUzpo0VldZxYNCBZbSRwJDU1mx9vzb3G977xQ6oY0eq0nQSqM
	FGM07gvkwQvDOm/hCQUnY+PYq1Dw96zA1kCEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=csVLr6a22i36y4y6p1jwy0WKeA2VyQPl
	9ZGnskCEHLZ7hdPELcT282mwHDCE36J/PoADJGTwMoxS+c53Z3oXnBkXhP7arRSc
	WjfyNsKmP/aa8Lq9xKE1nJivTY0oASpl38Y45de4kfudY1GiJXTZVB9dVnN23N+4
	QKrIHPTLaeg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EF358E438;
	Sun,  1 Nov 2009 22:07:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E2C698E435; Sun,  1 Nov 2009
 22:07:21 -0500 (EST)
In-Reply-To: <7v1vkhy6n4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 01 Nov 2009 18\:58\:39 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D8935882-C75C-11DE-8CEE-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131893>

The last one was probably harder to read since it was an interdiff.  Here
is what I am considering to queue.

No, I didn't use --mine option when I ran "commit --amend" to record this
one ;-)

-- >8 --
From: Erick Mattos <erick.mattos@gmail.com>
Date: Sun, 1 Nov 2009 16:45:27 -0200
Subject: [PATCH] git commit --mine: ignore authorship information taken from -c/-C/--amend

When we use -c, -C, or --amend, we are trying one of two things: using the
source as a template or modifying a commit with corrections.

When these options are are used, the authorship and timestamp recorded in
the newly created commit is always taken from the original commit.  This
is inconvenient when you want to just borrow the commit log message, or
your change is so significant that you should take over the authorship
(with the blame for bugs you introduced).

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-commit.txt |    7 +++-
 builtin-commit.c             |   10 +++-
 t/t7509-commit.sh            |  103 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 4 deletions(-)
 create mode 100755 t/t7509-commit.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0578a40..7832720 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--mine]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
@@ -69,6 +69,11 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
 
+--mine::
+	When used with -C/-c/--amend options, declare that the
+	authorship of the resulting commit now belongs of the committer.
+	This also renews the author timestamp.
+
 -F <file>::
 --file=<file>::
 	Take the commit message from the given file.  Use '-' to
diff --git a/builtin-commit.c b/builtin-commit.c
index beddf01..aa42989 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -51,7 +51,7 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty, dry_run;
+static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -91,8 +91,9 @@ static struct option builtin_commit_options[] = {
 	OPT_FILENAME('F', "file", &logfile, "read log from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
-	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
+	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
+	OPT_BOOLEAN(0, "mine", &renew_authorship, "the commit is authored by me now (used with -C-c/--amend)"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
@@ -381,7 +382,7 @@ static void determine_author_info(void)
 	email = getenv("GIT_AUTHOR_EMAIL");
 	date = getenv("GIT_AUTHOR_DATE");
 
-	if (use_message) {
+	if (use_message && !renew_authorship) {
 		const char *a, *lb, *rb, *eol;
 
 		a = strstr(use_message_buffer, "\nauthor ");
@@ -747,6 +748,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && !strchr(force_author, '>'))
 		force_author = find_author_by_nickname(force_author);
 
+	if (force_author && renew_authorship)
+		die("Using both --mine and --author does not make sense");
+
 	if (logfile || message.len || use_message)
 		use_editor = 0;
 	if (edit_flag)
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
new file mode 100755
index 0000000..ec13cea
--- /dev/null
+++ b/t/t7509-commit.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Erick Mattos
+#
+
+test_description='git commit --mine'
+
+. ./test-lib.sh
+
+author_header () {
+	git cat-file commit "$1" |
+	sed -n -e '/^$/q' -e '/^author /p'
+}
+
+message_body () {
+	git cat-file commit "$1" |
+	sed -e '1,/^$/d'
+}
+
+test_expect_success '-C option copies authorship and message' '
+	echo "Initial" >foo &&
+	git add foo &&
+	test_tick &&
+	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\> &&
+	git tag Initial &&
+	echo "Test 1" >>foo &&
+	test_tick &&
+	git commit -a -C Initial &&
+	author_header Initial >expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '-C option copies only the message with --mine' '
+	echo "Test 2" >>foo &&
+	test_tick &&
+	git commit -a -C Initial --mine &&
+	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >expect &&
+	author_header HEAD >actual
+	test_cmp expect actual &&
+
+	message_body Initial >expect &&
+	message_body HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '-c option copies authorship and message' '
+	echo "Test 3" >>foo &&
+	test_tick &&
+	EDITOR=: VISUAL=: git commit -a -c Initial &&
+	author_header Initial >expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '-c option copies only the message with --mine' '
+	echo "Test 4" >>foo &&
+	test_tick &&
+	EDITOR=: VISUAL=: git commit -a -c Initial --mine &&
+	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual &&
+
+	message_body Initial >expect &&
+	message_body HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--amend option copies authorship' '
+	git checkout Initial &&
+	echo "Test 5" >>foo &&
+	test_tick &&
+	git commit -a --amend -m "amend test" &&
+	author_header Initial >expect &&
+	author_header HEAD >actual &&
+
+	echo "amend test" >expect &&
+	message_body HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--mine makes the commit ours even with --amend option' '
+	git checkout Initial &&
+	echo "Test 6" >>foo &&
+	test_tick &&
+	git commit -a --mine -m "Changed again" --amend &&
+	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual &&
+
+	echo "Changed again" >expect &&
+	message_body HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--mine and --author are mutually exclusive' '
+	git checkout Initial &&
+	echo "Test 7" >>foo &&
+	test_tick &&
+	test_must_fail git commit -a --mine --author="Xyzzy <frotz@nitfol.xz>"
+'
+
+test_done
-- 
1.6.5.2.246.gc99575
