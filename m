Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED3EEDA
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417128; cv=none; b=rPn8b1ee3rHVSbrfj0jDPj1tbb3UyRdmQw+MkSupPipd/f5mtjWd0lAT1n/1woZVJvkoR1TA4/N31RfvJDk37ovaQvdyGygt4vO92pdbIJkAYlWULAEZ84kJiiQ/68yHbGXqDELKdUd1G7LEPhqMqdW/fr/4mI7zVK651DtOWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417128; c=relaxed/simple;
	bh=nrUZhwWIPAY4jfzMVMHciqZ9xKR3TLx6OmSB5CAs+xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+o76AKVh6H6vvVnRBiDVsS7qn9MdeikZZFCcj4hYNApJGy2q48YMFPocbZ1ImyhiJvu5nqt2+P2YnrDULJrI0mToujW4t4vFfF8vixAXaeZMDqcfnNistoYb8LC1L7RdAoVmFhYFcT6796nLzNS/1H0Jul9D9rSVCNsMsY6IGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=IV5LLL1c; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="IV5LLL1c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707417112; x=1708021912; i=l.s.r@web.de;
	bh=nrUZhwWIPAY4jfzMVMHciqZ9xKR3TLx6OmSB5CAs+xE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=IV5LLL1cl/KhD0M+hD08hW9gi9GCzGWnMsAidHSeOi3iVJWKZdkl5PINsylF+R9f
	 8dkEqYXQhN/XuIpycv7kHYHulCzZca5JABVT9rp0Nan9xDxB+L4SsvIcf2WLoUPoE
	 2gCYYkf1DHMiczoX1s4tL7GpdWlcYTEtjb81CNdb35a8LNHxgA3+vckKKb0qzGGuH
	 /nPKUraIQlLfttvQvODvPsClmbLOeDfaVLZOfCNu5neVdaZsjlm2dGRV7YuLI7c/R
	 gRPVt15AI01x6ShAhA4l5bNJDQd9TtPN7mbi486j8Vl6FzyDinHu1Erjwyj8SP0Qm
	 zcN82Y5vmvTD1ZaMJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.27.60]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqIB7-1rCZsx26B1-00nDv9; Thu, 08
 Feb 2024 19:31:52 +0100
Message-ID: <8313d9d6-f6bd-4fae-be9c-e7a8129768eb@web.de>
Date: Thu, 8 Feb 2024 19:31:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
To: Jeff King <peff@peff.net>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
 <ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de>
 <20240208010040.GB1059751@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240208010040.GB1059751@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lgr+nbnqmoTsi5ZrmzsIOELvFpZbcaxAolJWzffwy8XuVzcF6HL
 p6TEgLz0wJKNSTd5Lz4dIK976T3BJXHnvgWW0/Vbdb9OdPO9gmo7jqLPPpQlWEmFCm4OzEy
 avh/AmHNj/nfZ9PHmjsmyy/WCJX5gFHmmmrQheM438RE74JiWfM3AsJ1/TdrSXel99WIgHL
 yIy/YMrPzgkKjmog7Qx6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZnqYOl4Sq+s=;efzXg5H7zVUk2ATe2aIs3MhQoqW
 9oQvU7QJjNg3TMvrBA3vffhHoLLsuOGQsWL4i3/jyeapGPxT5ezjTgJN0Ee5dxtFAlbDZJGSt
 1vf7qGjpLSiInDbstJ2Tv2GPTVDgztXUWvTOQ8cdqwTMcfcYqgtmdQb+WuobWLPFtCnqOzwW4
 KW8c33lHeBNtaPvh8BiUEpMY1nmWh4w2a6ix+oZFrRsndp5lvsytdpiA2Z/7Guia01J0TXrhL
 a6Ouv9gNxUuwwTaZr+H5WiWm8Eekk3PM0aT9CHIQAw2GxePc0dmLsJOrlBA6fILiUAiCZhj/9
 yvii+5U+VmRG4L1FhYAklsXHKFakgxYg1y3v9TIKO57o8KqGfljMEZRZytKXSdwLlfnj0uNke
 ekv/GsKOSGHtmN4RkhB1V7P/279kufrwJcnt/7+rgF83eqM7u4xiqMb3caQ1TXX+tuaJKwrf6
 Nxnz09ZMkIECFEreNGBhF/1AeaYvLvYSYJPUwxu5FfwAXIJoFipZ48iGC6V9PVpv5AUEfp/Nf
 xPpOtR0f80OdrQgTDRVD7sZlSt5MOlVodM2zbInDDn1a6NCn0eHkMAVhqwNxIvpJ76rQqAhUt
 VtKHUd2ml+6GuDUoo6jrbyT0pW70+a9+NPmyRIfY46vrdSM58ptO4lVBsQ6stIDAP6xQep0Ob
 QrjpnOq2diFDcIU4VRqbPQmw6GXKO+xsdAmtuVRwn5daaQ+hnjx82VpVdNy53Y2cnv0CI2oWQ
 0MqrGE/DpcDmHbCMJV8PBAvkbqO17vBVaSIQzJHkDcpRIjuKEVAkAl5NVLZYe/nU8WQee1fOu
 KAiLgEaHdnM41L6h69ENc+uhZ7sKSuLa/cjVmHkP7pa58=

Am 08.02.24 um 02:00 schrieb Jeff King:
> On Mon, Feb 05, 2024 at 08:57:46PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> If you want to make the code work with buffers that lack a terminating
>> NUL then you need to replace the strchrnul() call with something that
>> respects buffer lengths.  You could e.g. call memchr().  Don't forget
>> to check for NUL to preserve the original behavior.  Or you could roll
>> your own custom replacement, perhaps like this:
>
> I'm not sure it is worth retaining the check for NUL. The original
> function added by me in fe6eb7f2c5 (commit: provide a function to find a
> header in a buffer, 2014-08-27) just took a NUL-terminated string, so
> we certainly were not expecting embedded NULs.
>
> In cfc5cf428b (receive-pack.c: consolidate find header logic,
> 2022-01-06) we switched to taking the "len" parameter, but the new
> caller just passes strlen(msg) anyway.
>
> I guess you could argue that before that commit, receive-pack.c's
> find_header() which took a length was buggy to use strchrnul(). It gets
> fed with a push-cert buffer. I guess it's possible for there to be an
> embedded NUL there, but in practice there shouldn't be. If we are
> thinking of malformed or malicious input, it's not clear which behavior
> (finding or not finding a header past a NUL) is more harmful. So all
> things being equal, I would try to reduce the number of special cases
> here by not worrying about NULs.
>
> (Though if somebody really wants to dig, it's possible there's a clever
> dual-parser attack here where "\nfoo\0bar baz" finds the header "bar
> baz" in one parser but not in another).

Good point.  A _mem function shouldn't worry about NULs.  Its callers
are responsible for that -- if necessary.

No idea what an attacker could do with nonce and push-option headers
with varying visibility.  Version detection?  Something worse?

But anyway: If NULs are of no concern and we currently end parsing when
we see one in all cases, why do we need a _mem function at all?  The
original version of the function, find_commit_header(), should suffice.
check_nonce() could be run against the NUL-terminated sigcheck.payload
and check_cert_push_options() parses an entire strbuf, so there is no
risk of out-of-bounds access.

Ren=C3=A9
