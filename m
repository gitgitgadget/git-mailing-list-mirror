Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A6BC56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA432068D
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V+slJv7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgKYTS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 14:18:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52921 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgKYTS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 14:18:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 86718FB56B;
        Wed, 25 Nov 2020 14:18:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s5Lh70zOcgDUWIMCY5Yft/RvGFo=; b=V+slJv
        7sZLB6UtZg45NbPpidKM/gR88DAm1PqBCccNeBSQ9tSmx5wIefanRi/8dI5HhfHX
        NeYVYHkjqFLTlAdsu1gTTGJYrSCRwSiWmYnb4TnkEihHkrKtaKpTxK/J+SI3FHc5
        ELXRDPLrYkfHZgC6tYKI9nsOwRTrGHA5PHzwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jWuzkkPtZmr/xd8Xyz3K2uM29hB4cyAt
        U8eU3Cf1K4yB27kwORWuj3Vk8de38VCCH6WiW3GCAewJ+YL04xZWogGc6xCJSSir
        CN72bIdDriBBN9ZCgGtEIjpqIPzc/guUCToyvNj0/Su2lAkHOO7nSgaiSdoP9rKN
        j2Ew1QU/xuU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EF62FB56A;
        Wed, 25 Nov 2020 14:18:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BFA7BFB566;
        Wed, 25 Nov 2020 14:18:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     git@vger.kernel.org, levraiphilippeblain@gmail.com
Subject: Re: [PATCH] imap-send: parse default git config
References: <76d2be10-0c42-70f4-101c-ee15e3039821@gmail.com>
        <8a21b031-fbfd-81c2-1f91-eff8c03bafb7@suse.com>
        <xmqqh7pdg7ma.fsf@gitster.c.googlers.com>
        <9c410f99-6b9f-3d94-bd4c-8e4197b3cde3@suse.com>
Date:   Wed, 25 Nov 2020 11:18:19 -0800
In-Reply-To: <9c410f99-6b9f-3d94-bd4c-8e4197b3cde3@suse.com> (Nicolas
        Morey-Chaisemartin's message of "Wed, 25 Nov 2020 09:43:01 +0100")
Message-ID: <xmqqd001fdok.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB7CAF0A-2F52-11EB-96F7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> writes:

>> Of course you could also unify in the other direction and instead
>> of running git_config(git_defauilt_config, NULL), pick the exact
>> variables you care about (did you say askpass???).
>
> The only one we care about for this specific case if core.askpass
> as user gets prompted to authenticate on his IMAP server.  So
> picking just this one would be simpler. However isn't the other
> way around cleaner if we happen to depend on another
> "generic/core" setting ?

Yes, "the other way around" is cleaner and more desirable exactly
for that reason.  

There is an established way to ask another parser to handle
variables you do not handle yourself with the callback-style
configuration parsing.  "git grep 'return git_default_config('"
shows places that are taking advantage of the technique.  There is
an in-core collection of all the configuration (variable, value)
definitions, which is populated by reading the on-disk files just
once, and a call to git_config() iterates over this collection and
calls the callback-style parser for each (variable, value)
definition, resulting in a single pass.

The parser imap-send currently uses is based on a more recent style,
where each of the individual variables the caller is interested in
is looked up from the same in-core (variable, value) definitions.
It is easier to start writing, but does not have a good established
way to ask the more basic layer to grab things they care about, 
without doing a full git_config() call if the basic layer only has
callback-style parser.

In the longer term (read: I do *not* think it is a good idea to do
this as part of this series; I am just pointing at a future course
to make it easier to use the config API in general, not just by the
imap-send command), we probably should come up with a way to add
another config helper that grabs the same set of variables as the
callback-style config helper at the same layer to help config
parsers like the ones in imap-send.  E.g. git_default_config() is a
callback helper to grab all the basic configuration variable, and it
is suited for calling from a callback style configuration parser,
but it would be nicer to the current git_imap_config() and its
friends if there were a function they can call that is better than
"git_config(git_default_config)", which causes all the variables
that the default layer do not care about to be fed to the callback
only to be discarded.

In the far longer term (read: I do *not* think it is a good idea to
think about this for too long in the context of this series, and I
am not even sure what I speculate would be what I'd be convinced in
6 months myself), we may want to choose one style over the other.
My current inclination is to write off the targeted "what's the
value of this variable?"  style as a failed experiment (because it
exactly has the "cannot chain easily" problem) and standardise on
the callback-style parsers, but at the same time I think it is
possible to establish a good convention and set of config parsing
helpers for subcommand specific config parsers that are not
callback-style to delegate parsing of configuration variables at the
more basic layer with enough engineering effort, and it would
probably be a more desirable outcome in the longer term, resulting
in removal of the callback-style parsers.

But for now, without such support, "the other way around" would
result in a cleaner solution that is futureproof until we solve the
"in the far longer term" issue.

Thanks.



