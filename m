Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125E91F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 17:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbcI1Ry7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 13:54:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52638 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752219AbcI1Ry4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 13:54:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8C1940961;
        Wed, 28 Sep 2016 13:54:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yhx+LSlfNhxy9ETfg3tQE3CfJvE=; b=QGGrbx
        4yKsHLASoomWwQ14HYcgKmRuNuab+t1nAR4/h0FTKDhsKPk2Y3qqprAOCHkCYjwP
        YvHtnJ5iCzWalDIMNAeUizmIVlmarlH5oe1k2pDf/sYe/IbSvmJch3cDVm7sZqoU
        7zf1ckUle0a+uEJ7tFhTYVhSimvICdjZ4yRyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wFFfuLggu4tGaQPSzApDRpQIOhQvjtGs
        V56fi+/J1M4+eBY81L589Asux9KgGKSSAj44uqNr+9vlg8djSAVMITrKwKjZDRvT
        WxkqfgdGiKxgawBcH+fk2GKld2iPX7zVfpRJjVpbPd3VstbesYR5bBRd+DdJNTRY
        PrwtHfYz1j0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0DAE4095F;
        Wed, 28 Sep 2016 13:54:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FB434095E;
        Wed, 28 Sep 2016 13:54:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/11] run command: add RUN_COMMAND_NO_STDOUT
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <1473984742-12516-11-git-send-email-kevin.m.wern@gmail.com>
        <xmqq37kzigvf.fsf@gitster.mtv.corp.google.com>
        <20160928044622.GE3762@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 10:54:52 -0700
In-Reply-To: <20160928044622.GE3762@kwern-HP-Pavilion-dv5-Notebook-PC> (Kevin
        Wern's message of "Wed, 28 Sep 2016 00:46:22 -0400")
Message-ID: <xmqqponnkiz7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A936B896-85A4-11E6-B56E-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Wern <kevin.m.wern@gmail.com> writes:

> On Fri, Sep 16, 2016 at 04:07:00PM -0700, Junio C Hamano wrote:
>> Kevin Wern <kevin.m.wern@gmail.com> writes:
>> 
>> > Add option RUN_COMMAND_NO_STDOUT, which sets no_stdout on a child
>> > process.
>> >
>> > This will be used by git clone when calling index-pack on a downloaded
>> > packfile.
>> 
>> If it is just one caller, would't it make more sense for that caller
>> set no_stdout explicitly itself?
>
> I based the calling code in do_index_pack on dissociate_from_references, which
> uses run_command_v_opt, so it never occured to me to do that. I thought it was
> just good, uniform style and encapsulation. Like how transport's methods and
> internals aren't really intended to be changed or accessed--unless it's through
> the APIs we create.
>
> However, I don't feel very strongly about this, so I'm okay with this change.

I am neutral and with no opinion.  I may have offered a solution to
a problem that did not exist.

I just got an impression that you were apologetic for having to add
this option that is otherwise useless and tried to suggest a simpler
solution that does not involve such an addition.
