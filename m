Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EEEC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D0622517
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390319AbhARXyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:54:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54207 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732553AbhARXye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 18:54:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0622A3CAE;
        Mon, 18 Jan 2021 18:53:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ecCsOolsRkROTafyYd5Kiz7Sbmk=; b=mgwlop
        ihO6sJycEZgqVbJolDHJmT+mq2jn6+uZ7lQZsuzTBLOX4OdG4PMp/zDgVb+o7799
        O9xTzkso3ZwGuxkO0bEwdOs6tgNexqzHo6nsnuHuZJeXoIU1V96dZk3IFwMCz/67
        AlBIcGdaPp1ezcdQ6OqGvX/cE1z3pTb7y+xcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eVYNrCTSWVVTXCh/KeZZz5G87o2Uog8f
        xkVoxVuEetdQnaYT7POgH8tBhHdNT1EZCy3LO4SleVusqrXiKCGjN2Lc4zhSy/ge
        +pneCAtmC3sd3xSMCVESsJi5ffHqMoqOa5JFe/9OpJwOZZljI1ZcV2VTGNwCyp0b
        OPaFojLIV0k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8C9DA3CAD;
        Mon, 18 Jan 2021 18:53:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7186AA3CAC;
        Mon, 18 Jan 2021 18:53:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Finish converting git bisect to C part 3
References: <20201221162743.96056-1-mirucam@gmail.com>
        <nycvar.QRO.7.76.6.2101181714370.52@tvgsbejvaqbjf.bet>
Date:   Mon, 18 Jan 2021 15:53:50 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101181714370.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 18 Jan 2021 17:15:16 +0100 (CET)")
Message-ID: <xmqqr1mhiyy9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A403D7A-59E8-11EB-ADDA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Miriam,
>
> On Mon, 21 Dec 2020, Miriam Rubio wrote:
>
>> These patches correspond to a third part of patch series
>> of Outreachy project "Finish converting `git bisect` from shell to C"
>> started by Pranit Bauva and Tanushree Tumane
>> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
>> continued by me.
>>
>> This third part is formed by reimplementations of some `git bisect`
>> subcommands and removal of some temporary subcommands.
>>
>> These patch series emails were generated from:
>> https://gitlab.com/mirucam/git/commits/git-bisect-work-part3.
>
> Nice, thank you very much!
>
> I offered a couple suggestions how I think this patch series could be
> improved even further.
>
> Looking forward to the next iteration,
> Dscho

Thanks for taking time to review a topic.  It would be really nice
to see this topic thru to its end.

And of course, thanks Miriam for your continued effort on the
"bisect" topic.
