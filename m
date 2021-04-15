Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D6FC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 06:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0D661139
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 06:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhDOGho (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 02:37:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55509 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOGhk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 02:37:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 714F0130710;
        Thu, 15 Apr 2021 02:37:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XwZDlzxRpmCEKC0PQoJmqbti7Qk=; b=yEHldB
        o2PLhJoeDlPYJerOVS1mbebTFaEVZ6vJkF5ufkR3rupBG28u8comBvzGnxQgQJvl
        gVDGyj0Oada05bcouunCoZoj6AwSpMIK0+a9oEjiX7Eh152b7brMY5grc7LL0jUS
        iGN9sdZkD3INivSiJgV6ls65SERm8yCigZvKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p3JGlkxMODZ8bZMIGq3PqCA0yiNymRZn
        CVrszxfTaLwz7/TzO7/acKlKktvojdFP4Wo8S3eT234DQ495nQkfNR4hjqKtOIut
        uSyvXXka+T9/mBtZXjCY78/o79NSrnSBcgS/7CuINAjwXWDtQppCaD4ul+xoz38j
        T9QW/JXqTNE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4660413070F;
        Thu, 15 Apr 2021 02:37:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6192513070E;
        Thu, 15 Apr 2021 02:37:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking (draft for #4's issue this month)
References: <xmqqmtu1zn3o.fsf@gitster.g> <xmqqim4owixg.fsf@gitster.g>
        <YHeKFILFySGRo2Dc@camp.crustytoothpaste.net>
Date:   Wed, 14 Apr 2021 23:37:11 -0700
In-Reply-To: <YHeKFILFySGRo2Dc@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Thu, 15 Apr 2021 00:34:28 +0000")
Message-ID: <xmqqr1jcrr3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 034088BC-9DB5-11EB-91EE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-04-14 at 23:22:19, Junio C Hamano wrote:
>> Here is the (local) test status near the tip of 'seen', relative to
>> the integration result last night.
>> 
>>  * hn/reftable has a preparatory change to use oidread() instead of
>>    hashcpy() in places queued at its tip.  This is essentially a
>>    no-op in the codebase without bc/hash-transition-interop-part-1
>>    and would be a bugfix with that topic.  Please squash it into an
>>    appropriate step in the series when updating the topic in the
>>    future.
>> 
>>  * ab/unexpected-object-type topic has an assertion to catch
>>    semantic conflicts with topics in-flight queued at its tip.  It
>>    would probably be safe to carry it until the topioc is merged to
>>    'master' and then remove it after the dust settles.  Please
>>    squash it into an appropriate step in the series when updating
>>    the topic in the future.
>> 
>>  * The tip of 'seen' passes all the tests locally, except that t5540
>>    fails when compiled with CC=clang (http-push exits with signal
>>    11).  bc/hash-transition-interop-part-1, which is at the tip of
>>    'seen', seems to have this issue standalone.  FYI, here is what
>>    "clang --version" gives me:
>> 
>>     Debian clang version 11.0.1-2
>>     Target: x86_64-pc-linux-gnu
>>     Thread model: posix
>>     InstalledDir: /usr/bin
>
> You should expect a reroll, so feel free to drop this if it breaks
> things for now and I'll figure out where things are going wrong.

I actually do appreciate the topic to be in 'seen', as these
integration exercises tend to serve as an early warning for
impending messy conflicts I'll need to be worried about.

I do worry about the memory requirement bloat of the object_id
structure, as we do need to keep one instance per object in-core,
but the squashable fix for the reftable topic given by Patrick
to replace use of hashcpy() with oidread() is still a good idea even
if we are going to use a different mechanism to keep track of which
object_id instance uses what hash algorithm, so again I am happy to
have seen your bc/hash-transition-interop-part-1 topic and had an
early chance to make it collide with others ;-)

Thanks.
