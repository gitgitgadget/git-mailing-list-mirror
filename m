Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC2E20899
	for <e@80x24.org>; Sun, 30 Jul 2017 21:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750926AbdG3V0A (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 17:26:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750741AbdG3VZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 17:25:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 356A993D70;
        Sun, 30 Jul 2017 17:25:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zEx1n/wdcmbBnW1+LAbTe7jN944=; b=s5ERvV
        p6YWqUB4RB/CU11YWkIefo86bic18Bf5/DQF6i9ony1BMNL16R+N8exHB0tb1bnu
        SuxFUS5gK15vmxgarHyZ8eXxXGaeU10LjPJr0OPyIc3qh9RZ55iP9m8gq5Y3tw1H
        V6jbPWX+xOr2TCVNEoQjd6+510g6BZ4P0hueA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t7WZIhD3sbD0cFRgvorkJkGug4W0pzdA
        2Y77Z/77NxTXTUga+fA6D/J6FcP+n9VcwTJchZzwLNl8KYYjq+NzxEHHE0CBXLSR
        nze0AugxWoKOv+1rpkR2ylLQw/M0P0nzN9P0PAgPJmtpFDbSVra3oNLQHJ/nQJ2V
        XyhYFMyA2ZU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DD6693D6D;
        Sun, 30 Jul 2017 17:25:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9912893D6A;
        Sun, 30 Jul 2017 17:25:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jens Lehmann <Jens.Lehmann@web.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/15] submodule: don't use submodule_from_name
References: <20170725213928.125998-1-bmwill@google.com>
        <20170725213928.125998-3-bmwill@google.com>
        <CAGZ79kY9Pdk5C8=k-AQpCPwo3q9Jzfg9A93UQxGyyf_OyrMS_Q@mail.gmail.com>
        <xmqqwp6uq56s.fsf@gitster.mtv.corp.google.com>
        <a3650c9a-fa42-09e6-efcd-f912d5ffc042@web.de>
Date:   Sun, 30 Jul 2017 14:25:50 -0700
In-Reply-To: <a3650c9a-fa42-09e6-efcd-f912d5ffc042@web.de> (Jens Lehmann's
        message of "Sun, 30 Jul 2017 15:43:25 +0200")
Message-ID: <xmqqefsxk469.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9A937EA-756D-11E7-B4D3-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> I wonder if we should barf loudly if there shouldn't be a submodule
>> at that path, i.e.
>>
>> 	if (!submodule)
>> 		die("there is no submodule defined for path '%s'"...);
>>
>> though.
>
> Not sure if you want to die() or just issue a warning(), but yes.

As long as the code after that point is prepared to see a NULL
submodule and still behaves sensibly, then I would of course prefer
not dying.  Continuing with just a warning() may not be a safe thing
to do if we are not prepared to see a NULL submodule after that
point, though.
