Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB658182B5
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810723; cv=none; b=UUJfDMr6t2Acrb65Y7ntCxAEYu/2of104zCwMIAsizDvTr8gj8mdQ3yZT3nISe6VT7+1snu9qQDRXCm8m5+JNZrT+SLQhabNlpHyN6YcRAzHJ/Va9293xxPuqSE334Y8WSuYQPJHyFWbdZ6Q0zd8dsxL9KbG+23DUoQUrBKTHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810723; c=relaxed/simple;
	bh=BhtwHJD6pSPWB9LKsFibMEgRYQxWAMOKjxbDoKRrBqo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=krVKsG3Kizngm9pe/c0/b4dLo5z4gpWCDMZ+HAGCroX3hDJfCdtt1oQWl60X/sXUAly1abZ4zhaJkmyzv9Ss4BaEVIfscdUfwkH5MUoVlkgaWxaKPa6lyRoNbPPRR3hYDdqve39h/iozx7Np7eo6a0nhbjwUWXzHN7X0nYjowfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45JFP99X3578767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:25:09 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>,
        "'Christian Couder'" <christian.couder@gmail.com>
Cc: "'Dragan Simic'" <dsimic@manjaro.org>, <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Patrick Steinhardt'" <ps@pks.im>, "'John Cai'" <johncai86@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <20240619125708.3719150-1-christian.couder@gmail.com> <0448495385b009f25a66b0712afb28f1@manjaro.org> <20240619134533.GA943023@coredump.intra.peff.net> <04b714d3e949c30bae0e26231e923fc4@manjaro.org> <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com> <20240619145042.GA957055@coredump.intra.peff.net>
In-Reply-To: <20240619145042.GA957055@coredump.intra.peff.net>
Subject: RE: [PATCH 0/3] Advertise OS version
Date: Wed, 19 Jun 2024 11:25:04 -0400
Organization: Nexbridge Inc.
Message-ID: <000a01dac25c$df7b23e0$9e716ba0$@nexbridge.com>
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
Thread-Index: AQHUvfRzK7z2XC+4Uuecgrzow0tdbQHeqvryAeKNQ2gB48xyzgJwsHEDAVWKbAuxj+Ku8A==
Content-Language: en-ca

On Wednesday, June 19, 2024 10:51 AM, Peff wrote:
>On Wed, Jun 19, 2024 at 04:01:57PM +0200, Christian Couder wrote:
>
>> On Wed, Jun 19, 2024 at 3:50=E2=80=AFPM Dragan Simic =
<dsimic@manjaro.org> wrote:
>>
>> > > I don't mind if this is present but disabled by default, but then
>> > > I guess it is not really serving much of a purpose, as hardly
>> > > anybody would enable it. Which makes collecting large-scale
>> > > statistics by hosting providers pretty much useless (and I don't
>> > > think it is all that useful for debugging individual cases).
>> >
>> > I agree that it should actually be disabled by default, for privacy
>> > and security reasons, but that would actually defeat its purpose, =
so
>> > I'm not really sure should it be merged.
>>
>> One possibility is to send just the `sysname`, described as =
'Operating
>> system name (e.g., "Linux")', field of the struct utsname filled out
>> by uname(2) by default.
>
>That would be better to me. I still don't love it, but I admit it's =
coming more from a
>knee-jerk response than from some rational argument against people =
knowing I run
>Linux.
>
>Since HTTP user-agent fields are common, we can look at those for prior =
art. curl
>sends its own version but nothing else. Most browsers do seem to =
include some OS
>information. My version of firefox gives its own version along with =
"Linux x86_64".
>So basically "uname -sm".
>
>> And then there might be a knob to deactivate it completely or to make
>> it more verbose (which might be useful for example in a corporate
>> context).
>
>Yes, I think we should definitely have an option to suppress or =
override it, just like
>we do for the user-agent string.

Instead of an override, what about a knob that specifies the uname =
command to use to build the value. Personally, I would use `uname -s -r =
-v` on NonStop to get the kernel version used in the build. The =
difficulty on my platform is that this is not truly useful info. The =
effective build OS compatibility version is in a #define __L_Series_RVU =
and __H_Series_RVU, so the knob might be needed in git_compat_util.h or =
similar. This comes from the compiler arguments, which are not yet =
captured.

