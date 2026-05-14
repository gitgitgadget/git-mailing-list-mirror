Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736F3BB134
	for <git@vger.kernel.org>; Thu, 14 May 2026 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789606; cv=none; b=CuX0Yd7JvSM7DczG70bVpzmFpB4u6fTj8rktzLtyYkmfv0phWsFNqqLW4EZXCo1IRZPDvZqih4w8NgnVKtjyHdvPfQB/5k8OM1qa9olM9di6GjCnF57gUMSp0jaMnHGk8dyfhzGRvRp9lfNbMpiPKTfsNIK1R6olqp7xXgEvKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789606; c=relaxed/simple;
	bh=AntR9ZLTOoIMny+a+9QtOQXBZdzW3zC7JM79JB66DzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoSV89Xd+HdfZetBNwjJmd2U/7RqdfJC8zSkHVaOchoECnW+i1DLTQLRD83VXuxuqlTpLdNge1se6Po1gEshS5AtI6RNVGgKLeYv6C23LREphcc9qTflKql3FW1e/fUl2EiswIAOo2fxyvvpRDmNmz/uRT5cwlxc0QGW6cnWjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=E5fTol9S; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="E5fTol9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778789600; x=1779394400; i=l.s.r@web.de;
	bh=6o+kVcszjlldmnHHqTZn8QNxu6aN2OZqejWCdXT7YZI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E5fTol9SSBH5GbOsfMM+N2FKaKTQAaRX6pu6vjHcXGirRXQmz2ZH45l4vqYbTFFs
	 3pFKYaAm2B5jzSJhMKQmsKmlV7O6VZcZEfwQXFRqdN5j3fi6CG8fAfkozjk3vur0i
	 E5pe3CJ++nzSHQyrCif5+f3sOxmpIrxa4iQ9gJ6MJYII3HUaR+urgBCgZVw4vAs8k
	 lvvaY3IU3MZWTrDMpUDlh6ZgE1R1PYz33YGKJWjAGkZQMXbDzDN4RMSKwfA0xAEr2
	 G+qqKLUJLMnIaZw87G3qBI/UkYhbdrWsoe7lxgcWx46E2d6xViOQmW82wr1VmJind
	 CRT3zie1kAJrCbZbCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1wO9rN404s-00ERPX; Thu, 14
 May 2026 22:13:19 +0200
Message-ID: <0c3b4e94-b56c-4c92-a4d8-0e4364f1257b@web.de>
Date: Thu, 14 May 2026 22:13:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] strbuf: use st_add3() in strbuf_grow()
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <xmqqo6ihg690.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo6ihg690.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kMuKzN9qBjQuOK9Sq/+JRSVNzfkoKf3nXywSQlVdE5gF3qUa8BK
 +WJTczZ9AiY64PB2D/X9PsbeFmRvkjTvigLDpBdMERnT6suwJremLpWbw9b/MYdF9tn9iEI
 4pgpunzWwK30qPwsih4t31HM2tAfWhN9goSZEZjDb80oGECBjIAOHneZtTWsVSsVu1PvVZi
 ZJJ4yiIutEUbqmuXYE+EA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pOUMoOCOjXo=;pGkgcdjEy/qeWRQ62+7c10EACnc
 jX3G+GNhJb6yJkyCdBwrxxWrUaCalqaLzyhSgDdeELCgOV9sNWXeAJPUdpobtOncTmiBLfc61
 yezbYlhetMkEjxHONYBRBk9AclZeEQTmlHm79k9r+LqIvRk8FHta2PMBFSv7GW8T3WmktdhjK
 ABkCdW4HTMFLZTW9OnegxGFJU2hOJtrjSA5tZpINYQyWIIg/NeWxIm1npx9xQX7I0Ij4kDr7O
 PErsut+p8yS16rBwx7fy6Nocm0Ndkw5HyOG459LBMFwCbM3C7aPcXrsHmjd2lR5BSrtxCrRbo
 Z6SNTsnE/JLKuonya5Li95/N8uKH4ovZ5JAkCZ3qy6bxMBokZ0Lk/DvDcqpsmdjfYVVMvGaE6
 kCZrMJWL724/AE/SEVS5Lhq34L/bP1ua0NKrbn3HTX898cwqGXlsh4vt03en2id1qO2YvFFY2
 czLNuW2pCsmSpfJkcBDpSN5+Bzi3IxAbop6SPhSdJ1sD3ekx/mjBQDLUs7hWh7lBJleGzP1fD
 paIj1OSMIu95mmfDLS+PPxJQCsp6zPPxEtv+W+hpUTv1c8JJI2Z5Yc+Rpg/4SwDKEoBbtEK/r
 TNkIPK+dQbu+gf6vjPOTdw5vd9P8DidZgs3qHsLHCq4gA+HR7ZgbFzB6Vdu0R/i4X41iHFin/
 9iTxshZWlb90kc9uGCne1M9L0QCmxjYYJETJUG1CCRjpWplzSDD32HF9q0Iz8sY4yzOjY+IWd
 4/1m7cTjXzuLUcmALoLQNBthYIM03jLzEswYee6vzxlzRNoOHgCM3QxWBjRH73PiZFCfslKma
 4XujzVKtIQR4vIHqNtXjB7V8upGpdRoDytSzzWZuCXK8qdNN33E2L0hRgTKLXBf11TDq/KgrQ
 uojyCkpkH6u6k01rjVamj9mEFn9sagCCZZhYbEPR2AEtoRUeDRnn5hvFLutaaRXVFISuRVAuo
 jMbd4BkyDBvNxN2SZRxRW4JM0ON+NA1dn1XynKjIjNpraNERz+P/05N8pY8dT20ZaobUE7OZ9
 cLGd30W5jIT71FkhZ6kZXtepUlcGFA9IDypDC/0NFClP/JvGBAAFGmRLY/mj4hQeErWaOUgEx
 iDMd+Dsg6DmMvNXu73HXoyV2yGnbOa/5AvBQGZmI35c4YfYpyE3wVIwmOBLS5p3Rz5duv72m4
 gEelz4Kmo4ftljn85+IpV1HYvuRZNJ6X91yX40SbJbMfF3C8u4Ej+2ykqJIR3gUN1uGWZryvh
 u6tXbdHR1vBvxs5Pi/qCW0Wx6kfypSbEs0BordPV1lvZvz9iaZ02jrZUyoud57RWa8kMog/Qw
 o/Mne/i4zVRIkqtODHkCdJuRIBRkpE6wOg6iP0ZW3LDP/gPnR9oaAh6vcYMpXQcO9t65xUPrO
 n4ddlj4QkVKqN0Yfc4/bo5nIMgW9Q+WtOa/YJh/HI8c3d0kIx52Ld1iWKVyP8AtPOH3NcYo4u
 pN/glSvBOiiqArdbDLVz2f7PphA0+/SiUwp++Mro50Z/Yx0H/H/8vg3NQuHdAS4qorBMb4R9w
 gnMzmYoEiMLYEfWg+cZMwcdrQ5INzcpd+E/76hzs7ELjfmIlQmOBwHdBmmtjj3TmQJHl6sFiA
 y9e4tr1ck6SSA6Rio4nZrUrP1iyPqWWJrrdA9j72tD+Y/ROCyCV0SNPC6jjFJZ5xNfK7QS2Q1
 AF1ACrTLRMFoxc2fkMq8+0AbIjOvUwwMqcWUqob5huafNgBU6ADPIrnC7D1bfodfYRX6sd2OW
 vGZCdeW8IBfTz/tLFeEmp+6SPi9+huu/n/spqejM8aqNBHnbwTTKpCP6yDCIgpDPXYbhJyFcz
 jWpz+DosOtqPAlP7MhhTg2C3YIizl/G8F8PA/RfrZYQBuRGN/GzlVZactATiBYlWwbPvYP1+V
 KxXgto2JcctRmnBrq/AHbfa8GZQ7c3bZJcsEIY+m+3FFmsubB55FnRS4KXOqXUmgmSUGVGte6
 0aC6xVH3CymhOzL/SgKbwzwTktQVS/exYysSafetLuQ5qiXDEMcws7vJq9jP9axSkiSb0Q38h
 cF8KLmT2pXvvdk4mqjiQkBzef2SAJWq3P58R/bdu55IBdnlo8y+Rm7VN5+qLfA8uE79RsmI7R
 6PrrXG5WJx4RYerwAvNhUfpqoC9FJTs4lv6oF4OfU1RHCBdnVc6z8glFK0l1pDFxrCeHEFArr
 pwJ/4UaAUaMarJIaHXJCihpWVc/FlzzyttexXHzm7qR/nzhgvTpFZzfb9sJBz7yh8LRNEHs2F
 YfUyldZ3RIpGeYI4Vc8HsbQVBDJ/nkZPW41R/57fHm6qgHPtAj2cYzfI3VgTcRSXNIzA/e+Gh
 sxxCqD1CZsbskz9wj4CgcRvfrVU3Q2B8qhMFv87mZwgxqvhIjGR3MBqIFZEdkIR3CHr0IIR0E
 1yEV6oM5GOHuAx47OxV9XdF0OYKs2glArWxQfRPt85nJAbw2yv56z3J8juuiFqVjjYTUYRxks
 EEfIe6ehRncYCA3MMiCvo53DzaUHG3apH+BHHgjR3QhbGzWFlqYbeYClweb1zRG6FWAkTcemA
 bK3d99J6NBuQXnCEeI4txtreQhejJLcUj+2l/SSDhFnQmCeQftN1YKvLqgxx75CHREaN451hc
 vtsvBUEbxsJTt6G4B1XzL3mHj5UqtK4qsSGb9wflRvLR/axNfGhn8RXyvZ14UcyjsdP2FmHUO
 36PBCgs6BB5rv8I+Dut9iBbOrNk3vsiyyOMVAH3/UdZdf9fwo+Q7Uu8oQ7d+67uu0kt6n75Qa
 hFtzmVc1reuGrrMYpkHRDeU5TPr3NAEo3k8AR+Zv/6tmc7ASHhn+xY0utDhYy4qHXC9JLyi71
 kvGdiD6M9w6facLHV2Ry8nxVhKFEDyBW5PRQtSgAf8VRxGs8y71dsHoEfHOTrxqvSO9e9jeO6
 7arxhoFIfcE76r2q5CdBqD3zYLYuLzKcRgaJbE0qJ9el03XnlhyapO1MTYoQoNSHl34kCEq3z
 RJPoir1LV9N7eQJUGKuVt8oVNXEj6/Iqzxyf4RctjIzNviB2u5yMVYAoteZUFK7mOJFexsllE
 6MbXLyAHjuQtWr5wXLVJZlQDGm/siXj9aPDy1xFbORjJSCcoSyMlo4Fm21JEAGAevupqt7u9C
 5cJaiIwADadRqwjEKhQsf9BGImpgLjPD0yCEAUEAdesYnEfUPQAHToYx3fBQtxP3OSCDKiTPA
 KHZEhrsXsT3eFryuigpBmEOjrYspZghwefPqPZKr8sVau0E5JW1Fz97nGJlBo8mScnzyPR/Qj
 8bWJiQkcGqwswLH0lAvJks5IUsqXhTs3TqLS54lEvMKFWJW8LTkpMAVeX8695oFw8qRC05BPW
 FlySBp1Ll9jJbvM2mabfHFbYruFekEPu+nwkZ9h8BeBq6Zy83jIvWFjwyXp+xupbC/QDyE9B9
 ZFWPuVQuU/sMIZqORXSJhEVVqxa9YxG6E5VcfbB4JcAzSRD6kCsaDBF1SawTBvzBIp//9avUQ
 FgQYnn/eANeyrCSjPCUeYO9aw/YPtEOtKhAk6ahjehFXWVvBV50IIvQAT2dG5u7dvk+LSb+yP
 jj3UOCiFDuEhE6GNZmY8JD5OCFm7fZlNgOM8Rs+mJstg7NJtdkK55hfK6MblRW7GGdXG/+hIX
 reia5A1R0T4gcY/gHMuEn+NB7AvS/J2pmz1B+6UbE6LpgQuvGCZBmYW4noMd2kcZ2U7pLDB3u
 8uRshc2qXsuRco6qe2OWSKvUmRLwUDp7C/dS9aspAFVK+SCM0o8Nz5JHIbHDK8yHRkyMmbXy6
 t5kgzYb0erafBTv7y09EbswlAQWSGBnMJXM+tD7R89w5WPftBiVOu+/kdSNmgLkP2L8yfjCWz
 x+sZ3yw2jB2qsSsQhZf/lKbnRTm3JNE2/akOdwQ76KxDF04xImMCJcrQD6/RWb9wS54PRVdeF
 dHmiNJAMo9h2sq6C6IRVjpjxHxKtO5yLYbYpBbhVrkbIZrhEdUEA5uhmfIKTgNSZ9yQGbxh/k
 EVuDJBmoxgRTladyjWic6Sc0QCp0Gzir97wUjM04/+om3OBzmT3w/RmCiVUQa7SDjTIYOxujC
 mpolZOm4ld9L9PnU+NbU1vz/VjRsu0kfpxYHORcRMBjTCk0dd6Kwe5fYRQ8I2eTFn5F91HPc3
 6/Qahzq/quA6iUXRLIypK+M3BmIFzY0ww3ZeHUl8sama1puj42KvPjoxvsmUMdqpu3C3xWnnk
 tO8X7vAODxCzGUvHL5qkRqi6inQkWDB8YJ5zgk2rc+KQaNF3JNXr3R4N3pLbHpfjcNrRtPqNN
 qUEsia9KMSPhuUTTkOVov0v6k3XfyXUtHnIQQK39BP3OHISrsk1TA1tiNxMTG6Vro/4CEzIwX
 tQ/4sjVYLixQ6wILSIH9Cc5ZYyvEVN8bqxFtCQodSAzGa1PP9f6pXiyAU9/RsMsBVHz3C/2oa
 N1I+w87Z2dwfzCUOyxRoNTnU7DWAjom+XiYUfEVY5MlPCyekiowLAC8go5dQlocXVIwdIZFhJ
 nxxvBxZtsrMjCcHiA/CWsylprCAE+Vl67IcB0o2Jouda1LYoIws7ihXSH+LrMysd00/Dr+0fN
 BFDCd6WPcpj3+4IaaCqB4IEPdNSXFnOWfuSLP95wCBDyAgwb+hjgwu4dghZEozHnU2jUxMYD/
 lnj+x5RnOSYw2mHIPA9nxxU8TmS2frRq7fX55mmj/Vm4449DY4UxQ+BDYfLiEibCDQukf+vEt
 S9iNeZx0h3T/dkpk255okyUnS99ApA/3l9vhhtqWeRZcPIE0q/iTKSoI6SONIgDUp9u2E42BP
 zSEOTh0LZiGmwV/rZMghmplq7uXig4p7cIGUs0dqVtyojyPkW71VEhTu1yPfOS1iMB6cMwywB
 FUb3Sujuo+bwU6/jZIoo3AC1213WNtzSCO9IQlj3DriXlcIWx1mo7O4FpqrJa2VplXRo4l7y1
 yepd/Rgp2Sb30AF36hTvtrEXJdWJWYfb65XN4we/B1SblXFLvPxtjhX31jPOD23OFZsJoe3oq
 kgTG/ItJebyyHa16X89TiOMFq3WNZjkqm9Kp6nJdBP7/hY7oxerLbBuzFFHmN4w3F14NKxRmF
 OgQ61cOxae66p8eX2fGff2X6CPG9A+4OcJdS9Slb80eJYDOJqLAXTYvJFNVAEK86KkxwZBLpy
 HwKlhRJiy4v4CAgdSov+ogntsObIJdzvVSJuEBdR0VOSvEBqwr7woYFT8p2HntPyahzDqcMAk
 ZyG0pbPvYmuFD+T42Yk4eRnGYFDV9BiApaBa10nFvwrrplldCc/BXEQPgG3Yv8sH3dDWCm6V7
 SDDpTQJj2Oc3Czgv7gVqXL+QujhE8eB3I3TBzcHc/D9KsSZEpbC18Uzax+yLLxC1u+KSWTrl6
 4iFebsFmNnTks9pV4/Ms1eZxW1gO5hbR2MmUdXEYjcbXURClI/xDoYRBCBg3UzJUY89AycG5w
 Vzo2LiW4UJKZihMmGdI1yCM46fxlvHqshpA2hUuz6zjrl0/33KeHpXafT/tDyUkRVMzd4pk8+
 tLH2YAhODUD+WKw==

On 5/14/26 9:07 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Simplify the code by calling st_add3() to do overflow checks instead of
>> open-coding it.  This changes the error message to include the offendin=
g
>> summands, which can be helpful when tracking down the cause.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  strbuf.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/strbuf.c b/strbuf.c
>> index 3e04addc22..bb04d3910e 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -106,12 +106,9 @@ void strbuf_attach(struct strbuf *sb, void *buf, s=
ize_t len, size_t alloc)
>>  void strbuf_grow(struct strbuf *sb, size_t extra)
>>  {
>>  	int new_buf =3D !sb->alloc;
>> -	if (unsigned_add_overflows(extra, 1) ||
>> -	    unsigned_add_overflows(sb->len, extra + 1))
>> -		die("you want to use way too much memory");
>>  	if (new_buf)
>>  		sb->buf =3D NULL;
>> -	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>> +	ALLOC_GROW(sb->buf, st_add3(sb->len, extra, 1), sb->alloc);
>=20
> ALLOC_GROW() being a macro that references its second argument three
> times, doesn't this rewrite rely on the compiler being clever enough
> to notice that checking for the same overflow three times is
> pointless and does it only once?  I guess the original has the same
> issue already, so this may not be so bad but it makes me feel a bit
> queasy.

As long as it has no side-effect (as is the case for addition) and we
keep compiler optimization enabled we should be fine.

I guess the reason for having multiple references as opposed to
loading the value once into a private variable is to support arbitrary
types.  In the end it needs to fit into a size_t, though.  Something
like this could bring the reference count down to one:

=2D-- 8< ---
diff --git a/git-compat-util.h b/git-compat-util.h
index ae1bdc90a4..ca89cfb0b3 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -812,6 +812,15 @@ static inline void move_array(void *dst, const void *=
src, size_t n, size_t size)
=20
 #define alloc_nr(x) (((x)+16)*3/2)
=20
+static inline bool st_alloc_nr(size_t nr, size_t alloc, size_t *out)
+{
+	if (nr > alloc) {
+		*out =3D alloc_nr(alloc) < nr ? nr : alloc_nr(alloc);
+		return true;
+	}
+	return false;
+}
+
 /**
  * Dynamically growing an array using realloc() is error prone and boring=
.
  *
@@ -857,12 +866,10 @@ static inline void move_array(void *dst, const void =
*src, size_t n, size_t size)
  */
 #define ALLOC_GROW(x, nr, alloc) \
 	do { \
-		if ((nr) > alloc) { \
-			if (alloc_nr(alloc) < (nr)) \
-				alloc =3D (nr); \
-			else \
-				alloc =3D alloc_nr(alloc); \
-			REALLOC_ARRAY(x, alloc); \
+		size_t alloc_grow_new_alloc_; \
+		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
+			alloc =3D alloc_grow_new_alloc_; \
+			REALLOC_ARRAY(x, alloc_grow_new_alloc_); \
 		} \
 	} while (0)
=20
=2D-- >8 ---

Hmm, alloc_nr() doesn't do any overflow checking.  It should, though,
shouldn't it?

Ren=C3=A9

