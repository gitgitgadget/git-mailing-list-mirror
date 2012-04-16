From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v3 1/7] t4052: test --stat output with --graph
Date: Mon, 16 Apr 2012 03:44:49 -0700
Message-ID: <1334573095-32286-2-git-send-email-lucian.poston@gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lucian Poston <lucian.poston@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 12:46:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjSL-00006F-L7
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab2DPKqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 06:46:34 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:58989 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab2DPKqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:46:33 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so6754418dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pH2bxoAxBm3BVSbffikbxC0inwCbIqH4fPuuw8cZqso=;
        b=TvKEvBrpBmQlPcwhJe4+/awve4GPmW+vFlgFlbukxrziYsGqVFGzW7BbPsSFmhFqkS
         EmEoHJcDqXtBSezi+rM7YtSkqluIaygyjpFsCdlIH6q56+sUQwMDbs21FvvJI8Rp/ipw
         rpdS/6Gh3o51H6j+29d25jfb4mB65SVOQpB70XyasAZ3whCZmuF3Zmn86cn/Fz6NkxLb
         OPlNp3gascnWCrXrU7W2kNsmtrEUfhMzMW6Y/uJWvyzcmL+6qWgTxVIz7AdfBPJ4oqCS
         DT8qoDDAXWXKvSieuTZT0WO3leXL6MPqlFXkAhs9xrOgvpqQGFRzU22ZADgM7ynbO6W6
         qrfQ==
Received: by 10.68.195.38 with SMTP id ib6mr27007816pbc.28.1334573192829;
        Mon, 16 Apr 2012 03:46:32 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id oh2sm10793051pbb.45.2012.04.16.03.46.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 03:46:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195612>

=46rom: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>

Add tests which show that the width of the --prefix added by --graph
is not taken into consideration when the diff stat output width is
calculated.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 t/t4052-stat-output.sh |   78 ++++++++++++++++++++++++++++++++++++++++=
+++++--
 1 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 328aa8f..da14984 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -82,11 +82,15 @@ test_expect_success 'preparation for big change tes=
ts' '
 cat >expect80 <<'EOF'
  abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
 EOF
-
+cat >expect80-graph <<'EOF'
+|  abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
+EOF
 cat >expect200 <<'EOF'
  abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-
+cat >expect200-graph <<'EOF'
+|  abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (big change)" '
@@ -94,6 +98,14 @@ do
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --graph $verb COLUMNS (big change)" '
+		COLUMNS=3D200 git $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
@@ -104,7 +116,9 @@ EOF
 cat >expect40 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++
 EOF
-
+cat >expect40-graph <<'EOF'
+|  abcd | 1000 ++++++++++++++++++++++++++
+EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb not enough COLUMNS (big change)" '
@@ -118,6 +132,20 @@ do
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --graph $verb not enough COLUMNS (big chang=
e)" '
+		COLUMNS=3D40 git $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
+
+	test_expect_success "$cmd --graph $verb statGraphWidth config" '
+		git -c diff.statGraphWidth=3D26 $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect40 diff HEAD^ HEAD --stat
@@ -129,6 +157,9 @@ EOF
 cat >expect <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++
 EOF
+cat >expect-graph <<'EOF'
+|  abcd | 1000 ++++++++++++++++++++++++++
+EOF
 while read cmd args
 do
 	test_expect_success "$cmd --stat=3Dwidth with big change" '
@@ -143,11 +174,25 @@ do
 		test_cmp expect actual
 	'
=20
-	test_expect_success "$cmd --stat-graph--width with big change" '
+	test_expect_success "$cmd --stat-graph-width with big change" '
 		git $cmd $args --stat-graph-width=3D26 >output
 		grep " | " output >actual &&
 		test_cmp expect actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --stat-width=3Dwidth --graph with big chang=
e" '
+		git $cmd $args --stat-width=3D40 --graph >output
+		grep " | " output >actual &&
+		test_cmp expect-graph actual
+	'
+
+	test_expect_success "$cmd --stat-graph-width --graph with big change"=
 '
+		git $cmd $args --stat-graph-width=3D26 --graph >output
+		grep " | " output >actual &&
+		test_cmp expect-graph actual
+	'
 done <<\EOF
 format-patch -1 --stdout
 diff HEAD^ HEAD --stat
@@ -164,6 +209,9 @@ test_expect_success 'preparation for long filename =
tests' '
 cat >expect <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
 EOF
+cat >expect-graph <<'EOF'
+|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
+EOF
 while read cmd args
 do
 	test_expect_success "$cmd --stat=3Dwidth with big change is more bala=
nced" '
@@ -171,6 +219,14 @@ do
 		grep " | " output >actual &&
 		test_cmp expect actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --stat=3Dwidth --graph with big change is b=
alanced" '
+		git $cmd $args --stat-width=3D60 --graph >output &&
+		grep " | " output >actual &&
+		test_cmp expect-graph actual
+	'
 done <<\EOF
 format-patch -1 --stdout
 diff HEAD^ HEAD --stat
@@ -181,9 +237,15 @@ EOF
 cat >expect80 <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++
 EOF
+cat >expect80-graph <<'EOF'
+|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++=
+++++++++++
+EOF
 cat >expect200 <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
+cat >expect200-graph <<'EOF'
+|  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (long filename)" '
@@ -191,6 +253,14 @@ do
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --graph $verb COLUMNS (long filename)" '
+		COLUMNS=3D200 git $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
--=20
1.7.3.4
