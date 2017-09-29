Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD2482047F
	for <e@80x24.org>; Fri, 29 Sep 2017 09:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbdI2Jf2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 05:35:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61439 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750847AbdI2Jf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 05:35:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2039B9DBF6;
        Fri, 29 Sep 2017 05:35:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=04eiGoNGAYCLpCGlrC2CpcBvPnQ=; b=Bc7VYA
        pod6OO6I/oE1QqXyniFW8QWpLVNSuVTSlUb5NsP3wJcIF+/JC52zUstPGKBayawq
        EMm8jei3HdiatzfSovHjmWyp+Okq82k3HK+SGndr9+kLJtAXeAp6VV5twemlhfor
        IzRtiiMXVW9ihakFgbEvowDppv+c6B5vQIjLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Po1weatDt7XUBLLxX8ZXGyxzeRR5pQ5s
        Yc17qREUJ9ikDmxtGaQEM99zKY8LTNH1gkXpMTSF5FcJvfF3RqjgFNJzNB/3nZfG
        BcslcrEzVre99tejC7qgIeFKqMLdyFXs5/qakjf2VQmcZohGJ51Ay8/W7AkkyUa7
        V/C9QEyyPs0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16FA89DBF4;
        Fri, 29 Sep 2017 05:35:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70AA39DBF3;
        Fri, 29 Sep 2017 05:35:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Rannaud <e@nanocritical.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
        Jeremy SERROR <jeremy.serror@gmail.com>,
        "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
References: <xmqq3776z0jg.fsf@gitster.mtv.corp.google.com>
        <0cb786584bd2669763c303f80072baa3693efc33.1506654123.git.e@nanocritical.com>
        <xmqqy3oyxiuo.fsf@gitster.mtv.corp.google.com>
        <CAH_=xobLo+K74HJ3a+XK4A3ok-FZJkAkO-9griaETkH50Qtp-A@mail.gmail.com>
Date:   Fri, 29 Sep 2017 18:35:24 +0900
In-Reply-To: <CAH_=xobLo+K74HJ3a+XK4A3ok-FZJkAkO-9griaETkH50Qtp-A@mail.gmail.com>
        (Eric Rannaud's message of "Thu, 28 Sep 2017 22:40:29 -0700")
Message-ID: <xmqqbmltx2xv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8652A5AE-A4F9-11E7-A57B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Rannaud <e@nanocritical.com> writes:

> On Thu, Sep 28, 2017 at 8:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think that your patch the last round that feeds fd#8 in the
>> foreground (i.e. fully trusting that the caller is sensibly giving
>> input that produces no output) is already a good place to stop.
>>
>> Your patch this round that feeds fd#8 in the background, plus the
>> attached patch (i.e. not trusting the caller as much and allowing it
>> to use commands that outputs something, within reason), would also
>> be a good place to stop.
>>
>> But I am not sure your patch this round alone is a good place to
>> stop.  It somehow feels halfway either way.
>
> I agree. If we're coding defensively against the caller, we do have to
> include your patch to be effective, you're right. I reckon we likely
> don't need to be quite so paranoid, at least until this has more
> users.

OK, let's then pick the (not too excessively) defensive version by
taking your last one and suggested "while" loop squashed into it.

Thanks.
