Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E815749A
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692610; cv=none; b=p5+QwLrVc0GyONKRir7M8TUYIJLAp5gobdvxc89z8ay2v30kWBiPhZLZBI03SgdmFG5EXKibIovQWN0dbmUsf2wyer4k/KhfGRFH0DsCO5mfAheL5/I6M8RhAZPVOsvPKw/qLV5RjDTweRXBWKWKeBBScyus7GgJ/cx/IuBOJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692610; c=relaxed/simple;
	bh=+UIHxuBZd2asz0yPl6l/xQ/ct2iy+Rng8+BOP1yy/1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUYgZSpPxxhLcvaQM3LlNcXBGpRpn3xLxSdL+8blSDAyGQyiucwKKAgtceyoA6tpKO6pJbDS+6EmuQ4gKkcC12JP3GDZ/VfO0N0se4bqftgD5lUEB5yB1plbIjY55QYsfCvr5yj9kaHltxaFgEM7d7CDk8xwu2EfrThWEdBGtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V/x3sPEv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V/x3sPEv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B267B1E5B73;
	Tue,  9 Apr 2024 15:56:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+UIHxuBZd2asz0yPl6l/xQ/ct2iy+Rng8+BOP1
	yy/1w=; b=V/x3sPEvUWhuJ/g+I66acwsRP5QhiojZCVJcueGq3iSt9Dl/WLALT/
	sQLCIyBZyGp7NELbka8uRQotzuQAQjfiVvzZCqEpMRyMR4aWfsSf7nUN0l0lCty/
	79dJUgMIciK9e+aS2eqPf8dhS4iuqvtATEbH2Ov2OnZJGLA0QX3FU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA8EB1E5B72;
	Tue,  9 Apr 2024 15:56:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F0551E5B71;
	Tue,  9 Apr 2024 15:56:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Stefan Haller <lists@haller-berlin.de>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/2] rebase -i: improve error message when picking merge
In-Reply-To: <1b74f6f9-f4b9-4909-82b3-26f19b7a1347@gmail.com> (Phillip Wood's
	message of "Tue, 9 Apr 2024 16:04:33 +0100")
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
	<pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
	<fbc6746e0188ed7b69c238935ec85b69112ddd79.1712585788.git.gitgitgadget@gmail.com>
	<xmqqle5n7ajt.fsf@gitster.g>
	<1b74f6f9-f4b9-4909-82b3-26f19b7a1347@gmail.com>
Date: Tue, 09 Apr 2024 12:56:45 -0700
Message-ID: <xmqqpluy1f9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4C16746E-F6AB-11EE-993A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> +		return error(_("'%s' does not accept merge commits, "
>>> +			       "please use '%s' followed by '%s'"),
>>> +			     todo_command_info[command].str,
>>> +			     "merge -C", "break");
>> OK.  And when hitting the "break", they know that they are supposed
>> to say "git commit --amend" and then "git rebase --continue"?
>
> Yes. I guess we could add a hint to that effect if you think its worth it.

As I said elsewhere, I do not deal with non-linear stuff using
sequencer, so I _may_ be missing something obvious to the target
audience of this message.  But if I were dipping my toes to try
mucking with sequencer and edit the todo myself by inserting a random
merge commit there and got this message, I would have probably
appreciated if the message were a bit more explicit _why_ I would
want to use the 'break' there.  Otherwise, I probably would be lost
sitting in front of the shell command prompt.  If it were

	'pick' does not take a merge commit.  If you wanted to
	replay the merge, use 'merge -C' on the commit, and then
	'break' to give the control back to you so that you can
	do 'git commit --amend && git rebase --continue'.

that would have given me 70% of what I needed (the other 30% is why
I would want to "--amend", instead of just taking the result of
'merge -C' as-is, though).

We can formulate the message in such a way that a succinct first
part is sufficient for people who know the command, while the latter
more verbose and prescriptive part can be hidden behind the advice
mechanism.

> It feels funny to call error_merge_commit() for a command that we know
> supports merges but I can see that would make it easier to extend in
> the future.

Yes, I think that it is just a sign that the function is misnamed.
"Gee we have a merge commit, please tell me what you want to do with
it" is what the caller is asking, and the error messages are side
effects the caller does not have to care too much about.
