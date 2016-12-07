Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D898C1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbcLGU3C (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:29:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752658AbcLGU3C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:29:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAFA855AF8;
        Wed,  7 Dec 2016 15:29:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yemapRYMG0EWFMU/PzphKrFdUxo=; b=yPshfK
        D/JqLm8rN+lTxE6+oQVy3OIlpPiIE6HOxlRQ8tn/CrWb3Ic6RXef0x7GQEzA828r
        ciGh3nIvy1NaoIGY5VktezCtbDU8heEBt6S1ToMuHPVWZphvqOVuQOh0CcxCcKd4
        nSR3blO6oY9VOgjLuJHomoezWHLsrNDblKHhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h9zuKwLlalCInReCDZGYlcHYDYs+He5M
        wJU7g9kIvy6sJyU0k9ei9N0uKvCI0a8CqTy/xrnO4yLokzvPj/VjJIykU3jphdsY
        Wbo1dvJ+n7eWOsikUdNg0k/DCoilwaLBl0idN+K7GHq9qc1bF+gHjQthCeMnRT14
        gkJZ8d5UaA8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8CCE55AF7;
        Wed,  7 Dec 2016 15:29:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B5BC55AF6;
        Wed,  7 Dec 2016 15:28:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     vi0oss@gmail.com, "git\@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
References: <20161207184248.6130-1-vi0oss@gmail.com>
        <CAGZ79kY3LR2KA69b4iDJb164EhJLb3JuVSRRcN0-4-kp-eryog@mail.gmail.com>
        <xmqq4m2fxzl2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka=XgO-VyS+Jqq2Fy28kPMy6HnXBAHb79Dt3NegZFd6kw@mail.gmail.com>
Date:   Wed, 07 Dec 2016 12:28:58 -0800
In-Reply-To: <CAGZ79ka=XgO-VyS+Jqq2Fy28kPMy6HnXBAHb79Dt3NegZFd6kw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 7 Dec 2016 12:26:36 -0800")
Message-ID: <xmqqzik7wkj9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9210B2C-BCBB-11E6-92A3-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Dec 7, 2016 at 12:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> This patch makes all not just the root repository, but also
>>>> all submodules (recursively) have submodule.alternateLocation
>>>> and submodule.alternateErrorStrategy configured, making Git
>>>> search for possible alternates for nested submodules as well.
>>>
>>> Sounds great!
>>
>> Is it safe to assume that all the submodules used recursively by
>> submodules share the same structure upstream?  Does the alternate
>> location mechanism degrades sensibly if this assumption turns out to
>> be false (i.e. "possible alternates" above turns out to be mere
>> possibility and not there)?
>
> According to the last test in the patch, this seems to be doing the
> sensible thing.

OK, that sounds great.  Thanks.
