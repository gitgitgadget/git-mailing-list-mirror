Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109D221F1A
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771474; cv=none; b=tmPO1qhgqQn0qgB9GZyY4jcsISKsEtBnTWGsWSKWF0FdtQ9Q7vyvaKqz0vqzayHCMEiLbPZliJwXKsfdT7oG3CF2ECA6G+Ahttwj7mMhESziDORUDNvE2Bt99ow3WRrStUcMALQioUffvRAd3t/W6tQer2XVH5vIpAj6uhI5CAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771474; c=relaxed/simple;
	bh=bdBjbqhx23uwd3V/9ocNznnF6MuLNhLEjO/Z8qlmqW4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D5RiS9eRcefh/+5kEcYCgLqTDpmroI2a2NHFIEvZAD6bocUOZuD49xEzeLbSOMeg1aq9UvH7ll0iFWkTAqsdPZllsskAB58I+9V7MukyMggxcIy2yX/UI6WOauiCEWRgQxFMxrC1lXAX71K7uRoese9q3jPDE15SxoigafBAY/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YSwASaR4; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YSwASaR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759771469; x=1760376269; i=l.s.r@web.de;
	bh=bfzuUPA4de2YXYIpfDcEzsRIsgAZ/b8WUs/Np3sFnCg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YSwASaR4c0H4aPOmmze8cIzCmQLChnOTbOu7uVFD3PK/b+An688ij90pPa2XP+vL
	 Y+bP6S654Piyhf1zZlHNFcBxnono6HdEwvqjIs/hl6+3GdqaBlqJp5exI7TCNXLfI
	 cydzjogqn/58uawpEz/HjIsbrn+JFXdMzIjMaG1WRsHCjxRbEL5BBeNR0yXLKbN+/
	 zoJJXl3yuAg3L2NPjvuMjEX/Q1ZhXcVCGBWhH5Jl30esQlqtFaSlqRBWpXkOUce5+
	 KOoo2KcQy2WFvq0bzo2sv2BkNS4vHieBGUU0GFaVVR99KhPp+BJLGLkqlJBiiBsR+
	 wl3szPqW54mKJKwVyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcpt-1uisE21GkN-00I6DT; Mon, 06
 Oct 2025 19:24:29 +0200
Message-ID: <ed73a585-5074-4e36-9f41-228909513237@web.de>
Date: Mon, 6 Oct 2025 19:24:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 6/6] add-patch: reset "permitted" at loop start
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Language: en-US
In-Reply-To: <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x2OX+mq1/ccwMviFvogFMtmwmHn7dG+IZCSJslMG/u3OpVDF1pB
 7WINHCabP4WceotwvcTZ3NV80ILsQODUxJvIhEJ0csz/H8xg8qjSBPKrzmyBVB2v5usOcmA
 NcH6tQhSInkAFjSejbZEKdCk28mU8MHzbdwDT8aiNgoo2wpNf8XCe3C5ZRipeZ4gQL1xsVD
 Nw6BUUcHmKFvx7ljw7XNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w8ytGStl9gM=;AAWxASPW9lXZMQpQbUD2whg1mn8
 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

Don't accumulate allowed options from any visited hunks, start fresh at
the top of the loop instead and only record the allowed options for the
current hunk.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 add-patch.c                | 19 ++++++++++---------
 t/t3701-add-interactive.sh | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 6da13a78b5..45839ceac5 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1439,15 +1439,6 @@ static int patch_update_file(struct add_p_state *s,
 	struct child_process cp =3D CHILD_PROCESS_INIT;
 	int colored =3D !!s->colored.len, quit =3D 0, use_pager =3D 0;
 	enum prompt_mode_type prompt_mode_type;
-	enum {
-		ALLOW_GOTO_PREVIOUS_HUNK =3D 1 << 0,
-		ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK =3D 1 << 1,
-		ALLOW_GOTO_NEXT_HUNK =3D 1 << 2,
-		ALLOW_GOTO_NEXT_UNDECIDED_HUNK =3D 1 << 3,
-		ALLOW_SEARCH_AND_GOTO =3D 1 << 4,
-		ALLOW_SPLIT =3D 1 << 5,
-		ALLOW_EDIT =3D 1 << 6
-	} permitted =3D 0;
=20
 	/* Empty added files have no hunks */
 	if (!file_diff->hunk_nr && !file_diff->added)
@@ -1457,6 +1448,16 @@ static int patch_update_file(struct add_p_state *s,
 	render_diff_header(s, file_diff, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
+		enum {
+			ALLOW_GOTO_PREVIOUS_HUNK =3D 1 << 0,
+			ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK =3D 1 << 1,
+			ALLOW_GOTO_NEXT_HUNK =3D 1 << 2,
+			ALLOW_GOTO_NEXT_UNDECIDED_HUNK =3D 1 << 3,
+			ALLOW_SEARCH_AND_GOTO =3D 1 << 4,
+			ALLOW_SPLIT =3D 1 << 5,
+			ALLOW_EDIT =3D 1 << 6
+		} permitted =3D 0;
+
 		if (hunk_index >=3D file_diff->hunk_nr)
 			hunk_index =3D 0;
 		hunk =3D file_diff->hunk_nr
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 9d81b0542e..403aaee356 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1386,4 +1386,18 @@ test_expect_success 'options y, n, a, d, j, k, e ro=
ll over to next undecided (2)
 	test_cmp expect actual
 '
=20
+test_expect_success 'invalid option s is rejected' '
+	test_write_lines a b c d e f g h i j k >file &&
+	git add file &&
+	test_write_lines X b X d e f g h i j X >file &&
+	test_write_lines j s q | git add -p >out &&
+	sed -ne "s/ @@.*//" -e "s/ \$//" -e "/^(/p" <out >actual &&
+	cat >expect <<-EOF &&
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? Sorry, cannot split=
 this hunk
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?
+	EOF
+	test_cmp expect actual
+'
+
 test_done
=2D-=20
2.51.0
