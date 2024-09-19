Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C6168C7
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726787272; cv=none; b=ZtK74tLOd3n7BNMYaFq89B63Db6CSomX+2xTasOztoyFXKF3cr1irHrixTHTKluUdMkfYjzorh2X7N+6wsqFNetEnZkKGqvspJLzLLOSlAyDv8pFpviqMQ6ma/AmAx6TkG317ZhLri1CpGMJy4M5O6gJpTaHDL/uKa5Ce8L/8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726787272; c=relaxed/simple;
	bh=lQkeqfqo6kwBU2ON74ovQlsH5MYZ8McHhz1EyvScIXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z13BScguBEwKc5HLFdGhNWhZ2NaWMrVHCbNoLzpV+wkei/oadvGnsgWOP9LEVzmjOqwf2z5elAy/T/vDfJjW7iZaEohUCbymTjwJY4CJ6zoNq/AMjr1TVGmUpcvsRKdaggcCyAuMdqScSwQKSkN47/qw9pHwp4547D2hOHec2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G2+JIemB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G2+JIemB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 79DB62DD68;
	Thu, 19 Sep 2024 19:07:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lQkeqfqo6kwBU2ON74ovQlsH5MYZ8McHhz1Eyv
	ScIXs=; b=G2+JIemBnwfGG8dB9pNLIcdIwMGivZxM9ulM9M1EDC+4dJqADUruAt
	gnLnUT2S9G2nS9cT4rHQ9RFjOvH80vYzzOfpfm+ziSsS/gNvM/47hpPsdJWx0MYG
	td7rTg+lrAjUq34ULHQhLXrPFhbRKazeJnqlDVg/vQeJD+NiH+AE0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 71CC12DD67;
	Thu, 19 Sep 2024 19:07:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFE472DD65;
	Thu, 19 Sep 2024 19:07:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, 	Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] fetch: set remote/HEAD if it does not exist
In-Reply-To: <20240919121335.298856-3-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Thu, 19 Sep 2024 14:13:26 +0200")
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
	<20240919121335.298856-1-bence@ferdinandy.com>
	<20240919121335.298856-3-bence@ferdinandy.com>
Date: Thu, 19 Sep 2024 16:07:47 -0700
Message-ID: <xmqqjzf744zg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FD246F9E-76DB-11EF-AE65-9B0F950A682E-77302942!pb-smtp2.pobox.com

Bence Ferdinandy <bence@ferdinandy.com> writes:

> If the user has remote/HEAD set already and it looks like it has changed
> on the server, then print a message, otherwise set it if we can.
>
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> ---
>
> Notes:
>     v3: - does not rely on remote set-head anymore so it only authenticates
>         once
>         - uses the new REF_CREATE_ONLY to atomically check if the ref exists
>           and only write it if it doesn't
>         - in all other cases the maximum it does is print a warning

Except for one thing, I can tell from the above that the design is
sensible without looking at the actual patch.  Nicely described.

The "one thing" is what to do if you normally do *not* keep track of
the remote-tracking refs for this particular remote.

If I am only fetching refs (or HEAD) in FETCH_HEAD for immediate
consumtion by doing "git pull bence HEAD" with something like

    [remote "bence"]
	 URL = http://github.com/bence/git

(with no other configuration under remote.bence.* hierarchy), I do
not think I want the code to create refs/remotes/bence/HEAD, with
no other remote-tracking refs in the same hierarchy, even if it finds
no existing refs/remotes/bence/HEAD there.  For that, I suspect that 
you'd need to see if the pointee of refs/remotes/bence/HEAD either
already exists or this fetch is about to create it, or something
like that, before deciding to create a ref with the REF_CREATE_ONLY
flag.

If you are doing so already in the code (I haven't started reading
it yet at this moment), you should mention it in your proposed log
message, so discount my earlier "Nicely described" a bit ;-).

Let's see what actually happens in the code now.

> +static const char *abbrev_ref(const char *name, const char *prefix)
> +{
> +	skip_prefix(name, prefix, &name);
> +	return name;
> +}
> +#define abbrev_branch(name) abbrev_ref((name), "refs/heads/")

We do not call the act of optionally skipping prefix "abbreviate" in
this project (object names are abbreviated but that is done by
chomping the later bytes of a long name).

I suspect that a caller of either of these two functions are
inherently buggy in that they _optionally_ skip the prefix so they
do the same thing for "refs/heads/main" and "main" but not
"heads/main".  The callsites may need to be inspected to see how
they should deal with cases where skip_prefix() did *not* see
anything to skip.

> +static inline int set_head(const struct ref *remote_refs)

Drop "inline".  You do not want to inline this much code if there
are many callers, and if you have only one caller, the compiler
would inline it into the sole caller if it is the more efficient
thing to do.

> +{
> +	int result, ref_changed = 0;
> +	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT, b_local_head = STRBUF_INIT, b_prefix = STRBUF_INIT;
> +	const char *remote = gtransport->remote->name;
> +	char * head_name = NULL;
> +	struct ref *ref, *matches;
> +	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
> +	struct refspec_item refspec = {
> +		.force = 0,
> +		.pattern = 1,
> +		.src = (char *) "refs/heads/*",
> +		.dst = (char *) "refs/heads/*",
> +	};
> +	struct string_list heads = STRING_LIST_INIT_DUP;
> +
> +	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
> +	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
> +				    fetch_map, 1);
> +	for (ref = matches; ref; ref = ref->next)
> +		string_list_append(&heads, abbrev_branch(ref->name));
> +
> +
> +	if (!heads.nr)
> +		result = 1;
> +	else if (heads.nr > 1) {
> +		result = 1;
> +	} else
> +		head_name = xstrdup(heads.items[0].string);
> +	if (head_name) {
> +		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
> +		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
> +		strbuf_addf(&b_prefix, "refs/remotes/%s/", remote);
> +		if (!refs_read_symbolic_ref(get_main_ref_store(the_repository),b_head.buf,&b_local_head)) {

Overly long lines around here cannot be sanely reviewed on my
terminal, so I'll stop here for now.  

Do not omit SP after ",", as that is the least effective way to
shorten overly long lines.  Instead, consider introducing a
one-time-use temporary variables with meaningful name, e.g.

		struct ref_store *store = get_main_ref_store(the_repository);
                
                strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
		...
		if (!refs_read_symbolic_ref(store, b_head.buf, &current)) {
    			/* it's current value is in "current" */
			...

