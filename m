Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF38289E
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046131; cv=none; b=S9Xzxe1zG19Dwp3dpXhbzQLq6lA+M2Hj1/rHhan/97XRdMBh+DH7DEoqe6b6O880Rw1y+IPD1Z3n2hcZy/EMJNHbTtEi+NieEc/0wEt2NXThhmZHWoxHJZIFA217Q8/pKdIy08c1RplRba9Zv8BDPIAQC9mwhEkEOLakP6C6kTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046131; c=relaxed/simple;
	bh=ad/G5T6ux5ZdT1xSnprhQG1c4SYmLbxZKJ5q0TY28d8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RfVwGow5wiBpSBSTTZV2cdk8FpEmR6I9AB9D0LXDpM/KohDQqt85MDn+H88qGA1h6iyFyLWHqHxtoeWUyutk+Hiv8YprZU5nMvBxYyaE8BqwZGNXjBGCLXHVDZIJpGtl/z4NF9did5txGoWslA4G2WJ5yg+OHs+oOZ33Yhw+0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i4AL9FU0; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i4AL9FU0"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 77E2518793;
	Wed,  7 Aug 2024 11:55:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ad/G5T6ux5ZdT1xSnprhQG1c4SYmLbxZKJ5q0T
	Y28d8=; b=i4AL9FU05ZIBYY2+TdpzIjdPteJ3qeU7pzzip8zA90cx8jYXuvCRit
	gIiTJWgp/8yFaIuFj2r0dIzeH38ow4tkHpnoKfatODoDm/wH1dpswm76Kf9R52gN
	R/F0EFj9UmrU5dEC4ZJuY0J1WrqDPlJtE/YYD2FQtjytO4caXCz18=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D3D518792;
	Wed,  7 Aug 2024 11:55:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C20BF18791;
	Wed,  7 Aug 2024 11:55:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v15 7/9] builtin/refs: add verify subcommand
In-Reply-To: <ZrMMaubE_V7wUZ3H@tanuki> (Patrick Steinhardt's message of "Wed,
	7 Aug 2024 07:55:54 +0200")
References: <ZrEBKjzbyxtMdCCx@ArchLinux> <ZrEB16WGGc28dxu2@ArchLinux>
	<ZrHRpnpGkH19godh@tanuki> <xmqqsevhy6e7.fsf@gitster.g>
	<ZrMMaubE_V7wUZ3H@tanuki>
Date: Wed, 07 Aug 2024 08:55:21 -0700
Message-ID: <xmqqjzgspbti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 745369CC-54D5-11EF-A539-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 06, 2024 at 09:15:28AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> >> +	if (argc)
>> >> +		usage(_("'git refs verify' takes no arguments"));
>> > 
>> > Junio has posted a patch series [1] where he wants to get rid of
>> > messages that simply say "no arguments" or "too many arguments".
>> > ...
>> > So I'd propose to make this:
>> >
>> >     argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
>> >     if (argc)
>> >             usage(_("unknown argument: '%s'", argv[0]));
>> 
>> I probably should have said that I am fully behind the intent
>> against "too many arguments", but I am not 100% behind the
>> particular messaging used in the patch series I sent out.
>> 
>> One potential complaint I expected to hear, for example, was that "a
>> is unknown" given when you said "git cmd a a a a a" is not all that
>> clear ;-).  To alleviate, you would have to say "git cmd takes only
>> 2 arguments" if 'a' you are complaining about is the third one.
>> 
>> Also, many people would consider that "unexpected argument" is
>> better than "unknown argument".
>> 
>> I personally think the message above is absolutely clear and good.
>> 
>> You say that 'git refs verify' takes no arguments, and for somebody
>> who said "git refs verify a b c d e", there is no doubt that all of
>> these a b c d e are unwanted.  And there is no room to misinterpret
>> the message as "'git refs' is ok but 'git refs verify' is already
>> unwelcome with extra argument", either [*].
>> 
>> In short, I think the message in the patch here is good, and it is
>> the other "war on 'too many arguments'" series whose messages need
>> to be thought further.
>
> Just to clarify: with "the patch" you probably refer to the current
> version that Jialuo has, right? In other words, keep the current version
> that he has and adapt the message in the future, when we have decided
> what to do about those "too many arguments" messages?

I meant that I think (1) that "'git refs verify' takes no arguments"
is a good message, and (2) that there is no further change needed to
the patch that started this review thread, regardless of how we want
to deal with "too many arguments" messages.

> If so, then the only two I had were some spurious newlines. I'm not sure
> whether these really would be worth rerolling the whole patch series.

Yup, those blank lines were annoying while scanning the patches, but
they alone would not be something that makes a reroll _required_.  A
reroll that clearly shows that the incremental change since the last
round is only these blank line changes is not too much to process,
so "not worth the reviewer time" is not a huge reason to avoid it,
either.  I'd see that it is up to how perfectionist the patch
submitter wants to be ;-)

Thanks.

