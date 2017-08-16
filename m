Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545181F667
	for <e@80x24.org>; Wed, 16 Aug 2017 21:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdHPVzo (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 17:55:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59110 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752605AbdHPVzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 17:55:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6534AA9709;
        Wed, 16 Aug 2017 17:55:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NS1Pp67X36N8Lk9E/sFtlM6Atkc=; b=DRIOtL
        TD2VQOUisc4+OPB4VLwC8pyWvmuNbKnCbLCPLnXFKF4OJRoKJR43AhOh/CbKBiON
        KvHvDd0AfbnVEBYXCvsc2+nCyquvdre+JfyUWfyQ7SSrHEXjtQD9oKHcUlnOXFBc
        YLNjI/B9YK6RtbyHyCQNv0qi2dLCZ1e9yvMOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YvtuAoorvm0aENzYIJTFqlp7NFvl7uip
        VDA013nCZO0v21Ac0ndZ1RW5PJZTyXuwE4pa4WiIzQA+lb6tBVuzWi3fhVPmgwBT
        wooJLYVJp40enIjgqhGpIblBnozcyrZ9TcsiLsOiRya9M0dsBfBX08oSvILzs331
        HschKuPIOyQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 507CCA9708;
        Wed, 16 Aug 2017 17:55:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B684A9706;
        Wed, 16 Aug 2017 17:55:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] sub-process: print the cmd when a capability is unsupported
References: <20170816124036.25236-1-chriscool@tuxfamily.org>
        <758d36a7-8066-7e1a-30d0-62baf2796520@gmail.com>
        <xmqq4lt7pir9.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 16 Aug 2017 14:55:40 -0700
In-Reply-To: <xmqq4lt7pir9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 16 Aug 2017 09:41:46 -0700")
Message-ID: <xmqqshgri3dv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A592AC14-82CD-11E7-9DB0-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ben Peart <peartben@gmail.com> writes:
>
>>> -			warning("external filter requested unsupported filter capability '%s'",
>>> -				p);
>>> +			warning("subprocess '%s' requested unsupported capability '%s'",
>>> +				process->argv[0], p);
>>>   		}
>>>   	}
>>>   
>>>
>>
>> This one is even cleaner.  Thanks Lars for pointing out the fact we
>> already had the cmd name.  Looks good.
>
> Thanks, all.  Will queue.

I still think we would want to turn warning() to die(), but it
probably is better to do so in a separate follow-up patch.  That
will give us a good place to record the reason why the current "just
call a warning() and pretend as if nothing bad happend" is wrong.

