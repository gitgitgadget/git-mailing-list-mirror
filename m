Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA4C2D0E4
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0C622470
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pgRbrquw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgKUA2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:28:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64793 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKUA2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 19:28:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12E0AA2BD1;
        Fri, 20 Nov 2020 19:28:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3FrqmMDbzLloyDbm/w9pB6+GL64=; b=pgRbrq
        uwXXAQbEek+mTr3ZaH6simP4/5hjADjIVaJfeMQ7XFwVcI9SckCLyrO06MrEKAO6
        /zgl6uramE1bTxANfzKden63vzluz+BKKXl+5vWDc9YLkkl8psLsaY1yUZvFXm3u
        hjVC5zZFJf4LjcaYl471LPz2yy7mTLZyybtOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rsrb0IspNuGQyUdr642IRDyfFKgBZlmn
        9A2Xi67Pu/QNWV6bAVOH/zH/t96jKlpvZ9N/JmvGo3dj9ITyDYclx75c9NtR7iIn
        V/j2POQOoFd5Gs6zAqjMbG9BAR7HQPvi3B7cJFWJoijr6m8KBYbPLPZaAkLu1r1H
        iqvR4Vof+f4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 085FDA2BCE;
        Fri, 20 Nov 2020 19:28:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80FA9A2B96;
        Fri, 20 Nov 2020 19:28:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
        <20201120235203.GA353076@coredump.intra.peff.net>
Date:   Fri, 20 Nov 2020 16:28:45 -0800
In-Reply-To: <20201120235203.GA353076@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 20 Nov 2020 18:52:03 -0500")
Message-ID: <xmqq3613tuwy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84A302A0-2B90-11EB-86EB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks for working on this. Regardless of whether we change the default
> behavior, this seems like an obvious improvement (and I do think it
> makes sense to eventually change the default; I'd even be OK switching
> it to "missing" in the near term).

I agree that "missing" would be an easy thing to take, and I do not
mind seeing it made the default in the near term.  It won't break
existing expectations too much, and can even be seen as a bugfix for
the current behaviour by making "init && fetch" a step closer to
"clone".  Beyond that to modify what the end user already has is a
much harder sell.  For some it may be an improvement, but for others
it would be a breaking change.


> The implementation looks pretty straight-forward, but I have a few
> comments below:
> ...
>> +	strbuf_addf(&ref, "refs/remotes/%s/HEAD", remote->name);
>> +	skip_prefix(head->symref, "refs/heads/", &head_name);
>
> Should we bail or complain if this skip_prefix() doesn't match? I think
> it would be a sign of weirdness on the remote side, ...

Yes, we should notice the weirdness and stop doing any further harm
to the local side.

>> +	strbuf_addf(&target, "refs/remotes/%s/%s", remote->name, head_name);
>> +
>> +	r = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
>> +		ref.buf, RESOLVE_REF_READING,
>> +		NULL, NULL);
>
> This won't resolve a symref pointing to an unborn branch, so it would
> count as "missing". I.e.:
>
>   git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/nope
>   git -c fetch.updatehead=missing fetch
>
> will update it based on the remote HEAD.  I guess I could see some
> argument for defining "missing" in that way, but I suspect it is not
> what somebody in this situation would expect.

What do we do in "git clone" of an empty repository with the current
branch not yet to be born?  Modern Git tells where the HEAD points at
even for unborn branch, so using that would be a natural thing to do.

> If we do update the symref, we should probably tell the user. Better
> still if we can print it as part of the usual fetch output table.

True.

>> +		if (need_update_head)
>> +			strvec_push(&ref_prefixes, "HEAD");
>>  		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
>> +	}
>
> Good catch. We need this for:
>
>   git fetch origin
>
> since otherwise it doesn't ask about HEAD in a v2 exchange. What about:
>
>   git fetch origin master
>
> That won't report on HEAD either, even with your patch, because it hits
> the part of the conditional before your "else if". What should it do?  I
> can see an argument for "nothing, we only update head on full configured
> fetches", but if so we should definitely make that clear in the
> documentation. I can also see an argument for "always, if we happen to
> have heard about it" (just like we opportunistically update tracking
> refs even if they are fetched by name into FETCH_HEAD).

After seeing that all users got accustomed to seeing an explicit
fetch into FETCH_HEAD still update the remote-tracking branches, it
is more consistent and easier to understand by users if the "if we
happen to have heard about it" is used, I would think.  Documenting
the behaviour certainly is needed in a real version after this RFC.

> In most cases the distinction would not matter anyway. The "guess" part
> comes in only for ancient pre-symref-capability versions of Git (which
> we are unlikely to see and it's OK if they just don't make use of the
> feature),

I agree with you that at this point the versions of Git that does
not know about advertising symref can be left to rot.

> or for remotes with detached HEADs (in which case not setting
> our local origin/HEAD is probably the best thing, as a bad guess would
> foul up a later use of the "missing" mode).

Yes.  That would help the "missing" mode.  With a mode stronger than
"missing" that modifies what the local side has, detaching origin/HEAD
in a similar way as the remote has would be OK (although I do not
see me using that mode personally).

Thanks for a detailed review.
