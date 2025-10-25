Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC52C15AE
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761371319; cv=none; b=K9ce5KLKDOtyjc46G+CbOInl+tJPm7Li+qDr3T6jsoZVs7NLga+AQpedMYE83My2wQ3tidHdtW5ItsYwCAOGzmtjqQrKMwJ5TcneWqhU72Mb7D5XKn5DKYsKN29YfYAS+SX2ywFKVjtBswKEnZmdrPKNoA+O51/yuqXRbAEAsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761371319; c=relaxed/simple;
	bh=uNCW/Uy4gk1Gcr6xGfTcdyL4ExdRHanDmr+dqqIy5zo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CuzV8YQh9V6zq15/Lf2TqnuFJHYIopcnZel1S1UcWliKBcIl2ag56cQrnAuUm9p1hIaC1T2YetzG6uX9l14bbfrc7NvM/i+PBn3sxD9dnYudi/YW2/sSndZJN9zZdcmBtzjXhhelBmegXKplywLb3avGp4axhbLv8CCamVRZDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rusMbAq7; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rusMbAq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761371308; x=1761976108; i=l.s.r@web.de;
	bh=EIDn2xqn1AhNmvGHsKo1sd/DRMUkcnKDNwHnGrSjmzQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rusMbAq7+eFCQgoWe7QyPd9N0nQmHTU/Ls9cPKtEqE0hhbYsZudwenf9aMXvcOFw
	 1KLVdYpuGi1tS4Cs7XWkagGkvxWxZD33bP+fa5yqBlLNy8VzvrzS7qqsQLCAFg5/s
	 L+S8TMcbTm59v4zQr82ItXUGXNViqzvlAjX4rQV6nzu/8ofIn5POh5bPHJAt5Puob
	 /mVeFPHv0wHH7Y+BE8/t30DD1vavumlKubN+RF47UG4k+RSMI2xBSlorqueTGkTnT
	 Xkzb+tzbJfh0+cvq9Q9UzsCDn1vlEFVTINvWhD8dPgIz6+V5upvr3LQcE9RnOxQPP
	 lTbnmML2amgFfp8WdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwNW-1ucv8c2l7e-00mriO for
 <git@vger.kernel.org>; Sat, 25 Oct 2025 07:48:28 +0200
Message-ID: <13529bee-1e02-4c20-9461-6569312bfe4f@web.de>
Date: Sat, 25 Oct 2025 07:48:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] add-patch: quit on EOF
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <0985f775-fb01-4de0-99a8-4775b602829a@web.de>
Content-Language: en-US
In-Reply-To: <0985f775-fb01-4de0-99a8-4775b602829a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mj3Suot5PUgFT2FkDkpQVax+jlVaTDSsM0O/cQtQfvaS5W1DmFq
 98wl17n5X70i93f/PpPp/uQIUSjsmQ6TplJM5eB3tv7SOrXy+YqTOv+ubqq9H+RCSEuXEYq
 Gg7oAC99HQmI591zz0CN6qa3N3jf3DQOBPfqa1X/PqJXq82XIs8NxTxgkcfJ4rOJU90mxdp
 TobDQTZk3uNnAtt/VoGLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ynJsGWqfRhA=;ZZ2xJo1Y7JNKyeti1I35Fllta6T
 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
 G2Stw1hsmH2e/5OTDEl2VxA==

If we reach the end of the input, e.g. because the user pressed ctrl-D
on Linux, there is no point in showing any more prompts, as we won't get
any reply.  Do the same as option 'q' would: Quit.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 add-patch.c                |  4 +++-
 t/t3701-add-interactive.sh | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index a70def1f81..173a53241e 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1569,8 +1569,10 @@ static int patch_update_file(struct add_p_state *s,
 		if (*s->s.reset_color_interactive)
 			fputs(s->s.reset_color_interactive, stdout);
 		fflush(stdout);
-		if (read_single_character(s) =3D=3D EOF)
+		if (read_single_character(s) =3D=3D EOF) {
+			quit =3D 1;
 			break;
+		}
=20
 		if (!s->answer.len)
 			continue;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 851ca6dd91..071b78c355 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1431,4 +1431,15 @@ test_expect_success 'invalid option s is rejected' =
'
 	test_cmp expect actual
 '
=20
+test_expect_success 'EOF quits' '
+	echo a >file &&
+	echo a >file2 &&
+	git add file file2 &&
+	echo X >file &&
+	echo X >file2 &&
+	git add -p </dev/null >out &&
+	grep file out &&
+	! grep file2 out
+'
+
 test_done
=2D-=20
2.51.1
