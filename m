Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DE181
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621158; cv=none; b=Gdo8/jsrKdlRJKnuE9RJqxjaj7SgXfHuVMlUsH6/qevvS72azfZoFdYvJSPEjd62V0wSr3GyT3j/Hhe0PeJL49VEJHqrE+/VF2falslqyMXVO+8/1fInvexyQTdhWFo4g1/v2yQqEBQut+dggmhBfY2v/QN+8diKlD/NEawr3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621158; c=relaxed/simple;
	bh=/V8hPFFA9gRLWy6Wl1ziT//cc8mY/KQC+O9yr/Dn9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOq80xVw3NUJ9zng5bkweELE+urgquVB9ofhqoJ33HiaDa1nCJKZbAjcJNEugLOeFn3WsJX7ac+/hQBmizCHXgF+PItz5gnPELT/4Z4T1saPkNA9zFxWabK+BzV+f/BZS7Yydan3PMUq4+tDOQgbs4xoDgtAZZAWRq4KEwt1t1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDnimvvM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDnimvvM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712621156; x=1744157156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/V8hPFFA9gRLWy6Wl1ziT//cc8mY/KQC+O9yr/Dn9Qg=;
  b=VDnimvvMcg5ZdydZptNEnRknI6krEAfLr9ibPnMFQI4WHYbgaPc6vzmM
   ZXRM7BD1TVBwxHd24IFclMsk0zFH8rTzv+VPZ83LrFmhTDARAh8VbICGy
   tfAimyxQr4g0ILciHXCYyd2VJTAdXJJUtvPldyxJYN28J90DdKBS6qmQy
   z3mvoxGC2K59FTWtu4QClE8emLkYnpSaxNug2teCiHTPS3upahi7DZMpK
   SDTZc0uPUAB+WEIBL+0wOZrZtzrJ9f7hs5ND5c8+Z8LExa/SeXgQOfB5k
   Suz93vUyQePGTbjJQ/DOoH6uwPsBeBDJrFo213FeIKEoma0pkMCmcq8VL
   Q==;
X-CSE-ConnectionGUID: ANrs9C28QA+JXhWM6LYgWA==
X-CSE-MsgGUID: AQKtdrXdRXuotlfycM9MnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7766798"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7766798"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 17:05:55 -0700
X-CSE-ConnectionGUID: TeLN4FM8SDmaknYkE5wWog==
X-CSE-MsgGUID: 5xed+lRVTHOVd1EIX6zDhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24677723"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 17:05:55 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] mailsplit add option to include sanitized subject in filename
Date: Mon,  8 Apr 2024 17:05:46 -0700
Message-ID: <20240409000546.3628898-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.44.0.53.g0f9d4d28b7e6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

git-am makes use of git-mailsplit to split an mbox into individual files
before attempting to apply the patches. In most cases this works fine,
but it can fail to apply patches in cases where the mbox file is not
properly sorted. This can sometimes happen due to clock skew, or other
issues with the software which saved the mbox.

For example, if you download a t.mbox.gz from a public inbox server such
as lore.kernel.org it may sort the messages in the thread by arrival
time to the list. Due to clock skew or other issues this may not be the
correct order of the patches to apply.

A savvy user may then attempt to directly use git mailsplit to split the
mailbox, only to find that the files are unhelpfully named "0001",
"0002", etc. It requires further digging to figure out which message is
which patch.

Git has a format_sanitized_subject() function which is used by code to
generate a suitable filename from a subject. Add a new --name-by-subject
option to git mailsplit. If enabled, scan for lines beginning with the
"Subject:" header when splitting mail. If found, extract the subject and
pass it to format_sanitized_subject(). Use this to create a new filename
which appends the sanitized subject to the standard sequence number. A
savvy user can invoke git mailsplit with --name-by-subject to help
analyze why the mailbox was not split the intended way.

I originally wanted to avoid the need for an option, but git-am
currently depends on the strict sequence number filenames. It is unclear
how difficult it would be to refactor git-am to work with names that
include the extra subject data.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-mailsplit.txt |  5 +++++
 builtin/mailsplit.c             | 25 ++++++++++++++++++++++++-
 t/t5100-mailinfo.sh             | 25 +++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 3f0a6662c81e..2e5ba45e1988 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] [--mboxrd]
+		[--name-by-subject]
 		-o<directory> [--] [(<mbox>|<Maildir>)...]
 
 DESCRIPTION
@@ -52,6 +53,10 @@ OPTIONS
 	Input is of the "mboxrd" format and "^>+From " line escaping is
 	reversed.
 
+--name-by-subject::
+	Include the sanitized subject in the generated filenames, in
+	addition to the sequence number.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 3af9ddb8ae5c..df81782d05b3 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -8,9 +8,10 @@
 #include "gettext.h"
 #include "string-list.h"
 #include "strbuf.h"
+#include "pretty.h"
 
 static const char git_mailsplit_usage[] =
-"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
+"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] [--name-by-subject] -o<directory> [(<mbox>|<Maildir>)...]";
 
 static int is_from_line(const char *line, int len)
 {
@@ -46,6 +47,7 @@ static int is_from_line(const char *line, int len)
 static struct strbuf buf = STRBUF_INIT;
 static int keep_cr;
 static int mboxrd;
+static int name_by_subject;
 
 static int is_gtfrom(const struct strbuf *buf)
 {
@@ -66,6 +68,9 @@ static int is_gtfrom(const struct strbuf *buf)
  */
 static int split_one(FILE *mbox, const char *name, int allow_bare)
 {
+	struct strbuf sanitized_filename = STRBUF_INIT;
+	const char *subject_start;
+	size_t subject_len;
 	FILE *output;
 	int fd;
 	int status = 0;
@@ -101,10 +106,26 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 			}
 			die_errno("cannot read mbox");
 		}
+
+		/* Get a sanitized filename from the subject */
+		if (name_by_subject && !sanitized_filename.len &&
+		    skip_prefix_mem(buf.buf, buf.len, "Subject:",
+				    &subject_start, &subject_len)) {
+			strbuf_addf(&sanitized_filename, "%s-", name);
+			format_sanitized_subject(&sanitized_filename,
+						 subject_start,
+						 subject_len);
+		}
+
 		if (!is_bare && is_from_line(buf.buf, buf.len))
 			break; /* done with one message */
 	}
 	fclose(output);
+
+	if (name_by_subject && sanitized_filename.len)
+		rename(name, sanitized_filename.buf);
+	strbuf_release(&sanitized_filename);
+
 	return status;
 }
 
@@ -296,6 +317,8 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			usage(git_mailsplit_usage);
 		} else if ( arg[1] == 'b' && !arg[2] ) {
 			allow_bare = 1;
+		} else if (!strcmp(arg, "--name-by-subject")) {
+			name_by_subject = 1;
 		} else if (!strcmp(arg, "--keep-cr")) {
 			keep_cr = 1;
 		} else if ( arg[1] == 'o' && arg[2] ) {
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index c8d06554541c..4826735c6033 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -44,6 +44,31 @@ do
 	'
 done
 
+test_expect_success 'split sample box with --name-by-subject' '
+	mkdir name-by-subject &&
+	git mailsplit --name-by-subject -oname-by-subject "$DATA/sample.mbox" >last &&
+	last=$(cat last) &&
+	echo total is $last &&
+	test $(cat last) = 18
+'
+
+check_mailinfo_name_by_subject () {
+	mail=$1
+	mo="$(basename "$mail" | cut -c1-4)"
+	echo "$(basename "$mail")" >"sanitized$mo" &&
+	git mailinfo -u "msg$mo" "patch$mo" <"$mail" >"info$mo" &&
+	test_cmp "$DATA/msg$mo" "msg$mo" &&
+	test_cmp "$DATA/patch$mo" "patch$mo" &&
+	test_cmp "$DATA/info$mo" "info$mo" &&
+	test_cmp "$DATA/sanitized$mo" "sanitized$mo"
+}
+
+for mail in name-by-subject/00*
+do
+	test_expect_success "check --name-by-subject $mail" '
+		check_mailinfo_name_by_subject "$mail"
+	'
+done
 
 test_expect_success 'split box with rfc2047 samples' \
 	'mkdir rfc2047 &&
-- 
2.44.0.53.g0f9d4d28b7e6

