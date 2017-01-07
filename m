Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6969120756
	for <e@80x24.org>; Sat,  7 Jan 2017 21:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbdAGVSS (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 16:18:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52047 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751795AbdAGVSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 16:18:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 523015CB01;
        Sat,  7 Jan 2017 16:18:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XQFoXh0r5Dfg0PPYoYkgJAjoVWs=; b=NlRVJL
        XYIStu2g4/fPSZqHJoYRZtlMIG1sr9QZzpruKXbMTF2CpdohWRegxycjPjIQ7LvD
        aVSnpo+hfBnT4tgRAQnA39Eu8lys4TPZToqzSfK35XkKmcDZ1aVuGNf4lskg3eCh
        Uxb6/1IIbUV2Z+ZoGM2/PXw99hln7Qh9hcYa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZFmSHwIQjuRKaXl/X8PTmT3AifgLRduw
        4Fd7txTUW3tpzyiFA98VEa5yqCF+Nq1PFaGMs3UaBtx1XutACiwAl5G7nsxTOlJv
        jift/6NW+pe06oy584Anu9sS7GndIPibSflb17ie06/ojlmr7Cmm4TtHfWSh6Kl3
        qkNzInsIPG8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 494535CB00;
        Sat,  7 Jan 2017 16:18:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A29725CAFE;
        Sat,  7 Jan 2017 16:18:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Luke Diamand <luke@diamand.org>,
        Git Users <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] don't use test_must_fail with grep
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
        <CAE5ih7-7e+ZLUbE7iquWV2=qP4ofzAHUC2ZPg3b-ivSpCo4eRw@mail.gmail.com>
        <285ed013-5c59-0b98-7dc0-8f729587a313@kdbg.org>
        <CAFZEwPNbtamFfFy7vYXurpEWBDmRMyPB9+Ep-hm4uZVMREbq5Q@mail.gmail.com>
Date:   Sat, 07 Jan 2017 13:18:13 -0800
In-Reply-To: <CAFZEwPNbtamFfFy7vYXurpEWBDmRMyPB9+Ep-hm4uZVMREbq5Q@mail.gmail.com>
        (Pranit Bauva's message of "Mon, 2 Jan 2017 19:10:12 +0530")
Message-ID: <xmqqy3ym36y2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD05D6FC-D51E-11E6-8719-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Hey Johannes,
>
> On Sun, Jan 1, 2017 at 8:20 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> which makes me wonder: Is the message that we do expect not to occur
>> actually printed on stdout? It sounds much more like an error message, i.e.,
>> text that is printed on stderr. Wouldn't we need this?
>>
>>         git p4 commit >actual 2>&1 &&
>>         ! grep "git author.*does not match" actual &&
>>
>> -- Hannes
>
> This seems better! Since I am at it, I can remove the traces of pipes
> in an another patch.
>
> Regards,
> Pranit Bauva

I see v3 that has 2>&1 but according to Luke's comment ("the message
comes from cat"), it shouldn't be there?  I am behind clearing the
backlog in my mailbox and I could tweak it out from v3 while
queuing, or I may forget about it after looking at other topics ;-)
in which case you may want to send v4 with the fix?
