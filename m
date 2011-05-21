From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/7] t4018 (funcname patterns): minor cleanups
Date: Sat, 21 May 2011 14:25:14 -0500
Message-ID: <20110521192514.GD10530@elie>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
 <20110521185314.GA10530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 21:25:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrng-00071O-VN
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 21:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab1EUTZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 15:25:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56639 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1EUTZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 15:25:19 -0400
Received: by iwn34 with SMTP id 34so3766674iwn.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UeA/+pS05PWXcYdVQuLIsWhqnqxENMf29M4Mx0UrkzQ=;
        b=ooox+a0/Jr30U9rD2MZWq9d1QVz62QfPuH5EuD/pTTJLAvnhejSJD33vLlbGdTdvrn
         YJIviTFE5xzs/SGlA5qpj2pIErjMSk6OOLxj7x8MnWwxwssDkuYSAEc3TmHA2YtJEzKV
         Xy3YdmmCRyvdDOIfBZQOG2TqVrfms4mVH1TAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=S1Ves0Pszb2GGDOVyMrS8mIZDlPDR5MU/tt0eaVADpfDcnUkcansHDXFbwViE2NWZq
         Jz83KdJ0b9alc6dLNTdJ53hBzWkH+LP+tDDQjTmhT5bzM0ltPLeR8+nPcPf6X97GJVrs
         FtnOT0mn5DZ3UUYjl7z0OrmmvCAHehySbr+m0=
Received: by 10.42.140.7 with SMTP id i7mr1272993icu.239.1306005918383;
        Sat, 21 May 2011 12:25:18 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.sbcglobal.net [69.209.78.180])
        by mx.google.com with ESMTPS id c16sm2072886ibe.24.2011.05.21.12.25.16
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 12:25:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110521185314.GA10530@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174170>

Introduce a test_expect_funcname function to make a diff and apply a
regexp anchored on the left to the function name it writes, avoiding
some repetition.

Omit the space after >, <<, and < operators for consistency with
other scripts.  Quote the <<here document delimiter and $ signs in
quotes so readers don't have to worry about the effect of shell
metacharacters.

Remove some unnecessary blank lines.

Run "git diff" as a separate command instead of as upstream of a pipe
that checks its output, so the exit status can be tested.  In
particular, this way if "git diff" starts segfaulting the test harness
will notice.

Allow "error:" as a synonym for "fatal:" when checking error messages,
since whether a command uses die() or "return error()" is a small
implementation detail.

Anchor some more regexes on the right.

None of the above is very important on its own; the point is just to
make the script a little easier to read and the code less scary to
modify.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4018-diff-funcname.sh |   49 +++++++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index ce0a0e3..ad74c60 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -9,8 +9,7 @@ test_description='Test custom diff function name patterns'
 
 LF='
 '
-
-cat > Beer.java << EOF
+cat >Beer.java <<\EOF
 public class Beer
 {
 	int special;
@@ -29,34 +28,40 @@ public class Beer
 	}
 }
 EOF
-
-sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
+sed 's/beer\\/beer,\\/' <Beer.java >Beer-correct.java
 
 test_config () {
 	git config "$1" "$2" &&
 	test_when_finished "git config --unset $1"
 }
 
-builtin_patterns="bibtex cpp csharp fortran html java objc pascal perl php python ruby tex"
-for p in $builtin_patterns
+test_expect_funcname () {
+	test_expect_code 1 git diff --no-index \
+		Beer.java Beer-correct.java >diff &&
+	grep "^@@.*@@ $1" diff
+}
+
+for p in bibtex cpp csharp fortran html java objc pascal perl php python ruby tex
 do
 	test_expect_success "builtin $p pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
-		! { git diff --no-index Beer.java Beer-correct.java 2>&1 |
-			grep "fatal" > /dev/null; }
+		test_expect_code 1 git diff --no-index \
+			Beer.java Beer-correct.java 2>msg &&
+		! grep fatal msg &&
+		! grep error msg
 	'
 	test_expect_success "builtin $p wordRegex pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
-		! { git diff --no-index --word-diff \
-			Beer.java Beer-correct.java 2>&1 |
-			grep "fatal" > /dev/null; }
+		test_expect_code 1 git diff --no-index --word-diff \
+			Beer.java Beer-correct.java 2>msg &&
+		! grep fatal msg &&
+		! grep error msg
 	'
 done
 
 test_expect_success 'default behaviour' '
 	rm -f .gitattributes &&
-	git diff --no-index Beer.java Beer-correct.java |
-	grep "^@@.*@@ public class Beer"
+	test_expect_funcname "public class Beer\$"
 '
 
 test_expect_success 'set up .gitattributes declaring drivers to test' '
@@ -64,35 +69,31 @@ test_expect_success 'set up .gitattributes declaring drivers to test' '
 '
 
 test_expect_success 'preset java pattern' '
-	git diff --no-index Beer.java Beer-correct.java |
-	grep "^@@.*@@ public static void main("
+	test_expect_funcname "public static void main("
 '
 
 test_expect_success 'custom pattern' '
 	test_config diff.java.funcname "!static
 !String
 [^ 	].*s.*" &&
-	git diff --no-index Beer.java Beer-correct.java |
-	grep "^@@.*@@ int special;$"
+	test_expect_funcname "int special;\$"
 '
 
 test_expect_success 'last regexp must not be negated' '
 	test_config diff.java.funcname "!static" &&
-	git diff --no-index Beer.java Beer-correct.java 2>&1 |
-	grep "fatal: Last expression must not be negated:"
+	test_expect_code 128 git diff --no-index Beer.java Beer-correct.java 2>msg &&
+	grep ": Last expression must not be negated:" msg
 '
 
 test_expect_success 'pattern which matches to end of line' '
-	test_config diff.java.funcname "Beer$" &&
-	git diff --no-index Beer.java Beer-correct.java |
-	grep "^@@.*@@ Beer"
+	test_config diff.java.funcname "Beer\$" &&
+	test_expect_funcname "Beer\$"
 '
 
 test_expect_success 'alternation in pattern' '
 	test_config diff.java.funcname "Beer$" &&
 	test_config diff.java.xfuncname "^[ 	]*((public|static).*)$" &&
-	git diff --no-index Beer.java Beer-correct.java |
-	grep "^@@.*@@ public static void main("
+	test_expect_funcname "public static void main("
 '
 
 test_done
-- 
1.7.5.1
