Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79F3112A1
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220430; cv=none; b=S9bNr9X2x5+cWIGkKyn4R6oCfXXBx9MzGhE/xA3fwy7Avs+1Pvvc+VB03lL+YK0HumLzri2e1hSwm1NgdRBUmGcnlo0qQc0KUUym9qnQ/jAs6FwLAQmX8Hvg0WpF1+7FBNHhlKP5IWL610i08K20DpojD1ZcUnGZ6ZTy0tj9a5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220430; c=relaxed/simple;
	bh=nADOFGS+mSROqF/CFXb/rx1udW9qelFTpM+iGspqSHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fIKeq1JW5QlpdOfL0g4zQhyrz3F6/UAutX243FQoBE/AxWwADFlzMHQ2KZfVmm++z4a4Pp8vhaaDr7jCZiqqddrYsdcz+ye1wILxnXhUEKKMxdTuH3lWzdHZiba0apA/PwqLwuH0JGT0ISPTI8D+tj4ZnjQhOhqu6YIm0nOpmRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=lOdXPzZf; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lOdXPzZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772220420; x=1772825220; i=l.s.r@web.de;
	bh=scGKC5fgYS1pDVfL5ChQIOLuy31SQ33CeQFK9JDfo4c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lOdXPzZfy1yAfxVepmRrWyIVRRIYSOt3wefjXFyHNM3KBjzRrmTBZUXRTS0gXwR2
	 dBD0I3qmgzrA43SF7tfDKL//AhoSN0jZewKl37ZC9T9fb1izKEYSrXO4vPJrpTNDw
	 hWA+H1Kv6zPUDUTsXB9fBSAQiAuk5gxARXPhvaZEyrzMmDPiPMsQVqJ/uNRwdMIM/
	 Ym+RXhQq6Qp2PhR/KWSRX4Q9obv2+ylb1iolIjUAlWQQxE+hPe/uRLCSvy2ok1XPy
	 utWvkcPe9+9x/D29BM07uVvNEY28Gi1zIsUXez9S2LmoDTYSpEbNiPM2Q1yvABT9W
	 Zl56v8vg4iEnfnXJQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWsc-1wFnIa2ADA-00Oh6O; Fri, 27
 Feb 2026 20:27:00 +0100
Message-ID: <1e7de0f7-a712-465f-b3c9-5dbe78132d3f@web.de>
Date: Fri, 27 Feb 2026 20:27:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] pack-objects: remove duplicate --stdin-packs definition
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Taylor Blau <me@ttaylorr.com>
References: <xmqq5x7jujqb.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5x7jujqb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k4E4KoMh+So7LBV4xj0CiA6nFWHyrITcym67VJKM2PlQc4i65ce
 0+T6s3G1SM9UYWvAIUxu4Ikr0gEl4omNcCaBviVgSrr9CQU9hHXGKVei05qu5mE/RKsgJeD
 1SJzq9MtH5KzCddXfjrPeJt8a8cYAI2qw+mVMmPiasfZXMdPsd366dB2xwQwhmPXpD0hF4A
 W3PnWXvEUw++tjP8Y1qCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w7vst9i3MHE=;TewpOajznA+P/kbQps0CtTYnx6E
 qp1+XrAQwjIRAj1KuKdDD03LMHn46FtUMF9TwP9BcpnzKjJ+wfiJBRdo4A+oFR/Rm1FL+e7vQ
 HNs6m65SHUsvWCXPqdIXUoHZI1IoLkJMJk4uxUTi7Mlk8BAlhpFvJcWe6IO8/yMX301527otH
 RKRTVMVf402+9vpjWQ5utM4yi90SZK+tiinmImJGXdxjuka7jc7ysKhcCvLKbDsUxq5LcI4/R
 YlQJCNhcxJrEyivCsbv22PDGRjv7kyUo7bJ19WUxhIlg27IHMmjwisGHsJPguZ5DAFCzD8J3W
 H+rO5FA2MgFgJy+TFhBLvPPxUkYQJEQAVqamwf/NAC1REXnCUB8UfJ2m5TJoHcp57Zk9QH2tb
 dRE4Pm9Q4f7PGPw5PNFC6nv1La9oy2a2iKS9jPQG68FbYYVOOhgoQrPPux6j/ZshVUY+cLEmt
 nnaDDWupgW28d5VhwGimShYYIKgxTy/gsd8t0QPf31XtwzgaUvmYixJHlBAaGYcEX2UgcXSQ4
 AQP8t09/3F7lfHPBJi7eubLjSjR6FGEjOg7+qzHgscSZ50QSU57pPDD/bcho9fy5m2DiZ5Ruq
 xd0FjCnTKNeVtY7+pweD6PcD4RX6yn45Zw3quUSFWs+9tzuoYoCY3QaURxv85k9mxtl+3hQci
 h2mHJ5fuszEd7M5x194amS5vyaVrTDfx1VhzoeqipWUlG89n9l11/13yyvGKAK56UPmRWRSM+
 nbuYAz7Wnz52tvJCUVqnw8P+rYOo1yywx9iHQl9zgBPKehBWDGXfokXhKfUuBU/KXOPdAkA1R
 7q1d2qNWQrZAET7YJZMQQUQfZESYmJNn9/YI0Lsbxv0uMcdE4DFW+XAx1IVY2H7JXWpHpIDVt
 Gg1/t06rfBedeWuR95q9eP9YikVf6Ji50BdlbswzisaGILNO4Kl9WbJusG4w8EAoKA9cpBoPW
 wo+75DzBOfIABuR+xhzBDnvubhgWwe+tFUXzNOpvKd29VSkfOI3Ou16qWefAuvPTvslgCpcrw
 qHEkm+ORVMd9szZUxbWkBltiEba+FuJmYyHkVTG0zbFsbgSzVBlxFQe2Z0DiB/mmA2k7U3h+u
 Nlw/AdMaIbB06KkbOyRMGxhOxt5yCvjfDTw4e3G05RqLup4ad76jQNGcasO8NUY6/ZxrBjSCI
 LKpPYVgJ81V3xa79G76hYtLK/rN46/oySeSPSGtf6xSqlKuzn6Vb3a5T0sY97oDSwEU5vNiDW
 /c8aL+4qf5vPnbz/eYWzo8ZBgF37HqLNz+kUdltA6P6izZIRykGh/f5U+uaLcK4Z7lMeuk22p
 ICrfnJNx4PrVO6Z0n+cmyHudD4eqfITeFHZPiWXN9Se8UBlc5+ED5SYnug/4QYOMaSwcyPQtb
 7Cojl97XfjYgd06q5NthcdMDFh6AYoGqNnYqSFHRW6Z2NKmU9BYPrN6WYb7GJtNO0yTzJvubz
 e0zDkYkichy+JIBIW9vA0uYc/dnmggGi4gor9r77eHPJGo3pV03TniUUeDkE5tsnWt7ytmGZS
 4eb3IU5Zggf7VdZ7lX8eGnn/CYCbez0VlEui+0py8lvBjYj29SZzGUufrmHvEF+iWkIgAKzZH
 UTWb25sIkmd61c5OK//rhAkrKQq+hKhDhSDc71VFvGeGaFh5KxR4PN/IVazqAE5cMZICYbFpG
 Czc2OUFvT9NQMBQyJIBnnSp9ObXbVe69etQpZ9GHLbX63bCP6vuWvBt0j9c2N09xz+vTyPbDa
 0THWzwQQOPCLK/ZMqJuHv/wemuHRHIPfxu9uP5IklD86Z+KMV1N5IM9tReTO5H+LAPtv9a0jm
 uNe1VddoCz+WbL8OfpjnF+9UI1XKJWdXECFXYBpdHipioh+Epr4BnP2Cu2SmfblTDKnc7UZWW
 DzDQJCQ4dAoMbQhr9zsA9oVVxDwH1DQN78i1IOGF/9Cx7VKhUJiY7MTHuvt3MynFZkolIYczk
 HP1X7tCiIbXJvXSZ1PSmAWhzMfSmyL+e25dYlIiwlEziV6MHWrTzcuvI5bo/VjCSPGN6kaC/i
 Rpxff0dn0+7seCMFP0in1UlmmQtoKe8c6PxXAdtZBZGrHv+woIL413MyAono7jz1SBgguz2MF
 PxuxFBUZq7E5tJXPbsnWg+Z4/uKdBWc6QWF7/3UkBv6t9974n8oGoozDH/cacgogzvIGFmlqK
 +A0dWvRSJtEfzI/aWODvuP54LI8pdwyLGvvlfFhjzLHgQLSN3BCZdFLhSPonHnA9GLZBQtEHw
 tNWa4RxyF6gfTHXVa3RXgLG4IBbnWffBAi2r/zC4zragDCh5XkunVt0FfCBzKBdfw3PL/hHw9
 d+EGDBmPHPzaPaS2UUmS5POSOR2R7to4lVX6mw23rxAwWglc7YcnseC8a8Dm8P65JLlGW4MJ5
 0qTSjbImQ2P8F9U7KdZhphJj8mcg0ab5K5FWQXAR3ZtKUSpYZy7jaJNrXAlIVQUopFio68liK
 V7J08xeEkzburYch2qZDd40KjOJ2v0AaOdQAPgEgESdm3dGtYeAAHb8sAz5/g1XR7QDC7Lm1U
 tdc6Fp7JUuV9QcMKK4+qCj6egDQbcwY2cVp5vdcC+DgRK+2VPcsqyRaLD0BttmZs+ILrtcUHW
 chP6FsFE2zRB42WXHSP3gktPw547k0TWcujFwk9FcMgA4k9Bk3KNn+GtKz4S3JKEc+Vo2Lahg
 DcWuW/gtuAoWWU0paUsVYvnTWj1fqT+6xW8r01pBNXODRXeA3mFrI8zB5bceJc4Xrvp/Z8Mh1
 DG0BmlbWoiD4X8h0g1U3emo2LfbemvAsSV5Fa822Xzgsh7soaXX+2e/g5lfvxS7wuxOPnHT43
 iBO7uU1Tbr7+hHcmsi0JHNCdT5fq6r1oLeeVGrm0Oh7MxJHR9YlkGLTdVpZBodwkaQIM/BX0L
 yq/IzDtVj7u7q1AvyokY5feFM5xUAwXA8kzarLuYTnr22QVwpobnPguQvqLzbdL1c0byNRS19
 qW1wx2H7FGuFM9bbLjJ7v2Osrf3B2HkjNiQsBS4HVCjW6X9phKPiVRkhRV4cpIfVEyPZKvIPn
 vNtFO/t49OK6uN0SIaCdlPXge0mOs/JCWtG5mne+Ujl16+UIOGE0etuh6/o8ovHEuUoX7BFkR
 7OkV9AF1vGWMu5LoMbEcLhoRW0vp1ueaKdlDPwLt5zei2qn/JNdLul82xGUtbGN/XG/zy5mSa
 VnNdhk7xGwnWlkQmhai6e+irYfgoffjbZp1et1RVEvZfLhFsYtUWmlvRz/L+O+DhS+yZjKvV5
 e66j/88epEzXOJ14sW3+Z8XsCq6cWEuiEGLeTgtnGE1ojjl0jPAoBFnNZWAiA4kqar4b/YOAo
 MAVOUomEE/oek4yAiWBamK2Ba7K4KoBz4+lzolFpvo2MdK/Aq77pyw2EkLxmtBSfz3jLkzrGe
 XEahMyHlZKFy3wSw5M7/TKdLcYxxZSXm3fCCFo/zq0U/0Cj1xocPuV7cWrnJuLG0wfkWkxTec
 M74XYe8Hklh3yI6uiDCi+T4nyASQsr7EqW5IRRmqprUvIwhoEZ6qhJc2pVFo/dorkSf/uUrto
 AWOgCLZ12y6Ng21wT/cCV1MB0KWoHvojQnLZpYmxUfnmNBGGc0IKOcUR1GkswKy1fiyQpMJ1+
 uYptDRwJvbs88j2s13g4f5UesVx7qBbtY3gjVCAdGoyjwqP0Z1/GbpRwIm714E6jRXdz4AwRv
 6lnGnsX0by7sVSVILr04d4FTeBDlHhrPYyRYqKrCnv9Sr0gPOSVWfQbUBdP3Ik/mTouKD8eTS
 QsjSwqXwzCZrgYDFe+XQMA5JWbCIPWqSXWyN3hvU9yaNT0EPGNk35I/Na5JlDAGWcSeAxYM/E
 dFMQpd4sKl8lBX1LSbGrR7C9qKHuDEVgqK8muPwASRO4Jojt+slhcjMbsFzR1hfvGZTKaKhf5
 7OMKHmFijWB/3CKdV9fL/9Wo75JY4CGbiNYTPlr5S77VC+BQptAQ/DvXBkDSF+MclfWO93AzK
 Bt3ZhGOcKuduzzcgAGEwJewoiOOSY93uT+57bo1xA3UgRi86Zs/JEFnJoGIylpVuhGcGHNSEt
 TnMJWNrIBTd0hgIprsQkuWzrcebaI0BiDFqlysjTWksl0mzV8y3sh59QA75SrOPGlt5cU/FPD
 EVWL+ANuEe/VkMCs0GBAzEZUTr6KBCUWhHOhtimYUYeEuMnYOOQKoN5RNpdi7qhOzna/rViij
 DAWOle4UK4FHwdekV42+y+bOPdEFl2G4TvwaRyhKb5GV/wHeqtTimZ/AUDT2rwxNy2vn8Gct+
 6r5aVnHkAZOIsUfPI/w1bZ4XCgZd5UQEZPHg4zRCbpdNOfyk46pfxrOzJ/P+VjEjUIf4St33u
 vwNor1TGpMqz1AcM9oQ/uHfGdXOPbGbDxVXAlayyf+qG/bJ3eCaHGhu8kK1QpF49QbvWqjXMb
 17nBg9QsbKqdm84jZ3MhZNJ7+J6SDnAhbtjDtuW52XRGkefwmynRgC8hIAnrQddnIcLZb9qR1
 2W4p9Uor5UkiwCPtE4/s7Dxxv3clN7w1lSiKDF8GwvdF2JQxyQP5qhYNXk0BaE7eaMgX0RRCB
 Vgt+6SQqj+OtSi/N67lt2k2mrYT4ltpW0htAM7uYfT71mTjgyNY31dJG1Gk2HYqf+bABKNwvj
 ypVsSJo8seoOwhJR08/3LGCVtLz0qRAWX36yg+OVdkUbSO9H0hbEAzLkjphknzExNAiAKl6qd
 8tFjaAsqPEs2s9tZSNi4i7uFacVIdDCxhEB8s7oudBd0sxjdWZ6a+vePJdTBs5vtZltqttLdu
 ChyEuJW9aUWgnlcWfWa3tjaLfi2Bz9Z+1wD9q6mOT8jTg/ff/oZJMTFApf211zhzfG4N1WVaS
 slr/BPmfih4vzOXCfxeobYuVXUoHJyQLsQIuZ725One5ZyhzlnIMOjSXhYONs/8FOUZmquDHu
 7ZDWQOUCA56c6181WI1tG71SCjTHE70qCqbhmNHR68nE8RH6sY1jvaTaEN4rTNCtKRxodmtWX
 Ltm/BcbxtUL/IdnsWtbVjDql7fqHFJLmAXrr1/2IDCA3jW2Nbp9neoKvdU5/yiKKcp3k6gQao
 p/K61Gr2uo9hBW2buG+919AqWUGRuVBqeWvHOwV0JiWvAA7gEiRkuweciEO3rF3ZRISGZL+1u
 Y8nLQZIVEedn7ge08MUc1u2f3FOdwa/ntdiSg/vEJ05Sv5voujpQHJsxwydFax7GAaS0GP9qD
 FWNwT9FvdmFTrtVGOU26o3FiX1wOc

cd846bacc7 (pack-objects: introduce '--stdin-packs=3Dfollow', 2025-06-23)
added a new definition of the option --stdin-packs that accepts an
argument.  It kept the old definition, which still shows up in the short
help, but is shadowed by the new one.  Remove it.

Hinted-at-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/pack-objects.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cfb03d4c09..1ea823f1fb 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4939,8 +4939,6 @@ int cmd_pack_objects(int argc,
 		OPT_CALLBACK_F(0, "stdin-packs", &stdin_packs, N_("mode"),
 			     N_("read packs from stdin"),
 			     PARSE_OPT_OPTARG, parse_stdin_packs_mode),
-		OPT_BOOL(0, "stdin-packs", &stdin_packs,
-			 N_("read packs from stdin")),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
 			 N_("output pack to stdout")),
 		OPT_BOOL(0, "include-tag", &include_tag,
=2D-=20
2.53.0
