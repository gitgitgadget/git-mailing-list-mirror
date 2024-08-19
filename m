Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34113A24E
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082115; cv=none; b=W5k5PDShLG7sBozndyXRC2x2P8YotHuVpE6L8+Nx8cU4b7TRSYs5bzSRsH/X+REw0tqUW3BqOWyBKxsuGdpO08RAsJdkvA3MpiPYqfe68zwnb9FqYsVB3UKtX/wFPy5K685DY8ctd9LHb3B4E0ragc1IbR1kQKviPThGZZ1c59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082115; c=relaxed/simple;
	bh=41FjyxR3dpbCitLR+OBm4dNmwgzYG34bOgmStpaGunQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LqnSrA4MZsylxLc/mQ0xFVXsJJVyIfRATfdHJ4pV07awax8WKHAim0t9qtFpT6G+40shXPVlp8Mf35J3YXvqlsB8QWynZjsSq8yMqwKsxIlflYjHG8IJXjcBvsPEuCtefinTpq+3AJspnGjQEpRdCDIqzmkJxIXjchPJ3RU82XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CqHZq52M; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CqHZq52M"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E3EA2125A;
	Mon, 19 Aug 2024 11:41:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=41FjyxR3dpbCitLR+OBm4dNmwgzYG34bOgmStp
	aGunQ=; b=CqHZq52Mr/LIJ8AJN93YMk7UzvUEJcFoqiGZg+ZTQE4O6m9EbP4SZo
	WlH6NjXxyib99mzFgVePB1Xdv0KX88m72rT9W1B/x3DrLN0BlTzHDQ7TA0F1TLuH
	CP/pETlUUDalmsusHI9KROzvla6kKFFxKcdmhhFbOmJjSW45a4+S0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 255A721259;
	Mon, 19 Aug 2024 11:41:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87CC021258;
	Mon, 19 Aug 2024 11:41:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matheus Tavares Bernardino <matheus.tavb@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  newren@gmail.com,
  ps@pks.im,  Lincoln Yuji <lincolnyuji@hotmail.com>,  Rodrigo Siqueira
 <siqueirajordao@riseup.net>
Subject: Re: [PATCH v2] rebase -x: don't print "Executing:" msgs with --quiet
In-Reply-To: <CAGdrTFhZ6KeDPDUoCsV3h5myPuoYf7RR8eFdbFFXGrUGCdEkEw@mail.gmail.com>
	(Matheus Tavares Bernardino's message of "Sun, 18 Aug 2024 10:03:45
	-0300")
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
	<be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
	<xmqq34n3jswh.fsf@gitster.g>
	<CAGdrTFhZ6KeDPDUoCsV3h5myPuoYf7RR8eFdbFFXGrUGCdEkEw@mail.gmail.com>
Date: Mon, 19 Aug 2024 08:41:45 -0700
Message-ID: <xmqqwmkcfrk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8AC39540-5E41-11EF-AEA5-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Matheus Tavares Bernardino <matheus.tavb@gmail.com> writes:

> Nonetheless, since these are invisible chars (assuming we haven't
> printed anything to be "cleaned" before them), printing them doesn't
> actually make a difference to the user running rebase in the terminal,
> as they won't see the chars anyways.
>
> The actual issue is when piping/redirecting the rebase output, which
> will include these invisible chars... So perhaps, instead of modifying
> the sequencer.c to use "if (!opts->quiet && !opts->verbose)
> term_clean_line()", the correct approach would be to modify
> "term_clean_line()" to return earlier "if (!isatty(1))". What do you
> think?

So, term_clear_line() assumes that there were something already on
the line, goes back to the beginning of the line and then makes what
was on the line invisible, either by overwriting them with enough
spaces or with "clear to the end of line" sequence, and then go back
to the beginning of the line.  None of that really makes much sense
if the output is not going to the human user sitting in front of the
terminal, so isatty(1) (or isatty(2)[*]) based guard does sound like
the right thing to do.  I certainly would have suggested us do so if
we were inventing this code anew today, and offhand my gut feeling
is that it is unlikely if such a behaviour change causes breakage of
any existing scripted use.

But people do "interesting" things, and because there are
sufficiently large number of Git users, I would not be totally
surprised if there are people who "double check" by, say, counting
"Rebasing" and "Executing" and making sure these match what they fed
in the todo file---their use case will certainly be broken.

>> I actually would have expected that this message ...
>>
>> >                       fprintf(stderr, _("Stopped at %s...  %.*s\n"),
>> >                               short_commit_name(r, commit), item->arg_len, arg);
>>
>> ... goes away when opts->quiet is in effect ;-).
>
> Sure, I can add that :) I was mostly focused on the "Executing ..."
> lines, so that's why I haven't seen/touched this one.

It would make the user experience horrible if we removed this
"Stopped at", especially with the "Rebasing..." indicator that is
given at each step squelched with the "opts->quiet" flag, because
the user would totally really lose where they are if we did't give
this message.  As it is the norm for sequencer operations to advance
without human intervention, stopping at somewhere ought to be given
a bit more special status and deserves to be marked as such.

With the same yardstick, removing "Executing:" message while running
under the --quiet option, when these "exec" insn were automatically
inserted via "rebase -x", does make sense, because it is just "a
stream of insns given in the todo file, we execute one step at a
time, and we stay quiet unless some exceptional thing happens".
Because we give a warning if the execution fails or the execution
leaves the working tree dirty, and we include what command we
attempted to run with the "exec" insn, it is unlikely that users
will lose their place and get confused.

If a user of "rebase -i" inserted an "exec" insn at a selected place
in the todo file, the above argument to sequelch "Executing" becomes
a bit weaker, but I think it still is OK.
