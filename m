From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include diff options in the git-log manpage
Date: Tue, 04 Dec 2007 22:45:08 -0800
Message-ID: <7vve7d1vyj.fsf@gitster.siamese.dyndns.org>
References: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org>
	<1193929060-6183-2-git-send-email-vmiklos@frugalware.org>
	<20071204122859.GQ31750@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 07:45:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izo0n-0004sL-VQ
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 07:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXLEGpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 01:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXLEGpR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 01:45:17 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50722 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbXLEGpP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 01:45:15 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A68D02EF;
	Wed,  5 Dec 2007 01:45:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2576E9B136;
	Wed,  5 Dec 2007 01:45:31 -0500 (EST)
In-Reply-To: <20071204122859.GQ31750@genesis.frugalware.org> (Miklos Vajna's
	message of "Tue, 4 Dec 2007 13:28:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67108>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Thu, Nov 01, 2007 at 03:57:40PM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> Recently I wanted to see what git log -M does but actually I was not able to
>> find it in the manpage, finally figured out that all the diff options are
>> missing from here.
>> 
>> Removing -p as it's already in diff-options.txt.
>
> could you please have a look at this patch? this also fixes the "-C is
> missing from man git-log" issue which was reported on IRC today.

Have you proofread the whole output after your patch?

 * It makes it say "--raw ... this is the default", while for "git log"
   no diff output is the default.

 * Also it says "-p ... (see section on generating patches)"; there is
   no such section.

This can be a possible fixup on top of your patch.  It has potential to
affect other documentation pages that includes the files touched.  I
have formatted log, diff and format-patch before your patch and after
your patch plus this patch, and eyeballed the difference, but please
double check.

---

 Documentation/diff-format.txt         |  159 +--------------------------------
 Documentation/diff-generate-patch.txt |  161 +++++++++++++++++++++++++++++++++
 Documentation/diff-options.txt        |    2 +
 Documentation/git-log.txt             |    2 +
 4 files changed, 166 insertions(+), 158 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 9709c35..2c3a4c4 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -83,161 +83,4 @@ Note that 'combined diff' lists only files which were modified from
 all parents.
 
 
-Generating patches with -p
---------------------------
-
-When "git-diff-index", "git-diff-tree", or "git-diff-files" are run
-with a '-p' option, or "git diff" without the '--raw' option, they
-do not produce the output described above; instead they produce a
-patch file.  You can customize the creation of such patches via the
-GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS environment variables.
-
-What the -p option produces is slightly different from the traditional
-diff format.
-
-1.   It is preceded with a "git diff" header, that looks like
-     this:
-
-       diff --git a/file1 b/file2
-+
-The `a/` and `b/` filenames are the same unless rename/copy is
-involved.  Especially, even for a creation or a deletion,
-`/dev/null` is _not_ used in place of `a/` or `b/` filenames.
-+
-When rename/copy is involved, `file1` and `file2` show the
-name of the source file of the rename/copy and the name of
-the file that rename/copy produces, respectively.
-
-2.   It is followed by one or more extended header lines:
-
-       old mode <mode>
-       new mode <mode>
-       deleted file mode <mode>
-       new file mode <mode>
-       copy from <path>
-       copy to <path>
-       rename from <path>
-       rename to <path>
-       similarity index <number>
-       dissimilarity index <number>
-       index <hash>..<hash> <mode>
-
-3.  TAB, LF, double quote and backslash characters in pathnames
-    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
-    If there is need for such substitution then the whole
-    pathname is put in double quotes.
-
-The similarity index is the percentage of unchanged lines, and
-the dissimilarity index is the percentage of changed lines.  It
-is a rounded down integer, followed by a percent sign.  The
-similarity index value of 100% is thus reserved for two equal
-files, while 100% dissimilarity means that no line from the old
-file made it into the new one.
-
-
-combined diff format
---------------------
-
-"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
-'--cc' option to produce 'combined diff', which looks like this:
-
-------------
-diff --combined describe.c
-index fabadb8,cc95eb0..4866510
---- a/describe.c
-+++ b/describe.c
-@@@ -98,20 -98,12 +98,20 @@@
-	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
-  }
-
-- static void describe(char *arg)
- -static void describe(struct commit *cmit, int last_one)
-++static void describe(char *arg, int last_one)
-  {
- +	unsigned char sha1[20];
- +	struct commit *cmit;
-	struct commit_list *list;
-	static int initialized = 0;
-	struct commit_name *n;
-
- +	if (get_sha1(arg, sha1) < 0)
- +		usage(describe_usage);
- +	cmit = lookup_commit_reference(sha1);
- +	if (!cmit)
- +		usage(describe_usage);
- +
-	if (!initialized) {
-		initialized = 1;
-		for_each_ref(get_name);
-------------
-
-1.   It is preceded with a "git diff" header, that looks like
-     this (when '-c' option is used):
-
-       diff --combined file
-+
-or like this (when '--cc' option is used):
-
-       diff --c file
-
-2.   It is followed by one or more extended header lines
-     (this example shows a merge with two parents):
-
-       index <hash>,<hash>..<hash>
-       mode <mode>,<mode>..<mode>
-       new file mode <mode>
-       deleted file mode <mode>,<mode>
-+
-The `mode <mode>,<mode>..<mode>` line appears only if at least one of
-the <mode> is different from the rest. Extended headers with
-information about detected contents movement (renames and
-copying detection) are designed to work with diff of two
-<tree-ish> and are not used by combined diff format.
-
-3.   It is followed by two-line from-file/to-file header
-
-       --- a/file
-       +++ b/file
-+
-Similar to two-line header for traditional 'unified' diff
-format, `/dev/null` is used to signal created or deleted
-files.
-
-4.   Chunk header format is modified to prevent people from
-     accidentally feeding it to `patch -p1`. Combined diff format
-     was created for review of merge commit changes, and was not
-     meant for apply. The change is similar to the change in the
-     extended 'index' header:
-
-       @@@ <from-file-range> <from-file-range> <to-file-range> @@@
-+
-There are (number of parents + 1) `@` characters in the chunk
-header for combined diff format.
-
-Unlike the traditional 'unified' diff format, which shows two
-files A and B with a single column that has `-` (minus --
-appears in A but removed in B), `+` (plus -- missing in A but
-added to B), or `" "` (space -- unchanged) prefix, this format
-compares two or more files file1, file2,... with one file X, and
-shows how X differs from each of fileN.  One column for each of
-fileN is prepended to the output line to note how X's line is
-different from it.
-
-A `-` character in the column N means that the line appears in
-fileN but it does not appear in the result.  A `+` character
-in the column N means that the line appears in the last file,
-and fileN does not have that line (in other words, the line was
-added, from the point of view of that parent).
-
-In the above example output, the function signature was changed
-from both files (hence two `-` removals from both file1 and
-file2, plus `++` to mean one line that was added does not appear
-in either file1 nor file2).  Also two other lines are the same
-from file1 but do not appear in file2 (hence prefixed with ` +`).
-
-When shown by `git diff-tree -c`, it compares the parents of a
-merge commit with the merge result (i.e. file1..fileN are the
-parents).  When shown by `git diff-files -c`, it compares the
-two unresolved merge parents with the working tree file
-(i.e. file1 is stage 2 aka "our version", file2 is stage 3 aka
-"their version").
+include::diff-generate-patch.txt[]
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
new file mode 100644
index 0000000..029c5f2
--- /dev/null
+++ b/Documentation/diff-generate-patch.txt
@@ -0,0 +1,161 @@
+Generating patches with -p
+--------------------------
+
+When "git-diff-index", "git-diff-tree", or "git-diff-files" are run
+with a '-p' option, "git diff" without the '--raw' option, or
+"git log" with the "-p" option, they
+do not produce the output described above; instead they produce a
+patch file.  You can customize the creation of such patches via the
+GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS environment variables.
+
+What the -p option produces is slightly different from the traditional
+diff format.
+
+1.   It is preceded with a "git diff" header, that looks like
+     this:
+
+       diff --git a/file1 b/file2
++
+The `a/` and `b/` filenames are the same unless rename/copy is
+involved.  Especially, even for a creation or a deletion,
+`/dev/null` is _not_ used in place of `a/` or `b/` filenames.
++
+When rename/copy is involved, `file1` and `file2` show the
+name of the source file of the rename/copy and the name of
+the file that rename/copy produces, respectively.
+
+2.   It is followed by one or more extended header lines:
+
+       old mode <mode>
+       new mode <mode>
+       deleted file mode <mode>
+       new file mode <mode>
+       copy from <path>
+       copy to <path>
+       rename from <path>
+       rename to <path>
+       similarity index <number>
+       dissimilarity index <number>
+       index <hash>..<hash> <mode>
+
+3.  TAB, LF, double quote and backslash characters in pathnames
+    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
+    If there is need for such substitution then the whole
+    pathname is put in double quotes.
+
+The similarity index is the percentage of unchanged lines, and
+the dissimilarity index is the percentage of changed lines.  It
+is a rounded down integer, followed by a percent sign.  The
+similarity index value of 100% is thus reserved for two equal
+files, while 100% dissimilarity means that no line from the old
+file made it into the new one.
+
+
+combined diff format
+--------------------
+
+"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
+'--cc' option to produce 'combined diff'.  For showing a merge commit
+with "git log -p", this is the default format.
+A 'combined diff' format looks like this:
+
+------------
+diff --combined describe.c
+index fabadb8,cc95eb0..4866510
+--- a/describe.c
++++ b/describe.c
+@@@ -98,20 -98,12 +98,20 @@@
+	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
+  }
+
+- static void describe(char *arg)
+ -static void describe(struct commit *cmit, int last_one)
+++static void describe(char *arg, int last_one)
+  {
+ +	unsigned char sha1[20];
+ +	struct commit *cmit;
+	struct commit_list *list;
+	static int initialized = 0;
+	struct commit_name *n;
+
+ +	if (get_sha1(arg, sha1) < 0)
+ +		usage(describe_usage);
+ +	cmit = lookup_commit_reference(sha1);
+ +	if (!cmit)
+ +		usage(describe_usage);
+ +
+	if (!initialized) {
+		initialized = 1;
+		for_each_ref(get_name);
+------------
+
+1.   It is preceded with a "git diff" header, that looks like
+     this (when '-c' option is used):
+
+       diff --combined file
++
+or like this (when '--cc' option is used):
+
+       diff --c file
+
+2.   It is followed by one or more extended header lines
+     (this example shows a merge with two parents):
+
+       index <hash>,<hash>..<hash>
+       mode <mode>,<mode>..<mode>
+       new file mode <mode>
+       deleted file mode <mode>,<mode>
++
+The `mode <mode>,<mode>..<mode>` line appears only if at least one of
+the <mode> is different from the rest. Extended headers with
+information about detected contents movement (renames and
+copying detection) are designed to work with diff of two
+<tree-ish> and are not used by combined diff format.
+
+3.   It is followed by two-line from-file/to-file header
+
+       --- a/file
+       +++ b/file
++
+Similar to two-line header for traditional 'unified' diff
+format, `/dev/null` is used to signal created or deleted
+files.
+
+4.   Chunk header format is modified to prevent people from
+     accidentally feeding it to `patch -p1`. Combined diff format
+     was created for review of merge commit changes, and was not
+     meant for apply. The change is similar to the change in the
+     extended 'index' header:
+
+       @@@ <from-file-range> <from-file-range> <to-file-range> @@@
++
+There are (number of parents + 1) `@` characters in the chunk
+header for combined diff format.
+
+Unlike the traditional 'unified' diff format, which shows two
+files A and B with a single column that has `-` (minus --
+appears in A but removed in B), `+` (plus -- missing in A but
+added to B), or `" "` (space -- unchanged) prefix, this format
+compares two or more files file1, file2,... with one file X, and
+shows how X differs from each of fileN.  One column for each of
+fileN is prepended to the output line to note how X's line is
+different from it.
+
+A `-` character in the column N means that the line appears in
+fileN but it does not appear in the result.  A `+` character
+in the column N means that the line appears in the last file,
+and fileN does not have that line (in other words, the line was
+added, from the point of view of that parent).
+
+In the above example output, the function signature was changed
+from both files (hence two `-` removals from both file1 and
+file2, plus `++` to mean one line that was added does not appear
+in either file1 nor file2).  Also two other lines are the same
+from file1 but do not appear in file2 (hence prefixed with ` +`).
+
+When shown by `git diff-tree -c`, it compares the parents of a
+merge commit with the merge result (i.e. file1..fileN are the
+parents).  When shown by `git diff-files -c`, it compares the
+two unresolved merge parents with the working tree file
+(i.e. file1 is stage 2 aka "our version", file2 is stage 3 aka
+"their version").
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e4af393..d0154bb 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -6,7 +6,9 @@
 
 ifndef::git-format-patch[]
 ifndef::git-diff[]
+ifndef::git-log[]
 :git-diff-core: 1
+endif::git-log[]
 endif::git-diff[]
 endif::git-format-patch[]
 
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 4b1b982..5920d17 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -27,6 +27,7 @@ OPTIONS
 
 include::pretty-options.txt[]
 
+:git-log: 1
 include::diff-options.txt[]
 
 -<n>::
@@ -77,6 +78,7 @@ include::diff-options.txt[]
 
 include::pretty-formats.txt[]
 
+include::diff-generate-patch.txt[]
 
 Examples
 --------
