Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88D2628D
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679767; cv=none; b=I3m1xMldqKAi/b4jQWxxMDuFWX4wPfbK1N+ieGCSyjPRX6wuxsE8HPg72ZcacYsMJfAlXQgdLfGOdOySkAkin0oDbGVBqpPMwbhVDoBXxfzJiBYfNYFiFzuO/q2SIYl3wiNlwx2tnLItuBIz9FIu6kiIzXQxuLPUIy/MsZKdwLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679767; c=relaxed/simple;
	bh=I2zxSBFc6v8K0rwNmFrw4Vv71vFGP/1r0CKc4F1GeqY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fBNDUTCKlsOQMAMwGXvbmUdChw5UimKhyMty1SI+n8hlj+joCwRSdtEW7nQjlGoet9mBDTSqYnh8wX5tYqypMQBSK706Nnjr0YnBbXm64NDyASK2budYvDbhVpQp8Kk67RxXzXted5mcr0RvJ2HEvkMU7cvr3xx1uOpUcqTN9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wiQl7p1o; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wiQl7p1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759679750; x=1760284550; i=l.s.r@web.de;
	bh=Rj0ZcM+8gzsbUPbC6MCiaXwGB4V483NOcG1sAn++Rb4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wiQl7p1o7mU7qg/GNwsucIZbDfJGYTQh9EeQANRLzJtoJF1xjr9lVAa1PDGk/lt0
	 Sks2/8a/S2qerdtAZI5kx8KbPGtN7PW3ssdVHSnYSFKUQgzCLqV9+cRlcJ1gfmNpg
	 6+h3XANNoypk9YDFdKqK/zFZSwcsxDMe/198CfMXaVpq8zZIhJcx4qnKKDIdDhvPw
	 YmjcGcCMjF2oZDdLhXHtBa7OBOWkKsKSx80PT8WusjLwnh8AABnB2vUzA9Fl0WSNT
	 ZFg2xqv3WD10qZ9iHEmM9cL5d7j1BcBOm0eUxQrUJonlSL1ixsqX8Re7GnHnu1FzT
	 WQfg1kJHXShCV24OTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpU1u-1uV1UA13Rk-00cTNa; Sun, 05
 Oct 2025 17:55:50 +0200
Message-ID: <5dc0941b-2bc1-4107-b39e-8312ff7c08f9@web.de>
Date: Sun, 5 Oct 2025 17:55:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/5] add-patch: reset "permitted" at loop start
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Language: en-US
In-Reply-To: <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x7Zk+MyP4Dat85MwPy4LDwROUbx5OaQcnyKIcLcB0dqZ3wJLy21
 PGDYfiAxcRdbUrJ9T2KcpF2bxDzSWxBZaF0btoQvJ5Fvexg3/xWvNpyuVnJidwPMXynF2v2
 +13D4xshCHPRKVT40huuGxRqJYTcSAavegZrzhSa0pyAVuD1PDXtEJ/sDiUA5MBb6wuC8oE
 F7Qt1JKZb69YT5KcIUUCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ooXy0TzppS8=;qRNyUhGug+1ohhG/eC+bbEjdXzS
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
index 52e881d3b0..7b489d0a75 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1428,15 +1428,6 @@ static int patch_update_file(struct add_p_state *s,
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
@@ -1446,6 +1437,16 @@ static int patch_update_file(struct add_p_state *s,
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
index 385e55c783..8c24a76e59 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1386,4 +1386,18 @@ test_expect_success 'options y, n, j, k, e roll ove=
r to next undecided (2)' '
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
