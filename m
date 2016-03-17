From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] dir.c: fix bug in 'nd/exclusion-regression-fix' topic
Date: Thu, 17 Mar 2016 19:45:42 +0700
Message-ID: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
References: <56E9F5B3.6030903@fb.com>
 <1458218744-15810-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: durham@fb.com, mitrandir@fb.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 13:47:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXKP-00047L-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 13:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094AbcCQMqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 08:46:53 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33043 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbcCQMqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 08:46:52 -0400
Received: by mail-pf0-f173.google.com with SMTP id 124so120248351pfg.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugAYmmPD5R/NSk+oPvOYR9INj7MuBPRYDvPtJPOo7zw=;
        b=Ueos3NIhSlrjwYQAUsIuOiStsMViaINKyb30jVtdfUCSC7DDDbVok5qvtStdM2yYnL
         tZlR7uzoLB4h91Yo4ZziGOnz74buz+e4hOP2oyz8ttu5sTBMzlpqx54fSyFRXcAWH8QT
         sf3sXG23nr2/JopqRuQxRJiyW7efuIjDqH/gu90XpVCY8/oc83gLzU9DFvpTCcMcu7Tz
         fn6gOwGOUnqvXqgVlVTxEw0+9iYE/g3N17+DCDa7VOkHLs5xRsA8Wzvpv+3NyUXwFLmV
         tPtN+hq3hX1AX2bTL0SB2iz97FhCcvia9Gct0cftQwZ+IQUENit9n8nMQTDn5AAW1LbS
         r19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugAYmmPD5R/NSk+oPvOYR9INj7MuBPRYDvPtJPOo7zw=;
        b=d6RV2Hs7yfjFRfBqeENK3oPj22gLL/ZMnRdoZzv3rr7bRhuFqGdAKumjc65f8OINwg
         LpezMMSrn6CxX7T3ezQgpHAlfk6ozLNpf0kmHsRf4vVbVHSzG5JBUW+kGogmY+PQNuwl
         QaNVuI3bNTzyDsWti5NiJuQPZP+ov4EnhYpbWg5bDa41teCKgz5GY9j3AuO2IbY4Cmux
         ZzXT9EisbufWfjCn52MqV5Pd9Ltt3NP0OsDqlXrmV3+VE9bs2WyEl9FLk31RvezLf2as
         1wxmsee5f/+VcF+5fvgYZWdIYt5mX2OY5MiiqjKxw8Qg7YVvTQbl037vB6GpAnXS+hEI
         H9ng==
X-Gm-Message-State: AD7BkJIpWgDM5mNtum6QJO11aeTLzxja4bTYXKUllI0ZLsBtM9TT/3VCkbZwRbUMYlUC9g==
X-Received: by 10.98.72.15 with SMTP id v15mr12743722pfa.23.1458218797791;
        Thu, 17 Mar 2016 05:46:37 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id y21sm13256113pfa.85.2016.03.17.05.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2016 05:46:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:46:35 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1458218744-15810-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289102>

The topic in question introduces "sticky" path list for this purpose:
given a path 'abc/def', if 'abc' already matches a pattern X, it's adde=
d
to X's sticky path list. When we need to check if 'abc/def' matches
pattern X and see that 'abc' is already in the list, we conclude right
away that 'abc/def' also matches X.

The short reason for sticky path list is to workaround limitations of
matching code (*) that will return "not match" when we compare 'abc/def=
'
and pattern X.

The bug is in this code. Not only it does "when we need to check if
'abc/def' matches...", it does an extra thing: if 'foo/bar' is _not_ in
the list, return 'not matched' by bypassing all matching code with the
"continue;" statement. It should let the remaining code decide match
status instead.

This bug affects both .gitignore and sparse checkout, but it's reported
as a sparse checkout bug, so let's examine how it happens. The
sparse-checkout pattern has two rules

    /*
    !one/hideme

and the worktree has three tracked files, one/hideme, one/showme and
two/showme. What happens is this

* check "one", it matches the first pattern -> positive -> keep
  examining.

*1* "thanks" to 'nd/exclusion-regression-fix' we detect this pair of
  patterns, so we put "one" in the sticky list of pattern "/*"

* enter "one", check "one/hideme", it matches the second pattern
  first (we search from bottom up) -> negative -> excluded

* check "one/showme", it does not match the second pattern.

*2* We then check it against the first pattern and notice the sticky li=
st
  that includes "one", so we decide right away that "one/showme" is
  included.

* leave "one", check "two" which does not match the second pattern.

*3* then we check "two" against the first pattern and notice that this
   pattern has a non-empty sticky list, which contains "one", not "two"=
=2E
   This bug kicks in and bypasses the true matching logic for pattern
   "/*". As a result, we exclude "two/showme".

One may notice that the order of these steps matter. If *3* occurs
before *1*, then the sticky list at that moment is empty and the bug
does not kick in. Sparse checkout always examines entries in
alphabetical order, so "abc/showme" would be examined before "one" and
not hit this bug!

The last remark is important when we move to .gitignore. We receive the
list of entries with readdir() and cannot control the order of
entries. Which means we can't write a test for .gitignore that will
reliably fail without this fix. Which is why this patch only adds a tes=
t
for sparse checkout, even though the same above steps happen to
=2Egitignore.

(*) which will be fixed later and described in detail then. For this
commit, it's sufficient to see the following link because the
explanation is long:

http://article.gmane.org/gmane.comp.version-control.git/288479

Reported-by: Durham Goode <durham@fb.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c                                |  1 -
 t/t1011-read-tree-sparse-checkout.sh | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 69e0be6..77f38a5 100644
--- a/dir.c
+++ b/dir.c
@@ -1027,7 +1027,6 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 				exc =3D x;
 				break;
 			}
-			continue;
 		}
=20
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 0c74bee..ecc5e93 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -274,4 +274,24 @@ test_expect_success 'checkout with --ignore-skip-w=
orktree-bits' '
 	git diff --exit-code HEAD
 '
=20
+test_expect_success 'sparse checkout and dir.c sticky bits' '
+	git init sticky &&
+	(
+		cd sticky &&
+		mkdir one two &&
+		touch one/hideme one/showme two/showme &&
+		git add . &&
+		git commit -m initial &&
+		cat >.git/info/sparse-checkout <<-\EOF &&
+		/*
+		!one/hideme
+		EOF
+		git config core.sparsecheckout true &&
+		git checkout &&
+		test_path_is_missing one/hideme &&
+		test_path_is_file    one/showme &&
+		test_path_is_file    two/showme
+	)
+'
+
 test_done
--=20
2.8.0.rc0.210.gd302cd2
