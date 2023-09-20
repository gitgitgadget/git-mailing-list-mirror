Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA7C04AA7
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjITPgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjITPgb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 11:36:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E38D3
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:36:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F5CA1AA2AE;
        Wed, 20 Sep 2023 11:36:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7s98F+qrIZZw
        7E5Ua141fh6mc2wOz8dd5spmY+sDPkQ=; b=cP8Cmc9JDUnCjVbXl0AMeVRPMzy3
        ao11f2NAAVQ56QZBaRQQ5E/+kvQ/uReJ8LO4grhHgFZUo8+ATycIVEjW+FvD00As
        5bpkm4PMWYoErIo1mSTkxv7rSOo6wI6C34FBjKJ+hLJH/RfYjNoPZFUuNsJ9lyFb
        eagX89/T/znjkYw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56ED81AA2AD;
        Wed, 20 Sep 2023 11:36:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9CA01AA2AC;
        Wed, 20 Sep 2023 11:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
In-Reply-To: <118975ef-c07f-c397-5288-7698e60516a7@amd.com> (Michael
        Strawbridge's message of "Tue, 19 Sep 2023 10:37:36 -0400")
References: <ZQhI5fMhDE82awpE@debian.me>
        <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com>
        <ZQknHjKdGZV3vJpV@debian.me>
        <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
        <118975ef-c07f-c397-5288-7698e60516a7@amd.com>
Date:   Wed, 20 Sep 2023 08:36:22 -0700
Message-ID: <xmqqcyycc0w9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74645A5A-57CB-11EE-9099-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Strawbridge <michael.strawbridge@amd.com> writes:

> Whoops, somehow I missed the other responses on this thread until I
> looked on the web archive version of this mailing list.=C2=A0 I see tha=
t a
> solution to "Use of uninitialized value $address" has already been prop=
osed.
>
> I suppose I may have mistook what issue was being reported.=C2=A0 I had
> originally understood the problem to be that hook related logic was
> failing with correct email addresses, but it seems rather that we are
> trying to fix an error that occurs when an email address that fails
> extract_valid_address_or_die() is given.=C2=A0 Feel free to ignore my l=
ast
> email if that is all we are trying to solve.

I just had an impression that the original was complaining about the
command failing, and the patches addressed a side issue that the
error message that is given when the command fails uses an undefined
value.  The report was not quite clear what Bagas considerd a
regression (e.g. did the command allow an invalid address like <pi@pi>
but now it complains?), though.
