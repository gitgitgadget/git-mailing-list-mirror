Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B079C2
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722788158; cv=none; b=Gl/O9g/axL8G6qmYOTPutjflaJtt850yIAxMvgMOTCjXuEKRBKbrCy+umFYdvlnYMMZuWDh4l6Of0nAg2K8ZFcQprb0bCzi1HJhf0nvnCUit+Nc/EDUXw0bUh24ddx9B3CECjdCQ3tlRclBDhOa2kLWsK2mmtbtLp0Cupq/aK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722788158; c=relaxed/simple;
	bh=EPufFUBgCHcOeRg4K+lWDy7QfGW74N5ygYZB5s4zR4c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=PpE6pkR/rwVJD4gUbwrWGZFY5IghFe4UmulcRBJhAuyPk8n2cjdDTAIW5xhvpLdm6ZpKJLBz6WEPWae3NWp3oizT+zbpLj/+NbRu7xTgjnpajcl20x8U9sLAsSoK+40G9rrSTmNUU5Ga3eDiqwFWoq+iigMIhZuvAEBgbhsxUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 474GFkFW3992166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Aug 2024 16:15:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>
Cc: <git@vger.kernel.org>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com> <ZqvgmYl8BTYvsSa0@nand.local> <032201dae461$c7bcc9d0$57365d70$@nexbridge.com> <ZqwvQUAqVozGHG/t@nand.local> <040801dae528$70966d10$51c34730$@nexbridge.com> <Zq+mF2fyL5hux+3k@nand.local>
In-Reply-To: <Zq+mF2fyL5hux+3k@nand.local>
Subject: RE: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Date: Sun, 4 Aug 2024 12:15:41 -0400
Organization: Nexbridge Inc.
Message-ID: <04ee01dae689$90b0e0f0$b212a2d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIp93LlMAXo5OzQ9HEGtsfRK+e3MwGmTwJBAbmv8+0Ce5iwkALnbZ/bAmhVbPOxH8h2cA==



>-----Original Message-----
>From: Taylor Blau <me@ttaylorr.com>
>Sent: Sunday, August 4, 2024 12:03 PM
>To: rsbecker@nexbridge.com
>Cc: git@vger.kernel.org
>Subject: Re: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
>
>On Fri, Aug 02, 2024 at 06:07:55PM -0400, rsbecker@nexbridge.com wrote:
>> After the first repack, I have the following idx files. No =
foo/bar/baz inside.
>> The generate_random_blob() does generate the proper amount of bytes.
>> I tried changing 0xff to 0x00ff at the putchar just in case we had =
bad
>> sign extension - that wasn't it.
>
>Hmm. What is in these index files if not the three randomly generated =
objects? Can
>you run show-index instead and share the results of that on the pack(s) =
in your
>repository after the first repack, and share the results with the list?
>
>I think those would be more readable than a hexdump, especially if your =
machine
>random source is different than mine (in which case I can't guess the =
values of $foo,
>$bar, and $baz).

After git repack -d --cruft --max-cruft-size=3D1M &&...

./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index < =
.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
fatal: unable to read index
./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index < =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.pack
fatal: corrupt index file
./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index < =
.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.pack
fatal: corrupt index file
./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index < =
.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.pack
fatal: corrupt index file

Apparently, something is wrong. This is an ia64 Big Endian. Not sure =
that matters.

