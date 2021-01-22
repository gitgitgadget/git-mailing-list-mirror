Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1976AC4321A
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEAF23AC2
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbhAVSlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:41:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53177 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbhAVSec (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 13:34:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71301932F3;
        Fri, 22 Jan 2021 13:33:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5bVaVyIYUak5tW14VTIJNDzTYEU=; b=a6CVAf
        m1QTfnZdoaII6tMAFtfWViPHcIRck6WDZzJ7L9CqBICpFhIod844KoQSitwkAGT4
        NEeK+jgQc3mPnoTxqTf0pHex0JJzJ7IwNYulEMsgt9sCtxuXeNyROrKyjC4gQe9m
        UB64iBJQayM0aAZ5rWunRoVEDtL4o50hMbP90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AY9oXj8Zncq0zoQXxK0aB5BO1cleW3jU
        DJnNRSPrT7CWUguPWXK3bQzw2wYWbrIwTDlG5qhbgxj+gmZ2UJumDgvTPCQeq89u
        geDCPplzB3Znqo65Ffl0QS2TdClrksU79w+P1Av+0EeHfg2y7dLjGBn3Ji+sLUmj
        fCfA8IPKxF4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67EBB932F2;
        Fri, 22 Jan 2021 13:33:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9957932F1;
        Fri, 22 Jan 2021 13:33:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com
Subject: Re: [PATCH RESEND] refs: Always pass old object name to reftx hook
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
        <ae5c3b2b783f912a02b26142ecd753bf92530d2f.1610974040.git.ps@pks.im>
        <xmqq4kjdkgol.fsf@gitster.c.googlers.com> <YAfNcyZ7mj4J69XT@ncase>
        <xmqqft2wgk9k.fsf@gitster.c.googlers.com> <YAp0Y3rHty7itayo@ncase>
Date:   Fri, 22 Jan 2021 10:33:49 -0800
In-Reply-To: <YAp0Y3rHty7itayo@ncase> (Patrick Steinhardt's message of "Fri,
        22 Jan 2021 07:44:51 +0100")
Message-ID: <xmqqwnw495yq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EE9DF44-5CE0-11EB-BA8D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> Yes, it can mean both, but when you pretend to be that hook,
>> wouldn't you check if the ref exists?  If not, the user is trying to
>> create it, and otherwise, the user does not know or care what the
>> original value is, no?
>
> As long as you're aware as the script author, yes.

As you said downbelow, I agree that clear documentation may be
necessary.

> There is one gotcha though: you can verify the state when the
> reference-transaction hook gets invoked in the "prepared" state, as it
> means that all references have been locked and thus cannot be changed by
> any other well-behaved process accessing the git repository. In
> "committed" or "aborted" that's not true anymore, given that the state
> has changed already, so any locks have been released and it's impossible
> to find out what happened now.

True, but isn't the situation the same if we replaced the 0{40} old
side with (one version of) original value of the ref?

> different from the user-provided change. E.g.
>
>     0{40} <new> <ref>
>     ^<old>
>
> or
>
>     0{40}^<old> <new> <ref>
>
> That can be considered as backwards-incompatible though.

Yes, it is an incompatible change.  I thought of somehow annotating
the old side, e.g. "<old> <new> <ref>" vs "<OLD> <new> <ref>", to
show the distinction between "this is the original value of ref the
user wanted to see when updating <ref>" and "the user does not care
what value the <ref> gets updated from, but by the way, here is the
original value of the ref as Git sees it" [*], but I cannot think of
a way to do so without breaking existing readers.

    Side note: here, I am exploring the approach to replace 0{40}
    that is given when "do not care" into an actual original object
    name taken from the current state, like your patch did, but
    trying to find a way to make non-NULL object name distinguishable
    between the two cases (i.e. user-supplied vs system-filled).

That raises another question.  How much trust should the hook place
on the value of the <old> given to it?  When a non-NULL <old> value
is given by the end-user, does the hook get the value as-is, or do
we read the current value of the ref and send that as <old>?  Does
the transaction get rejected if the two are different and such a
record is not even given to the hook?

> Yup. Whatever we agree on, what is clear is that the documentation needs
> to be more specific here.

Yes, agreed.

Thanks.
