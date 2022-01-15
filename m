Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B988C433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 01:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiAOBB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 20:01:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57003 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiAOBB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 20:01:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29FC3114A72;
        Fri, 14 Jan 2022 20:01:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+uusEW88E9wD
        dT8WwkqJ6pr03QvVxVq7ItNn2XIsWRU=; b=QvtvajF1pLueuXRLbqGNhpEJ+wb3
        BxhdbikYE/gmrfkR0OVRAm1QYLeR3lAXPoTO1mt8Osdi/oKwHzO3O7K0vwPjW3pu
        rXuRqUovDnqIceZ3s2Iu0rienAj919WLq62DD7353kbXpLgVe481n6qVqSHTsui5
        edbXKpOOao3k4bw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 223F3114A71;
        Fri, 14 Jan 2022 20:01:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89EE8114A70;
        Fri, 14 Jan 2022 20:01:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
References: <cover.1642129840.git.dyroneteng@gmail.com>
        <xmqqfspqeun5.fsf@gitster.g>
        <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
        <xmqqbl0eaw2e.fsf@gitster.g>
        <220114.86y23iqbbk.gmgdl@evledraar.gmail.com>
        <xmqqo84e9e9g.fsf@gitster.g>
        <220115.86lezhrg0o.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 17:01:26 -0800
In-Reply-To: <220115.86lezhrg0o.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 15 Jan 2022 01:34:28 +0100")
Message-ID: <xmqqk0f16cd5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AB0042F6-759E-11EC-A1BD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Which is what I was mainly pointing out upthread, that your summary of
> options before other types of args omitted that many utilities support
> the reverse. Or perhaps you were only describing an asthetic choice
> (which I don't think is worth debating). I'm just talking about what th=
e
> ground truth is.

The ground truth is that it is unlikely that we can fix some of our
commands so that they stop taking options that are given after args,
because of inertia.  But we can teach users especially the new ones
to always use the canonical order to sidestep the whole "some
subcommands imitate misguided GNUism to make it ambiguous, some
don't" problem.

> What do you think about something like this to clear this up?:

As we should aspire to fix the misguided "options can come still
after we saw args" eventually (don't talk back on this point to
waste any more of my time on a release day), I do not think it is a
good idea to say "reverse is often not true" and stopping there.

It will mislead people to think these "not true" commands should
somehow be updated to the GNUism in the future.  It's the other way
around.

> + * Options are (almost) universally accpted before other types of
> +   arguments, e.g. `git cat-file -t HEAD` or `git push --dry-run
> +   origin`, but in the case of those commands a GNU-style `git
> +   cat-file HEAD -t` and `git push origin --dry-run` would work just
> +   as well. The reverse is often not true, many commands do not accept
> +   options after non-option arguments.

  * A subcommand may take dashed options (which may take their own
    arguments, e.g. "--max-parents 2") and arguments.  You SHOULD
    give dashed options first and then arguments.  Some commands may
    accept dashed options after you have already gave non-option
    arguments (which may make the command ambiguous), but you should
    not rely on it (because eventually we may find a way to fix
    these ambiguity by enforcing the "options then args" rule).

