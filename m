Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DDE31F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 17:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfHNR41 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 13:56:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51437 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfHNR41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 13:56:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 025507C1C2;
        Wed, 14 Aug 2019 13:56:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BdtQYlZm2vKZ4eK/mAMcGxVIa+c=; b=WNAw7e
        QF3beYMaGa0GH5SMfEZjxOBRP5jQ5ohpQZ3GTgcZvnBXzIWyu1hJo2SKZGT/5ZxL
        xOWEbfRA4UKWSFUl0MVeC9kWeU45ax69pj0FzhdjI3OQ/r7LdDwsSMl68LoRzbE1
        LGr091gkK82nCk7Vzihvu6/YVKEHUUWZTQSzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lU3nrCRyUkV3ekOZUSjVKPl0sQ4Ct/cc
        LRlDKh7mkFW9TYP0yI36gdcQjxAv8nFYT7g5F8KIdmJfuUhgnjRMGFT89mSc4oS2
        w2CyhSET84anyqZPUrg+Wg1CCK9wpN7/jZb0SHOApDSc0ODJMIE5PpXc5VHodxjM
        MkcgJuZ25Pk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE5C27C1C1;
        Wed, 14 Aug 2019 13:56:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 262097C1C0;
        Wed, 14 Aug 2019 13:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Paolo Pettinato \(ppettina\)" <ppettina@cisco.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git fetch bug in git 2.21+ "Could not access submodule '%s'"
References: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
        <20190814153607.GB12093@sigill.intra.peff.net>
        <xmqqpnl766pj.fsf@gitster-ct.c.googlers.com>
        <5a58b0eb-0690-c445-dbfd-bd4c5b614629@cisco.com>
Date:   Wed, 14 Aug 2019 10:56:19 -0700
In-Reply-To: <5a58b0eb-0690-c445-dbfd-bd4c5b614629@cisco.com> (Paolo
        Pettinato's message of "Wed, 14 Aug 2019 17:03:44 +0000")
Message-ID: <xmqqh86j637g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D36C32E0-BEBC-11E9-9827-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Paolo Pettinato (ppettina)" <ppettina@cisco.com> writes:

> Thanks for the reply!
>
> On 14/08/2019 17:40, Junio C Hamano wrote:
>>   Why is the user mucking with
>> that directory in the first place, and isn't the flagging of the
>> situation as an error, done with 26f80ccf ("submodule: migrate
>> get_next_submodule to use repository structs", 2018-11-28), a
>> bugfix?  If not, why not?
>
> Not sure if you're implying here that this is not a bug; I'd say that:

Yeah, sorry for a confused comment.

It does feel strange that the error behaviour depends on what is in
the working tree for a "fetch", which is between two $GIT_DIR and
does not involve the working tree on the receiving side (that brings
us back to my earlier comment in the same message).
