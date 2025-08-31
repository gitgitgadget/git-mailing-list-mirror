Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73204270552
	for <git@vger.kernel.org>; Sun, 31 Aug 2025 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756661440; cv=none; b=N214XbrzMuGakX/UbFyhiaImJW5UkxPJfQyyxiciv6SokETQMKCgZZEU8CE2MnDM+KleDOtZmRtHhg2+pGdXMF/wfgoqtOO1s+m1r/a6MLne6s+A3CUWL3u9tshzpkkqpze2m1gHOpZwYF43GdacOdB8r3C3cjHX29MUR6KLHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756661440; c=relaxed/simple;
	bh=XI6bz46VdPofn6U52EWXWeTecaiYw6NrNSCVQkbFAII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1bxnW4mTBR2/N2KXb7Vw6OLmt8ewT+ykAigYFLJ86euVpnyhiNaQiubopz5ZzKjo3kATSXRShFLCTYkw+z/PRXPtnP3kUZQqkdUckiCTZiihLCU4iXwjJVRuVLOjOWeQT8665nO3djIG86uXg1SCJxE/ZkqHBOVQt1WhlETNaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=UVv0U6Wh; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="UVv0U6Wh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756661430; x=1757266230; i=l.s.r@web.de;
	bh=nSHsVz17kPOfxoO4duRic2279tdHN4PbOgK2BRKF1rc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UVv0U6Whvhje4z1loG9Z3r4vmkxo5ILVIeak2qEuSx5b3zPTa0Ue8Sc+WywGAmaY
	 PTieR98QZXPpne5/kPrz8Bu/QFy/zky/9lXtp1ogfZ04X8eiGmu/texdr6FT2u6x/
	 IOyvgOJEfoHHPDbVBEaQiPfEx9kdHmbQzx6P0a40absfWSS+ko5xMtzHf2VBzCQLw
	 /ttru5uPFbJdpepsdqXpK0yppsl/0qPyr7En785JgnkkN3WyDQ7TvbUV3tBeYuR8m
	 rVXPBTmC+Ry/FkXGAhfmwnIoi+oZOIotnDN0vzXzpsOZX3LmIGXeK/iJEwB7p2I/7
	 wsTXb5l+34Kxxm7P7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1ue8Yr03Vz-00s2lz; Sun, 31
 Aug 2025 19:25:14 +0200
Message-ID: <cb192b28-d85a-4866-a312-df4408cae93e@web.de>
Date: Sun, 31 Aug 2025 19:25:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250825073403.GA332447@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/+c8Jq6tnXLCmf6zasBIBmlLSu/7w5DGLy5L2MqFvSfu9kJkcTO
 DSvdjPYxt5FqDlmy4u94vQJEyUtC7nYPQeFECQjRUh6Gas79MVSLpEgdW3Db76YjX4duneI
 C+4l/XmgPVW67V8Qks0wZC5EMxKWNXHqUb3jKtHn55MOFHE3vMZu2kib6nLcmDzzgao4yor
 6O/PsBiNWAKbQ+hWaPlCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LxEYO7fONB8=;6v/WZNIINX+5eWG5587nGK4NKvy
 aHxtvAcD8XpTPmlTFfuuWr8ygcF8pekQF5tXSxYqeFz+EjfT6x+rMTAi6CuZNfF49tvidqSWp
 +AOJwVZId5K1tetHQxiHcECFjiw3UaDpdFSSEltK4fQs9BQJ1fMKGQtYpxlG6KbWfgX5TiqGK
 cODzaOYcnZUnVnBTH9CpY+wG8AFc9CejKQ99md2INsfjUtDxfsxLvbsfRr7VJfpWBuWN6AZPB
 wIEtRClaDjB46iZc7H6Vr/QEANT+acbUzmqkDTLmwtD0m73TUkbjCo/JeKAgp+0RB1UkkGyw0
 cuXsdlsaJV7R43von7bSSNkYylla61nkDcmjSBlGQH2t7bzTu6XztxpyDUEYahTYxCX6g4AUV
 Nwv8vgMViyFYQUstRsQVYu4m6z/4+fa4jWCRL345cxGCTpRjxgUhKXyfCrA+VGYcCHbiQ1xtx
 eLCuTBNchvyTbRZjKWv/1k5y4pmG5EGpH0a//mRULCyKZSs2Rb62fMfJlBQ4mrHnhPOC0yQLu
 GHApYtraCY1rg57nDI7LnxXuIgU4mKZHi4kd98gima5drXYTQlhvewZ/+nESZf6VUT6gk+e7b
 T2yiMRMCcJCcFmdN9kAhW0FAe0JWenXDnbBRvLQtaGV/JMmSR7rO2oKcXqtoTB18I4WDityqw
 MKXO9s7wX9Yhp6FE8ePz2LoBlgH65+i1YQJsQxpAwp/mbKj8FC/NNCcNsTyv8eKelPmdITwjA
 Wp8Rp+ZlyUSImXHlS5VwLfr3H2Ca0BS6b8lStVckn4ZP43TVyWRjrKFf4CIr6jc6znQ1mYW9M
 wdFUxaRhdzF5pNPqiO3+NkeWThdm9c/ztC+T4wTesr9T3vDc5FiT0zx741Z+J+AfMe+I4rXx7
 vHl0yua7w2WBi9Iz6U2dVhSrH69b1wRKTcCWPmLF0evLeXC+PnEtEntLi54W1BkVnIBSLjppy
 jE+vSamkXloOn8oV/s5N0lPZPSlkJIbTTp882DBpPr7QziXSbnR8lZGUgjNTpK+b+nrMmTsEO
 bB6iRsdTbP5N2DvMJFqd5kNcCT0AzaDppAfEgv9AZWDGRt3yxXvsopjTRDTLNXRhXfdtscTJh
 mrdiRVc9Ry6afHxKz8K5jLFrCuoAvgfFtQrn62Ap9OyprA073i3ShdzYNkClNFSUBPB4dVMQM
 zUBvhjuEAS9RYLgsYofUwC9yYJog8J6QO+hyA+TMPNIknp9G+jvHGjQR2t9cvQeFMzxYqPK0q
 +vVfeUU89pZXVL9KtoGAp9SPi92LQQ1ix77PKMzpqnkozemuIL82Fj7Thmrk6g2SkwuKBvn/H
 58Gg8XAWS4InLd9BZDdJ+5jsCeIGh/uPpgD/pE2diazNhr85z2L+Q55KLFeoVp9oixGGH/Mrv
 VaD8vL481WkUuQX5HEFOUHweY0GaC2DEo0JUM6rPK6ofad2HwSSe7NoC/ZtJzIDf+4tXr6hSb
 VlpnEZnQHyluKvqgcMIBX2YqcChajxQLGPP7gOzwgDnQ76XCnizO0sAlr0fviCH/aZu3Pj9BB
 OsOzGO02hG9lsd0ezJdvYKgo3YwvoVMQKS0iZxLP735j2pKJwP3WuxgHlfOmrGfl7frUHsUJU
 26yct1tot7yIErcowBuwasf1Rw1tjAwIE3wSJRRl/PzpNNR+t56pFgb7kA68yGeizlUZenaQ/
 GQiZnc4k53WOWpQ1vGSZ3+ZHqKtyw5XLt+X0h7M0Gzj01TmRRfd3nBm+boKHRad5l4Tk8qhL9
 rIiVX1ERs/QevXJ/M2zZNu4FjhJOv/4QVw/MhFg6RgdkEUj3+5sN+XUVWQEsUkwjcpT1PjIBW
 qKhe/4ZwjXEXQOAsKY332//hLeqZKG8fA58awEEBE0n2ud1Sty3OMg/qi1U7vYGDURCBQwbU8
 /jmRGBKErkwJuTA8wTaAa4uPpNAO3RnAivfBj1FZuag7OCoKJoTDXL2TTUvZk1QgnRzPABsgO
 WQSEO+mhvREK7sNYQgPalkDLFvwjJ3iSuAnFJpDEik4+jn15yFiUGEbsddp6P0bMs+OTCjbzV
 d+PZr/cEAtvtD3ds/0fW0tj1nIuULrbxuX0Wq0Fhbl/w7vLTZEowNVM7ZIeFSiJkkoppGEh4o
 9PtgR56v353EZeB4aHr8GIEpbUrrCOZnunaNvQeQUGfa/hjptMlCEGdx+fIwz2VVzNuQ+G7Uq
 TfXKekw95qrQhuimXGnOl7OUDw8mS1rNdBLMdvKY2RiFBppyOMr22+rqSmnV0mW1W0C9/paO3
 4AVfn3gVKhurGOFDUXVGPfbfkgZ5/BLnvujVRG/QFfoda1MYobqwSzEFO/QMT+N8aaDFEMdsK
 Qs7N3o7qY/x2Cj41zPGTZv9uesrDd8E245T3juzZ/mwVZ9ZfVMCbgVGk0dNcuif6OpwpD02eC
 L8Dpjfe0MzdrrIMzVMGyCmcoB3Al1L3OjndGOOc/jW8vu+v1lv6abxS5t3ngDAJXoT5yNQIV+
 zr6Ge7TjTDshIgdjDSG4vvs6XdOZ/eGrTLlAgKI85zCamRVIs/qNOQ+FFHHP+d3k8R9HsTHAx
 jE8APw+jyXHKWss0Pf2skGj+V4Tw4RMB6efj3LUiW+yo8Nx2P6FpwC6q6Z6fthUoD+vSbjIin
 m0JT1kn8fhkwifEbjRd2b3vGqrdhIqsSYThLsD89n7jdkVhh4I7im7xNIccEwu5sMQKzuXhqc
 8iWASMRtBBh/bLTZ7EAjGA2oSGRVYY/wEt0d2rpyeDEcccISD/O0/wjEUrQ+9CDauJn1wPrt3
 woppu6CwRl6WHzJBJ8YuB3fO6wC23gfR8bPlTctWfBUUoJZzJ1oz5bbuW9CynGyDTqxduNPLH
 GpYIKeWvh+xIfmag+loXWXwFFiBFQyHDZNZux3IDWeCtwP3bwFZev8VBIEyOKqFyLVE7fbc/P
 KiTdKQqahdmTBsa6yj7pIFVaJnq+2uX88uCcYhytRoFHyPMQsRUDVVGyXMQ1rZI9qEZj0DQc/
 hjK6ZzY8czjstLFS6zZQjI68AudaOLSy+bQzPM+xYRx2HRjB7Pmtt3HYeFv5nuP7wXUo5nu8o
 VpnsL3TYGYdvTqs1QDLAyP6663jguFJQ666PHBd6wk5H08CHgDqHAqYLw56S/W1ptP8TebUH0
 KZeNxvPNLBg+W7CBDRtAu4qYexQIYjIhE36aGsxraqeo0qImFFg06Br+CteW4PIDgnj88/3TF
 lULMJEOzoFzqkiga4objG96oUIHv/+Fa+p3B8veOgSReqFIPNLDOwK3w4j7/+zFz69VFwhK9o
 6dmIPAW24RT8nKqolIYawLO2Yfj0CuSaeX2zRL94QGDMNZ+HdCvSZt4qIf+YGl1Gq2r4IN3BJ
 /cDgadEW756ms+WMEv1/xxKjQosHylKlBQxWQ3vZhUVGbe/3ItYSR/kmg/8USAmoWq5wWCjdX
 eu52qsrXKzglBR40csi9wXoPqZlRFnQvUZkjnnkowPpSOY5j9BzO6v91wuC/bkWePIJuNCdtp
 bbe+dGC9KPzhhUqsPlXE2UVEHNjWlwFir4RHOcXfK5c4pCEKr/BfFu1gc1TssmPsaSX1EJpiw
 C2CIWMVHx7NFYe9x/TKae8Ql8/IEtziaNbI6OqwxcbCfZCNb9nBoStXOMAhEGvvuIQmxxRur+
 9M2yBzCMT1MciLlsEBIK9KDRmlXLmrtCiLjucAcZ7SEKRi355+0gCLazLvJMx/Wni3j7akR+3
 TEsxxQjufuMDiR9pF2MIjg3XiPoCG57WVPu896+FXhPm4/RIbFP1ktxrFP+E+hbuZYiIiDqw4
 Q1KFLKHoTnx4i79Klu5ty9AFCDNNe4N+6tcFV6shBPjaW4KR0+6Pd9OjbbMxWf7xAx9z0GKJR
 vZk02CUTvrGyQ1HHWqscQKBudKGAtroT6lI1F4UUEjLTQmFhmZ+oL/yh/XlOZZ6boW4Yd25A9
 PaVBCRXqlGLWcoeGPlWNK3G/Qo9jmLt27hxxZXzl7y2Rj76eDAKUzVCujptascSTs1Qdv+Ydn
 /ZOAvYti3knhO4uUWE1gihzdnO1/7AomMuN2Ry98VX8L84HSOKAWuwH4BqPyXstqpBGWYPCgP
 JmEP1HbkbCjDrSPYjpXNkTz8FNbLCJEKOvusuOwKfJQ+m17rfl8VutOSNpKSR4Vv3T8XTUiSw
 RQ19Y3P+c9k8e2aX7b72YBiD/qVyGlLwRsKkGzlU/ZAZ/VYttoL0FCV7iCyitMTcIHEz5VnRv
 +6A9BgqmnY3AjtBrcWUIlsmATFAzu0MUw1+tI8E7S0KWrSTrt1iSSzW8qXofa7XPqCVYea0G9
 Gns1eMfPlLUJu/OA9XJC0sOTGPI7w+VgjPV/iEfSfbFocsCH3ehXjDwxyQStFjYWkmBXmICmu
 F2KLT1vxdkGR9aEJexVkjGdt4wemZotHuGHXUXLP/NFxLYZJfDIciXnp8M/i5bluGqxxZNz4m
 lHx594iKY+yPWf0LtKsqH3zo+8Yt0QOEz/9gqiYoNF8J+6T34AYaKtqjyBmESLDtMIuXcRhgE
 o8JA9mV6uSyQiUzbs9Fjw7XtEDN+Zy/n9hga2Z6GYWJvbqOvDBf3Arwn1vOg/9kDRagTQqc1b
 +7+zCBjryXfGrKS4P/ZMzVJ/TG/0Xn9h0YCwpvVNr3xADnuZO3/w1x2K73tOGhDNDU14G8HKE
 RsuYEPi+PRl/hdFBv6X1kofNPFYwJtQ8WAYVjmkMuFeO9TV71u3t5KWSCNeIZW0dJxB2InCRq
 lX0w2NoRsvuFeYb22yeUHXpfRn2fGz2faUSueMAH9hI5nfv1RagDhFmtyg8hcf3PAryiY0RQz
 bgu7qlk9S76HTZoFOGl

On 8/25/25 9:34 AM, Jeff King wrote:
> On Sun, Aug 24, 2025 at 06:32:47PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>>>> Use the commit index value as a hash because it is unique, has the
>>>> right size and needs no computation.  We could also derive the hash
>>>> directly from the pointer value, but that requires slightly more effo=
rt.
>>>
>>> Interesting. This is exactly what commit-slabs were created for (and a=
re
>>> why the convenient index value is there in the first place!).
>>
>> Kinda -- they have a payload value, while a khash set only stores keys.
>> A commit slab with an int payload would still be smaller than a khash
>> set with 64-bit pointers as keys -- IF we were to add all commits.  Her=
e
>> we typically add just a few, but a pathological history could add a lot=
;
>> not sure if there's a boundary.  Hmm.  So you might be able to find
>> examples where commit-slabs win.
>=20
> A khash set doesn't have a "vals" array, but I think it does always keep
> the flags array, which is a uint32_t per bucket. That's how it knows
> which buckets have a value in them (since it does not otherwise assume
> there is a sentinel value like NULL). So even though its API is that of
> a set, you can think of it as a mapping of keys to flags. So a mapping
> to an int (or even a char) should cost the same.

Admittedly I *did* ignore the flags and they *are* stored in an array of
uint32_t, but they occupy only two bits per bucket (see __ac_isempty,
__ac_isdel, __ac_fsize).

>>> +define_commit_slab(commit_counter, int);
>>
>> We only need one bit, so a uint8_t or char would suffice.
>=20
> True, though that doesn't seem to change timings much for me (I used
> "int" because that's what your khash used, but I think the type is a
> dummy value in "set" mode).
I also saw no significant change.  Yes, the second type is not actually
used in a khash set.

> Thinking on it more, how much benefit are we getting from the use
> of commit->index in your patch? In other contexts where we store oids or
> objects in hash tables, we use the low bits of the oid directly. So it's
> similarly cheap. If I do this tweak on top of your patch:
>=20
> diff --git a/builtin/describe.c b/builtin/describe.c
> index edb4dec79d..e024feb080 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -289,7 +289,7 @@ static void lazy_queue_clear(struct lazy_queue *queu=
e)
> =20
>  static inline unsigned int commit_index(const struct commit *commit)
>  {
> -	return commit->index;
> +	return oidhash(&commit->object.oid);
>  }
> =20
>  static inline int ptr_eq(const void *a, const void *b)
>=20
> I get similar results (actually faster, but I think within the noise).

Sure.  I'm not comfortable with oidhash() though, because it allows
attackers to influence the hash value, cause collisions and thus
increase the cost of lookups and inserts to O(N), leading to quadratic
complexity overall.

They "just" need to construct commits with a common hash prefix.  I
guess that's easy for two bytes and hard for four bytes.  Not sure how
what an attacker would get out of planting such performance traps, but
I guess some people would do it just for the heck of it.

Letting oidhash() XOR in another word would close that line of attack
for quite a while, I assume.

> Which made me think more (always a danger). We already have an oidset
> data structure, which is backed by a khash. It's not _quite_ the same
> thing, because it's going to store an actual 36-byte oid struct as the
> hash key, rather than an 8-byte pointer to a "struct object" (which
> contains that same oid). And likewise when we do a lookup, the bucket
> search requires a larger memcmp() than the pointer equality. But how
> much difference does that make?
>=20
> If I instead do this on top of your patch:
>=20
> diff --git a/builtin/describe.c b/builtin/describe.c
> index edb4dec79d..38ce0c1978 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -287,41 +287,16 @@ static void lazy_queue_clear(struct lazy_queue *qu=
eue)
>  	queue->get_pending =3D false;
>  }
> =20
> -static inline unsigned int commit_index(const struct commit *commit)
> -{
> -	return commit->index;
> -}
> -
> -static inline int ptr_eq(const void *a, const void *b)
> -{
> -	return a =3D=3D b;
> -}
> -
> -KHASH_INIT(commit_set, struct commit *, int, 0, commit_index, ptr_eq)
> -
> -static void commit_set_insert(kh_commit_set_t *set, struct commit *comm=
it)
> -{
> -	int added;
> -	kh_put_commit_set(set, commit, &added);
> -}
> -
> -static void commit_set_remove(kh_commit_set_t *set, struct commit *comm=
it)
> -{
> -	khiter_t pos =3D kh_get_commit_set(set, commit);
> -	if (pos !=3D kh_end(set))
> -		kh_del_commit_set(set, pos);
> -}
> -
>  static unsigned long finish_depth_computation(struct lazy_queue *queue,
>  					      struct possible_tag *best)
>  {
>  	unsigned long seen_commits =3D 0;
> -	kh_commit_set_t unflagged =3D { 0 };
> +	struct oidset unflagged =3D OIDSET_INIT;
> =20
>  	for (size_t i =3D queue->get_pending ? 1 : 0; i < queue->queue.nr; i++=
) {
>  		struct commit *commit =3D queue->queue.array[i].data;
>  		if (!(commit->object.flags & best->flag_within))
> -			commit_set_insert(&unflagged, commit);
> +			oidset_insert(&unflagged, &commit->object.oid);
>  	}
> =20
>  	while (!lazy_queue_empty(queue)) {
> @@ -330,10 +305,10 @@ static unsigned long finish_depth_computation(stru=
ct lazy_queue *queue,
> =20
>  		seen_commits++;
>  		if (c->object.flags & best->flag_within) {
> -			if (!kh_size(&unflagged))
> +			if (!oidset_size(&unflagged))
>  				break;
>  		} else {
> -			commit_set_remove(&unflagged, c);
> +			oidset_remove(&unflagged, &c->object.oid);
>  			best->depth++;
>  		}
>  		while (parents) {
> @@ -348,13 +323,13 @@ static unsigned long finish_depth_computation(stru=
ct lazy_queue *queue,
>  			p->object.flags |=3D c->object.flags;
>  			flag_after =3D p->object.flags & best->flag_within;
>  			if (!seen && !flag_after)
> -				commit_set_insert(&unflagged, p);
> +				oidset_insert(&unflagged, &p->object.oid);
>  			if (seen && !flag_before && flag_after)
> -				commit_set_remove(&unflagged, p);
> +				oidset_remove(&unflagged, &p->object.oid);
>  			parents =3D parents->next;
>  		}
>  	}
> -	kh_release_commit_set(&unflagged);
> +	oidset_clear(&unflagged);
>  	return seen_commits;
>  }
> =20
>=20
> then I likewise get very similar timings. Your version seems to be
> consistently a little bit faster, but within the run-to-run noise of
> ~1%. But the bonus here is that we didn't need to define a new hash
> type, nor do any tricks with the commit->index field.

I don't see any performance difference at all.  Using the existing
oidset structure is clearly better under these circumstances.

> Now if we really are worried about those extra bytes in storing a fresh
> oid, is there room for new data types? I.e., A "struct objset" that
> stores object pointers, hashes based on the oid, and uses pointer
> equality to find a match?  And likewise a "struct objmap" that could
> perhaps compete with commit-slab (but be more pleasant to use).

Maybe.  It's a matter of measuring the performance difference, though,
and that's hard.

>>>   2. Can the hash version handle strides of different sizes? One of th=
e
>>>      points of commit-slab is that the fixed size of the value type ca=
n
>>>      be set at runtime (so you could have a slab of 32 bits per commit=
,
>>>      or 132, depending on your traversal needs).
>>
>> Dynamic value sizes require an indirection via a pointer, or at least I
>> don't see any other way.  What would be a possible use case?  (Don't se=
e
>> any in-tree.)
>=20
> The value isn't totally dynamic; it's static for a single instantiation
> of a slab. I don't think khash supports that (it has a value type and
> lets the compiler take care of indexing into an array of that value).
> But you could imagine a world where khash (or some custom hash code)
> only knows that it's storing N bytes per item, and does the indexing
> multiplication itself.
>=20
> But yes, I don't think we are even using that feature of commit-slab
> currently. I used it in a series for fast --contains long ago:
>=20
>   https://lore.kernel.org/git/20140625233429.GA20457@sigill.intra.peff.n=
et/
>=20
> but can't remember why I never got back to it. It would also be useful
> for show-branch, which wants to paint down for each starting tip. But
> given that we haven't used it, it may just not be that useful a feature.

Or for describe, actually, to allow an arbitrarily large --max-candidates
value.

Ren=C3=A9

