From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <luksan@gmail.com>
Subject: [PATCH] git am/mailinfo: Don't look at in-body headers when rebasing
Date: Wed, 18 Nov 2009 23:45:01 +0100
Message-ID: <4B0478ED.30306@gmail.com>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com> <20091118155154.GA15184@coredump.intra.peff.net> <20091118164208.GB15184@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <luksan@gmail.com>,
	Philip Hofstetter <phofstetter@sensational.ch>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 23:49:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAtKZ-0002Nk-7U
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 23:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392AbZKRWpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756328AbZKRWpD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 17:45:03 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:23581 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245AbZKRWo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 17:44:59 -0500
Received: by ey-out-2122.google.com with SMTP id 25so321403eya.19
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 14:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=YRo1dCD0NSbexoSwDaiyMt8Bfi/0q5DCeA8VYib6GeY=;
        b=rCaFlBv+PAyhOyyRKGgrQgNaM8b2aq4a49mQpfVTpr7YmXldQdUR/M3sGIA5QSqUtl
         NQzFUyece8Ou+OBDJxA4lOTND2tAsyQIDfc7EWXjfdNLae6oJeXoyksstaKRn1s6LfY3
         MT5AdrR/Ze3m1+p3plgf2y57YpWNRDwzQRucc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=NZyNEedpipjtwbkZdclVp+0T9k2LsJ0AW5UsZ0S/86CH2GOCetzxePYdmtpNEXUocF
         aRP9NaQNstUtxIWfDU1dY3Ok0GkDT6RU2n+0E2QxPSyf6LP+a1gA3Tbm7c0TBelGDMTl
         Yxo0xFMkaV7k98Vcv3MvaVRq/Zn15N53YRpv8=
Received: by 10.213.104.5 with SMTP id m5mr2813148ebo.40.1258584304134;
        Wed, 18 Nov 2009 14:45:04 -0800 (PST)
Received: from ?192.168.0.85? (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
        by mx.google.com with ESMTPS id 14sm132169ewy.7.2009.11.18.14.45.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Nov 2009 14:45:02 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091019)
In-Reply-To: <20091118164208.GB15184@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133205>

When we are rebasing we know that the header lines in the
patch are good and that we don't need to pick up any headers
from the body of the patch.

This makes it possible to rebase commits whose commit message
start with "From" or "Date".

Test vectors by Jeff King.

Signed-off-by: Lukas Sandstr=C3=B6m <luksan@gmail.com>
---

Jeff King wrote:
>> Some solutions I can think of are:
>>
>>   1. Improve the header-finding heuristic to actually look for somet=
hing
>>      more sane, like "From:.*<.*@.*>" (I don't recall off the top of=
 my
>>      head which other headers we handle in this position. Probably
>>      Date, too).
>>
>>   2. Give mailinfo a "--strict" mode to indicate that it is directly
>>      parsing the output of format-patch, and not some random email. =
Use
>>      --strict when invoking "git am" via "git rebase".
>=20
> Solution (2) seemed like a lot of work, so here is the relatively sma=
ll
> solution (1). I think looking for <.*@.*> is too restrictive, as peop=
le
> may be using:
>=20

This is an implementation of solution (2). Not much work, but I might
have missed something. git-mailinfo usally breaks when I touch it,
but the testsuite passes with this patch, including the extra test
vectors from Jeff.

The actual change is that mailinfo doesn't look for in-body headers
at all if --no-inbody-headers is passed. git-am now passes this option
to mailinfo when rebasing.

This won't handle the case when a "bad" patch is passed to git-am from
somewhere else than git rebase.

/Lukas


 builtin-mailinfo.c                   |    5 +++++
 git-am.sh                            |   13 ++++++++++---
 t/t5100-mailinfo.sh                  |    6 +++++-
 t/t5100/info0015                     |    5 +++++
 t/t5100/info0015--no-inbody-headers  |    5 +++++
 t/t5100/info0016                     |    5 +++++
 t/t5100/info0016--no-inbody-headers  |    5 +++++
 t/t5100/msg0015                      |    2 ++
 t/t5100/msg0015--no-inbody-headers   |    3 +++
 t/t5100/msg0016                      |    2 ++
 t/t5100/msg0016--no-inbody-headers   |    4 ++++
 t/t5100/patch0015                    |    8 ++++++++
 t/t5100/patch0015--no-inbody-headers |    8 ++++++++
 t/t5100/patch0016                    |    8 ++++++++
 t/t5100/patch0016--no-inbody-headers |    8 ++++++++
 t/t5100/sample.mbox                  |   33
+++++++++++++++++++++++++++++++++
 16 files changed, 116 insertions(+), 4 deletions(-)
 create mode 100644 t/t5100/info0015
 create mode 100644 t/t5100/info0015--no-inbody-headers
 create mode 100644 t/t5100/info0016
 create mode 100644 t/t5100/info0016--no-inbody-headers
 create mode 100644 t/t5100/msg0015
 create mode 100644 t/t5100/msg0015--no-inbody-headers
 create mode 100644 t/t5100/msg0016
 create mode 100644 t/t5100/msg0016--no-inbody-headers
 create mode 100644 t/t5100/patch0015
 create mode 100644 t/t5100/patch0015--no-inbody-headers
 create mode 100644 t/t5100/patch0016
 create mode 100644 t/t5100/patch0016--no-inbody-headers

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index c90cd31..a81526e 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -26,6 +26,7 @@ static struct strbuf charset =3D STRBUF_INIT;
 static int patch_lines;
 static struct strbuf **p_hdr_data, **s_hdr_data;
 static int use_scissors;
+static int use_inbody_headers =3D 1;

 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
@@ -771,6 +772,8 @@ static int handle_commit_msg(struct strbuf *line)
 		return 0;

 	if (still_looking) {
+		if (!use_inbody_headers)
+			still_looking =3D 0;
 		strbuf_ltrim(line);
 		if (!line->len)
 			return 0;
@@ -1033,6 +1036,8 @@ int cmd_mailinfo(int argc, const char **argv,
const char *prefix)
 			use_scissors =3D 1;
 		else if (!strcmp(argv[1], "--no-scissors"))
 			use_scissors =3D 0;
+		else if (!strcmp(argv[1], "--no-inbody-headers"))
+			use_inbody_headers =3D 0;
 		else
 			usage(mailinfo_usage);
 		argc--; argv++;
diff --git a/git-am.sh b/git-am.sh
index c132f50..96869a2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -289,7 +289,7 @@ split_patches () {
 prec=3D4
 dotest=3D"$GIT_DIR/rebase-apply"
 sign=3D utf8=3Dt keep=3D skip=3D interactive=3D resolved=3D rebasing=3D=
 abort=3D
-resolvemsg=3D resume=3D scissors=3D
+resolvemsg=3D resume=3D scissors=3D no_inbody_headers=3D
 git_apply_opt=3D
 committer_date_is_author_date=3D
 ignore_date=3D
@@ -322,7 +322,7 @@ do
 	--abort)
 		abort=3Dt ;;
 	--rebasing)
-		rebasing=3Dt threeway=3Dt keep=3Dt scissors=3Df ;;
+		rebasing=3Dt threeway=3Dt keep=3Dt scissors=3Df no_inbody_headers=3D=
t ;;
 	-d|--dotest)
 		die "-d option is no longer supported.  Do not use."
 		;;
@@ -448,6 +448,7 @@ else
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
 	echo "$scissors" >"$dotest/scissors"
+	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
 	echo "$GIT_QUIET" >"$dotest/quiet"
 	echo 1 >"$dotest/next"
 	if test -n "$rebasing"
@@ -495,6 +496,12 @@ t)
 f)
 	scissors=3D--no-scissors ;;
 esac
+if test "$(cat "$dotest/no_inbody_headers")" =3D t
+then
+	no_inbody_headers=3D--no-inbody-headers
+else
+	no_inbody_headers=3D
+fi
 if test "$(cat "$dotest/quiet")" =3D t
 then
 	GIT_QUIET=3Dt
@@ -549,7 +556,7 @@ do
 	# by the user, or the user can tell us to do so by --resolved flag.
 	case "$resume" in
 	'')
-		git mailinfo $keep $scissors $utf8 "$dotest/msg" "$dotest/patch" \
+		git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" =
"$dotest/patch" \
 			<"$dotest/$msgnum" >"$dotest/info" ||
 			stop_here $this

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 0279d07..50e13c1 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
 	last=3D`cat last` &&
 	echo total is $last &&
-	test `cat last` =3D 14'
+	test `cat last` =3D 16'

 check_mailinfo () {
 	mail=3D$1 opt=3D$2
@@ -30,6 +30,10 @@ do
 		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--scissors
 		then
 			check_mailinfo $mail --scissors
+		fi &&
+		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--use-first-header
+		then
+			check_mailinfo $mail --no-inbody-headers
 		fi
 	'
 done
diff --git a/t/t5100/info0015 b/t/t5100/info0015
new file mode 100644
index 0000000..0114f10
--- /dev/null
+++ b/t/t5100/info0015
@@ -0,0 +1,5 @@
+Author:
+Email:
+Subject: check bogus body header (from)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/info0015--no-inbody-headers
b/t/t5100/info0015--no-inbody-headers
new file mode 100644
index 0000000..c4d8d77
--- /dev/null
+++ b/t/t5100/info0015--no-inbody-headers
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: check bogus body header (from)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/info0016 b/t/t5100/info0016
new file mode 100644
index 0000000..38ccd0d
--- /dev/null
+++ b/t/t5100/info0016
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: check bogus body header (date)
+Date: bogus
+
diff --git a/t/t5100/info0016--no-inbody-headers
b/t/t5100/info0016--no-inbody-headers
new file mode 100644
index 0000000..f4857d4
--- /dev/null
+++ b/t/t5100/info0016--no-inbody-headers
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: check bogus body header (date)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/msg0015 b/t/t5100/msg0015
new file mode 100644
index 0000000..9577238
--- /dev/null
+++ b/t/t5100/msg0015
@@ -0,0 +1,2 @@
+- a list
+  - of stuff
diff --git a/t/t5100/msg0015--no-inbody-headers
b/t/t5100/msg0015--no-inbody-headers
new file mode 100644
index 0000000..be5115b
--- /dev/null
+++ b/t/t5100/msg0015--no-inbody-headers
@@ -0,0 +1,3 @@
+From: bogosity
+  - a list
+  - of stuff
diff --git a/t/t5100/msg0016 b/t/t5100/msg0016
new file mode 100644
index 0000000..0d9adad
--- /dev/null
+++ b/t/t5100/msg0016
@@ -0,0 +1,2 @@
+and some content
+
diff --git a/t/t5100/msg0016--no-inbody-headers
b/t/t5100/msg0016--no-inbody-headers
new file mode 100644
index 0000000..1063f51
--- /dev/null
+++ b/t/t5100/msg0016--no-inbody-headers
@@ -0,0 +1,4 @@
+Date: bogus
+
+and some content
+
diff --git a/t/t5100/patch0015 b/t/t5100/patch0015
new file mode 100644
index 0000000..ad64848
--- /dev/null
+++ b/t/t5100/patch0015
@@ -0,0 +1,8 @@
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
diff --git a/t/t5100/patch0015--no-inbody-headers
b/t/t5100/patch0015--no-inbody-headers
new file mode 100644
index 0000000..ad64848
--- /dev/null
+++ b/t/t5100/patch0015--no-inbody-headers
@@ -0,0 +1,8 @@
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
diff --git a/t/t5100/patch0016 b/t/t5100/patch0016
new file mode 100644
index 0000000..ad64848
--- /dev/null
+++ b/t/t5100/patch0016
@@ -0,0 +1,8 @@
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
diff --git a/t/t5100/patch0016--no-inbody-headers
b/t/t5100/patch0016--no-inbody-headers
new file mode 100644
index 0000000..ad64848
--- /dev/null
+++ b/t/t5100/patch0016--no-inbody-headers
@@ -0,0 +1,8 @@
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 13fa4ae..de10312 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -650,3 +650,36 @@ index b0b5d8f..461c47e 100644
  		convert_to_utf8(line, charset.buf);
 --
 1.6.4.1
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Subject: check bogus body header (from)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
+From: bogosity
+  - a list
+  - of stuff
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Subject: check bogus body header (date)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
+Date: bogus
+
+and some content
+
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
--=20
1.6.4.4
