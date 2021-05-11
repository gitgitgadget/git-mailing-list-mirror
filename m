Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB79C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE9C61285
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEKW6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 18:58:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59331 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEKW6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 18:58:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C882121705;
        Tue, 11 May 2021 18:56:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OeiFHff+Yt1cgksgiF8oLfqUye3uVkisDt0uYI
        gJCpA=; b=THlOqz7pQYIC4pds4BDos3X67iqvfmGbct5OpDmBQKzi+/TVi/9Bs6
        Z5YlVhI19xnAAsjtq06Bnk0yp20gDYVhxEwzJ5VWJ/YyOPqWtzA95Wrxluvybu+J
        aHeKZiElOM2V2xybvZZpCzrLec3oyoJk2muWmwrn1wlJUvBrTO1hw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75CA5121704;
        Tue, 11 May 2021 18:56:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 615BC121703;
        Tue, 11 May 2021 18:56:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Gregory Anders <greg@gpanders.com>, git@vger.kernel.org
Subject: Re: Syntax for specifying a command in git config
References: <YJrH8uqzapnpNEsb@gpanders.com>
        <YJrKJAa45mNIL+rf@coredump.intra.peff.net>
Date:   Wed, 12 May 2021 07:56:47 +0900
In-Reply-To: <YJrKJAa45mNIL+rf@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 11 May 2021 14:17:08 -0400")
Message-ID: <xmqqo8dgj2vk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B37F1AA-B2AC-11EB-BDB7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Obviously this is not a *huge* deal, but it is a minor annoyance. I'm
>> wondering if it would be possible to add a new syntax to config options like
>> this. For example,
>> 
>>     [sendemail]
>>             smtpServer = !msmtp
>> 
>> The leading ! character says "the following value is a command that should
>> be looked up in PATH". This is congruent with alias definitions, where the
>> leading ! means to run the following value as a command directly instead of
>> as a git subcommand.
>> 
>> This also is unambiguous since server hostnames will never begin with a !
>> character.
>
> IMHO this is a good path forward. There's a thread from a few months ago
> which talks about this idea:
>
>   https://lore.kernel.org/git/YCvotU6KVruFuf9%2F@coredump.intra.peff.net/
>
> There's some back and forth, and I'm not sure if I convinced Junio in
> the end. But certainly a patch would be a good way to restart the
> conversation. :)

The argument is not just about configuration but applies equally to
its command line argument "--smtp-server=<what>", right?  I think it
makes sense in both of these places.  I further wonder if we should
allow not just a single token, but supplying an initial few arguments,
too, e.g.

	git send-email --smtp-server="/usr/bin/env msmtp"
	git send-email --smtp-server="!my-msa --emulate-sendmail"

Thanks.



