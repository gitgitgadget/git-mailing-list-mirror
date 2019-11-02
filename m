Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C761F454
	for <e@80x24.org>; Sat,  2 Nov 2019 04:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfKBEOs (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 00:14:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61837 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKBEOs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 00:14:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 568392E82F;
        Sat,  2 Nov 2019 00:14:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rYsqU9eooX+2/24or/N6myH4t2E=; b=ixI5+x
        r11EP/dAHWsU12XnKvy+dkLUZ/oZwH1NydPZFy5A3FgrNoi21OjjkjfyF3xBbO8Z
        AIUa01sLA4XedRO0XEtehveULJIgOfxROwmh69r3rVDF0pSk3WO22unC4uOm0H60
        JaxpfRSZbgEHLVtHLA0pDFo4tqvDUlKG9H8V0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wyV8FX1CWt5gAzTR4P1Y0sBIS3jQclq6
        gN4WrdbWuIdNRaUKtSN1i+rBiTieoCrl9coxDGfesG7qq7tGSZ9XaJxAUIxWbYDC
        Zx4bPgEQ1RzcbPLfRc1QrzlaPL95Y/fFUljE99CI3PO8Jw1P9hZAn21K950gIOK6
        ggjEGLb5gcs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C2712E82E;
        Sat,  2 Nov 2019 00:14:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9EC62E82D;
        Sat,  2 Nov 2019 00:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     george espinoza via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, George Espinoza <gespinoz2019@gmail.com>
Subject: Re: [PATCH 1/1] [Outreachy] merge-ours: include parse-options
References: <pull.425.git.1572306149.gitgitgadget@gmail.com>
        <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
        <xmqqk18n3s3i.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910302257480.46@tvgsbejvaqbjf.bet>
Date:   Sat, 02 Nov 2019 13:14:44 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910302257480.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 30 Oct 2019 22:58:39 +0100 (CET)")
Message-ID: <xmqq8soy6hjf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D7D58D6-FD27-11E9-AAEF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 30 Oct 2019, Junio C Hamano wrote:
>
>> "george espinoza via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: george espinoza <gespinoz2019@gmail.com>
>> >
>> > Teach this command which currently handles its own argv to use
>> > parse-options instead because parse-options helps make sure we handle
>> > user input like -h in a standardized way across the project.
>>
>> Sorry, but why do we even want to do this?
>
> It _is_ a command you can run via `git merge-ours` by mistake. Don't you
> think it would be nice for users to at least get a synopsis?

I think it would be good to tell users that the subcommand is not
what they want to run directly, instead of the synopsis to tell them
how to run it ;-).

So no.

But if merge-ours needs to learn its own -Xoption, it would make
sense to first convert it to use parse-options API and then add the
backend option support on top of it.  And the patch under discussion
in a polished form (by the way, has anybody pointed out that the use
of the verb "include" is a bit strange there on the patch title?)
would serve as a good first step for such a topic.

Thanks.


