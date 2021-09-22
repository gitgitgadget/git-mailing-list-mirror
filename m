Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670FFC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47517611B0
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhIVTEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:04:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62553 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhIVTEY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:04:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F41AFE2F5;
        Wed, 22 Sep 2021 15:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fDOqxJftaNfZ
        Xg/e0Gg2NxgFm13ggLyLZisdSlTS8pg=; b=RgsVCreCvGEgW6gsYzZ903AYA0hC
        8CslYqxOG6ztteCHsmEHa4MTfQM5Fw4iK/AyuEru7/WHSRKvgPFbcrol7hoAZdF2
        EHq9Ek9aqxJUXdum+yCaX3D3UKSxX58quC/13fZ5RiYJDDMFvSy7rXb1xaZPD1nb
        McAMtwcWVKSSyYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05D92FE2F4;
        Wed, 22 Sep 2021 15:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 657EEFE2F3;
        Wed, 22 Sep 2021 15:02:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 6/5] grep.c: mark eol/bol and derived as "const char *
 const"
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
        <patch-1.1-c317e6e125e-20210921T124416Z-avarab@gmail.com>
        <YUnx7gt0KQNRlhuZ@coredump.intra.peff.net>
Date:   Wed, 22 Sep 2021 12:02:52 -0700
In-Reply-To: <YUnx7gt0KQNRlhuZ@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 21 Sep 2021 10:53:34 -0400")
Message-ID: <xmqqh7ec77s3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B079C43A-1BD7-11EC-AD9B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 21, 2021 at 02:45:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> I think that generally git's codebase could use going beyond just
>> "const char *" when a "const char * const" would suffice, for some
>> reason we seem to mostly use it for the static usage variables.
>
> I didn't dig up the references in the list archive, but I feel like
> we've had this discussion long ago. One of the reasons not to do so is
> that it pollutes the function's interface with internal details. The
> caller does not care whether the function is going to modify the pointe=
r
> itself, because it is passed by value. You could apply the same logic
> that we should be passing "const int", and so on.

Yes.  "This pointer is not modified" is a good thing to have inside
an implementation, but the callers should not have to care.

Thanks.
