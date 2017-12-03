Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3925220A40
	for <e@80x24.org>; Sun,  3 Dec 2017 00:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbdLCAh6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 19:37:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63504 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751494AbdLCAh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 19:37:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D46DB8663;
        Sat,  2 Dec 2017 19:37:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eNXzxHrZo7YSyJxLYE/tarUJ/ho=; b=YiEapM
        fdYM2GO8rXkc2jUoWguBTipStLrkF383nLzp71ys71O8B2bk8Hf1s3SSWYPEWNxO
        N/kRVv2PfSkLFtGWZxXfGmQhguGsWjZyXfy9aj0uCW8/0YO0h7b8S75dbp/bS9eo
        P3fvGWNB7BVWobGpN5ffL40PCjg3ZEZryS8Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c57TYe9ydUg/BRALUifBpuX8Gkqxlg4D
        H5+d5qTJagiyacF525qCg1G8RR6WUI3sUUDORRixRFRSdh2RqMs4uvtNLuIErS+f
        5Lmw8z/SSRkBrBU6ZsEk8gYD4zk8fIL5hTllolWZWPiwO5h68un2oL3tTewL1GDG
        dsh6kynApo0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25DB1B8662;
        Sat,  2 Dec 2017 19:37:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88F4AB8661;
        Sat,  2 Dec 2017 19:37:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
References: <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
        <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
        <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
        <20171122202720.GD11671@aiede.mtv.corp.google.com>
        <20171122211729.GA2854@sigill>
        <20171122215635.GE11671@aiede.mtv.corp.google.com>
        <20171122220627.GE2854@sigill>
        <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
        <xmqq7eudidqb.fsf@gitster.mtv.corp.google.com>
        <20171127044314.GA6236@sigill>
        <20171127205731.GB27469@aiede.mtv.corp.google.com>
Date:   Sat, 02 Dec 2017 16:37:55 -0800
In-Reply-To: <20171127205731.GB27469@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 27 Nov 2017 12:57:31 -0800")
Message-ID: <xmqq7eu4mysc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34BB3AB6-D7C2-11E7-AF64-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I am worried that the project is not learning from what happened here.
> ...
> Fair enough, though that feels like overengineering.  But I *still*
> don't see what that has to do with the name "no-optional-locks".  When
> is a lock *optional*?  And how am I supposed to discover this option?
>
> This also came up during review, and I am worried that this review
> feedback is being ignored.  In other words, I have no reason to
> believe it won't happen again.

I too would like to see this part explained a bit better.
