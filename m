Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD82D8DD1
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690311; cv=none; b=kWUULfpITk2+yMckkkEa9SvCnIIW81BHYZazf1Fap4r0IPRywEFyUUjvuHcMO1ivBS14L0ZAV86vVTpSUu6kQ7zTQ3CMeq+cGWNwSGRFS55uYtCmQHaDk5SaDUY6bVfVN4vBJ6hOSPgjLjgGFR0k2NNj/kQx7GWv5B6opPSqX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690311; c=relaxed/simple;
	bh=owLb3+xtv1oFUmBOqTL/6o5ZY6NUDX5FVzXbucJs67I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ydf1UcB248mSr2TMsySKbi81tAL270wSmmN8PRiQGQ8dbOW8pTauQRFVLlY3WrVQJ6QZxDVVdqG2FOXP+UlmNDi8o/SsaapGG8MT3kXKnkyl7RUclvDwXpU9TQuECM4dCg+FaNGG7zC10sFtbhHofQSGdnc0XQW69uISDtyiivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=iVdd7jHJ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="iVdd7jHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762690300; x=1763295100; i=l.s.r@web.de;
	bh=btgDh+lRe021pT8vPwIS3aZiFsXlFH9EQCXDg60iPfc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iVdd7jHJfUz6plaHVwFp/6LwmWa9FMbqiVuD2FfeS4JKEyKJiUSmAoY1q7ivOXF3
	 h2qQrjhWXt2lQYQ42byuZt2aVHIJFgwulxPNafAmkhRXov+nzNHNZHV79cAXVeCgB
	 HBpJO6M8qfZBvMTO9O0T24+IZi0Nokw9NWFvSEtMhFsgzfzQWjIfGmzO+BlYhdeCy
	 0bpEC1FBeFLJW0I9NTgIUIlwBMTShX+9nrhJjprhzlz7C87mM0+/YJwTAlIpRBSvw
	 OulS1ey9Yzht/aogV7I+04MMA4T+MXlEaaStn07n5M6/cGu08VcIksFn9raRhF6zl
	 vzWCOp2iELOouwGvIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.146.25]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4eGJ-1wJYJH1MRD-00rgam; Sun, 09
 Nov 2025 13:11:40 +0100
Message-ID: <bbd1a371-b0a4-4412-b329-cb4d654a0ca8@web.de>
Date: Sun, 9 Nov 2025 13:11:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] diff: disabled quick optimization with --find-copies-harder
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rMqwVKjEOBQ7uCFCo6Q1q1ph6UKpmXxTSXTUl6sK4z+f9Vug26L
 KMndEso3LALM2ziLCMQLem7rQY+WxWi5dOSGTJ93mhYwvoSREvOgbMy7+ulOeQ0n6ZVUxFA
 LuVCjowCa0SQn+olmXbXxiZXhT5ApJkA1/cLwwLtTkGPc3Tc1WX2DguEpb2mTUdepnu1qUL
 w4PijK1sp/DGNZxXS9Ryw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/n5hb36IEo0=;A8G81OBliiaVPQuHh2DW3PaUkrh
 iMskb5ltQGXypTx+8XQ/akvJcTICZzCH5gBi0+wlyQai77UwXx0i5ukYJKWxVIMK/PRWAguxg
 c4WhKw2g1tcxU4C/0VMDBnuqYyi6qgoivtcjTPxi1qko+hopjaIqkuGCghbeOjBkROUtQB039
 5KGMGE1R43LqM11ZF7PEiG4eloLQLSAbbn7GvhEt9nAwuDzqy5nXrTiAhLeGp5nch35iQ/B0Y
 tbNSFUhWhTkzyJWBj38OvpUO5gYQGu5Rxh+qlqvsVYPTKurQU+nRmpC86j80cfvLmwyHYQLfa
 KsOrHsUYE/bYO7gOyM1Xnjpc4IQiBIyzsPKLwgmvvvB/d/cRejTWwIfC0kL5jdu8cB63fzgi2
 bGo8mPjfeEF7+rhNeqr196Dt65cjhZ49Q8TDvE7Y1HPjd/kC2GZznaXMi1aHx5xO5RUCFxfLu
 0dRq7xHpwGc7jgHh1+iXh8rkO4/vkuqZz3sSZkYN3k3+PESGAq90vmo+cZfQ1nGP8OQZp7mEJ
 pVxbUfNYMJESZXwZILinSemodbuCJA80jB0jQLBZNCwWOyo8ra44P+3V3H0hOx5c2hAhjhuS/
 Yxd5FnYaw9fzZW1xQgV2mVTPBOlOldt16WS8TmnihXZ0ygh4LR08z752oJ/0k0fKfdhZ64nhP
 G8SKaDOFaL0eqokFP3Yb0AOmzkPwP9UqMsS/Lftgiqn7AUMYxfkDTnFIGvBh5ZNnbrLvZGMHe
 rCCjgRnFbkjNbixh9d/eQHY02lZaW8T02UCc0NUSE9Ycm2HpWHUSewJh0gHMTAWFMnzcvm2K1
 1rFvqCdiByPue82AJXeoTp3h9OxqMlmc27+dl3ajyRAFD6nReJk9UQvg8GmSxqy5hQNbaOpnI
 QNaJ45H7BiqadARaOEjDyymokTxvNgljDlk5wUFBgU/nRmqOSGH3FUS8IAbaGuzjOwyS6CNE5
 6xuWnFO8w4fQtSnj7norXaAkYGygevnPaLvo+I0HZA8IQfytmd81u/CUsPpD+k59cgRzEyXB5
 vVBzPrNUUaYxTG+/n0PKrQqIGPZkuVhQ9hnwGeGYUoqoXs/8L7a99893ml4Xf8l6wbho39tH1
 2NSiEBjsjW7f0AV3HlcUL1OMACcps1VKEnYp0agJOJd6FRy7um7f8Dr4y0Oqt9V2PagXjPlYH
 AwdihosUxD61EC0QFjrShu1Szedex+FlfmADFufSVX5Dx0SoT3FvVMtEFkhP/exila8xyY4TZ
 hB5wEgEQIpKoE1Bp4AzqKGYziQOwEGDicqWsHmQMLUb5pm7GnMpjzClDjftsTQXYcL/7AxD4Q
 QwWTTTFxv6mD/VKxO9aFNZSbhElRLTgE7JLqYOzuILBjUPR5UkejVJW2LfH+28XfsGDm6Z2US
 A6toRrd0DpVnby25aEyyk/0cD5O4/Uoj6l6brg2StNmiqkbHscLRuM4vCuSsaB1032zCu9xsM
 x2PDCEvYH4SLHivce2QhfKw2NINZuSb2wy8AFRXtP9DldgZApMoqzr6t68tM8E7c9d9jN5uiD
 DDFCJbaNyNpXgZI56uusShOWXfUdHgpXm6C49xOF47/RpyjVq/qU8ZCzstr+6hJeFSPhMF+Bl
 U/IY6frbYB9q9F7QqzJc9LooeN8Ah9IZiuUnigbfDQvIORJmLmTwnibXxA9UIqFxDNkTp6ed+
 uouXYiDgt8Evee5Jmt4umnZ/hJpNJMp+r9M8H2HX4WBXEPgXTcyE0yk8rVSE54zfVHNDBzI0M
 Qb8UmcSPMSNgaH/iXlj8RMF4q2VQOratMjg+++xOIh7FO+cRVqoj6P8WcyjubnYrX2OARRwkZ
 3Yy4X1ukmn66Z6Dx8gDB2Dl0+KzYcLIbCu7GSWFKcsVq/31PA8tbrP4KhUcRvp9K6zVx66Z3K
 GOZzJvXuGsOhYwJnsmaEziQWGydl1ygHzNwAYbm7CUrNOXrsFnA5WuDnGThgomYCezGkaGfIa
 mUJ4NLgya37W0BVmEsd2EVTu5FTrbwjb8Pbb60Wpc9XKIsCTBU8QRRDSzDMcMplnQ9rCmkXUe
 aUd+Nh1VuREoLMhm6buf96tK+OJU9W1uLSKVMeBpkXf4L97buwVJT0kA/K86RICEwF0+B2j1w
 oBRPGvGtQ0HQVbh6xIBVbRn5wU4i0UEEcqDWZrFVtnXIZ4s148ckvbRpbVKlBLG6Bbzo9r9c+
 nzkspWD/UbqDX3JgDzomSmyIkyKFCw+HsiS6RaDxdSSzrVbDVVEiJqRfm+0YNOPt3k8EA3Pjr
 ay6xCYdbN3z9//pZRDrjzbaQcX9szvMpg0nA2zsRSzTMOtgKiDIh8HzqUhnIsuLQ9OzklYs8N
 o96nfziJ8TVondGFbYW3b0lPFltG7D05YvrnOtvuPOrrAKf4H4MvXIWAxJf8LaM3f/ElXBC8p
 ecQkQGVQe/npvE7DMlSMSeTLmFgDrmOKRCESjp29JjH/1T2OtS/bwXvNSbp20bAbpGc4THzYL
 +zZlKS6eo+4FuOIKYMzD/xUA20iLW2CRm0SmZUb3u+qH+TQQGh040qWdrYPApyvD2ZEfMTk1n
 b75ZdnUb7Gf+kyhThdG2OWnHD2CeIfzl4+F0stPJviqFFNxJ1SevJ6V2qtQrVCJlj8sPqNM7m
 zbtvziyprvLilBNo+CR2hSAP6hqGAFMg5AW2PYO050LPSvdwm05SbmGMO5SZs3zH7ES+NSI6j
 hxrb8TRO15pydHwm9/HVSFs6sWFHIC0HAtKCG2XzSai4XZJJt6DTBI3ebGXusenJtp48je9z4
 0A9Ny3IpV11x7umcjtynHO38fbsE07RrrLN49mbiJiBU4NDejJrjljVzQQn99RmDkQghasdoE
 duQboj/EcL/sbd82vvVl/eXj8LpdSGuKHP5m+2sh868UrGxM/xN5WW8f4RfKvCPJsE3zPlajK
 LEhu0zUARjACvql0CTYBAQD/OGsfV7HXa/ImJF3BSozdqCYNQbzctpA4J/X5mTsTpnYxJ+gsw
 GB//4INGEtmJI/JlyMn9KQd512aOQz66eDRC1FSGSdA6/QHnDHeMu/r9io07XABC8nGmHEqA4
 4rdTLv0fuOwI/H0Fl2wDkP+1t293uOafRlB9UWhGyyEbl72TIc6htO42panhGAbUR5SZqdhQp
 tEJ7adAR644/dGZL33INe3QzLbjcsgtsRRnu4S2c7CyNcCmXqLGnN0Thpi7lRWUJ4j6FPsVl3
 WhmV0N5hnErlOZMk2WBxHxdDnbtObWr92s5SfIrEgM+OsDRUepD8DNI7nvowWuicdk1xRe6Kd
 dTMMtxM3bK58p3Yzat4ppoLPoNiOBc2aVmoNImEfWzFI2BFG9Y2MPZs5p5Tu/tYuSUYxzaiyR
 Bv6ulvNCJFc2vTKjopiYg4+kFjsRwR+T+vfSvoOZV9lAPmDtLIfMMe8um/hVA28GdlbrSi47E
 VUiV2khrFxIEAhmD8B6kzbeBSbxBNdeHEtiJo0GFDuKlS07S6ebvZw+K8+n2uAmXssdZ1Ekyr
 EDeTUPHJqTjpXnkynly8UUaSG0dzL/8Hhim+uXk35JqOG2s1hETMbwhuj4/XHqJv9V74gfkWh
 +zM+hzPUNyWLgZf3U1+8fi1SaoXzkKS1JPE1eR9n18z/xMtnJZ8sGbmDDsc+7+HMPqn6MDREg
 EPPP5epDdxN2xjTT0Ukdu3mcyBpNg+MXHN9dW4vIQXJOD5RgiMbpL/WOl3yD8hoSxOVkwMw2D
 Pt2MMJnPosSqygC2T4ZMMpOKz5gSzKwHonh761jna5X9vWlk8TjS+MZUAK/85Y4mdBoq2ADEJ
 kxJ9NFdfHTDy9aNCtvf8RrJ8ddd0QXge1JPMSUg0IKBkNFrdtvverquIxPGvdnXBzTAfJ3GcC
 /5v0cEQ61Z2Vr7BY0uTTjzmVvbkB9EecXQm+ozW7sAJK18v3+edKfmUC6CZnY7WoTPosk+zFq
 vNdHldm61o/J4yzyuHEMazLWnUnznYi7FPt+/jzXMvFcFt2FC9WIvEb/bn1ANyeutgXQvDEAV
 kpBADRoVDA2H2lXFSaHy2CF9NRox7hYWX2+CUS5boL+hquyKALup21ngbmaxN2aHG2vXjAy+8
 X35QzcEmNP7CExLUTal2IKOhTUjrpqB6oemMoXf4VWXupqEIZZSDeOvv3Dr/SOCHPU3pC/abX
 S4dJY1cxUB0WFhpREO5iUNTpkBjauK2FxHsH6jX1b8R7Y0cuffWjsfw0hupfm3tYj7pt6kHss
 wJzB8DrBBXplc7JT4p+ata0j87Cw9JJXjd0AajchtbpEDeTH24rVdG9wdNQNntlkTN9M/NHUs
 KwIjJEqxS0FDzJ3umoirp9v1zUCiYLXdvhZ6+xcIAoPJjmQ4i0QcWL6fjvP8xnotZXMRXa21b
 0lW9IIqnr5AUdhJG/wD3D3G28wTuBD/ODt+yaCNSI3UNn9ddkDBO01JfeqgsMOqJKkuIVyKBA
 YuGvZ1/xUFNW/nd06I2Wr8OKzMDDdxpKow73wZRRyWDc5G1kcrbjthR9UTeZTvDy7deKznhVx
 EyUxZcLCL03Q0YzHnjiSiAmE2lG9wVfXWQBDl+dKJ1cun1FPCPrKWTChAqEO4fYscjhrSYbn7
 aqp4RVfdsjO3SaABvRQMP3M76c7kzSFQEKOvaOwKk58TG8nvVqATJgS3cPqnIZi7tkUXlu/Yc
 KmN3hCEYxKXRWXpLpd7upmPAzqNDG+J5C8lsYXtvyt1JSj3pxQIINtS7kpwbyWO5TAwFy3nH+
 56GJtx3gmi7v3G2+Cm2+SYgvAXn1fcwqwfK7A7ln086giWDxSxcBqVGx9Vqq5sJyj/aKygZTC
 AEzUGDknC8mNSrt+QGhN0IgrmYFyTy2pmsMeYP6V86m06BSTQnPAbe8uvoZOYBFPFtdzsDvvr
 r6Jq0fuvojx3fjprT1cWG0zNyZsphRQgL8+SG7nc4eDZPVw/L6jAqGCLWmfx32KDOV//LZTrO
 6xv82Xqte8F2bHclaTVJeSHp/Qw/F/JrLLNv7+PqLBK4TwAcLcRERU88tq+/Ms153bOpWjVsZ
 dGE7s8VgAbhzOl6SD7sbG28W8Lm0t/0cA3urIA2fxGQnud6y4RNoS1im2jsfaF9FYh60Xdai6
 QrpndMxJgPOIkHn5WCLu/FqvE6XrL+E4dPUX4UJOitYTGsvwpu0BHPDnzhiZWI2wfbcbdeb71
 9rEV8jyH1RB2/jnCo=

If --find-copies-harder is given, diff-lib.c::show_modified() queues
even non-modified entries using diff_change() because we need them for
copy detection.  diff_change() sets flags.has_changes, though.  If
=2D-quiet is also given this causes diff_can_quit_early() to declare we're
done after seeing only the very first entry, which is way too soon.
Disable this optimization in that case.

This issue is hidden without --no-ext-diff because then we set
flags.diff_from_contents, which disables the optimization in a
different way.

Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c              |  1 +
 t/t4007-rename-3.sh | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/diff.c b/diff.c
index a1961526c0..84ac148c37 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -7188,6 +7188,7 @@ int diff_can_quit_early(struct diff_options *opt)
 {
 	return (opt->flags.quick &&
 		!opt->filter &&
+		!opt->flags.find_copies_harder &&
 		opt->flags.has_changes);
 }
=20
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index e8faf0dd2e..3fc81bcd76 100755
=2D-- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -41,6 +41,16 @@ test_expect_success 'copy detection, cached' '
 	compare_diff_raw current expected
 '
=20
+test_expect_success 'exit code of quiet copy detection' '
+	test_expect_code 1 \
+	git diff --quiet --cached --find-copies-harder $tree
+'
+
+test_expect_success 'exit code of quiet copy detection with --no-ext-diff=
' '
+	test_expect_code 1 \
+	git diff --quiet --cached --find-copies-harder --no-ext-diff $tree
+'
+
 # In the tree, there is only path0/COPYING.  In the cache, path0 and
 # path1 both have COPYING and the latter is a copy of path0/COPYING.
 # However when we say we care only about path1, we should just see
=2D-=20
2.51.2
