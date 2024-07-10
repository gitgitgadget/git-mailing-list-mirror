Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F6195389
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625689; cv=none; b=HeiofEZU6CdzXMb08Wv8LUhACHW6p5uDDSv0MGS4z67beEwvw1cXgfvmHjdY8nRwkRTrM0TQ83jx1/Z9uC7mJhZDPGFWIMCGXnKUiWhP1mz0jsezHVi0S11DOqOk0l6vgznJ7LTmmsK6BIhwZDw7l83l6XiqBEENwjrgML1+SDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625689; c=relaxed/simple;
	bh=Tylfw3znC4zpVUQxqa7afdbvqQMpEzj5KL1mKmEEfT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGcr0A1XO7evVkD68XAYgDHyiN7D9e5WAV0f2rFqLtJ/yXzdc5b7aKm3TWb1PJSixUFJiA4Mf6woSKG6HSt473l7m09b9+WWRHqANnxI7vVMxLw99vlOGaicyYhZa9xN00cluAki6ntZKKtLm2av0nFkjh+zoT2wTijXblAWv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C6a4o+d8; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C6a4o+d8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58F3E1D9DD;
	Wed, 10 Jul 2024 11:34:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Tylfw3znC4zpVUQxqa7afdbvqQMpEzj5KL1mKm
	EEfT8=; b=C6a4o+d8vXbWeukF0Jd2baJy9MK0M13EGWfXzYQPJ4GUoXqmdavERE
	fJu5zi8ES2CX0O1sKP+9e/jiLqooCny/djWt7LxAJRoKPVU8q98zdazs2cEssWSg
	y2LtMmz86IWbFFv5GjCihZBl3YHiHM3TQ3Cnc04nYS3v2Ww7eD744=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 507DC1D9DC;
	Wed, 10 Jul 2024 11:34:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B798E1D9DB;
	Wed, 10 Jul 2024 11:34:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2] builtin/push: call set_refspecs after validating remote
In-Reply-To: <CAOLa=ZQXZ6DyE3YjuVU48nQcj0xuW7uPoPvg2yqktk+S6gXwsg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 10 Jul 2024 06:12:21 -0700")
References: <20240708140350.622986-1-karthik.188@gmail.com>
	<20240709144931.1146528-1-karthik.188@gmail.com>
	<xmqq4j8yflrq.fsf@gitster.g>
	<CAOLa=ZQXZ6DyE3YjuVU48nQcj0xuW7uPoPvg2yqktk+S6gXwsg@mail.gmail.com>
Date: Wed, 10 Jul 2024 08:34:39 -0700
Message-ID: <xmqqle29z2eo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EC70FC90-3ED1-11EF-85D6-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> In any case, an obvious additional fix on top of your change might
>> be to do something like this:
>>
>>         diff --git i/remote.c w/remote.c
>>         index 5fa046c8f8..d7f9ba3571 100644
>>         --- i/remote.c
>>         +++ w/remote.c
>>         @@ -682,7 +682,7 @@ remotes_remote_get_1(
>>                 struct remote *ret;
>>                 int name_given = 0;
>>
>>         -	if (name)
>>         +	if (name && *name)
>>                         name_given = 1;
>>                 else
>>                         name = get_default(remote_state, remote_state->current_branch,
>>
>> which would give us the default remote name, and we would not call
>> add_url_alias() with a bogus empty string to nuke the list.
>>
>
> I'm a bit skeptical of making this change. Mostly from the user's
> perspective.
> ...
> This is because we actually obtained the default remote here. Isn't this
> confusing from a user's perspective?

I agree with you 100%.  I haven't checked the ramifications of such
a change to other code paths, and callers of remote_get() are many.
With your fix, the above is not necessary and it certainly can be
left well outside the scope of the current topic.

> I mean I agree that an empty repo
> name is something we should support, but it also shouldn't be something
> we simply ignore?

For the sake of simplicity of the UI design, I think an empty repo
name (giving an empty string explicitly where a repository nickname
or URL is expected) should be forbidden.  The above change lets ""
stand for the default remote (which is different from "simply"
ignoring), and is confusing, because we never did that historically.
Unless we advertise it as a new "feature" [*], that is (and I do not
believe it is such a great feature myself).

> So if we're simply testing my patch, this is definitely enough. But I
> wanted to also keep in mind the state before this patch. Wherein the
> only way the flow would be triggered is if we provide a local_ref,
> providing ':' follows a different path in 'set_refspecs'.

OK.  If so we may want to have both, so that we won't regress in the
other code paths?

Thanks.


[Footnote]

 * When you want to interact with the remote you usually work with
   but want to affect a custom set of refs, with the current UI,
   you'd need to remember what you call that usual remote (typically
   "origin") and say "git [push|fetch] origin $refspec".  The above
   change may be seen as a feature that allows you to use an empty
   string in place of the remote that has to be named explicitly on
   the command line.

