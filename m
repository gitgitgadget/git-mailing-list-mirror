Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45F7127B7E
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282139; cv=none; b=STFHzUGt2tunfYvPxXOmK8LhsyVBY0DbA7J2t+6Jo7321y8TYlEa5L6XJm78++pHX0URkAMLyOyU27LesED/YZCPQeWmWpYDv0TuNTo2W6DTuoETlwb00DhV/K+89XPHAm2ILb+1iEagqBwy+SCTZ6QRIIKYpBwgqXEz6rK4PD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282139; c=relaxed/simple;
	bh=22q0YLoS/iQauaOmYUgUSeRyr1mWWUrQrWozOOrBmNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSTJCuICNtkVHseX0Fee66Puaf23mlrjlegpnKGBsP3mLw2QAu14eHkwEN/yFUFCBTmcM8dKJfhqAtcA9ewG+B59GoQhZ9WUt6snYKirl/0Fk4RQrDP4XidE+orWHF7tRIeJhODiy9FHqPVmzUq49d32Zwv89mU/wk6Lgu7qOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lYCweUcA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lYCweUcA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D9961836F;
	Tue, 16 Apr 2024 11:42:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=22q0YLoS/iQauaOmYUgUSeRyr1mWWUrQrWozOO
	rBmNQ=; b=lYCweUcAHG1r5+6Zn1ryKzQ7uuzcE3KOZDWP2h7AvwNvCEDH1EkNlu
	TLBaoGZkMiAPlFmbumUY5346uQ2E9EOhxvrEo/+ljOQMM2s5qrcPDvvjxEgq+O1l
	bTi/0G/h68t/9AKsZb00bVcMQt7y5nxTedqF1U7qfmmovCiOXjrW8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 243F51836E;
	Tue, 16 Apr 2024 11:42:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 753A21836C;
	Tue, 16 Apr 2024 11:42:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Jeff King <peff@peff.net>,  Peter Krefting <peter@softwolves.pp.se>,
  git@vger.kernel.org,  "Osipov, Michael (IN IT IN)"
 <michael.osipov@innomotics.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect: Honor log.date
In-Reply-To: <CAP8UFD0W7PUHTg2NwuVkQJik2+HqTDF6KRZZ8tA_dW7-YZtsbQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 16 Apr 2024 13:01:34 +0200")
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
	<xmqqh6gni1ur.fsf@gitster.g>
	<5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se>
	<xmqq7chif1pu.fsf@gitster.g>
	<20240401023225.GA2639800@coredump.intra.peff.net>
	<CAP8UFD0W7PUHTg2NwuVkQJik2+HqTDF6KRZZ8tA_dW7-YZtsbQ@mail.gmail.com>
Date: Tue, 16 Apr 2024 08:42:10 -0700
Message-ID: <xmqq8r1dfh65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4946A1E-FC07-11EE-AAA1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> IMHO this config thing is a good example of the strength of the separate
>> "show" process. If our goal is to trigger all the niceties of "git
>> show", it is tricky to catch them all. The revision machinery is pretty
>> reusable, but there's no easy way to figure out which config affects
>> git-show and so on. Of course if we had a way to invoke git-show
>> in-process that would work, but I suspect there are unexpected corner
>> cases that might trigger.
>
> Sorry for not following the topic closely and for replying to this so
> late, but I think that by now we should have some kind of guidelines
> about when forking a new process is Ok and when it's not.

I thought we had passed that stage long ago.  A case like this one
we see in this patch, where it is run just once immediately before
we give control back to the end-user (as opposed to "gets run each
time in a tight loop"), I would see it a no-brainer to discount the
"fork+exec is so expensive" objection more than we would otherwise,
especially when the upside of running an external command is so much
bigger.

There actually should be a different level of "running it as a
separate command" that we do not have.  If we can split out and
encapsulate the global execution context sufficiently into a "bag of
state variables" structure, and rewrite cmd_foo() for each such
command we wish to be able to run from inside an executing Git into
two parts:

 - cmd_foo() that prepares the global execution context to a
   "pristine" state, calls into cmd__foo() with that "bag of state
   variables" structure as one of the parameters, and exits when
   everything is done.

 - cmd__foo() that does the rest, including reading the
   configuration files, parsing of the command line arguments to
   override them, doing the actual work.

then the codepath we are changing from using diff-tree to show can
do something like:

	struct git_global_state state = GIT_GLOBAL_STATE_INIT;
	struct strvec args = STRVEC_INIT;

        strvec_pushl(&args, ...);
        cmd__show(&state, args.nr , args.v);

and expect that cmd__show() will do the _right thing_, right?

And to reach that ultimate goal, I do not think using run_command()
API in the meantime poses hindrance.  The real work should be in the
implementation of cmd__show(), not the open-coded use of revisions
API at each such point where you are tempted to spawn an external
command via run_command() API, which will have to be consolidated
and replaced with a call to cmd__show() anyway.
