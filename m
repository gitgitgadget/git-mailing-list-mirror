Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A459C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11F561447
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbhDURAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:00:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62937 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbhDURAG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 13:00:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9EBED6BC4;
        Wed, 21 Apr 2021 12:59:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VrIQ1UGd3ANe
        qCGNKDkJhHlkzmk=; b=qw69CVsHi/EprogVZ0RUWq8Q5HX/pz7/bQlIsmjCP2Xy
        aVz/oJqvz/z4h3fYUOBt/w6B6Cks/KucsowCwD6bkuG9twH7XpRDQfrWgzqMC/BV
        rEFl9aVnfWGrt3GSNE1KACA9ecsSKChpnfXQHHYpM7sOayPHmPtLDhG+98BUj5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Uhrl12
        +KkcJ1NlklelLO/3NNVBsnwx60Sr//20K0vq/O42r3fXwX1VP+7LXtjSS0S0x4z4
        WJ2IEKULyQZ8V9o+qjlzebQ9f3RK2vGwg0E+dJsHk/Ig9fDACGF+qJCxFz4RvZWA
        Hr4xFir/K22NwYjdyAm/drEzbkWRy33kD0SFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1DF8D6BC3;
        Wed, 21 Apr 2021 12:59:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F953D6BC2;
        Wed, 21 Apr 2021 12:59:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>, git@vger.kernel.org,
        Luke Shumaker <lukeshu@datawire.io>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
References: <20210420190552.822138-1-lukeshu@lukeshu.com>
        <xmqqa6ps4otm.fsf@gitster.g> <87zgxs2gp9.fsf@evledraar.gmail.com>
Date:   Wed, 21 Apr 2021 09:59:31 -0700
In-Reply-To: <87zgxs2gp9.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 21 Apr 2021 10:18:58 +0200")
Message-ID: <xmqqeef3zi8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F18BB1CE-A2C2-11EB-A67F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I actually think this is a good direction to go in, and it might be
>> even an acceptable change to fsck to require only the tail match of
>> tagname and refname so that it becomes perfectly OK for Gitk's
>> "v0.0.1" tag to be stored at say "refs/tags/gitk/v0.0.1".
>
> Do you mean to change fsck to care about this it all? It doesn't care
> about the refname pointing to a tag, and AFAICT we never did.

I misspoke.  What I had in mind was the existing behaviour of the
"describe" tool that warns when the in-object tagname does not match
where it is found in the refs/tags/ hierarchy.

But I do not think allowing "fsck" to perform the same check would
be wrong.  It would be good for consistency, but then we'd need more
serious thought about what is and what is not considered worthy of
a warning (or worse) than a mere warning from "describe".
