Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A018637
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726547; cv=none; b=dcZ2HhTwLCPcu+naD4IFSYODnWeQd+jnOfaUiUwrJowoxXRLXanBFhpQE6ExiC1sDQLv/wvDh5Hsep2R59CLN5BQPakCZgKQvELMtTDYPuoUeRpR0nI9o9J2s5qcrtXdSE5ui968LJDWvK2RugjRMFfjYxbPb2kuTAdB6xvX98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726547; c=relaxed/simple;
	bh=zZZUZvTwbYAPtTJj2GRCFNr4IwlrpYdcOGRn9Bc0qmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMT5tuf4oLestD5rR174O3VS4KGHqWT4jEy8MsHRlWbTw3IdUkahntjIrKGGBBnh5qowsE5O1cYPKkpULEsIWOPCHINwl4r1rDaAwMoz35Vhbrohx425gr43Y/AFhNiwSGWW/gcOb+0zlOhoDGkQY+fgeLxNsX3FG1unS67auTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DtowwTsl; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DtowwTsl"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EBD2B23489;
	Sun, 21 Apr 2024 15:09:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zZZUZvTwbYAP
	tTJj2GRCFNr4IwlrpYdcOGRn9Bc0qmw=; b=DtowwTslCmsfPy8C+GcGfHmGTG9f
	BeVNiH9SEfNsGw8oTP/CkkEoUtQZeHIkOnx4AvL8KX6zbLcR/aqIV8YVdnYtb8B0
	/Mh72gBJBZV8+xnjCJwNcaShGvRFpHfqa3kD5QOHKl5usjtTJaPqNl0aJcllxeqF
	Md+HuEhl6DkOwWE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E430B23488;
	Sun, 21 Apr 2024 15:09:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5AE9D23487;
	Sun, 21 Apr 2024 15:09:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: =?utf-8?Q?'Ren=C3=A9_Scharfe'?= <l.s.r@web.de>,  "'German Lashevich'"
 <german.lashevich@gmail.com>,  <git@vger.kernel.org>
Subject: Re: Possible git-diff bug when using exit-code with diff filters
In-Reply-To: <03b501da941a$4896bdb0$d9c43910$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Sun, 21 Apr 2024 14:32:30
	-0400")
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
	<82561c70-ec33-41bf-b036-52310ffc1926@web.de>
	<xmqqy1961sxf.fsf@gitster.g>
	<03b501da941a$4896bdb0$d9c43910$@nexbridge.com>
Date: Sun, 21 Apr 2024 12:09:00 -0700
Message-ID: <xmqqh6fu1qk3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9D83EA46-0012-11EF-AE4E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

<rsbecker@nexbridge.com> writes:

> On Sunday, April 21, 2024 2:18 PM, Junio C Hamano wrote:
>>Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> You can more easily reproduce it by setting the environment variable
>>> GIT_EXTERNAL_DIFF or the configuration setting diff.external -- no
>>> attributes needed.
>>
>>Indeed.
>>
>>A much simpler fix may be to declare that these two features are imcomp=
atible and
>>fail the execution upfront, instead of just silently ignoring one of th=
e two options.
>>
>>As a person who is very much used to the external diff not contributing=
 to the exit
>>status (who also invented the external diff driver interface), I would =
be a wrong
>>person to judge if such a simplified approach is desirable, of course, =
but just
>>throwing it out as a food for thought.
>
> My suggestion would be to keep with a priority approach, where
> GIT_EXTERNAL_DIFF overrides diff.external, assuming they set hold
> to the same specification (the git-config page implies they do)
> and GIT_EXTERNAL_DIFF overrides diff.external as I would expect.

Nobody in this discussion thread is hinting to change that, so I am
a bit confused where the above suggestion comes from...

