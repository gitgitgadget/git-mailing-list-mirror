Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B771F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 02:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeKNMqI (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 07:46:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60750 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbeKNMqI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 07:46:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE264288FF;
        Tue, 13 Nov 2018 21:44:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zPTGpnFA4OLQ
        X7dcPOuktIGV2K8=; b=tREvgMSXOe8x8eJaAcA0fxaMQq3dcXZSGXWr5bQxc1j7
        J3wJiKy+7SsTkpZfREzc/ltsgJxrksO4nArCWeDB5sDbH/JJ8aBqs7iGL1EmLk0s
        rUp1IbIFnPdlKQVoalMNzZv7IEW9GY59ZbOVwPsKD4twFRwXfkaBdnJItFyA82g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P68Lel
        ObOFLL0DSm257LbgxMjmG/gzXK61rtoX02rKph0THxkB/zofIvj08jixRxF0Nb9x
        ZWPm290TO+6Zhw6qhq0OE8UtX04o0imMNr6NfqniL5YeTJbnqZoUBrSqkcyFeWgb
        9UrvN0KKUZnFgXgZm3FELiTF/6YvT6UYojO6I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E75A7288FD;
        Tue, 13 Nov 2018 21:44:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0AEDC288FB;
        Tue, 13 Nov 2018 21:44:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     steadmon@google.com, git@vger.kernel.org, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
References: <cover.1539305180.git.steadmon@google.com>
        <cover.1542059029.git.steadmon@google.com>
        <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
        <20181113182802.GG30222@szeder.dev>
Date:   Wed, 14 Nov 2018 11:44:51 +0900
In-Reply-To: <20181113182802.GG30222@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 13 Nov 2018 19:28:02 +0100")
Message-ID: <xmqqwopgqsws.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 43FE7410-E7B7-11E8-8B59-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +	if (tmp_allowed_versions[0] !=3D config_version)
>> +		for (int i =3D 1; i < nr_allowed_versions; i++)
>
> We don't do C99 yet, thus the declaration of a loop variable like this
> is not allowed and triggers compiler errors.

I thought we did a weather-balloon to see if this bothers people who
build on minority platforms but

	git grep 'for (int'

is coming up empty.

We have been trying designated initializers with weather-balloon
changes (both arrays and struct fields) and I somehow thought that
we already were trying this out, but apparently that is not the
case.  Also trailing comma in the enum definition was what we
discussed earlier but I do not know if we had weather-balloon for it
or not offhand. =20

Perhaps we should write these down in CodingGuidelines.
