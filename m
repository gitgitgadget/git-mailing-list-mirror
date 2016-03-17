From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] dir.c: fix bug in 'nd/exclusion-regression-fix' topic
Date: Thu, 17 Mar 2016 19:45:41 +0700
Message-ID: <1458218744-15810-1-git-send-email-pclouds@gmail.com>
References: <56E9F5B3.6030903@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: durham@fb.com, mitrandir@fb.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 13:46:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXK8-0003z6-Of
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 13:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbcCQMql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 08:46:41 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34193 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbcCQMqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 08:46:39 -0400
Received: by mail-pf0-f171.google.com with SMTP id x3so119751584pfb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCzDGzb1b6YTzzJRABl2NdB5XdXy26XcpG4JkcsEPnk=;
        b=xbhcfu/ISqUISGDhjo4xrPEzUYABKCa9mWS+bm06besE9lRsSssG34Cl3OMNdljUX/
         BvyWcKRheMiSDaA5wtYtPd0CpAbi9EEELvEn+YLC987ICE7LamXFJh/hZzChvhYXIzcJ
         nYw7txMdkUZlYh+zx/+QCVGP0UCtH2KfyplRV/bNvJFJxSbiwiWVl/MR8IaEuC/2I6AA
         j/vrqeELFBfUvzYAbXhylnJoXRNwuvgSZdhqLb4iz6kH7OqlxPBXflJTo8ID0dbOyzYG
         qHUzs2sMZ+nKhLMVHyzSNI8o1eWIp7MRn5AIlEu1HYPzSZJ8NOIfA+CwDcLw1yfy66GF
         FyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCzDGzb1b6YTzzJRABl2NdB5XdXy26XcpG4JkcsEPnk=;
        b=FnaQNgQNlLuwz5zT6AVXO7qJXf79tOq/CiIg4NMovQC7ffwiKwJEX0Goj8W2CveWmD
         Mc1ZOuGJgwjOYpGwyqWlqJF+Ru34zqf38mx8HYU5ut4oI35PrImpW04vEzub+itxVU61
         SwiUeoEHq/Owmoj3m6LQUs6/ga2Gh80ET5vlapNyZntEbXJPJJ+sMV4RuVYqdGfRZB0N
         zA0qqjdZynMtt/Sq3mIp2wOQTdCShuzDv+dz+2WKcoIugXlICmB6oTfzXbkeFJCiSau+
         0rjNZITYIW5JLE5+qj0bI0S7bQzMvTP0yXYsLuPmCjg5bLzCqM8fWKqm6wK6V41DXtTa
         rT+w==
X-Gm-Message-State: AD7BkJJlPSVullYTr9NFoZKpXxx+0iY8DS12K8HUap4neFyabNfohDcDl7OfnjyM23DHPQ==
X-Received: by 10.66.144.4 with SMTP id si4mr14743310pab.0.1458218783965;
        Thu, 17 Mar 2016 05:46:23 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id p26sm13251680pfi.84.2016.03.17.05.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2016 05:46:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:45:47 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <56E9F5B3.6030903@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289101>

The topic in question introduces "sticky" path list for this purpose:
given a path 'abc/def', if 'abc' already matches a pattern X, it's adde=
d
to X's sticky path list. When we need to check if 'abc/def' matches
pattern X and see that 'abc' is already in the list, we conclude right
away that 'abc/def' also matches X.

The short reason (*) for sticky path list is to workaround limitations
of matching code that will return "not match" when we compare
'abc/def' and pattern X.

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

(*) The problem is known and will be fixed later and described in
detail then. For this commit, it's sufficient to see the following
link because the long reason is really long:

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
