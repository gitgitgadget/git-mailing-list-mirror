Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E8C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10C022BF3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UtDY7Zfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgHCSrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:47:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61175 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCSrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:47:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE8AFD33E3;
        Mon,  3 Aug 2020 14:47:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tv71D84pl9pzn25tDigIvDlrGPI=; b=UtDY7Z
        frwHPn149/WRZxKe5tiq1wWPT14hXaQDgIYocYmplW5Ig4bj7PdQE4dW4AcKa1tE
        1J0v2NHR5qKju8bP8lOYqmbA5PDA0TNfrZAtxsDXUDi/tI1xXSRoU2b3kSaS1nHk
        x3/xBFMYcPoEDPyest2eDqnAOXm7UiqXncOfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uxKYsvAmbeCikbUTS4KFrT93RaVYtXA1
        /VAv1P2YwkDFUXh2fETueBxLnItWNBSsKCj4QW4nAAE7j90z4XJxL2aIi63bouHm
        dd4s1fNPVybJ19yacrNkqWsh6O/Ip9qJmoiux0a3kcczW/J4yjFsVzPG21UwdZoD
        nt0JA36jvGE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A75BED33E2;
        Mon,  3 Aug 2020 14:47:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EBDC0D33E1;
        Mon,  3 Aug 2020 14:47:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
        <xmqqlfivwvtw.fsf@gitster.c.googlers.com>
        <c014fe87-9663-3ff4-9527-bf60ff30d0d9@gmail.com>
Date:   Mon, 03 Aug 2020 11:47:03 -0700
In-Reply-To: <c014fe87-9663-3ff4-9527-bf60ff30d0d9@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 3 Aug 2020 23:50:29 +0530")
Message-ID: <xmqqtuxjva6w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9B9499A-D5B9-11EA-A0E7-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 03-08-2020 21:44, Junio C Hamano wrote:
>> 
>> If we wanted to do this properly, I'd imagine we'd need to add a
>> mechanism for repositories to convey "this branch that used to exist
>> got renamed to this other name", not specifically for any "special"
>> branch name (like 'master').  If we plan to never allow reusing the
>> old and banned name, it probably is enough to turn the old name into
>> a symbolic ref that points at the new name, e.g. in my repository
>> 
>>     $ git update-ref refs/heads/seen refs/heads/pu
>>     $ git update-ref -d refs/heads/pu
>>     $ git symbolic-ref refs/heads/pu refs/heads/seen
>> 
>> which would create a symbolic reference 'pu' that points at 'seen'
>> to say "pu used to exist but it is now seen".
>> 
>> But that would not work well, as we must allow reusing the old name,
>> as the primary point of renaming 'pu' to 'seen' in this project was
>> so that we can accept topics from contributors whose anglicized name
>> has 'p' and 'u' in capital letters as pu/$topicname branches.  Having
>> a symbolic ref 'pu' would defeat that plan.
>
> Of course. Though, having a symbolic ref of 'pu/seen' to 'seen' would
> hopefully not defeat the plan while being a little helpful ;)

How would that be helpful?  After all, I do want to allow us accept
a topic about 'seen' from author 'pu', and that pu/seen branch
should be different from the "not yet ready for 'next' but at least
the maintainer acknowledges that he has seen them" integration
branch whose name is 'seen'.
