Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F902070F
	for <e@80x24.org>; Mon, 19 Sep 2016 17:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbcISRD4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 13:03:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57000 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752436AbcISRDz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 13:03:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D02983E76C;
        Mon, 19 Sep 2016 13:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=06dTlZnFkpOqSHDtgI4QmOwbgKI=; b=AQcIOq
        wC7GynxP1MeLL9JbltoMJ9v1re2PozH9jNSRZwyZtYLkAtvPPT9CF1q6El9AG7tf
        X5lggMi1RHyfvCu42yezWrtU38VAToBQQUgAv8/yl9reojI1NqZaRp2NqAvq0ffO
        ZxKw25B3xP3xOLvZXazF2per4wvxFm/1eYsVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yVwc5U6f1DdFZe3igm2sbLIWFVoiwhfP
        9JWtD9S5FG4fcpa7p9eKHfIOoyO9wgnFJ3e9C8/8JOBKCwdgmhnDrjg448oEFHRz
        0sFI+bJeMyzhT9DKfgrW8P5LE/FwA5Ro7XhGB1CyQRCgXBCO70Pk0XgNFdwNh3j/
        zoxOcr5byEE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C94853E76B;
        Mon, 19 Sep 2016 13:03:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 505EC3E76A;
        Mon, 19 Sep 2016 13:03:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Peart" <peartben@gmail.com>
Cc:     <pclouds@gmail.com>, "'Ben Peart'" <benpeart@microsoft.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
References: <20160913142628.15440-1-benpeart@microsoft.com>
        <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>
        <BL2PR03MB3232D3128A72D4EC9ADC2C6F4F10@BL2PR03MB323.namprd03.prod.outlook.com>
        <BL2PR03MB323E1B2F810C63CB01AA234F4F30@BL2PR03MB323.namprd03.prod.outlook.com>
        <007401d21278$445eba80$cd1c2f80$@gmail.com>
        <xmqqzin3g8di.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 19 Sep 2016 10:03:51 -0700
In-Reply-To: <xmqqzin3g8di.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 19 Sep 2016 09:30:17 -0700")
Message-ID: <xmqqr38fg6tk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B1E4EFA-7E8B-11E6-AC1A-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> "git checkout -b foo" (without -f -m or <start_point>) is defined in the
>> manual as being a shortcut for/equivalent to:
>>  
>>         (1a) "git branch foo"
>>         (1b) "git checkout foo"
>>  
>> However, it has been our experience in our observed use cases and all the
>> existing git tests, that it can be treated as equivalent to:
>>  
>>         (2a) "git branch foo"
>>         (2b) "git symbolic-ref HEAD refs/heads/foo"
>> ...
>
> I am still not sure if I like the change of what "checkout -b" is
> this late in the game, though.

Having said all that.

I do see the merit of having a shorthand way to invoke your 2 above.
It is just that I am not convinced that it is the best way to
achieve that goal to redefine what "git checkout -b <new-name>" (no
other parameters) does.
