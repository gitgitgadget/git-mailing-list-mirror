Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33E39FC1
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511804; cv=none; b=UGKFzqS4mY3r9OnAKlV+pP1zZgYYxUXzGuDw/vUJtr7CThxodXhFWglf7IrK7DY/XwwCcWsB4FO9SlTk70g6T//XhHhRegRmiGfwxJPTvvbUCdNpsjWJK++1siRyF6KdrENbcqU7sf5FZOvIBZZrq0cwLiD3rf730BB8KXkBRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511804; c=relaxed/simple;
	bh=L5YL2uiviHU3hf4LBtkYPIQClsFsWdyLB1G37tKLSJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=puTpjrODFiC2f7z3+n1GLPCpvKmjPsBXAu7sL5ABwMv5bJq9kqq499tNMPW9T0ASuIY/X3mo81I4q683XlDS35fkc07QpFSu9d7Dc0iZcjUxjFIWUjed/LJzqBKg0G5olDMcsQxwHfr8DN89enmhdOMeBw2m6zb7jmz1Gr45uDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oQAoOHcm; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oQAoOHcm"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 283B1363F9;
	Mon, 16 Sep 2024 14:36:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=L5YL2uiviHU3hf4LBtkYPIQClsFsWdyLB1G37t
	KLSJ0=; b=oQAoOHcmr5kYbC45dk9k+GgBHD+d5JGYbh7evb04PHtqB8zeCiNGWe
	40aR/kzju8YhlJcSPbL12TOk+NfPHlZ2lhHtybkxwEQuff6jQhiQEnYv5iF7lZ5K
	10beceaHFzrIPQNZBwMDEVNDiiLW+hwFN1bRajUuvCTGE5G/lHjwQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E7AA363F8;
	Mon, 16 Sep 2024 14:36:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86843363F7;
	Mon, 16 Sep 2024 14:36:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Patrick Steinhardt <ps@pks.im>, 	Christian
 Schlack <christian@backhub.co>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] set-head: no update without change and better output
 for --auto
In-Reply-To: <20240915221055.904107-1-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Mon, 16 Sep 2024 00:09:54 +0200")
References: <20240915221055.904107-1-bence@ferdinandy.com>
Date: Mon, 16 Sep 2024 11:36:39 -0700
Message-ID: <xmqq5xqvo37s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9D3D770C-745A-11EF-B230-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

The message I am responding to is sent as the first message to start
a brand-new thread, but for future reference, it makes it easier for
everybody involved if you sent a new iteration of a patch (or a
patch series) as a reply/follow-up to the last round.

If it is too cumbersome to do for any reason, as an alternative, you
can give a reference to previous rounds as URLs to the list archive,
i.e.

 (v1) https://lore.kernel.org/git/20240910203129.2251090-1-bence@ferdinandy.com/
 (v2) https://lore.kernel.org/git/20240910203835.2288291-1-bence@ferdinandy.com/

> Currently, even if there is no actual change to remote/HEAD calling
> remote set-head will overwrite the appropriate file and if set to --auto
> will also print a message saying "remote/HEAD set to branch", which
> implies something was changed.
>
> Change the behaviour of remote set-head so that the reference is only
> updated if it actually needs to change.

I sense a patch with a racy TOCTOU change coming ;-)

> Change the output of --auto, so the output actually reflects what was
> done: a) set a previously unset HEAD, b) change HEAD because remote
> changed or c) no updates. Make the output easily parsable, by using
> a slightly clunky wording that allows all three outputs to have the same
> structure and number of words.

This would be useful.

>         This patch was originally sent along when I thought set-head was
>         going to be invoked by fetch, but the discussion on the RFC
>         concluded that it should be not. This opened the possibility to make
>         it more explicit.

I am not quite sure what the discussion concluded "should be not",
though.  In a message from you

  https://lore.kernel.org/git/D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com/

what we agreed was that "git fetch" does not need a new option, but
we also agreed that it would be a good idea for "git fetch" to
create, refs/remotes/$remote/HEAD when it does not exist without
being told.

I take it that you still want to see such a change to "git fetch"
eventually happen, but decided to tackle the other half of the
original two-patch series first with this patch?

>  static int set_head(int argc, const char **argv, const char *prefix)
>  {
> -	int i, opt_a = 0, opt_d = 0, result = 0;
> -	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
> +	int i, opt_a = 0, opt_d = 0, is_ref_changed = 0, result = 0;

Shall we simply call it ref_changed instead, so that I do not have
to wonder which is better between has_ref_changed and is_ref_changed? ;-)

> +	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
>  	char *head_name = NULL;
>  
>  	struct option options[] = {
> @@ -1440,13 +1440,19 @@ static int set_head(int argc, const char **argv, const char *prefix)
>  
>  	if (head_name) {
>  		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);

> +		refs_read_symbolic_ref(get_main_ref_store(the_repository),buf.buf,&buf3);
> +		is_ref_changed = strcmp(buf2.buf,buf3.buf);
>  		/* make sure it's valid */
>  		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
>  			result |= error(_("Not a valid ref: %s"), buf2.buf);
> -		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
> +		else if (is_ref_changed && refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
>  			result |= error(_("Could not setup %s"), buf.buf);

Two and a half small issues:

 - Do not omit " " after "," and avoid overlong lines by folding
   lines at an appropriate place (usually after an operator at
   higher point in parse tree, i.e. after "is_ref_changed &&").

 - This is inherently racy, isn't it?  We read the _current_ value.
   After we do so, but before we write _our_ value, another process
   may update it, so we'd end up overwriting the value they wrote.

 - To compute is_ref_changed, we look at buf3.buf but what happens
   if such a ref does not exist, exists but is not a symbolic ref,
   or is a hierarchy under which other refs hang (e.g., a funny ref
   "refs/remotes/origin/HEAD/main" exists)?  Does the strcmp()
   compare a valid buf2.buf and an uninitialized junk in buf3.buf
   and give a random result?  Shouldn't the code checking the return
   value from the refs_read_symbolic_ref() call, and if we did so,
   would we learn enough to tell among the cases where (1) it is a
   symref, (2) it is a regular ref, (3) no such ref exists, and (4)
   the refs layer hit an error to prevent us from giving one of the
   previous 3 answers?

If we really wanted to resolve the raciness, I think we need to
enhance the set of values that create_symref() can optionally return
to its callers so that the caller can tell what the old value was.

I am not sure offhand how involved such an update would be, though.

> +		else if (opt_a && !strcmp(buf3.buf,""))
> +			printf("%s/HEAD was unset: set to %s\n", argv[0], head_name);

I suspect that this does not account for a case where the
"read_symbolic_ref()" we did earlier failed for a reason other than
"the ref did not exist".

> +		else if (opt_a && is_ref_changed)
> +			printf("%s/HEAD was changed: set to %s\n", argv[0], head_name);
>  		else if (opt_a)
> -			printf("%s/HEAD set to %s\n", argv[0], head_name);
> +			printf("%s/HEAD was unchanged: set to %s\n", argv[0], head_name);
>  		free(head_name);
>  	}

Quoting the values we obtained from the environment or the user may
be nicer, e.g.

    'refs/remotes/origin/HEAD' is now set to 'main'.
    'refs/remotes/origin/HEAD' is unchanged and points at 'main'.

This is a tangent outside the immediate topic of this patch, but I
wonder if we need "--quiet" mode.

Thanks.
