Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D013B58A
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742021071; cv=none; b=RimW5acoK5WPbbAvPfvxeht2H2PHEdohJL1K7XDJNC7CcVwyUjGBatXOhVvWN6fLbIIti8wNsdcGLDvc2HZUSizHzy+WFscw9zx7oJY9Zpo9oLVWy2Hwl3pdu2exoqvryvLtPsKWfMfQs/P69nh3zNGMbRFa4gxaj+Vgpa4UaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742021071; c=relaxed/simple;
	bh=2Kxi0I//m//gGAVTzHXNq3SK+Yx2jX/ZJmn0c/vMYQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jw0nTNIoO3qoMgJq7A5iV9SDckv4ovm4BUR3Ac6arxyX0g492b41jcWzWrjHKkA9CicXso28BZX6F0iR6EEAGaEg/yvEXXAqnreNrFqYGpZPAWYOqMTUz9lS8/xLW9ygL7Mf3D835qND227UNHcVxNUuiaHg/YrawAafM8emAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=UeNy5b1q; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="UeNy5b1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742021060; x=1742625860; i=l.s.r@web.de;
	bh=paOxzqiSXqRKIRz1f/k+59BKz3LofacmkCDMXOu3hMI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UeNy5b1qv85jtRiQ1etnaqmy8CZbDrBKtXme+lAtwaXmN4lunAvpRXurllIYo2wW
	 V5hZzkXv/v6me1wj0pYMsSHnuKyy3w/oJKW5/4soUPIrGfdTi7pAspiCJZreQtwcX
	 0Q/4aGK104BmwjYI8V/nLFhiOP7x80nQiufXL10wRGaqnE4CFCBmkiVLNRXdaFcyU
	 EXsRvZDYPpeiCpSPjhtZxvq9rqK7DyXIG8aUsXMksXcqM0c6c3KJqGOZLWtT03lzA
	 2w/Y7V2rd1N5dKTnqtzvShGn9GTAfwE7UZFHFmUINlJBsp1zBpxuYBywg+TBoW/Oo
	 3aXapuv5/F7yQhiqWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.218]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vop-1t6rIY4785-014CrV; Sat, 15
 Mar 2025 07:39:00 +0100
Message-ID: <8c9a3966-2746-4619-9f77-ca95797dcab8@web.de>
Date: Sat, 15 Mar 2025 07:38:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdiff: avoid arithmetic overflow in xdl_get_hunk()
To: Junio C Hamano <gitster@pobox.com>
Cc: Jason Cho <jason11choca@proton.me>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <xXWgbH3mlNEvFcdGLqBHwcclZoeZNPoLg8Hr6YCipHXvS5eKaHeTppzFM-l_wyB46BB1R1T0j6g_jWRXIj7-GRJh1LPxi1ta3GkQ5t8F4-0=@proton.me>
 <NYMqsJ7uttDzFT2OOEg5LLsxCSoQhTzqBs16KrMHGEKC7LzOAiYnYTEZavRQWqGH41UgjdwScwer7MssNzI7AEDHnD8GTBWvoBIqJ2e7D6g=@proton.me>
 <4e9b6b4c-aaa1-4c6f-93f4-7bb04607e843@web.de> <xmqqikobdz7l.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqikobdz7l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JTZlrp1teeqmq8nGgxCmks0m92D9wwDPzzIHGgP2Y72AMolfvBi
 qph+AuhYTV3wREyZqxxQhjcxffjulxBvCpgcPlEGkXL3E3e1MjX4+qrsbvThmN7l/VX88Ug
 8//aTzXm+MKyhh/M53jaE+yj5nT/Ra/Is25Y8c2pce2ifKvj/4ogeHbxXqcUsused6s73mP
 HRyquuRiPRo8iqb2IZ0sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oZrr+J0Eazk=;9T3Pzj42xIQZt940PdHJ8V5lc4H
 izlxeoLRIs6RPeFflvTbiIGcTAYcT1RlYjpSxz6Eff2XGi/vSYYFcAWhfI1R/7k9KOwm+zCV4
 SWDM6h1ignQOMAfVan7hQGXsNv5Jiq0cEDT77BB03Te8rDmNJFvs+BTaErI9pyP1xd6LtyEVD
 et8b7IISfIITqTNmnL1GjWxMa/76Hi7pCZVWcb5Q0hxiesG11wG+GghOGnWjn6B5F0WcMbplG
 lek9+8R38LjPx34/WSeZRWPzwr999cfXhGHLowxVXRCP6uxFpwSzp1y13mmwIGbFucb+iG3MP
 0Hvlzu+E4f4qZqLoOvZ4F8uaFiQPBZ65338KOgkIBnUEV3sJRJ2ZioabIVU1+o55Iuf3bXFOm
 iKbX6uo5i7omThMiiOAtLbwgMoiB16KV/cCBUw1zFQbbNZA4C+vVEuklWmtX4eyu4bErDnxJf
 KwK104lz34F/RhQB2SMLVjwQtFxc4zitclZAEeH9CTBVIzJv5n+Ul6M3yIwR9kx7TVQ142g3w
 A+pgf8nLhscj1/CQsHpqyUZq5nfvki+CZxUlHW7MbYYs5Huq/81dkuTUCEO8MxQineCtYrOm4
 Fs4qvYDq2HmFcET1OyZbbUkz6mq3Gg/nM64ATBlKRixLVPZI0eKvVU91HzgBnAGbNxAA91Jc6
 Judmc5+qcWc2Jw/JCgr07JTcWd3jV7uJxD7iYLZW/2qIXRzz8mYJXz1A/nuYBkG//nYRjrems
 8IFPUbkOO72XPhMCbLX8/SNUyj7fxsDx5uvr5oFlndtn3iuVLhw5BqB1cHgwnlLTiD1cPFcKe
 AzKK7BODVpNX06DdHE9Tlkvui6Sxa6F7x4kz73JRWpRZQIDcJgF2FqcYYluMdYkMHHb3/4rJQ
 8qbmXJQ7nkdy5dhveRh9xI03Weab4kB6PdbwzkFhwhNFbOtP66/hpugFU57CA4wWvcP3yjRwM
 PU+GYM0PuaDejann+orhc/UnyPL0h8NuOn+hYwX0x0T9sqyqrxonz5KhCtJ/zjd+f/Xu4J1UN
 nxPFZa6wWJkbgBw+jYxFuxL/Pmru9CX/KcDxg/vxXyQCKPwwla+DonOGYBFrhTIcC6zXg1sva
 8VRlVO3nb/a2gD3AIVNTP5FKytPjSkflsOJi4dNbU12/mvfgTejYiyw4MD1/m2D/HO9b36sr4
 0bOfx3PguSZjbDh26gjKShn7Tjkixh8tHnuWjQYfZVn2f9XxR6C0a8u9EbBWKKivg4a+xMxUl
 9B2EtFA014ZVUKDQt+gXE0arhPuMdiPsYVr01OoA9O1HRUtvm9us5QVUEvRaCwl2XniMZelND
 dCW1ike09M8EfYVcULR5mkAtb/9Qqoh4cidozZi6bOgGQEO4W+UCwkWBcyOGPW2JHgYZ4kiU/
 ojkD45avEMjOpO8UrpjPKqRyjt4ZQk8pOkNKoW3ofTh5Uc4x3pjqeFDK0kFp+JLPyGYLsBWuw
 j1ABtFQ==

Am 14.03.25 um 23:28 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>  t/t4055-diff-context.sh | 10 ++++++++++
>>  xdiff/xemit.c           |  8 +++++++-
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> Oh, I love a patch like this that is well thought out to carefully
> check the bounds, instead of blindly say "ah, counting number of
> things in size_t solves everything" ;-)

Converting xdiff from long to size_t is still a good idea, I think, but
would be lot more effort and thus more risky.  Comparisons to upstream
would become a lot more noisy as well.

Ren=C3=A9

