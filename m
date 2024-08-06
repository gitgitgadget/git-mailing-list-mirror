Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1D18D655
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960936; cv=none; b=UM+Cww6qEAN3wlTAOO4Cy431b8p/x2kS/lDuaw6Vh1MjOFjH+gXKXGS9sQ7uFcGbNlsbEKPAxwCIdXfQE/c0Vplwwd+tTIVuF0/PyGHC2BFa1OFzKIwiiqRaSgQnmI5N1bt/lFxwt/0up5+ArqxRQ/YCRaaeocBn5VNsQx+Vi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960936; c=relaxed/simple;
	bh=s+0uRjnXfFD6Im/5I8CJLfOgLvXgA3ABNVsA6u3+t8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JnOs24QwuMJ4vKFE/K2VTmRUlYyV5opvZyE+4B6as9QeYjGuZdh2I93FKYVgJpbric6XQbM0BsfTyJDLVTdTyJgi2jvrqHQ1KEmQG7wYwk3Z+EqoL3yUp1EDvE+XlCGQsW5j4qUlCRnzbDTwJ46lXV6w8LlSvRsOHUL0T5w0hR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gaAP4rvk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gaAP4rvk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DA4822C12;
	Tue,  6 Aug 2024 12:15:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s+0uRjnXfFD6Im/5I8CJLfOgLvXgA3ABNVsA6u
	3+t8U=; b=gaAP4rvkmTC+R5NOlWjwQpvUmrugWLVs3XLIC440fizuxkv2iVWqoS
	KIjLF5Ay+g7Zx+vzjAahNvXB2CDaDdnoCyzFhHLXe0aaoIjqP2dAvp12dbI8y0sj
	UlvCCUiE6o3QLVL3giM+eRet3Bl/YpSE2BMBzbGJUEYxD3iNB8AGY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 25A8022C11;
	Tue,  6 Aug 2024 12:15:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1974F22C10;
	Tue,  6 Aug 2024 12:15:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v15 7/9] builtin/refs: add verify subcommand
In-Reply-To: <ZrHRpnpGkH19godh@tanuki> (Patrick Steinhardt's message of "Tue,
	6 Aug 2024 09:32:54 +0200")
References: <ZrEBKjzbyxtMdCCx@ArchLinux> <ZrEB16WGGc28dxu2@ArchLinux>
	<ZrHRpnpGkH19godh@tanuki>
Date: Tue, 06 Aug 2024 09:15:28 -0700
Message-ID: <xmqqsevhy6e7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 19859784-540F-11EF-8B9B-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +	if (argc)
>> +		usage(_("'git refs verify' takes no arguments"));
>
> Junio has posted a patch series [1] where he wants to get rid of
> messages that simply say "no arguments" or "too many arguments".
> ...
> So I'd propose to make this:
>
>     argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
>     if (argc)
>             usage(_("unknown argument: '%s'", argv[0]));

I probably should have said that I am fully behind the intent
against "too many arguments", but I am not 100% behind the
particular messaging used in the patch series I sent out.

One potential complaint I expected to hear, for example, was that "a
is unknown" given when you said "git cmd a a a a a" is not all that
clear ;-).  To alleviate, you would have to say "git cmd takes only
2 arguments" if 'a' you are complaining about is the third one.

Also, many people would consider that "unexpected argument" is
better than "unknown argument".

I personally think the message above is absolutely clear and good.

You say that 'git refs verify' takes no arguments, and for somebody
who said "git refs verify a b c d e", there is no doubt that all of
these a b c d e are unwanted.  And there is no room to misinterpret
the message as "'git refs' is ok but 'git refs verify' is already
unwelcome with extra argument", either [*].

In short, I think the message in the patch here is good, and it is
the other "war on 'too many arguments'" series whose messages need
to be thought further.


[Foornote]

 * ... which was the problem I was trying to address in the current
   message "too many arguments" that does not even say which early
   part of the command line we consider is "command" that was given
   "arguments"---to uninitiated who said "git refs verify foo", it
   is unclera if that's "git refs" command whose first argument is
   "verify", "git" command whose first two arguments are "refs
   verify", etc.

