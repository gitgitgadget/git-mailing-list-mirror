Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863622FAFD
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769946484; cv=none; b=evt2Q0DfmCyfxzK9DU2lSGDAPuq1cNMjB4adNZhTtg5vZG8HASTszvBzhCyD3LDtbzkR9ZBBOwcrWuWVQjghHx2HS2pYFrYhYcJ5PbrU4+IjtfM7wA17GW0p7GWB6+gipe/kvv5YzUP+VgyiDmZmOHVVTyJ8beFASi5M5kCjmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769946484; c=relaxed/simple;
	bh=eEW4TKdXjlskUQeCY5eUiO7Cngk4QYIL2EwW7Wlcsog=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u1lLTS6Y8wKDbAnBnd1S+exB4Rgv/nkpxd1d/oNzlIVizeNw884xS76RWkggpcq8OYEEr/37ML1AfRUDwqFMkFfA2D7+R9b8MqCCDC0sTN8UNRfq39k2cReD6rKBjHwUxUEJsVbdX7lCVbC6mv8Ng0BJz3wgnX+pUE6QGPIVvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=j2WjN4sx; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="j2WjN4sx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769946473; x=1770551273; i=l.s.r@web.de;
	bh=nCcLpZ7PK+KpTGVyXFLwZXIgva8ImKeR3Xe/Pp1Yh1A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j2WjN4sxWX0zv0mL61hgiIng4yjhx3eNJQSPQd+xz7GwWhs2gW4ApBMBbeX8ty+5
	 v7PTL/KX/SHFzfQqiJsDm+ubgCBlGtjX8cMn1Ncs3MKNtFESjXOPFVxcruM9dBDPw
	 g6w/R8+0GRUlARdBIKpSGlqNKXwmsFhlmwvekf1jN3uV/CAqxu7fPN78D6mhNT+Dn
	 1YhrAAaguK3hiseIvT1uk0AlwbksoUjSFP6NJjmEbnsVqGhKDbaEU73ZQ6fRD7VGb
	 J3vpWEuqKkIRrMALbLj/qjm0TnqXAKohsMvgdjFb//c39dyO4VxXQOUkEuEiBXSdi
	 /vDWUGb1E8ldpf62QA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91Pe-1vgRf536L0-009QwU; Sun, 01
 Feb 2026 12:47:53 +0100
Message-ID: <28ac1ee6-f3e9-4789-92b7-903788430697@web.de>
Date: Sun, 1 Feb 2026 12:47:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] blame: fix coloring for repeated suspects
To: Seth McDonald <sethmcmail@pm.me>, git@vger.kernel.org
References: <aX8BjoOGPIytGXjD@McDaDebianPC>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aX8BjoOGPIytGXjD@McDaDebianPC>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4hOyEFxI6FFvGtnNnmG9yUbwqC8gq/NdBQEtMezVgsqOr2C/Uaf
 NjMJRAfgWsVHWZ1zWOAuobRH0FevBGvL+t4CIhDHYXsnqucvV6aylJyjFQlbyaulxt9MQ+o
 ZfB9JjGPA4eMZco43O7uvje03r3qtvnv3g0WZ14o+YtWbgY+/H2MG8pzgh7NTwnlbrcYbtp
 2yIFxVQ5yoQD7xHC/4FIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J0lhPQMxeFc=;suoZKDNt9qw8RRJdxQsQ9F7PzQX
 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
 oj9I6EqVw0+TkaBLcL4h

The option --ignore-rev passes the blame to an older commit.  This can
cause adjacent scoreboard entries to blame the same commit.  Currently
we only look a the present entry when determining whether a line needs
to be colored for --color-lines.  Check the previous entry as well.

Reported-by: Seth McDonald <sethmcmail@pm.me>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/blame.c         | 13 +++++++++----
 t/t8012-blame-colors.sh | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6044973462..bb460346e6 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -454,7 +454,8 @@ static void determine_line_heat(struct commit_info *ci=
, const char **dest_color)
 	*dest_color =3D colorfield[i].col;
 }
=20
-static void emit_other(struct blame_scoreboard *sb, struct blame_entry *e=
nt, int opt)
+static void emit_other(struct blame_scoreboard *sb, struct blame_entry *e=
nt,
+		       int opt, struct blame_entry *prev_ent)
 {
 	int cnt;
 	const char *cp;
@@ -485,7 +486,10 @@ static void emit_other(struct blame_scoreboard *sb, s=
truct blame_entry *ent, int
 			the_hash_algo->hexsz : (size_t) abbrev;
=20
 		if (opt & OUTPUT_COLOR_LINE) {
-			if (cnt > 0) {
+			if (cnt > 0 ||
+			    (prev_ent &&
+			     oideq(&suspect->commit->object.oid,
+				   &prev_ent->suspect->commit->object.oid))) {
 				color =3D repeated_meta_color;
 				reset =3D GIT_COLOR_RESET;
 			} else  {
@@ -571,7 +575,7 @@ static void emit_other(struct blame_scoreboard *sb, st=
ruct blame_entry *ent, int
=20
 static void output(struct blame_scoreboard *sb, int option)
 {
-	struct blame_entry *ent;
+	struct blame_entry *ent, *prev_ent =3D NULL;
=20
 	if (option & OUTPUT_PORCELAIN) {
 		for (ent =3D sb->ent; ent; ent =3D ent->next) {
@@ -593,7 +597,8 @@ static void output(struct blame_scoreboard *sb, int op=
tion)
 		if (option & OUTPUT_PORCELAIN)
 			emit_porcelain(sb, ent, option);
 		else {
-			emit_other(sb, ent, option);
+			emit_other(sb, ent, option, prev_ent);
+			prev_ent =3D ent;
 		}
 	}
 }
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index 3d77352650..5562eba436 100755
=2D-- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -28,6 +28,20 @@ test_expect_success 'colored blame colors contiguous li=
nes' '
 	test_line_count =3D 3 H.expect
 '
=20
+test_expect_success 'color lines becoming contiguous due to --ignore-rev'=
 '
+	mv hello.c hello.orig &&
+	sed "s/	/    /g" <hello.orig >hello.c &&
+	git add hello.c &&
+	git commit -m"tabs to spaces" &&
+	git -c color.blame.repeatedLines=3Dyellow blame --color-lines --ignore-r=
ev=3DHEAD hello.c >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	grep "<YELLOW>" <actual >darkened &&
+	grep "(F" darkened > F.expect &&
+	grep "(H" darkened > H.expect &&
+	test_line_count =3D 2 F.expect &&
+	test_line_count =3D 3 H.expect
+'
+
 test_expect_success 'color by age consistently colors old code' '
 	git blame --color-by-age hello.c >actual.raw &&
 	git -c blame.coloring=3DhighlightRecent blame hello.c >actual.raw.2 &&
=2D-=20
2.52.0
