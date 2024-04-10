Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2DC1E878
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763881; cv=none; b=NcNN9L4dADX1c6DJp3a9AoQ+Xw/l3QfVshB5/c9oCR7MR+tpd9Pq6manYvu0Dcq6bGs59ZwhfROZFhZYK+Ae8gKEwpbiM9pZOP9i9tT8OtAnTzbLZEzH7fwhvnSV0VoZdgo4LgKvWqAWKh5OINwTJUdRbWeWbRX7Oo1qtp70Jl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763881; c=relaxed/simple;
	bh=Dv1TInMFzcAi0ttQ88/bMrF2E4cPBjruFLuAFtVnLZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lduavTgQr7NfpYhcx5TGKDp1f00UzWbMgJxQGJcjLUqxw3aBoL6Rbwj7ad8oAf2Ie3VmxRLqHUjvbhNLts1pc0dIg34JfpHvzXePp+2Pmmw4CsXQwBfu63pWnap5Wj+PTYWg+/auQBAk8ctSES2L9xYIQQOjE8UULs1teAL1WP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MbJKcat2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MbJKcat2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 61459219D3;
	Wed, 10 Apr 2024 11:44:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Dv1TInMFzcAi
	0ttQ88/bMrF2E4cPBjruFLuAFtVnLZA=; b=MbJKcat2xJvkdufjTwecJIVlEFvB
	1VD3KJOoL4QUz9nfWm+tP5hnln9eSECmtkiQmCWD3hHXA+0dD24uTKDr3kFvkXJb
	YZ1T/NZYMFZGC+koPP6VBW6XiMT1GX5KeBNafSP8LgO6m1eY/NCRkuEelI4d281P
	6ha9mBjNsZExqdM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5992C219D2;
	Wed, 10 Apr 2024 11:44:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11E67219C9;
	Wed, 10 Apr 2024 11:44:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] launch_editor: waiting message on error
In-Reply-To: <54dcd4f1-5a79-47ba-9650-7115b7170a84@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 10 Apr 2024 01:38:10 +0200")
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
	<96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
	<0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
	<xmqq4jcb495u.fsf@gitster.g>
	<54dcd4f1-5a79-47ba-9650-7115b7170a84@gmail.com>
Date: Wed, 10 Apr 2024 08:44:25 -0700
Message-ID: <xmqqle5lxlwm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3652BBBE-F751-11EE-9DF2-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On Mon, Apr 08, 2024 at 06:27:57PM -0700, Junio C Hamano wrote:
>
>> I wonder if we can just call term_clear_line()
>> regardless of the value of ret.  Either case, the waiting is already
>> over and in the error case, we show another message after it.
>
> My concern is that perhaps term_clear_line() might clear some useful
> information for the user.  Although I am not sure that this concern is
> sensible.

It happens ONLY when the error message the editor itself emits
(which comes later on the same line as "We are waiting for your
editor...") without terminating newline itself.  Otherwise, we'd
have

    We are waiting ... THE EDITOR SAYS I FAILED
    _

on the screen, and the cursor is at the _ position.  term_clear_line()
would not clear anything.

> Stepping back a bit, how painful it would be to drop the
> term_clear_line() and start using advice_if_enabled() here?
>
> This is what I'm thinking about now.
>
> 	$ GIT_EDITOR=3Dfalse git commit -a
> 	hint: A-good-explanation-to-say-we-run-'editor'
> 	hint: Disable this message with "git config advice.waitingForEditor fa=
lse"
> 	error: There was a problem with the editor 'false'.
> 	Please supply the message using either -m or -F option.

I do not think the problem is in the case where the editor
immediately exits with an error.  It is when the editor opens
elsewhere (or more likely, opens another tab to let you edit in an
existing GUI editor session, but the editor's window is buried under
other windows) and your "git commit" will stay silently without
giving you back a terminal prompt, leaving you wondering why it is
taking so much time.

So I am not sure if the advice mechanism is a good fit.

>> There is another error message when we fail to start the editor.
>> Doesn't that codepath have the same problem?
>
> Of course.
>
> My itch is:
>
> 	$ GIT_EDITOR=3Dfalse git commit -a
> 	hint: Waiting for your editor to close the file... error: There was a =
problem with the editor 'false'.
> 	Please supply the message using either -m or -F option.

I do not think we want to encourage "-m" when the end user did not
say so.  Instead we should let them fix their editor to keep them
more productive.

Thanks.
