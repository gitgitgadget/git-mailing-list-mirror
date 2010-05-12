From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [RFC/PATCH v3 5/5] Rename "core.autocrlf" config variable as "core.eolconv"
Date: Thu, 13 May 2010 01:00:55 +0200
Message-ID: <d739aefee3d015b739b41e1db549c19472c3dd5a.1273700831.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 01:01:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCKvb-0004Tr-Bg
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 01:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab0ELXBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 19:01:09 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:60012 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757942Ab0ELXBH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 19:01:07 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so355525ewy.28
        for <git@vger.kernel.org>; Wed, 12 May 2010 16:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0AyRVnrM8cjdUyD4kLB0JasDqp3dLWP2Nwd1ZUMwzDg=;
        b=qfjHTff5svxtlzTCv8e5LO297+ctPwpwW2UEZI7n+odGUOvLa8IRrN0uE7q8FLEOuy
         3sxTe6a9Qe866Nj0qGfZLRmQvTkIxpT/ao9jvo7JRTdvV58XIK+ny34vbL/uq+N0bi76
         Nw0rrCdxMLieEnlbwSBZOOPclDQdS0eOcM3mU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rFr7aUgPbGTTTrtpZafO9zII3UxU4JUNT7OdHXvgaw99eZCE201okrkFEEGUObvQOd
         9wu5tcR+II4Ls7SPPiMI2bwZ9pltNIaSb1pZ9B5WEmMlHhNMZjFmgQ3aR3AKN61DUk+v
         BL7HD+n7D2zlKD3/COMt76mcgX74F9ukWau1s=
Received: by 10.213.0.212 with SMTP id 20mr3667866ebc.43.1273705266262;
        Wed, 12 May 2010 16:01:06 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm365675ewy.4.2010.05.12.16.01.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 16:01:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
In-Reply-To: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146965>

As asserted by myself and not vigourously contested on the list,
"autocrlf" is a pretty bad name.  Rename the variable "core.eolconv",
but also accept "core.autocrlf" for backwards compatibility.

Also add aliases "crlf" for "true" and "lf" for "input".

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/config.txt        |   22 ++++++++-------
 Documentation/gitattributes.txt |   16 ++++++------
 config.c                        |   11 ++++++--
 t/t0020-crlf.sh                 |   54 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4d3c472..6814e23 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -196,16 +196,18 @@ core.quotepath::
 	quoted without `-z` regardless of the setting of this
 	variable.
 
-core.autocrlf::
-	If true, makes git convert `CRLF` at the end of lines in text files to
+core.eolconv::
+	If true or 'crlf', makes git convert `CRLF` at the end of lines in text files to
 	`LF` when reading from the work tree, and convert in reverse when
 	writing to the work tree.  The variable can be set to
-	'input', in which case the conversion happens only while
+	'input' or 'lf', in which case the conversion happens only while
 	reading from the work tree but files are written out to the work
 	tree with `LF` at the end of lines.  A file is considered
-	"text" (i.e. be subjected to the autocrlf mechanism) based on
+	"text" (i.e. subject to the eolconv mechanism) based on
 	the file's `crlf` attribute, or if `crlf` is unspecified,
 	based on the file's contents.  See linkgit:gitattributes[5].
+	For backwards compatibility, `core.autocrlf` is an alias of
+	this variable.
 
 core.safecrlf::
 	If true, makes git check if converting `CRLF` is reversible when
@@ -214,12 +216,12 @@ core.safecrlf::
 	For example, committing a file followed by checking out the
 	same file should yield the original file in the work tree.  If
 	this is not the case for the current setting of
-	`core.autocrlf`, git will reject the file.  The variable can
+	`core.eolconv`, git will reject the file.  The variable can
 	be set to "warn", in which case git will only warn about an
 	irreversible conversion but continue the operation.
 +
 CRLF conversion bears a slight chance of corrupting data.
-autocrlf=true will convert CRLF to LF during commit and LF to
+eolconv=true will convert CRLF to LF during commit and LF to
 CRLF during checkout.  A file that contains a mixture of LF and
 CRLF before the commit cannot be recreated by git.  For text
 files this is the right thing to do: it corrects line endings
@@ -243,9 +245,9 @@ converting CRLFs corrupts data.
 +
 Note, this safety check does not mean that a checkout will generate a
 file identical to the original file for a different setting of
-`core.autocrlf`, but only for the current one.  For example, a text
-file with `LF` would be accepted with `core.autocrlf=input` and could
-later be checked out with `core.autocrlf=true`, in which case the
+`core.eolconv`, but only for the current one.  For example, a text
+file with `LF` would be accepted with `core.eolconv=input` and could
+later be checked out with `core.eolconv=true`, in which case the
 resulting file would contain `CRLF`, although the original file
 contained `LF`.  However, in both work trees the line endings would be
 consistent, that is either all `LF` or all `CRLF`, but never mixed.  A
@@ -991,7 +993,7 @@ gitcvs.allbinary::
 	as binary files, which suppresses any newline munging it
 	otherwise might do. Alternatively, if it is set to "guess",
 	then the contents of the file are examined to decide if
-	it is binary, similar to 'core.autocrlf'.
+	it is binary, similar to 'core.eolconv'.
 
 gitcvs.dbname::
 	Database used by git-cvsserver to cache revision information
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2887f85..7d02146 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -99,7 +99,7 @@ This attribute enables and controls end-of-line normalization.  When a
 text file is normalized, its line endings are converted to LF in the
 repository.  Text files can have their line endings converted to
 CRLF in the working directory, using the `eolconv` attribute for
-individual files or the `core.autocrlf` configuration variable for all
+individual files or the `core.eolconv` configuration variable for all
 files.
 
 For compatibility with older versions of git, `crlf` is an alias for
@@ -126,19 +126,19 @@ Set to string value "crlf"::
 
 	This is similar to setting the attribute to `true`, but forces
 	git to convert line endings to CRLF when the file is checked
-	out, regardless of `core.autocrlf`.
+	out, regardless of `core.eolconv`.
 
 Set to string value "lf"::
 
 	This is similar to setting the attribute to `true`, but
 	prevents git from converting line endings to CRLF when the
-	file is checked out, regardless of `core.autocrlf`.  "input"
+	file is checked out, regardless of `core.eolconv`.  "input"
 	is an alias for "lf".
 
 Unspecified::
 
 	Leaving the `eolconv` attribute unspecified tells git to apply
-	end-of-line normalization only if the `core.autocrlf`
+	end-of-line normalization only if the `core.eolconv`
 	configuration variable is set, the content appears to be text,
 	and the file is either new or already normalized in the
 	repository.
@@ -172,18 +172,18 @@ normalization in git.
 
 If you simply want to have CRLF line endings in your working directory
 regardless of the repository you are working in, you can set the
-config variable "core.autocrlf" without changing any attributes.
+config variable "core.eolconv" without changing any attributes.
 
 ------------------------
 [core]
-	autocrlf = true
+	eolconv = true
 ------------------------
 
 This does not force normalization of all text files, but does ensure
 that text files that you introduce to the repository have their line
 endings normalized to LF when they are added, and that files that are
 already normalized in the repository stay normalized.  You can also
-set `autocrlf` to "input" to have automatic normalization of new text
+set `eolconv` to "input" to have automatic normalization of new text
 files without conversion to CRLF in the working directory.
 
 If you want to interoperate with a source code management system that
@@ -231,7 +231,7 @@ weirdchars.txt	eolconv
 
 If `core.safecrlf` is set to "true" or "warn", git verifies if
 the conversion is reversible for the current setting of
-`core.autocrlf`.  For "true", git rejects irreversible
+`core.eolconv`.  For "true", git rejects irreversible
 conversions; for "warn", git only prints a warning but accepts
 an irreversible conversion.  The safety triggers to prevent such
 a conversion done to the files in the work tree, but there are a
diff --git a/config.c b/config.c
index b60a1ff..a5f445e 100644
--- a/config.c
+++ b/config.c
@@ -459,12 +459,17 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.autocrlf")) {
-		if (value && !strcasecmp(value, "input")) {
+	if (!strcmp(var, "core.eolconv") || !strcmp(var, "core.autocrlf")) {
+		if (value && (!strcasecmp(value, "input") ||
+			      !strcasecmp(value, "lf"))) {
 			auto_crlf = AUTO_CRLF_INPUT;
 			return 0;
 		}
-		auto_crlf = git_config_bool(var, value);
+		if (value && !strcasecmp(value, "crlf") ||
+		    git_config_bool(var, value))
+			auto_crlf = AUTO_CRLF_TRUE;
+		else
+			auto_crlf = AUTO_CRLF_FALSE;
 		return 0;
 	}
 
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 234a94f..52c2b71 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -135,9 +135,35 @@ test_expect_success 'update with autocrlf=true' '
 
 '
 
+test_expect_success 'checkout with eolconv=crlf' '
+
+	rm -f tmp one dir/two three &&
+	git config --unset-all core.autocrlf &&
+	git config core.eolconv crlf &&
+	git read-tree --reset -u HEAD &&
+
+	for f in one dir/two
+	do
+		remove_cr <"$f" >tmp && mv -f tmp $f &&
+		git update-index -- $f || {
+			echo "Eh? $f"
+			false
+			break
+		}
+	done &&
+	test "$one" = `git hash-object --stdin <one` &&
+	test "$two" = `git hash-object --stdin <dir/two` &&
+	differs=`git diff-index --cached HEAD` &&
+	test -z "$differs" || {
+		echo Oops "$differs"
+		false
+	}
+'
+
 test_expect_success 'checkout with autocrlf=true' '
 
 	rm -f tmp one dir/two three &&
+	git config --unset-all core.eolconv &&
 	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
@@ -159,9 +185,37 @@ test_expect_success 'checkout with autocrlf=true' '
 	}
 '
 
+test_expect_success 'checkout with eolconv=lf' '
+
+	rm -f tmp one dir/two three &&
+	git config --unset-all core.autocrlf &&
+	git config core.eolconv lf &&
+	git read-tree --reset -u HEAD &&
+
+	for f in one dir/two
+	do
+		if has_cr "$f"
+		then
+			echo "Eh? $f"
+			false
+			break
+		else
+			git update-index -- $f
+		fi
+	done &&
+	test "$one" = `git hash-object --stdin <one` &&
+	test "$two" = `git hash-object --stdin <dir/two` &&
+	differs=`git diff-index --cached HEAD` &&
+	test -z "$differs" || {
+		echo Oops "$differs"
+		false
+	}
+'
+
 test_expect_success 'checkout with autocrlf=input' '
 
 	rm -f tmp one dir/two three &&
+	git config --unset-all core.eolconv &&
 	git config core.autocrlf input &&
 	git read-tree --reset -u HEAD &&
 
-- 
1.7.1.3.g448cb.dirty
