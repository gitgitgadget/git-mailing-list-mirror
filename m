Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49ACC433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 22:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA1122E00
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 22:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbhAEW5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 17:57:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61201 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbhAEW5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 17:57:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9B289A0C8;
        Tue,  5 Jan 2021 17:57:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HcaWh+qmfunJ/FfpjFZZ1doHDOE=; b=vzNOwK
        IpEQ+kCLiqvy9MtN7xscX3r0fjJIuW9EF97cQIdAVghRpQxMn550W8SYSGG4/use
        oI+Z018vGt2p/NJGFgjnlsq4IzIhQhj75ztvpCHyGIuM5IgPH3kCvWoRtXtuK/JI
        Y6q7XEwxQJbBcXzQHH0YYN7PgVioVpIgzINb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tAtdU1DmEkbLuhq8PdhOWGDYfPw1Y+ah
        Jst5sLJHmz8hujrSP6g+pMMtdEDQb6vMUqcN3Z4fgxqPJLlZ7Em0yGI2eQ85sh1t
        RKJkGS5ev6VhQWFoZptlkKHybaexFdhCdMEAXZNWo0+X18kTROQ2V2vuLNYbm7Lh
        ZaYdjQofme4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD6D59A0C7;
        Tue,  5 Jan 2021 17:57:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D6089A0C6;
        Tue,  5 Jan 2021 17:57:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: ss/submodule-add-in-c, was Re: What's cooking in git.git (Dec
 2020, #05; Mon, 28)
References: <xmqqeej9g325.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101051640150.2213@tvgsbejvaqbjf.bet>
Date:   Tue, 05 Jan 2021 14:57:02 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101051640150.2213@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 5 Jan 2021 16:41:38 +0100
        (CET)")
Message-ID: <xmqqturvxa9t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 536E79A2-4FA9-11EB-9DBC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 28 Dec 2020, Junio C Hamano wrote:
>
>> * ss/submodule-add-in-c (2020-12-15) 3 commits
>>  . t7400: add test to check 'submodule add' for tracked paths
>>  . submodule: port submodule subcommand 'add' from shell to C
>>  . dir: change the scope of function 'directory_exists_in_index()'
>>
>>  "git submodule add" being rewritten in C.
>>
>>  Expecting a reroll.
>>  The patches are split incorrectly; part of 1/3 belongs to 2/3
>>  cf. <nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet>
>>  It seems to introduce a segfault on 'seen'.
>>  cf. <xmqqft3xflw7.fsf@gitster.c.googlers.com>
>
> Maybe nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet would be a
> better reference,...

That is the first message-id referenced in the above, isn't it?

