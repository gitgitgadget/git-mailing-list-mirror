Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B893A94B
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460836; cv=none; b=DlxqcLqV8Ni96fcg0MF8E7bAAF0e+l1Js9vwU6YRqrmV8rTx2kFzk21UcepjE+3gyji2ve7gcD9WStDzYexk4vMywwnmSM6bTxKT9zy3gxPdrmon27OyEiJvjTUJkrZcs38IEPZ+FMuCJjziq0uFB2tMX3gEp51hdfS0Cvb0ADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460836; c=relaxed/simple;
	bh=yB7sWUiQxVJrF5JOIuKOLJ9enSP9v9LC+wrCASzSBLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeuSGvAxBT2N2n80zrQ2/+jHrtJs5858adBo2/pcsV5rcAlTVieL4l7ZPatw21qXKacpdnVTWvjGFd/ancz1jc9vYBg7can8MXbJh9J3MgHuW04+B/E0pqLKliYhnOtm079awtUFhEpYEHfBmogIoaQuOifi54fygweU/zzv31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EosGHrnl; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EosGHrnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709460830; x=1710065630; i=l.s.r@web.de;
	bh=yB7sWUiQxVJrF5JOIuKOLJ9enSP9v9LC+wrCASzSBLw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=EosGHrnlrv2JVFlzIP92jPekTE8me1OH//ZEqGZc5ndi3wAIyHZrndTdZdDUWHi2
	 h+tsbXVMWIYwXBrzHiat3MHzExvIuHY8KCZ9sr06/Aq7G4n4hOYo8H3OroTHVpQgY
	 fWQV1YXJisFw+EV/H3dFDFws1t++GXXKNvnlUKm9RaVAM+BwCJz7Em4XXdlfT7KAI
	 D7QfLO1dxmEhEh8TF49GNGJ7eVDwIUYEJ+pT+QFhwap9A6jKo8kl3kDemA4/dKTDA
	 iPnvt5m+SeIrKyOEv9QgI/jpMQgs8vZdAKT9ch4vy8rv7mqlUuJNYIwxZVE3HbRHX
	 /ylj4QFxcLPmRdhcPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MyvB8-1quxod46eg-00vyBE; Sun, 03 Mar 2024 11:13:50 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 2/4] t-ctype: simplify EOF check
Date: Sun,  3 Mar 2024 11:13:26 +0100
Message-ID: <20240303101330.20187-3-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303101330.20187-1-l.s.r@web.de>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240303101330.20187-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:02ZVcwmGUHR3/effSkVqzPfd1E6/Rj0KC2oePAk0FDot3yWzcXx
 d7BCbrV0rSgJhdIj9SPBCtcyTOUydbw/QYD88bnriwk38jII7pP5NJ1ZGVPbWWBdBH0N0EL
 JCd/ITVblfj47fNu6tOiHYRWSLNqPX7tuFfEwvOnXlRajpnon8Y6gY0TNtYxhbSRJHXnE/r
 MQY1Rqh/ayIlt4Q9EalEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bbgQRKwKIsk=;rNv9up158rlIp/p2Df4exPUKmow
 W0xNR7Nr4G8xfjrDs5Sgru6Uxhs5i9GZ0JeHuuqBkQW9P0T0lV3EfnQ1LsBjvM+XNLqTjgIno
 Fsew/4Z3X/CnWQ1H2aJT7ezCD4bv9kphmYhUjHBay3/5tY1cOtcOly8pWAmhjeUhz/yHe7QW8
 eRK72Lyth/GsRDk6LRUJJ6FXuG0w6nU6Au4hDnd70vQ4oA223pG8t11POVTuYIeiqq0CfxTMq
 8Lt4BGDvyyPY5lESBh5lv1VRBfUCqJM8aW39nhKufwnMMao6CVycqfcvjxGug46kjQH0LPQ/i
 Q8aOGu6O1i47IFh0c2iASi79Kc24839JnEMbtM9K6F2KxRau1IZxG/8hNkrpbxUN+A4ClC19W
 wAfVbSHvA1toxBGNeuxrA8mKuN1uOcJEovVLpa0oD3KZ80r/nerDxijRTu7dv4r0NhL5dCY5u
 UYUqDOVEwRb8LMy+4QZSeUr0Tuwjf51rB3oZHo77OSMxEDnlAwvZtqpZwmnjy/xaqrviDPXwB
 2bQ2oaQyRo/jxlW2e6rrIFhrrdDTY5xXqfdcFjYEH0OU+RGIHLhtLFpoVSYkH1J0i+JM7FoWF
 r6h4Cn7EqU1iD1lMFqF+VF4ELuTwKM2qVV03W6LKxJEbSGsfe2ckNl+Hd4qcK5VeZtKiCWmcM
 tBeuXvg5d1zRuH0i0BoNIhMR+NOWrka2q+T0891ToEzz1bVtCWqWy+PWhnL076WoVA1DMxxHC
 jTrhQD/+s4DBi+BlQ73iZoym4HPd26goM7XIohE+JgDDzB4KG1YAIhGEzyLc16SUDRuk7lM8U
 qVJcZt1So3QQJTjbwTVcGkv6+vum0+issqABfJtOKdQ5E=

EOF is not a member of any character class.  If a classifier function
returns a non-zero result for it, presumably by mistake, then the unit
test check reports:

   # check "!iseof(EOF)" failed at t/unit-tests/t-ctype.c:53
   #       i: 0xffffffff (EOF)

The numeric value of EOF is not particularly interesting in this
context.  Stop printing the second line.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index 35473c41d8..f0d61d6eb2 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -10,8 +10,7 @@ static void test_ctype_##func(void) { \
 		if (!check_int(func(i), =3D=3D, !!memchr(string, i, len))) \
 			test_msg("       i: 0x%02x", i); \
 	} \
-	if (!check(!func(EOF))) \
-			test_msg("      i: 0x%02x (EOF)", EOF); \
+	check(!func(EOF)); \
 }

 #define TEST_CHAR_CLASS(class) TEST(test_ctype_##class(), #class " works"=
)
=2D-
2.44.0

