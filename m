Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B6C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 20:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B605122D5A
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 20:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAEUGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 15:06:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63653 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbhAEUGK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 15:06:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32C86108F4F;
        Tue,  5 Jan 2021 15:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=n22agjShHxnWy12/7xTD9XzCWOU=; b=o6Uq67f6smLP4NygM1aw
        bLHIwm6Mis5h3nMgHsGSG6t9BvC38rHwJeu5OEZ7+kMMhXLvW9kut0lwuTYPK0sO
        9qCVecVH6CqUYrhh8Or2zT3Mfkhod9JrJRSN0wEI3pF6uZuKsyVVzwBSrSajwf7e
        Pr+aSG9wucYdnk3b01hZOsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=WxO2Bt0Au/BQcD7B5GpixZvmUQeBTPCcOzDWGZLXRZPD0w
        kSiibxxY4/qdODNnUNKii+JLCn+vN3r6Xq9laKsl3L7azz2vvu/axBfy6gEMkjPP
        aw51qzoFgIbFRdARhfnyD/Jf0caw22lXplrU3eZDuZ2J6v5Z6uaBdoSgZzYKI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A6DF108F4D;
        Tue,  5 Jan 2021 15:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 733E8108F4C;
        Tue,  5 Jan 2021 15:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/5] mailmap: support hashed entries in mailmaps
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
        <20210103211849.2691287-6-sandals@crustytoothpaste.net>
Date:   Tue, 05 Jan 2021 12:05:22 -0800
Message-ID: <xmqqft3fywsd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58E0713C-4F91-11EB-BC2F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> For example, a person may transition from one gender to another,
> changing their name, or they may have changed their name to disassociate
> themselves from an abusive family or partner.  In such a case, using the
> former name or address in any way may be undesirable and the person may
> wish to replace it as completely as possible.

I am not sure if we want to even mention the "for example" here.

These are certainly all legitimate reasons to want this feature, but
after reading the "for example", lack of a corresponding negative
statement (e.g. sometimes people also change their name or address
to hide their bad behaviour in the past that is associated with
these names) needlessly stood out and made me wonder if we need to
somehow defend the feature with "...but we do not mean to abet
people in hiding their past bad behaviour with this mechanism".  I'd
prefer us not forced to defend the mechanism if we did not have to.

> Note that it is, of course, possible to perform a lookup on all commit
> objects to determine the actual entry which matches the hashed form of
> the data.  However, this is an improvement over the status quo.

There were suggestions to use reversible encoding, IIRC, just for
obscurity.  I do not have a strong preference either way myself, but
because such an approach would give the same improvement over the
status quo, would be simpler, more performant and most importantly,
it makes it clear that this is not serious security but casual
obscurity, I'd want to be convinced why we want to use a hash here
a bit more strongly.

> +In addition to specifying a former name or email literally, it is also possible
> +to specify it in a hashed form, which consists of the string `@sha256:`,
> +followed by an all-lowercase SHA-256 hash of the entry in hexadecimal.  For
> +example, to take the example above, instead of specifying the replacement for
> +"Some Dude" as such, you could specify one of these lines:
> ...

> +SHA-1 is not accepted as a hash algorithm in mailmaps.

Is this needed to be said?  After all, we won't take @md5: or
@blake2: or anything other than @sha256: in this version (and
probably any forseeable versions).  Unless we offer a way to plug-in
algos of projects' choice, that is, and at that point, "SHA-1 is not
accepted" is a statement too strong for us to make.
