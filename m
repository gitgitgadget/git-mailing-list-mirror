From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Fri,  3 Jun 2016 18:08:43 +0700
Message-ID: <20160603110843.15434-4-pclouds@gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 13:09:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8myj-0006oW-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbcFCLJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 07:09:14 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36732 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487AbcFCLJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 07:09:10 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so5768830pad.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4lKSmycSQIzvlh1zWZJIKU9N/V8LbbGSL1OXYy1XUc=;
        b=IKCK8Jkt2WZDMfLMzQUCzAywjIRbUN3J9Sfm5/k0F7RcK90OKBmuBozoppsjBuMr+p
         ZcFOeHpHsyNgXzDxmzGLn9FUwA/BqLKiklkb1NVLanq4EpRKzvC/FOX6QySlNfEsFZu3
         b25KlId9nNNIoJ3P5XoIW25nN9fVNZzkcwwdp/g3Foy4ZQbx0FVitH/YUo0y0ZGoe2mG
         j0SRoeSi+OmFlLJv6u5+8wRLXB0VEnDmd+WxHBJebUc6tX5WeWh61Q/h/Vexqg5ILtd7
         YSrEBGyv/iErKuJkiw/ODZmtImeeeXxuXEFFLVZPjXBZehquvZLvLViGlEveMOk93ocD
         +giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4lKSmycSQIzvlh1zWZJIKU9N/V8LbbGSL1OXYy1XUc=;
        b=Q9l2a0kkHoaJkv/VD9pPg4NFCarikoX88CJmSd73S0Si9WGchV87MZ25MRkbAiH0gf
         vAqp7XVjDU0LRpfJng0sY2c4kaeevtZOkUAkzFNeHW40+yQuMwVGVKpWcuDj6iq0QiGT
         jcRF7pFRQdr75Xrnn83UVcW40fSqd809ZUMiODQlUgMCffoe7zLR1mwXN3eMve6aIFqp
         uihUUhX5ZpTBMIGTVWwGvJz5pofw3YxoXvnieeRjbAPigOs1hAWId41jwGI8ODwHqoR2
         /M60Dko0axIUNRZS/ForBYHWeRZOMOxIptWi2vduTHcoGQ0PdABki7KNZv+eBgsWLh7C
         Coeg==
X-Gm-Message-State: ALyK8tJl3oOSIK/lZgbO8u9bR4Yo2q8EHRTmwQLBiWHDwMAF6OOzpG6g8HnvhLHf5W233g==
X-Received: by 10.66.90.196 with SMTP id by4mr4595681pab.117.1464952149770;
        Fri, 03 Jun 2016 04:09:09 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id v184sm7643853pfb.24.2016.06.03.04.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 04:09:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 18:09:05 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603110843.15434-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296299>

When there are lots of ref updates, each has different name length, this
will make it easier to look because the variable part is at the end.
---
 Documentation/git-fetch.txt |  7 +++++++
 builtin/fetch.c             | 37 ++++++++++++++++++++++++++++++++++++-
 t/t5510-fetch.sh            |  4 ++--
 t/t5526-fetch-submodules.sh | 26 +++++++++++++-------------
 4 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 18e733c..61c3bd1 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -113,6 +113,13 @@ representing the status of a single ref. Each line is of the form:
  <flag> <summary> <from> -> <to> (<reason>)
 -------------------------------
 
+When `from` and `to` share a common suffix, the line could be
+displayed in the form:
+
+-------------------------------
+ <flag> <summary> {<from> -> <to>}<suffix> (<reason>)
+-------------------------------
+
 The status of up-to-date refs is shown only if --verbose option is
 used.
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a7f152a..15782d6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -451,12 +451,47 @@ fail:
 
 #define REFCOL_WIDTH  10
 
+static int common_suffix_length(const char *a, const char *b)
+{
+	const char *pa = a + strlen(a);
+	const char *pb = b + strlen(b);
+	int count = 0;
+
+	while (pa > a && pb > b && pa[-1] == pb[-1]) {
+		pa--;
+		pb--;
+		count++;
+	}
+
+	/* stick to '/' boundary, do not break in the middle of a word */
+	while (count) {
+		if (*pa == '/' ||
+		    (pa == a && pb > b && pb[-1] == '/') ||
+		    (pb == b && pa > a && pa[-1] == '/'))
+			break;
+		pa++;
+		pb++;
+		count--;
+	}
+
+	return count;
+}
+
 static void format_display(struct strbuf *display, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local)
 {
+	int len;
+
 	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
-	strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
+	len = common_suffix_length(remote, local);
+	if (len)
+		strbuf_addf(display, "{%.*s -> %.*s}%s",
+			    (int)strlen(remote) - len, remote,
+			    (int)strlen(local) - len, local,
+			    remote + strlen(remote) - len);
+	else
+		strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
 	if (error)
 		strbuf_addf(display, "  (%s)", error);
 }
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 454d896..9a7649c 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -222,11 +222,11 @@ test_expect_success 'fetch uses remote ref names to describe new refs' '
 	(
 		cd descriptive &&
 		git fetch o 2>actual &&
-		grep " -> refs/crazyheads/descriptive-branch$" actual |
+		grep " -> refs/crazyheads/.descriptive-branch$" actual |
 		test_i18ngrep "new branch" &&
 		grep " -> descriptive-tag$" actual |
 		test_i18ngrep "new tag" &&
-		grep " -> crazy$" actual |
+		grep " -> .crazy$" actual |
 		test_i18ngrep "new ref"
 	) &&
 	git checkout master
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 954d0e4..2285c47 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -18,7 +18,7 @@ add_upstream_commit() {
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule" > ../expect.err &&
 		echo "From $pwd/submodule" >> ../expect.err &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
+		echo "   $head1..$head2  { -> origin/}master" >> ../expect.err
 	) &&
 	(
 		cd deepsubmodule &&
@@ -30,7 +30,7 @@ add_upstream_commit() {
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule/subdir/deepsubmodule" >> ../expect.err
 		echo "From $pwd/deepsubmodule" >> ../expect.err &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
+		echo "   $head1..$head2  { -> origin/}master" >> ../expect.err
 	)
 }
 
@@ -235,7 +235,7 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  master     -> origin/master" >>expect.err.sub &&
+	echo "   $head1..$head2  { -> origin/}master" >>expect.err.sub &&
 	head -3 expect.err >> expect.err.sub &&
 	(
 		cd downstream &&
@@ -253,7 +253,7 @@ test_expect_success "Recursion doesn't happen when new superproject commits don'
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.file &&
+	echo "   $head1..$head2  { -> origin/}master" >> expect.err.file &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -277,7 +277,7 @@ test_expect_success "Recursion picks up config in submodule" '
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.sub &&
+	echo "   $head1..$head2  { -> origin/}master" >> expect.err.sub &&
 	cat expect.err >> expect.err.sub &&
 	(
 		cd downstream &&
@@ -306,14 +306,14 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule" > ../expect.err.sub &&
 		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err.sub
+		echo "   $head1..$head2  { -> origin/}master" >> ../expect.err.sub
 	) &&
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.2 &&
+	echo "   $head1..$head2  { -> origin/}master" >> expect.err.2 &&
 	cat expect.err.sub >> expect.err.2 &&
 	tail -3 expect.err >> expect.err.2 &&
 	(
@@ -339,7 +339,7 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 		head2=$(git rev-parse --short HEAD) &&
 		echo Fetching submodule submodule > ../expect.err.sub &&
 		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err.sub
+		echo "   $head1..$head2  { -> origin/}master" >> ../expect.err.sub
 	) &&
 	(
 		cd downstream &&
@@ -358,7 +358,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	head2=$(git rev-parse --short HEAD) &&
 	tail -3 expect.err > expect.err.deepsub &&
 	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  master     -> origin/master" >>expect.err &&
+	echo "   $head1..$head2  { -> origin/}master" >>expect.err &&
 	cat expect.err.sub >> expect.err &&
 	cat expect.err.deepsub >> expect.err &&
 	(
@@ -387,7 +387,7 @@ test_expect_success "'--recurse-submodules=on-demand' stops when no new submodul
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.file &&
+	echo "   $head1..$head2  { -> origin/}master" >> expect.err.file &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
@@ -408,7 +408,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
+	echo "   $head1..$head2  { -> origin/}master" >>expect.err.2 &&
 	head -3 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
@@ -436,7 +436,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
+	echo "   $head1..$head2  { -> origin/}master" >>expect.err.2 &&
 	head -3 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
@@ -462,7 +462,7 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 	git commit -m "submodule rewound" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err &&
+	echo "   $head1..$head2  { -> origin/}master" >> expect.err &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
-- 
2.8.2.524.g6ff3d78
