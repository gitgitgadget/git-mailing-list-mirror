Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE1C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6310F613BF
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFCAIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:08:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61614 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFCAIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 20:08:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 770881376A0;
        Wed,  2 Jun 2021 20:06:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XNQJSVME0KiA/JAW5BJjHvUJIHa3vY2dJ/6yDY
        l6DJY=; b=fRVWnk4lAOcVy7+9jkRE6rz++vZ5fgVDosr9LYv21sHweJeHSvbWsF
        H+I5N/gLZcN5Gm94dQPog6StuSTxOlpM+SY8+nXavGR65T9ictXXf0cEiivk7KEA
        oeLHoTcI57keGoDizDCzoiQLwVY0cP9xjZqZWuoRPGpMUsgbIhOo0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F99D13769F;
        Wed,  2 Jun 2021 20:06:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B862813769B;
        Wed,  2 Jun 2021 20:06:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <87wnrd6wqj.fsf@osv.gnss.ru> <60b6c08f75c1c_40442086d@natae.notmuch>
        <87eedktq4x.fsf@osv.gnss.ru>
Date:   Thu, 03 Jun 2021 09:06:34 +0900
In-Reply-To: <87eedktq4x.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        02 Jun 2021 15:19:58 +0300")
Message-ID: <xmqqeedj7qwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 902A7EF2-C3FF-11EB-B35F-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>>> [push]
>>> 	default = simple
>>
>> This is the default, you don't need it.
>
> Yep, a remnant from the past.

This reminds me of something.

This particular remnant is there because the user was an early
adopter from the days before the 'simple' setting was made the
default, and it is a common pattern in our configuration variable
settings.  We introduce a knob to allow early adopters to experience
new settings, and after a while, one of them may become the default,
and at that point, the setting the user has appears redundant.

If we had a central registry of configuration variables and their
default values (there isn't one), one could write a configuration
linter to point out "you have this set, but it is the default these
days" to remind you, which sometimes may be useful.

I say "sometimes" because the reason why the user has a seemingly
redundant setting may be because the default for the variable in
question is planned to change, and the user has it set to keep the
current default---the opposite of the 'early adopter' use case.

Being reminded may still be useful in such a case, but the linter
tool certainly should not make any change blindly in the name of
removing redundant setting without consulting the user.


