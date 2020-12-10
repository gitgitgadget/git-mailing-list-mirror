Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47791C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FAE235F7
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgLJA5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:57:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58981 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgLJA5v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:57:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A09E19FF55;
        Wed,  9 Dec 2020 19:57:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tBoQ9As8JbgQSHyZQEbGk5j2YmM=; b=A7TE9x
        iQn/8TlhUrxIedy0XCYGlhDutASZt8xnVfHy0r4q/F6TLd9hfbi/fzmmPD0TZYfi
        VITLsKDQZpPIBm6MmBeT/Bdir0gOQeHL4av1txTQJAmDl7VUsOfcgASVihNfFizx
        ocSQ8dVgruNFRbkOyrqUWSIdv9cN5SzFympnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yN57nc/B24gbacK1UPbsVbhO4QYOm32y
        WzO3OWxwq0dlRApWELMY41P0vRodstZXHPXpUFvO5ZMlX7cbXYmxfgiYeTGbpLlW
        nOVVbUzfUEo7Kv2NJMylBDf+zQJDXRx4T12mnyWlKkGExVyXWaTDsWqRW+a2R5pp
        plU/1I0QLR0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 969B79FF54;
        Wed,  9 Dec 2020 19:57:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B8439FF53;
        Wed,  9 Dec 2020 19:57:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
References: <cover.1606214397.git.ps@pks.im> <cover.1607514692.git.ps@pks.im>
        <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
        <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
        <xmqqy2i6zg1j.fsf@gitster.c.googlers.com>
        <X9FnU5Jj2XPl8BFk@coredump.intra.peff.net>
Date:   Wed, 09 Dec 2020 16:57:08 -0800
In-Reply-To: <X9FnU5Jj2XPl8BFk@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 9 Dec 2020 19:09:55 -0500")
Message-ID: <xmqqeejyzdej.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1575F08-3A82-11EB-AC4B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes. I'd be happy to rebase them if we're not going to do the
> GIT_CONFIG_{KEY,VALUE}_<n> parts.
>
>> The above is my understanding of the state of these patches.  Am I
>> getting it right?
>
> Yep.

Thanks.  

I have no strong feeling for or against the env-pair feature, so the
way these three parts are structured (i.e. more robust parsing of
'=' comes at the end) is fine by me.


