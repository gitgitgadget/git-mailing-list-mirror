Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030D6208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbdHYRIF (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:08:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54313 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754410AbdHYRIE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:08:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 025E994BB9;
        Fri, 25 Aug 2017 13:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zY58A5IaqQDdJ4VutS2R2zJX5h8=; b=en05Gz
        E0I6k/E+OM7hFDUYqGzS1QonoycxWu0zKKXfs78Zsgm9RRj+cQ/WI2P6yQ6niGM6
        4fVyqn+QxCoGaEuOGY6ko3d4foWKD5I4ubPdHGezAA1pMDdeqmkTTE2xvAdLjbiD
        0pQzQdTaCoTabc8O2ZgaH8Edwbf2kNhGQ1QVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sbGzJVsvf9l32U0SEeX8Xevsoctx0uA1
        rlN3k29ZLdZGG9aTbmjCqJKSz8a1C+W+o7Q7GmsUSjEwX9ONF9YQN+Ymy6jHN/4J
        EphB8THZubHovHPrFJYCki5nfv/+tKqoDnnP1sKULwRwxtjcjbSNBOJvg565cHAN
        D1RASm3BxtU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB6C094BB7;
        Fri, 25 Aug 2017 13:08:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 36DAC94BB5;
        Fri, 25 Aug 2017 13:08:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Should rerere auto-update a merge resolution?
References: <CACPiFCJH7RSb_rz6M6ADuGi0q+oeWYhE1fNMQC0EUcCn_kCJwg@mail.gmail.com>
        <xmqqlgmaxbuc.fsf@gitster.mtv.corp.google.com>
        <CACPiFCJCgKtTbKX8jCSC3QgMKZ7Usu2ojqXe5w_QAHwk7T4M-A@mail.gmail.com>
        <xmqqwp5ru17n.fsf@gitster.mtv.corp.google.com>
        <xmqqshgftyua.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 25 Aug 2017 10:08:01 -0700
In-Reply-To: <xmqqshgftyua.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 25 Aug 2017 09:07:57 -0700")
Message-ID: <xmqqfucftw26.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4844008-89B7-11E7-8324-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Martin Langhoff <martin.langhoff@gmail.com> writes:
>>
>>>  - when I tell it to forget, won't it forget the pre-resolution state?
>>
>> I do not recall the details of what I did ;-) so I played around a
>> bit.  Here is what I did:
>> ...
>> After git rerere forget, I observe (check subdirectories in
>> .git/rr-cache/ whose timestamps are recent) that postimage gets
>> removed but preimage and thisimage stay.
>
> Having said that, I suspect that it may be a bug if this procedure
> kept the original preimage.  It should either remove it, or update
> it to record the state before the ealier resolution was applied
> (i.e. make the updated preimage identical to thisimage, so that a
> corrected resolution can be taken from the working tree to pair with
> it).

I just made a cursory scan of rerere.c again, and it seems we are
doing the right thing.  The details are in rerere_forget_one_path()
where we unlink postimage, we recreate the conflicted state from the
stages in the index and update preimage.

It seems that code gives up if you already declared that you'd take
the previous resolution by adding the result to the index.  It may
probably be a good idea to unmerge such a merged index entry instead
of giving up.  #leftoverbits

So, yes, it will forget both preimage and postimage, and it should
update the preimage with the conflict you got during _this_ merge,
so that the resolution you make _this_ time will become usable as
the corresponding postimage for the next time.



