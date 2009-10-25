From: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: [PATCH 1/3] format-patch: Make implementation and documentation agree
Date: Sun, 25 Oct 2009 16:55:27 +0100
Message-ID: <4AE474EF.1050609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:56:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N25Ro-0005Rb-1W
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbZJYPzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZJYPzq
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:55:46 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:35140 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbZJYPzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:55:41 -0400
Received: by ewy4 with SMTP id 4so2959953ewy.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=eDk8dRtTYkT1NH3NPn1Iif0hXbrdfRQGT2J0Qj+pmw0=;
        b=sK8obLzjA5EpLSfEStUT2YNLkaQlPVJwvTv05ztRjouPhBmLWNUODCQrHtSMU7S7NQ
         rjxo4Uu1+34o43JGg23AxlJNZfvPwxRNcIqMIJ68rMI6maBaisNi/HOBruxaa8T76t4x
         z7pX2mcWcdrpPSpvqtJEoRJux/wgvxjL8KscE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=bWMHK1RtpuUXZbP+1JorYQ70vryVeyfSIVCqV1DmLdODoxwVujursB7E5zKX8I7a4b
         UaX5kxUY5+3J/Pccw98CUpXt5fo0qFOvO21ojJU8qi+tkCkgsy471eweibUakcZkkaZ+
         qWBu8SrpWZVPbfhCDOnb1dvvwXCZDE5Q7C2bg=
Received: by 10.216.93.70 with SMTP id k48mr890208wef.134.1256486144808;
        Sun, 25 Oct 2009 08:55:44 -0700 (PDT)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm10104eyf.7.2009.10.25.08.55.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:55:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131216>

The documentation for the -p option for format-patch says:
"Generate patches without diffstat."

Starting with commit 68daa64d, however, -p no longer suppresses the
diffstat and is a no-op *most* of the time. It is still needed when
--stat (or one of the other 'stat' options) is given in order to
produce a patch at all.

Since no-one seems to have noticed (or cared) that -p no longer
suppresses the diffstat (after more than a year), it makes most
sense to fix the documentation (rather than the implementation).
The trouble is that -p is still sometimes needed, so to simplify
the documentation, it would be best to change the implementation
as well.

Therefore:

* Update 'git format-patch' to always generate a patch.

* Since the --name-only, --name-status, and --check suppresses
  the generation of the patch, disallow those options. They don't
  make sense for format-patch anyway.

* Remove the description of -p from the documentation.

* Remove the reference to -p in the description of -U.

* Remove the descriptions of the options that are synonyms for -p
  plus another option (--patch-with-raw and --patch-with-stat).

* Remove the description of the options that are no longer
  allowed (--name-only, --name-status, and --check).
---
 Documentation/diff-options.txt |   19 ++++++++++++-------
 builtin-log.c                  |   12 +++++++++++-
 t/t4014-format-patch.sh        |   18 ++++++++++++++++++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9276fae..673fbb0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -12,11 +12,6 @@ endif::git-log[]
 endif::git-diff[]
 endif::git-format-patch[]
 
-ifdef::git-format-patch[]
--p::
-	Generate patches without diffstat.
-endif::git-format-patch[]
-
 ifndef::git-format-patch[]
 -p::
 -u::
@@ -27,14 +22,19 @@ endif::git-format-patch[]
 -U<n>::
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
-	the usual three. Implies "-p".
+	the usual three.
+ifndef::git-format-patch[]
+	Implies "-p".
+endif::git-format-patch[]
 
 --raw::
 	Generate the raw format.
 	{git-diff-core? This is the default.}
 
+ifndef::git-format-patch[]
 --patch-with-raw::
 	Synonym for "-p --raw".
+endif::git-format-patch[]
 
 --patience::
 	Generate a diff using the "patience diff" algorithm.
@@ -71,21 +71,24 @@ endif::git-format-patch[]
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
 
+ifndef::git-format-patch[]
 --patch-with-stat::
 	Synonym for "-p --stat".
-	{git-format-patch? This is the default.}
+endif::git-format-patch[]
 
 -z::
 	NUL-line termination on output.  This affects the --raw
 	output field terminator.  Also output from commands such
 	as "git-log" will be delimited with NUL between commits.
 
+ifndef::git-format-patch[]
 --name-only::
 	Show only names of changed files.
 
 --name-status::
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.
+endif::git-format-patch[]
 
 --color::
 	Show colored diff.
@@ -115,11 +118,13 @@ override configuration settings.
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
+ifndef::git-format-patch[]
 --check::
 	Warn if changes introduce trailing whitespace
 	or an indent that uses a space before a tab. Exits with
 	non-zero status if problems are found. Not compatible with
 	--exit-code.
+endif::git-format-patch[]
 
 --full-index::
 	Instead of the first handful of characters, show the full
diff --git a/builtin-log.c b/builtin-log.c
index 25e21ed..7b2cde2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1027,9 +1027,19 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
+	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
+		die("--name-only does not make sense");
+	if (rev.diffopt.output_format & DIFF_FORMAT_NAME_STATUS)
+		die("--name-status does not make sense");
+	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
+		die("--check does not make sense");
+
 	if (!rev.diffopt.output_format
 		|| rev.diffopt.output_format == DIFF_FORMAT_PATCH)
-		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH;
+		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY;
+
+	/* Always generate a patch */
+	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 531f5b7..f826348 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -515,4 +515,22 @@ test_expect_success 'format-patch --signoff' '
 	grep "^Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 '
 
+echo "fatal: --name-only does not make sense" > expect.name-only
+echo "fatal: --name-status does not make sense" > expect.name-status
+echo "fatal: --check does not make sense" > expect.check
+
+test_expect_success 'options no longer allowed for format-patch' '
+	test_must_fail git format-patch --name-only 2> output &&
+	test_cmp expect.name-only output &&
+	test_must_fail git format-patch --name-status 2> output &&
+	test_cmp expect.name-status output &&
+	test_must_fail git format-patch --check 2> output &&
+	test_cmp expect.check output'
+
+test_expect_success 'format-patch --numstat should produce a patch' '
+	git format-patch --numstat --stdout master..side |
+	grep "^diff --git a/" |
+	wc -l |
+	xargs test 6 = '
+
 test_done
-- 
1.6.5.1.69.g36942
