Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB3CC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C3F6044F
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhINSdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:33:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62302 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhINSdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 14:33:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05FC315CD36;
        Tue, 14 Sep 2021 14:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hoU+71/JhMIrCbM7IcCDy1r1JjZH0MQPsr8IKR
        lBXJc=; b=YofG8Ok4/q7nxlVBAJKHfdY/ty2LqE27CQ7WbALeCaokLTyuA8vztE
        2nPf71MSAqdrVhGD8yK0u4Rw0UCuTgjazZE/lJQ2++sF+W8rGAzq0MRidyKbjylN
        nTQF5NLarI6J+Q0lxqHXawa5I3ADjxc97t1ADCyrXRjNOEoEa079E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0B0315CD35;
        Tue, 14 Sep 2021 14:31:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69B5415CD33;
        Tue, 14 Sep 2021 14:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] git-clone.txt: add the --recursive option
References: <20210913185941.6247-1-alban.gruin@gmail.com>
        <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
        <26422bc7-f1d4-4959-ce30-b26d8fe61888@gmail.com>
        <CAPig+cRGzmN6tH-5DmtnbW2cMHSSQ2RS_6d=B0xJ7QWKtG6yug@mail.gmail.com>
        <d02c7f3b-221d-fbab-827a-a950bf28856c@gmail.com>
        <xmqqbl4v2gpu.fsf@gitster.g>
        <CAPig+cTQNkwWgpgu-Mw=Qd++cUVnFrrdnaQnaSZ79RexnNQFHg@mail.gmail.com>
Date:   Tue, 14 Sep 2021 11:31:46 -0700
In-Reply-To: <CAPig+cTQNkwWgpgu-Mw=Qd++cUVnFrrdnaQnaSZ79RexnNQFHg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 14 Sep 2021 13:53:11 -0400")
Message-ID: <xmqqtuin1019.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 058D8D0C-158A-11EC-8B4A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Sep 14, 2021 at 1:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>> I am wondering if it is just a matter of either
>>
>>  * removing the "recursive" alias from the options table.  Because
>>    we accept unique prefix, --recurse=<arg> the user types will be
>>    taken as --recurse-submodules=<arg> anyway (until "git clone"
>>    learns another option --recurse-xyzzy=<arg>, at which time it
>>    will become ambiguous and error out, that is).
>
> With this option, we risk breaking existing tooling which happens to
> use the deprecated --recursive.

Ahh, sorry and thanks for correcting my stupid thinko.  recursive is
not a prefix of recurse-submodules.


>>  * adding the PARSE_OPT_HIDDEN bit to the OPT_ALIAS() element for
>>    the deprecated "recurse" option.
>
> I was going to suggest this as a possible way forward to address
> Alban's most recent response to my response. The lack of
> PARSE_OPT_HIDDEN on OPT_ALIAS() almost seems like an oversight.

You may have an alias with no intention to deprecate either, so it
would make it cumbersome if OPT_ALIAS() always meant HIDDEN, just
like it currently is cumbersome for an alias that is deprecated.

Independently (because I do not think this helps in solving the
current situation), we might want to tweak the disambiguation
machinery to require HIDDEN ones to be spelled out exactly, because
they are hidden for a reason---we do not want users to casually and
accidentally trigger them.  Of course, that is totally outside the
scope of everything we discussed so far.

>> Between adding "--recursive" to the manual and describing it as a
>> deprecated synonym for "--recurse-submodules", and not doing so, I
>> do not have a strong preference.
>
> I don't have a strong preference either, especially considering how
> long ago --recursive was removed from the manual, however, adding it
> would help someone who runs across --recursive in existing tooling or
> old blog post and wants to know what it does.

Makes sense.  I think we list other deprecated ones for that exact
reason.
