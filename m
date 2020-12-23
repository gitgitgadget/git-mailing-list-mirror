Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05310C433E6
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8E6221F5
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgLWUZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:25:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63650 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgLWUZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 15:25:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE410118BD0;
        Wed, 23 Dec 2020 15:25:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Nwkjt2hZj+Gg
        fStpZfyZ4jNjUSo=; b=Re6jxdVrGbJhadoIYx08CyG8VtVpojNous3ZF1qB2VOc
        Dkz7yLlInhF1e8t8c79dNaKMHUsYHuK75QeOz+S9wvEnTUeW8fAC/BNHJ5WEYtiH
        2O5UqQU9C+ixOxmSc1O7wHxP/ti+18R69HmPVhxfm7EmusTw5I3h9K+gDKL+WN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rlEMek
        taNqrm5kry+Obd5UXbKkO90a9Bgph5vYZeY+DA4VysXLOtRWrCYwOZkKD09zAJkM
        102iAeF45grYb8UdGeqdHZgaQnEyHzhiEaP/UnFydV4HKdnw171LsxHFT5oNcVQF
        Z0aaAW7dhUmKTc1LqNnSeo0SgBcnT1tk2mHf8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7052118BCF;
        Wed, 23 Dec 2020 15:25:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E630C118BCE;
        Wed, 23 Dec 2020 15:25:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH try2 0/4] completion: bash: a bunch of fixes
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
        <xmqqy2hoanps.fsf@gitster.c.googlers.com>
        <5fe3484465fac_198be208bf@natae.notmuch>
        <20201223141950.GA23264@szeder.dev>
Date:   Wed, 23 Dec 2020 12:25:04 -0800
In-Reply-To: <20201223141950.GA23264@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 23 Dec 2020 15:19:50 +0100")
Message-ID: <xmqq1rfg8e3j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F1B76CA6-455C-11EB-8F57-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Dec 23, 2020 at 07:38:12AM -0600, Felipe Contreras wrote:
> ...
>> I see 5 courses of action:
>>=20
>>  1. Drop the offending patch: this is wrong because the bug is still
>>     there, we are just not checking for it.
>>  2. Add a BASH prereq just for that test, or test_expect_unstable (we
>>     would need to add extra code for both of those).
>>  3. Add the fix, but not the test for the fix.
>
> I'm for this option 3: this patch does fix a bug for users of Bash
> v4.0 or later, while it doesn't change the behavior with v3.2 or
> earlier (and with zsh, if I understand correctly).  OTOH, the test
> doesn't seem to be all that useful: while it does demonstrate the
> issue, it checks only one of those callsites that passed the wrong
> suffix, and, more importantly, it doesn't protect us from adding
> another callsites with similarly wrong suffex in the future.

Yeah, I might have preferred, if we didn't read your "doesn't seem
to be all that useful", to keep the test with prereq on bash 4, but
I think either way is fine.

> In any case, the commit message should note that the fix doesn't work
> with all Bash versions and why.

Very true.

Thanks, all.
