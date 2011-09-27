From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 2/2] grep --no-index: don't use git standard exclusions
Date: Tue, 27 Sep 2011 15:21:04 -0700
Message-ID: <7vty7xwrsf.fsf_-_@alter.siamese.dyndns.org>
References: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com> <7b3551dd84a2bfec78c8db1d14dd2d0e6dda35f6.1316110876.git.bert.wesarg@googlemail.com> <7vmxe5pp4n.fsf@alter.siamese.dyndns.org> <CAKPyHN2ewwLf6am3VQr_z4c3_Q5=saeLcZtuY-fEtUGr-41rKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 00:21:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8g1d-0001bZ-QQ
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 00:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab1I0WVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 18:21:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab1I0WVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 18:21:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13ADC54A9;
	Tue, 27 Sep 2011 18:21:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6U5syTOvdGr4jlfjunpwxgwhgCk=; b=ZhCsQ6
	1xDLV5B3Q7AW1AtpJhYHPL7uPSRx49ubFjK8FqcpiCMKLK6EcAU5+N62GtpwXpx9
	J873MDI6buu8FVILE4xmR/FXAcvICcpeThKAkGf0nVP+/sdAFmxkTuTCfhEczAoP
	t8V8UJX7a5detRAMDWHMha4439E4U25r0OUt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pd7OvFDnMaLMUJB1ijN4HvuMkA/q3EpV
	Ga6tolorOu4iZDJQMp7ZBp8zp9R2pwyJUFd6pfx3+poO8NUULU/+2RdsWuLykNiP
	m6gT3NogY/tDbFqvlbwjZYvKe8J/xuGpx3tbCFJu86hc0piGjc/7JaVASKdahrDp
	UHlMRdFJz4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC8B54A8;
	Tue, 27 Sep 2011 18:21:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BF2354A7; Tue, 27 Sep 2011
 18:21:06 -0400 (EDT)
In-Reply-To: <CAKPyHN2ewwLf6am3VQr_z4c3_Q5=saeLcZtuY-fEtUGr-41rKQ@mail.gmail.com> (Bert
 Wesarg's message of "Fri, 16 Sep 2011 20:23:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE4A8960-E956-11E0-85C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182271>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Would '--untracked-too' only be a synonym for '--no-index
> --exclude-standard', i.e. the current behavior?

That basically would be the idea. Perhaps something like this on top of
a9e6436 (grep --no-index: don't use git standard exclusions, 2011-09-15).

-- >8 --
Subject: [PATCH 1/2] grep: teach --untracked and --exclude options

In a working tree of a git managed repository, "grep --untracked" would
find the specified patterns from files in untracked files in addition to
its usual behaviour of finding them in the tracked files.

By default, when working with "--no-index" option, "grep" does not pay
attention to .gitignore mechanism. "grep --no-index --exclude" can be
used to tell the command to use .gitignore and stop reporting hits from
files that would be ignored. Also, when working without "--no-index",
"grep" honors .gitignore mechanism, and "grep --no-exclude" can be used
to tell the command to include hits from files that are ignored.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-grep.txt |   15 ++++++++++++++-
 builtin-grep.c             |   25 ++++++++++++++++++-------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index e019e76..2ccfb90 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -9,7 +9,7 @@ git-grep - Print lines matching a pattern
 SYNOPSIS
 --------
 [verse]
-'git grep' [--cached]
+'git grep' [--cached] [--untracked] [--excludes]
 	   [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
@@ -36,6 +36,19 @@ OPTIONS
 	Instead of searching in the working tree files, check
 	the blobs registered in the index file.
 
+--untracked::
+	In addition to searching in the tracked files in the working
+	tree, search also in untracked files.
+
+--no-excludes::
+	Also search in ignored files by not honoring the `.gitignore`
+	mechanism. Only useful with `--untracked`.
+
+--excludes::
+	Do not pay attention to ignored files specified via the	`.gitignore`
+	mechanism.  Only useful when searching files in the current directory
+	with `--no-index`.
+
 -a::
 --text::
 	Process binary files as if they were text.
diff --git a/builtin-grep.c b/builtin-grep.c
index a10946d..c6cfdf8 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -646,12 +646,14 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 	die("unable to grep from object of type %s", typename(obj->type));
 }
 
-static int grep_directory(struct grep_opt *opt, const char **paths)
+static int grep_directory(struct grep_opt *opt, const char **paths, int exc_std)
 {
 	struct dir_struct dir;
 	int i, hit = 0;
 
 	memset(&dir, 0, sizeof(dir));
+	if (exc_std)
+		setup_standard_excludes(&dir);
 
 	fill_directory(&dir, paths);
 	for (i = 0; i < dir.nr; i++) {
@@ -749,7 +751,7 @@ static int help_callback(const struct option *opt, const char *arg, int unset)
 int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
-	int cached = 0;
+	int cached = 0, untracked = 0, opt_exclude = -1;
 	int seen_dashdash = 0;
 	int external_grep_allowed__ignored;
 	struct grep_opt opt;
@@ -764,6 +766,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		{ OPTION_BOOLEAN, 0, "index", &use_index, NULL,
 			"finds in contents not managed by git",
 			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP },
+		OPT_BOOLEAN(0, "untracked", &untracked,
+			"search in both tracked and untracked files"),
+		OPT_SET_INT(0, "exclude", &opt_exclude,
+			    "search also in ignored files", 1),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('v', "invert-match", &opt.invert,
 			"show non-matching lines"),
@@ -950,18 +956,23 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		paths[1] = NULL;
 	}
 
-	if (!use_index) {
+	if (!use_index && (untracked || cached))
+		die("--cached or --untracked cannot be used with --no-index.");
+
+	if (!use_index || untracked) {
 		int hit;
-		if (cached)
-			die("--cached cannot be used with --no-index.");
+		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
 		if (list.nr)
-			die("--no-index cannot be used with revs.");
-		hit = grep_directory(&opt, paths);
+			die("--no-index or --untracked cannot be used with revs.");
+		hit = grep_directory(&opt, paths, use_exclude);
 		if (use_threads)
 			hit |= wait_all();
 		return !hit;
 	}
 
+	if (0 <= opt_exclude)
+		die("--exclude or --no-exclude cannot be used for tracked contents.");
+
 	if (!list.nr) {
 		int hit;
 		if (!cached)
-- 
1.7.7.rc3.4.g8d714
