Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B015B134
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832792; cv=none; b=QIbjrOh+sbJgNbTrccjsbTVfoXKQd8Lb0N5ULG2dGbB6jzRdFbLx3KfcT+ZstF14tifxMi7aR01uAEACjF0muxY9Q1hZHMOF5xcygbEpbHGtJSzHF3fj8rNiBUW88KpzPd4ouDzVPE1M+hcyy0jeHSdYySgkErCarIccFu/0DpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832792; c=relaxed/simple;
	bh=438lcOvmlew/vUJkbq2Wo+GsT0Zjvn85P8sXcjgd4ew=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rj41dHX/pK2GKykQwnJxWpYhWZn4kvPAWJEJ+9RS07Li76hKF0HZheRxHl/ReQwY91tZmwm9WZdP5GlaqN2S5sOaU42tr6zluLff6wVm3h4kxAlVtWinwVhhe8oampOvCI0rPeUhaFWTOPKtyGtyLy/oBuQWRkvul7d+PW6qbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YwjMrueI; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YwjMrueI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721832776; x=1722437576; i=l.s.r@web.de;
	bh=KNsd2zaRe+Lni3oRy7QaGElWYVhhLSZsuuFxqqYmBS0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YwjMrueIOnsXqK/gOxkBZDdskIaQLHbxuayod4THLcWRTG30QgZjwp3Y1YYric1m
	 rhwmHffLIRGXcnJWq3RTi4dOfcpVpVsC1tWZ2UutqJneZWRbE/u5/qDdxLTH04y1h
	 awmnemRNZhXcNZXQJGOWj2nheJsUY3seZwRuJ0orClqh5QgqX11wHZ02aRSRF1DT/
	 lwZ33KSrMdzBh2G3SEyh4Hlf6RKlWogWo9uVWGMIO/HfWe71lndt+AiaBrIpA31X5
	 mmOr4TkRh17bBqdpuPoSqxUIhF8NF6rRYb7xwP61qpdFT6vWaFJb08GRRitSKNo1v
	 JZO9i+r/IGKG6k48uQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ac-1ruq7C2HZ8-00a3DF; Wed, 24
 Jul 2024 16:52:56 +0200
Message-ID: <0fa8b2fc-ac59-45da-abcc-1ac758e4813e@web.de>
Date: Wed, 24 Jul 2024 16:52:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 4/7] t-ctype: use for_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Language: en-US
In-Reply-To: <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o4ebfqNkB/nveyLtNlhfS+5fpBxolb0BwdQVYG6JcLBqaQSTGfo
 FuMNgZj/2HvlQgeIySLt/BO6/ZdTlp5/4cStEb+x+HybI1tpWKGAKcbRTVNkhH/BLUVKV2N
 NaPM+FWGsWohaxhgnyUzg7aHPpZbfwMvyZJT1Jz4Z5mOi32Xn2AEDswgYHGk9NjrhkMrzOp
 uhgCk1q5Z+pwMLtglfnxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YLmno0FPWbc=;AfC2INQQ/ngqzRCW7upKwa2m3U6
 hSCV5Ur0SqW1zGuPNssIII9GJzdt03TIDP8CX+77AVur9GQqdtbYmyoTnRQG693hHFBJnerHA
 fn/6/05rW/CqlK1enYpNhP6H5A66/v+ySje57JfV1CwFgkHHuGQo7PIDPAxyhSEUgUl3GKSqc
 Z0QgSb+UmMc2hHyxPA/Xvr+OSIAtTSLED3HQKT0DWLEkzjVFlmurC5WeLw6Z64h66bUl2+yRO
 9PpTxIs74CWg2UNK3J4sXo/7EgW1IHZbVmt/PoaloKA6VgWN2+n525kR0kPgy0B1HsIVqtGrs
 hSFuCNbhpYxpTd+lE98qXaneliyNzRk5ybTP2teKej78n7UPmUk9s5JNo+CerdEp01EPlv6y5
 ta0j1fRvr7Js/oZqqIWIsROEeY3zsMZlCmoIDMSp+a0ofVg3dk34bvb4TAPxN+dvhToayoosA
 VFBS/93Z49Jfp8SmbYUWcerht9OZSXcsOWNrjeMy49dCGke/Z8cKJfT9TAzR4FVCjsLnETW4s
 Mp82FxQyDCKV1Dq/Zfo02jlzaLBXkzLhS23j4WadIW6cLVg/ZBBSLb8IBIHb7xRXBpLOKty6c
 B4CE4mG4UgcUhxKIT+iqsIf4FyAz7BlIznAGW07GCU98JA7XlAbOrqSFH8zCIzSCNbvjs7/V3
 slFto/i1KVxybjlJxscmtKFcALOHJbri8fwMX0pfk+8Fo/Svx7tCsqpn4daFRViAvdAa1kCIk
 Yb+JeYJN9ci+eveXOR55ItttlodOdSGjZmmLSMgyiWVC+Zi/3GUVuLcwKaZTEMkQVrcojldYc
 n3WESf+hrLzi83schbx30Avg==

Use the documented macro for_test instead of the internal functions
test__run_begin() and test__run_end(), which are supposed to be private
to the unit test framework.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index d6ac1fe678..92a05f02b3 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -4,15 +4,13 @@
 	size_t len =3D ARRAY_SIZE(string) - 1 + \
 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
-	int skip =3D test__run_begin(); \
-	if (!skip) { \
+	for_test (#class " works") { \
 		for (int i =3D 0; i < 256; i++) { \
 			if (!check_int(class(i), =3D=3D, !!memchr(string, i, len)))\
 				test_msg("      i: 0x%02x", i); \
 		} \
 		check(!class(EOF)); \
 	} \
-	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
 } while (0)

 #define DIGIT "0123456789"
=2D-
2.45.2
