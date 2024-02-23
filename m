Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F338C
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646847; cv=none; b=VjbE8OaXly9LB2vJ70MbI9NqxPxzwlJi8SRm9XKsYcZQ242kplkrs1qDq4LqgQhGQCpE7NCpIxfEqvEGEdndhMuzCwBTbhcOMLhV0T+TrKZua7mVyAykv6PfO/SHnvfkHElHxsPzEa/mE+3ojlGCf3JURGjyMFn4UUFqPsIT5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646847; c=relaxed/simple;
	bh=JZSqLDbBgw0QayefdTrDBFp3pXsERO9dqOkHALWOOp8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=mAhNICbljdA4CYBWv25PIkSDY5cc2m1Ld3TtEbROKsXrJPZDhjloGRKC45u/FauqdMcVuKvcNu/j6PW1iYfFykSetOBx1BWezVSiN/kobAc3HXIhOQxU80OgwExPO5h+ayXJUXKGYBIizrDJmXezG5/nD0hK/lsqdWVV5wx1qD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41N070jR1499175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 00:07:00 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Josh Steadmon'" <steadmon@google.com>
Cc: "'Jeff King'" <peff@peff.net>, "'Junio C Hamano'" <gitster@pobox.com>,
        <git@vger.kernel.org>, <johannes.schindelin@gmx.de>,
        <phillip.wood@dunelm.org.uk>
References: <cover.1705443632.git.steadmon@google.com> <cover.1706921262.git.steadmon@google.com> <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com> <20240207225802.GA538110@coredump.intra.peff.net> <ZcqFOVuR0sxFDDUv@google.com> <xmqq34tx5q6o.fsf@gitster.g> <20240213074118.GA2225494@coredump.intra.peff.net> <016c01da5e8a$1ada8fc0$508faf40$@nexbridge.com> <Zdffgzf74eNeNBnF@google.com>
In-Reply-To: <Zdffgzf74eNeNBnF@google.com>
Subject: RE: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
Date: Thu, 22 Feb 2024 19:06:55 -0500
Organization: Nexbridge Inc.
Message-ID: <005801da65ec$3a35e9f0$aea1bdd0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIssOVLS8sqB28S9JSX6UZPm2IKnQIcq8MKAgMoudwB8/Zk4wJvkolkAfmHKQsBAfOFkgIupb5gAksGyB6v8rI9gA==

On Thursday, February 22, 2024 6:58 PM, Josh Steadmon wrote:
>On 2024.02.13 09:36, rsbecker@nexbridge.com wrote:
>> On Tuesday, February 13, 2024 2:41 AM, Peff wrote:
>> >On Mon, Feb 12, 2024 at 01:27:11PM -0800, Junio C Hamano wrote:
>> >
>> >> Josh Steadmon <steadmon@google.com> writes:
>> >>
>> >> > I see this line in the docs [1]: "As with wildcard expansion in
>> >> > rules, the results of the wildcard function are sorted". GNU Make
>> >> > has restored the sorted behavior of $(wildcard) since 2018 [2].
>> >> > I'll leave the sort off for now, but if folks feel like we need
>> >> > to support older versions of `make`, I'll add it back.
>> >> >
>> >> > [1]
>> >> > https://www.gnu.org/software/make/manual/html_node/Wildcard-Funct
>> >> > ion .html [2] https://savannah.gnu.org/bugs/index.php?52076
>> >>
>> >> Thanks for digging.  I thought I was certain that woldcard is
>> >> sorted and stable and was quite perplexed when I could not find the
>> >> mention in a version of doc I had handy ("""This is Edition 0.75,
>> >> last updated
>> >> 19 January 2020, of 'The GNU Make Manual', for GNU 'make'
>> >> version 4.3.""").
>> >
>> >Likewise (mine is the latest version in Debian unstable). The change
>> >to sort comes from their[1] eedea52a, which was in GNU make 4.2.90.
>> >But the matching documentation change didn't happen until 5b993ae,
>> >which was
>> >4.3.90 in late 2021. So that explains the mystery.
>> >
>> >Those dates imply to me that we should keep the $(sort), though. Six
>> >years is not so long in distro timescales, especially given that
>> >Debian unstable is on a 4-year-old version. (And if we did want to
>> >get rid of it, certainly we should do so consistently across the
Makefile in a
>separate patch).
>>
>> I am stuck on 4.2.1 and cannot get to 4.3.90 any time soon. Can you
>> want on this? It will take us out unless we can suppress the $(sort)
>
>Hi Randall,
>
>I'm not sure I follow here. The change in 4.2.90 is that wildcard expansion
becomes
>sorted by default again. So adding the $(sort) back shouldn't cause any
problems in
>4.2.1. Or did I misunderstand your point?

I thought you were referring to a new ${sort} behaviour in 4.2.90. My bad.

