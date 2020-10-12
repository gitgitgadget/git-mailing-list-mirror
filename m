Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C9C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C8B2074F
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="atfNhSAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbgJLRsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 13:48:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63996 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404029AbgJLRsW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 13:48:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C29EC9FA40;
        Mon, 12 Oct 2020 13:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gp8f+Q0VEFEqsfK9iVWcNsRBLkk=; b=atfNhS
        AHVATm4bOnAfdswTNidkAp5uO2xQ4N74Dr5I8P26p/SuFkBeTJVZdOZkSLxp84NC
        mhDDcGhM69FsX31qmJ2YIPzea5Y30rvyA7695vsvSgOtsXz0ONNB67rO6HYmbIdE
        9TQyeS+tyzjh+ePKywwVu5db1kt2K7a8M1gE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nuZo/6REaP5T9Xn0nyY047IZMhhRfKwN
        hqbuxUN/LuT1/hqpU7xwmZ0U+etf7aeVffy6nMuuOfqHZ3PRjWg68dgwEvDnJpOF
        Uf1n8XsxG3eEK3vDlYbppizEeEdGO6JsY3Xa8iIgBD/9ijfDPBCHtHlr4r3/mmh6
        LrpwEB71GDA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB05A9FA3F;
        Mon, 12 Oct 2020 13:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D0D29FA3E;
        Mon, 12 Oct 2020 13:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Victor Porton <porton@narod.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature: checkout and merge
References: <28a86c75-de4d-acbe-dab7-e5512961538c@narod.ru>
        <5293161602514983@mail.yandex.ru>
Date:   Mon, 12 Oct 2020 10:48:19 -0700
In-Reply-To: <5293161602514983@mail.yandex.ru> (Konstantin Tokarev's message
        of "Mon, 12 Oct 2020 18:04:19 +0300")
Message-ID: <xmqqo8l7pc7w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DC8BB70-0CB3-11EB-89C5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Tokarev <annulen@yandex.ru> writes:

> 12.10.2020, 14:12, "Victor Porton" <porton@narod.ru>:
>> It is a very often need to checkout a branch and them merge the branch
>> that was before the checkout. Moreover after this is very often needed
>> to push.
>>
>> So please add the flags to `checkout`:
>>
>> 1. to merge the old branch immediately after checkout
>>
>> 2. to push after checkout
>>
>> I repeatedly write:
>>
>> git checkout stable && git merge main && git push && git checkout main
>>
>> (I am not subscribed to this mailing list.)
>
> Why not make a shell script to do this?

Sounds like a very sensible suggestion.  "merging and then pushing
immediately after" without any validation step in between is not for
everybody and being able to implement such a custom workflow is why
we have these individual steps as discrete commands.

Thanks.
