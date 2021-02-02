Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76625C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C57164F63
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhBBWUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:20:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59126 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhBBWSw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 17:18:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2371102C49;
        Tue,  2 Feb 2021 17:18:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AtzdsRyLMFNIyYZuEHsZyrWDbk0=; b=DQ1W7W
        uvnzG/HaxY2bQckEjQ3Mjywrfbf3DM53oZ/DKwFOe45f33oRFOzwPHyTQV46Vhr7
        Dv2jh2QLeqyYC3Up9JdLZr8pH0DcSKlF4lPINKb6czCurH73NsoD7rUn1aQ3MHWm
        CGVNY/Z0PnLMWaMuONdnw1IHzNG4jj4IShcZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G5ISNJ5YKvpeKNInBFJfNytmCMr8h4CT
        gPbcw6NM5GIWYCZKE3R0U5Z770eKKATBn+DMC9Q/lxcQt5v06RORNbOPiZgV0PPP
        3rY7MdpWvSXDa/fkYZUrThT0E/TbYsHtw8ITg4Vmk1R0m2aO0Z4W1VRO7wv65hpn
        7XFkKhsAjGE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB3C7102C48;
        Tue,  2 Feb 2021 17:18:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33B2D102C45;
        Tue,  2 Feb 2021 17:18:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v6 1/3] ls-refs: report unborn targets of symrefs
References: <xmqq4kiuif4d.fsf@gitster.c.googlers.com>
        <20210202183453.1907985-1-jonathantanmy@google.com>
Date:   Tue, 02 Feb 2021 14:17:59 -0800
In-Reply-To: <20210202183453.1907985-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 2 Feb 2021 10:34:53 -0800")
Message-ID: <xmqq1rdyf71k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 839FF45A-65A4-11EB-A09C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I'm not sure what the ideal endgame state is, but I could see how
> sending all symlinks would be useful (e.g. if a client wanted to mirror
> another repo with more fidelity). Right now I don't plan on adding
> support for dangling symrefs other than HEAD, though. Maybe I'll update
> it to something like:
>
>   If HEAD is a symref pointing to an unborn branch, the server may send
>   it in the form "unborn HEAD symref-target:<target>". In the future,
>   this may be extended to other symrefs as well.

Unless you plan to add support for symbolic refs that are not HEAD
in immediate future, "In the future, ..." is not even necessary to
say.  The users cannot expect to exploit the missing feature anyway,
and they cannot even plan to use it in near future.

I've been disturbed by the phrase "the server may send it" quite a
lot, actually.  In the original before the rewrite above, it was a
good cop-out excuse "no, we do not send symbolic refs other than
HEAD because we only say 'the server may' and do not promise
anything beyond that".  But now we are tightening the description
to HEAD that we do intend to support well, it probably is a good
idea to give users a promise a bit firmer than that.

    unborn If HEAD is a symref pointing to an unborn branch <b>, the
    server reports it as "unborn HEAD symref-target:refs/heads/<b>"
    in its response.

It would make it clear that by sending 'unborn' in the request, the
client is not just allowing the server to include the unborn
information in the response.  It is asking the server, that has
advertised that it is capable to do so, to exercise the feature.

> I think that there is a discussion point to be decided
> (advertise/allow/ignore vs allow/ignore), so I'll wait for that before
> sending v7.

What is the downside of having three choices (which allows phased
deployment, where everybody starts as capable of responding without
advertising in the first phase, and once everybody becomes capable
of responding, they start advertising) and the reason we might
prefer just allow/ignore instead?  Too much complexity?  It does not
help the real deployment as much in practice as it seems on paper?

I am not advocating three-choice option; I am neutral, but do not
see a good reason to reject it (while I can easily see a reason to
reject the other one).

Thanks.
