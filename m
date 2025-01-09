Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704802153D6
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430554; cv=none; b=LaPKqhE0K50KlRiKaD0pIMiFV3IcSYji89U51mYzPTVIX2XIyk9Cmc3NO5r1mkTu6NKH6qL2DlpoH34LVjeAmbz9V1zMNAMM/rKvF9Y5DX+rS06E5ViQwz5CPqpswnCFCo7sppQS1n8TbsimoycWBcMraXQJTRWq6JmdKxu7y2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430554; c=relaxed/simple;
	bh=Y/eHZbmaLjDwy7tyKQk5yBwjthyB3qTXECOnFzlLSDc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pVFC61P1dftg1jZGSV6KqOskV1WU+dhigPaCMtJ5Vulk62Vpj8/tOXF89fFfUVBrhw2FNCYdRhv3W6KPjIMXNXU629lOl98elFYP7vHAghcx2tuVwCYyDBKcvLaMQj50W48jEzJ+BtdbijeGVsYeBzDZCxd7fnvjnDmHFEn4E58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=DvnzzUxF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="DvnzzUxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736430550; x=1737035350;
	i=johannes.schindelin@gmx.de;
	bh=YFiXjs3YEi9vsprha11GVMF0HiP9R1H9KuA5DfrGLgM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DvnzzUxFrExOTLTC+BgcTHNPPpFonOOtavoz47t6dYhWiQUIy+vTyHnv+CPgXSsu
	 I1qt7CcJUWiiq20XhLr+0dxkMG3Vw7DbGUmj3bo2NwbiqZZOAFhqmLHr/hZVzuP7j
	 ooTykxXb0n9pnKExXpmwewgu/I1T/cRLoQBjurS1Atp8tpFcxPDgiFRcnJV5ABc+t
	 DHAo/gtrDyehFpn0eTTTU5LKrqG72nne2YDVaJTOpkQhArjS8tAWOUJINFuS2AWtt
	 FrCLJ9m1TLwr6aa0aoShbG0uvwcvOPXSlNHlyjlGNQs/VMMENJZxCuuNUNyvWHFAK
	 igFmMONHd63bqKI9jQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.7]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sit-1tVyn442P9-016xZq; Thu, 09
 Jan 2025 14:49:10 +0100
Date: Thu, 9 Jan 2025 14:49:09 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: shejialuo <shejialuo@gmail.com>
cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
In-Reply-To: <Z3_Dt5SpG6qE5_9V@ArchLinux>
Message-ID: <2db1688e-bf2b-8f53-82d0-11c453a64cd8@gmx.de>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im> <20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im> <Z3_Dt5SpG6qE5_9V@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AyhhX3H3y31N4g9r0oE9iNwnPsDd9VVhtzBp+OhNCwjHbbvOmhL
 6eCgCVUjsi80nsgY4BbqNckvvdpMueCCtK7GUrYJb7S8gI5m7TjJupgdrlSdjFIP7ElM5j7
 T2jwXqo3g2nxmWoN3nPQoSed9krvQZvwjb77CVhTbxqAPtF8pG9m+H18Hko88PlF2vFoyQF
 VSRzl//Z5vbGsXPbl3x8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BmuH4uw/hqk=;n9Spe01ZZHPGqLvpBhGvMGyuSg5
 a+6/PnSujX0TA4KGyyeuwbIOqRFmYHLN1iT5vwjlxor+1WUpTnvAw4fPdrmJG/xNGjlEiCJ1b
 TxGbJKRLns6yyxxLBiZ9HY1v1hZaNyzW9m1XSrLG4CySIoVrrtYfiC8TRXLD50KZIelvMTx8D
 JWKEpDgew0ax7UX/dWGG1oi/O7exYAwjkLfb/HEI49S297Tgtl/oNfNWZ4TLtQb79+ieIueha
 X9xfZPsc2y6S1A/P8dsMH92fqUeywHDqdAerOagaaAfOgmlAuM5lNgnFQQbt5jEkUh2nLIsr5
 VC3CvY5M2TD09pGOMWdTVih4C3popJj6SkaxEd994m2YYgVqn/JeaOOV8RTOtudP5ndMxIrnc
 kfZbpOW3mrETokPddRetNJQHlIwpaDcRQA3RsK4JJ3RtFhlDPZjuIhY4jAbNDSidXGsKWHZNP
 zQdZrD2NqSVWjW82F9C9JZfoJNV96E9s9rx/NqF8p89EvKUOoOoooXDVLtjvfpgZ4r+IjsdyQ
 hPNzlbMz9p3lNXfz5s7eHysaCAkM7J5c5zoduXCw2oyEunnSdyEwUO2uHV0J6eGDUo953hCnr
 dPJ/Mr1G5WD5BtyVHmodLHsOXEgPxkkd+UcqlLhXCIBLu9UKjKX6TZFM2ItpRo6sUANZBIKa9
 qWlX/0VeJTDl2YDdxo81OzYIznPpaWitL+bht/Zku8B/5K0KauJ+7mskjwkHPtUZNjGwravKE
 3IU6ralORDZ+BolS/qG7EMbnRCcG4973RzRj006U9E8g4GdwIuH75AQJVX3ElqSaMWkpTIksu
 vqU5Y0J+NlVG/DbWHGBWUm2rYgiwlZfG2LzE8iV/pQAhgG+pchHdHDxq6rYzI39yl3GWAlxAp
 gjCcPyBDtty+9inGMKaibj1te2LP3lv1tRykc6gq/2Mg2/GbExmnNUDMuDvyihfo/r9aVqmzK
 RNznDSjh9ivnQvOyqKW1Kq1cNlbBt8rtcO+ptztzh7wFXz1SzSGd/uEf6sJoiFWL8LrPBRSCw
 ALe+0ZdY/eWxuYMMzfeO9IJc5a+HeCRlH3X2SEMcW19djksx45iYSPCq5c6QZKa7J325KWIMu
 d+bmWdzzLBEVI2rEG6MHpbK3kixX9h
Content-Transfer-Encoding: quoted-printable

Hi Jialuo,

On Thu, 9 Jan 2025, shejialuo wrote:

> On Thu, Jan 09, 2025 at 12:48:22PM +0100, Patrick Steinhardt wrote:
>
> > +		printf("%.*s", (int)length, hex);
> >  		if (opt & OUTPUT_ANNOTATE_COMPAT) {
> >  			const char *name;
> >  			if (opt & OUTPUT_SHOW_EMAIL)
> > diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> > index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..7cf6e0253a5bbd4d6e438e=
627dc18b47eac4df66 100755
> > --- a/t/t8002-blame.sh
> > +++ b/t/t8002-blame.sh
> > @@ -126,6 +126,10 @@ test_expect_success '--no-abbrev works like --abb=
rev with full length' '
> >  	check_abbrev $hexsz --no-abbrev
> >  '
> >
> > +test_expect_success 'blame --abbrev gets truncated' '
> > +	check_abbrev $hexsz --abbrev=3D9000 HEAD
> > +'
> > +
>
> By the way, I feel this usage is a little strange as the user side. When
> I received the report mail from Johannes today morning, I feel a little
> funny that we allow the value of the `--abrrev` option exceeds the
> `GIT_MAX_HEXSZ` in the first place.

See the explanation I provided in
https://lore.kernel.org/git/c439fcaf-11af-7862-9c3c-18dc0842b57d@gmx.de/:
When calling `git blame --abbrev=3D40 HEAD.. -- <file>` (in a SHA-1-based
repository), the OIDs are prefixed with a `^` and then the last hex digit
will be cut. The reason? Git wants to align the text after the OID.

When calling it with `--abbrev=3D41`, the full OID is shown.

Ciao,
Johannes
