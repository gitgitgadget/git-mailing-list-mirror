Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E701FBB
	for <git@vger.kernel.org>; Tue, 21 May 2024 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306739; cv=none; b=dSP67inACsuwcC15AfIUG+dqgKoLou9GHlFLg0yjSxUz6r7IbfaI04QrYSh4eLJq3RUhMM4wJd6WKskKNBW5j8jh68JXki97Wl74QQXtT/JhbNh5HyHgc0Int9SIq0uaD64IcOPz0bqHCcih5bqaKMLDfKzYQ3H2AkY79xLVJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306739; c=relaxed/simple;
	bh=g2yMlhD1W1Kb6iXkCAfNiI0BuozSQ6IZMlRYaFyPpwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bEDZYBTJuw74Sb/ideM6ICn6YySEqEjbz2icYhMam+IggatLNISabbi7Pypwbxe/1Du7Pct+5EqCUbcDzMffFtBvDCGE8/pjjxgpNBp5ox9jQRU/QiJZ86YtR/ujix/78pl4aNI4E8WJiFKQVrvU2BP7pgXsYpOOZ8ThhSvMP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BJ5xUrK/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BJ5xUrK/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CFB32F931;
	Tue, 21 May 2024 11:52:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g2yMlhD1W1Kb6iXkCAfNiI0BuozSQ6IZMlRYaF
	yPpwA=; b=BJ5xUrK/r9jLfDkyXFNzQYV9OZiX9kbYLVcPJjMH+lrUz6KypXP3p0
	G6xFbL/lJb/uN2aSnAGKwamNMjlnxjDX9ptjAxn3YUXlPsLuOFG5cotg7tmfZZZf
	yRajTPA9ZvRg1bR0ox5GCmZscsef+68pXsMHfQjrhVvX43nIqziMk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84ED72F930;
	Tue, 21 May 2024 11:52:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E26012F92F;
	Tue, 21 May 2024 11:52:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re* [PATCH] add-patch: response to unknown command
In-Reply-To: <ZkxHLE_8OpYvmViY@tanuki> (Patrick Steinhardt's message of "Tue,
	21 May 2024 09:03:08 +0200")
References: <1dbe4c61-d75f-45d9-95d2-ac8acae22c56@gmail.com>
	<ZkxHLE_8OpYvmViY@tanuki>
Date: Tue, 21 May 2024 08:52:14 -0700
Message-ID: <xmqqr0dvb1sh.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 18B8400C-178A-11EF-9917-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I'm a bit on the edge here. Is it really less confusing if we confront
> the user with a command that they have never even provided in the first
> place? They implicitly specified the first letter, only, but the user
> first needs to be aware that we discard everything but the first letter
> in the first place.

I share your doubt.  If what the user said (e.g. "ues") when they
wanted to say "yes", I find "You said 'u', which I do not understand" 
more confusiong than "You said 'ues', which I do not understand".

> Is it even sensible that we don't complain about trailing garbage in the
> user's answer? Shouldn't we rather fix that and make the accepted
> answers more strict, such that if the response is longer than a single
> character we point that out?

I personally guess that it is unlikely that folks are taking
advantage of the fact that everything but the first is ignored, and
I cannot think of a reason why folks prefer that behaviour offhand.

If 'q' and 'a' are next to each other on the user's keyboard, there
is a plausible chance that we see 'qa' when the user who wanted to
say 'a' fat-fingered and we ended up doing the 'q' thing instead,
and we may want to prevent such problems from happening.

Instead of ignoring, we _could_ take 'yn' and apply 'y' to the
current question, and then 'n' to the next question without
prompting (or showing prompt and answer together without taking
further answer), and claim that it is a typesaving feature, but
it is dubious users can sensibly choose the answer to a prompt
they haven't seen.

So, I am inclined to be supportive on that "tighten multi-byte
input" idea, but as I said the above is based on a mere "I cannot
think of ... offhand", so we need to see if people have reasonable
use cases to object first.

------- >8 ------------- >8 ------------- >8 ------------- >8 -------
Subject: add-patch: enforce only one-letter response to prompts

In an "git add -p" session, especially when we are not using the
single-char mode, we may see 'qa' as a response to a prompt

  (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?

and then just do the 'q' thing (i.e. quit the session), ignoring
everything other than the first byte.

If 'q' and 'a' are next to each other on the user's keyboard, there
is a plausible chance that we see 'qa' when the user who wanted to
say 'a' fat-fingered and we ended up doing the 'q' thing instead.

As we didn't think of a good reason during the review discussion why
we want to accept excess letters only to ignore them, it appears to
be a safe change to simply reject input that is longer than just one
byte.

Keep the "use only the first byte, downcased" behaviour when we ask
yes/no question, though.  Neither on Qwerty or on Dvorak, 'y' and
'n' are not close to each other.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 add-patch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/add-patch.c w/add-patch.c
index 2252895c28..7126bc5d70 100644
--- c/add-patch.c
+++ w/add-patch.c
@@ -1227,6 +1227,7 @@ static int prompt_yesno(struct add_p_state *s, const char *prompt)
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			return -1;
+		/* do not limit to 1-byte input to allow 'no' etc. */
 		switch (tolower(s->answer.buf[0])) {
 		case 'n': return 0;
 		case 'y': return 1;
@@ -1509,6 +1510,10 @@ static int patch_update_file(struct add_p_state *s,
 
 		if (!s->answer.len)
 			continue;
+		if (1 < s->answer.len) {
+			error(_("only one letter is expected, got '%s'"), s->answer.buf);
+			continue;
+		}
 		ch = tolower(s->answer.buf[0]);
 		if (ch == 'y') {
 			hunk->use = USE_HUNK;

