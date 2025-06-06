Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E21E2853
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194436; cv=none; b=R7lxv/Aty5vV84Yf2LTf7NHajajhgNpUiY1CWZmzFxEzzgP0HWS4JJ9TiVbJTEro8Oqzy26hSY108rGY8C/9S0+/fpwUtLrzzSfKTcSmfFoYif165Vb8yFF+jbfhnUN6ira7xnuGJZ8mydocSlZD9mQS3dJN9e7nq8o+vm5qAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194436; c=relaxed/simple;
	bh=b4KxK4Xqdv72g2CK1h5FuweXerbkLAJMcl4YeTLhEmw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=T2FHtDlfwmX7mWRE04XjG5XUESA4AJ94aRKoXVPIbJbilsHFmYa4WkFgog68v1XpVz6DgSwmJrfJAe8NF3rlRrQMtzhg5RnmEYGQ7VPI1jbbjg4Y8dggRZRrsjyRTgdUZLOobezQDu2vvTEdlB+SO8AcAJ0hU5s1eO/lxN3VAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen ([185.122.133.20])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5567KPrM852801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Jun 2025 07:20:26 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Todd Zullinger'" <tmz@pobox.com>, "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Johannes Sixt'" <j6t@kdbg.org>, "'Patrick Steinhardt'" <ps@pks.im>,
        <git@vger.kernel.org>
References: <007d01dbd4d9$356ded70$a049c850$@nexbridge.com> <aEBPdFXpIca7lMls@teonanacatl.net> <xmqqjz5rcz90.fsf@gitster.g> <44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org> <010b01dbd5f1$3c26ec20$b474c460$@nexbridge.com> <aEFb0Sjj0Xuu-t7l@pks.im> <014201dbd658$4da75680$e8f60380$@nexbridge.com> <f2ed8920-347d-45d3-a0bb-df94ece0d9df@kdbg.org> <014f01dbd663$0ef73530$2ce59f90$@nexbridge.com> <xmqq7c1p7si3.fsf@gitster.g> <aEIqXphU07pYjFCg@teonanacatl.net>
In-Reply-To: <aEIqXphU07pYjFCg@teonanacatl.net>
Subject: RE: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
Date: Fri, 6 Jun 2025 03:20:20 -0400
Organization: Nexbridge Inc.
Message-ID: <016d01dbd6b3$7a27f290$6e77d7b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE99jmsA4lHO8yqJlfwsdV613M/mQIMJMJlAdw958MB9Pa7NAJTV6K7AhvfeRMCcS5DpwH0x2SMAkAmrQMBS3EHxwGvilwPtJINDoA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250606-0, 6/5/2025), Outbound message
X-Antivirus-Status: Clean

On June 5, 2025 7:38 PM, Todd Zullinger wrote:
>Junio C Hamano wrote:
>> <rsbecker@nexbridge.com> writes:
>>
>>> Can I pass this in via command line? Instead of modifying =
config.mak?
>>
>>     make NO_TCLTK=3DNoThanks
>>
>> just like you are passing V=3D1 on the command line of "make" in your
>> earlier message.  That would not build or install gitk and git-gui.
>>
>> By the way, I do not think writing into config.mak qualifies as
>> "modifying", as we do not ship one ourselves.
>
>Indeed, I always considered that the ideal way to set options.
>
>Another benefit, from the perspective of package builder, is that you =
then
use the
>same options for all the invocations of make.  This avoids things being
needlessly
>rebuilt if you happen to set them in build and install sections of your
packaging
>recipes and then let them get out of sync.
>
>In the Fedora builds, we did it like so=B9:
>
># Use these same options for every invocation of 'make'.
># Otherwise it will rebuild in %%install due to flags # changes.
># Pipe to tee to aid confirmation/verification of settings.
>cat << \EOF | tee config.mak
>V =3D 1
>CFLAGS =3D %{build_cflags}
>LDFLAGS =3D %{build_ldflags}
>...
>EOF
>
>['%{build_*flags}' are rpm macros, not something to be used  literally,
just in case
>anyone wonders.]
>
>=B9 =
https://src.fedoraproject.org/rpms/git/blob/ee7f0d4/f/git.spec#_545-582

Thanks. Thinks are looking much better now on NonStop.

