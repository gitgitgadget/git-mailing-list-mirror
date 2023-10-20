Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D629D09
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ww29TbrZ"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9E810D0
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:42:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0938E3363F;
	Fri, 20 Oct 2023 17:42:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IcrpkHc8A1lO8O0c2W6mtw2mks8vQCLXVGDVRK
	n8qho=; b=ww29TbrZLbXSLuqBmloLQd3LVPSPrrsV6W639nK9iiWYKAsnheRoEH
	35sD1AybSa/bXB9M517qpz1a2yfxcMaTcXIkauv6lRo0SPzlr73YmEupaODG0McM
	Q5Pm1EX1r5uFL7spTvG+1Qi6f7m0Z4ATj6l52aFZ41Cahyzku07T0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 003EA3363E;
	Fri, 20 Oct 2023 17:42:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90AED3363D;
	Fri, 20 Oct 2023 17:42:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,  Bagas Sanjaya
 <bagasdotme@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] some send-email --compose fixes
In-Reply-To: <20231020100343.GA2194322@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Oct 2023 06:03:43 -0400")
References: <ZSal-mQIZAUBaq6g@debian.me>
	<95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
	<7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
	<xmqq1qe0lui2.fsf@gitster.g>
	<20231011221844.GB518221@coredump.intra.peff.net>
	<xmqqzg0oiy4s.fsf@gitster.g>
	<20231011224753.GE518221@coredump.intra.peff.net>
	<b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
	<20231020064525.GB1642714@coredump.intra.peff.net>
	<20231020071402.GC1642714@coredump.intra.peff.net>
	<20231020100343.GA2194322@coredump.intra.peff.net>
Date: Fri, 20 Oct 2023 14:42:13 -0700
Message-ID: <xmqqil71otsa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 887FDEAA-6F91-11EE-9005-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> [culling the rather large cc, as we moving off the original topic]
>
> On Fri, Oct 20, 2023 at 03:14:03AM -0400, Jeff King wrote:
>
>> and there's your perl array ref (from the square brackets, which are
>> necessary because we're sticking it in a hash value). But even before
>> your patch, this seems to end up as garbage. The code which reads
>> $parsed_line does not dereference the array.
>> 
>> The patch to fix it is only a few lines (well, more than that with some
>> light editorializing in the comments):
>
> So here's the fix in a cleaned up form, guided by my own comments from
> earlier. ;) I think this is actually all orthogonal to the patch you are
> working on, so yours could either go on top or just be applied
> separately.
>
>   [1/3]: doc/send-email: mention handling of "reply-to" with --compose
>   [2/3]: Revert "send-email: extract email-parsing code into a subroutine"
>   [3/3]: send-email: handle to/cc/bcc from --compose message

Nice.

With the approach suggested to move the validation down to where the
necessary addresses are already all defined, Michael observed "whoa,
why am I getting stringified array ref?".  If that is the only issue
in the approach, queuing these three patches first and then have
Michael's fix on top of them sounds like the cleanest thing to do.

Will queue on top of v2.42.0 to help those who may want to backport
these to the maintenance track.

Thanks.
