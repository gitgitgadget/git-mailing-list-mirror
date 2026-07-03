Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67D36E494
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089199; cv=none; b=ghlfDbO/yjdNEVIuMTLpeKQMiRFK6vuo8PzdBloYd3y/DooyU42aB/wgOtMBLikf3tKv583umWrCqLDFnwaD18ESeRzvvZemlESRYsDFk/VIMpo/NOoCGjirTNGAmqU6cM92BwgQOTjyCYjkQUu53qbSWYfFlSin1bDWoc6CWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089199; c=relaxed/simple;
	bh=vUCz++oSVrPvlKqy8zCJ158sQ4fgsQj8wuev+pzh88c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ap27wrjGZxnnlcTQwYz2tXHyXEGbxuhzQTWEfAmVXKAuNOS3/3epzVqGYDNMF8u4WlZoXlviC04Av/lAu6GdIBUujgM1Zb4AxcjQZp1K3PB381kanA+PnXIlfZvkLlKgMEsOGzARTEeK8uFpO8QATSj8jgqMfAKhLp+oqhU8UQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=YFzIWUvD; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="YFzIWUvD"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id AA80C609E0;
	Fri,  3 Jul 2026 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1783089194; bh=vUCz++oSVrPvlKqy8zCJ158sQ4fgsQj8wuev+pzh88c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=YFzIWUvDKVnhbZCHE8LMFHyjFLff1fZOPiFfooSmGj1abi/e9USNCAP+XNy4u//7I
	 2/y8iPJsicA4Xb+hu2Dr5vwLzgxfptpZHOOzhjJZNTaUPCoTeZhqTdxISittfhiXGS
	 n3KjVpveIpR1+mdGnxhIcr2Ekwte9AjLZSmxpvUk=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 10:33:14 -0400
Message-Id: <DJP0D7IZJ8WX.S1DDPT3KTQ95@lfurio.us>
Subject: Re: Programmatically edit the git rebase sequence?
Cc: <git@vger.kernel.org>, <neikos@neikos.email>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, "Matthias Beyer"
 <mail@beyermatthias.de>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <akei64goQf3nFhX4@hikari>
 <ake8OAIyK-ELs-fU@fruit.crustytoothpaste.net>
In-Reply-To: <ake8OAIyK-ELs-fU@fruit.crustytoothpaste.net>

On Fri Jul 3, 2026 at 9:42 AM EDT, brian m. carlson wrote:
> On 2026-07-03 at 12:02:33, Matthias Beyer wrote:
>>=20
>> Now I fire up `git rebase -i master` and manually(!) match the list from
>> above `git-log` call and find the respective commits to edit them.
>>=20
>> Is there a way I am not aware of to do that manual step programatically?
>> Something like
>>=20
>>     git rebase -i master --edit-commits=3D"$(git log master..mybranch --=
diff-filter=3DM --format=3D"%H" -- "./subdir/*.rs")"
>>=20
>> would be convenient here, although I would understand if that is too
>> much clutter for the already very heavy git CLI interface :-)
>
> Yes, such a thing exists.  You want `GIT_SEQUENCE_EDITOR`, which is an
> `EDITOR`-like command that edits the rebase list in place.  So tools
> like `ed`, `ex`, `sed -i`, `perl -i`, or `ruby -i` would be useful here.

Interesting tip - thanks!

>
> I personally use this alias, which explicitly does not edit the sequence
> list, to automatically squash in all squash and fixup commits without
> prompting:
>
>     srebase =3D "!f() { GIT_SEQUENCE_EDITOR=3Dtrue git rebase -m -i --aut=
osquash \"$@\"; };f"

'git rebase --autosquash' does work now without the need to invoke
--interactive mode.  I believe we got this with f8f87e082798
(Merge branch 'ak/rebase-autosquash')
