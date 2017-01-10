Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7254E20756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033842AbdAJUXq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:23:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56730 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030869AbdAJUXp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:23:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 417415FEFC;
        Tue, 10 Jan 2017 15:23:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TgB9caBObwigeq2zQ94lt0JiL6g=; b=DzSEJf
        2ClkrdSYa2biCg3lgo1MO8nn+i0Dft+W6393YmsgDATAfNVxXSaBerYwitIOu4Uo
        y/4eMQv9bK0uE6dPU6PZMHsZ6ypb+sjafNA73cc8M8MqwkIUDVcZeqBAi+WXj3YM
        JKcV4hdIOckOnVoNmgTiEVovw9wnwGqw7tJvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nOpXbX8ZtcHmjfEN/POI3+50c8aR7inb
        movl0lPXRR1V7lyNcXxspXDBscv2wJOD8rw99UBS8V0ZF5MoxzDDa973llW+fitN
        Uao304kxl68+muLUrdvRpV+hJ1yROx3DBWL8Lw9RCZOnLX5shgvZTgxAQLVPL+px
        KxeveTqEvQw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 389BF5FEFB;
        Tue, 10 Jan 2017 15:23:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CEA15FEFA;
        Tue, 10 Jan 2017 15:23:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: document behavior of relative diff.orderFile
References: <20170110004031.57985-1-hansenr@google.com>
        <20170110004031.57985-2-hansenr@google.com>
        <20170110065816.pu325sxajbyuqpj6@sigill.intra.peff.net>
        <e100d30a-5ee8-8485-5012-f9b1c6961ffa@google.com>
        <xmqq4m16sm5v.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 10 Jan 2017 12:23:42 -0800
In-Reply-To: <xmqq4m16sm5v.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 10 Jan 2017 12:19:24 -0800")
Message-ID: <xmqqziiyr7e9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE94526A-D772-11E6-97EC-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Richard Hansen <hansenr@google.com> writes:
>
>> On 2017-01-10 01:58, Jeff King wrote:
>> ...
>>> What happens in a bare repository?
>>>
>>> I'm guessing it's relative to the top-level of the repository,
>>
>> I just tried it out and it's relative to $PWD.
>
> That is understandable.  When the user says
>
>     $ cmd -O $file
>
> with any option -O that takes a filename, it is most natural if we
> used $PWD/$file when $file is not absolute path.

Ahh, ignore me in the above.  The discussion is about the
configuration variable, and I agree that being relative to GIT_DIR
would have made more sense.  In fact taking it as relative to PWD
does not make any sense.

We should have been a lot more careful when we added 6d8940b562
("diff: add diff.orderfile configuration variable", 2013-12-18), but
it is too late to complain now.

A related tangent.  

I wonder if anything that uses git_config_pathname() should be
relative to GIT_DIR when it is not absolute.

