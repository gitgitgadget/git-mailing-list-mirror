Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AD6208BD
	for <e@80x24.org>; Thu, 10 Aug 2017 22:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbdHJWFA (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 18:05:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63263 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751487AbdHJWE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 18:04:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 345CDA1343;
        Thu, 10 Aug 2017 18:04:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T0TdP2I2F2OrYhcUEZA92iHqda4=; b=Z5Neh6
        cL1G2IT7ZGBbeDYNtN2sz6UwW3svo3nf+q7XFaO/goCrmmSV6nzdCyCEurGvoKxl
        nhMWY9451o4wvq8PMufQFBZMGe3ZWutJWxSO09AZv7O6k7AoOlYkCQRI6+RRVG9L
        PN5SSgGfDI/87tJRJLiLSmOey/CHi7dWkkkec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iArKtXoZayWNTxPdcn6cxAeg41wqZ9KM
        1wZkEnFTaFgZbWpN0FlED4DWf3/38Un4x48OS02zGKgvxCEePKClZuTL8KsxIuIi
        oGuCmEliPV+7t2c+W54f2G257nEXyaxakEVpcwDHns4+LgvLLc0/a8mhwA8TwJCZ
        S4ghan3JL3E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CC84A1342;
        Thu, 10 Aug 2017 18:04:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A207A1340;
        Thu, 10 Aug 2017 18:04:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH V2 2/2] Convert size datatype to size_t
References: <1502348462-4992-1-git-send-email-martin@mail.zuhause>
        <1502348462-4992-2-git-send-email-martin@mail.zuhause>
Date:   Thu, 10 Aug 2017 15:04:51 -0700
In-Reply-To: <1502348462-4992-2-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Thu, 10 Aug 2017 09:01:02 +0200")
Message-ID: <xmqqwp6b13lo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF83AC16-7E17-11E7-A706-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> For next. As this touches core functions, it will likely produce
> conflicts with other changes. Please provide the commit you want
> to rebase the patch on and I'll produce a V3.

No matter what base you pick, by the time the series is merged with
other topics in flight to form an updated 'pu' branch, any series of
this invasiveness will cause conflict.  

So from that point of view, picking 'master' or 'next' as the base
would not make much difference.

However, picking 'next' (or 'pu') as the base is definitely worse
than 'master' for a different reason.  Anything based on 'next',
even though it may apply cleanly there, will not be able to graduate
to 'master' without dragging all the other topics that are in 'next'
with it.  Immediately after a feature release is the worst time, as
we will rewind and rebuild 'next' on top of 'master'.

In practice, the only sensible base for an invasive change is the
mimimum one you create yourself.  You would:

 (1) Start from a reasonably stable base, like 'master'.

 (2) Among topics that are in flight but not in 'master', find the
     ones that materially interfere with your changes.  Merge them
     on top of (1).

 (3) Then build your change on top.

In the patch series you create in step 3, you would note which base
you chosen (e.g. "v2.14.1") in step 1, plus the names of the topics
you merged in step 2, after three-dash lines.

The set of topics you find in step 2 might end up including a topic
that is of dubious doneness (e.g. especially the ones that are not
yet in 'next').  In such a case, you or the other topic may have to
yield and wait for the other to stabilize.  Git is not a substitute
for inter-developer communication, and you'd talk to the author of
the other topic and coordinate between yourselves when it happens.

Thanks.

