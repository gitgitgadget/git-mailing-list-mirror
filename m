Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51AC71F461
	for <e@80x24.org>; Tue, 27 Aug 2019 22:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfH0W0E (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 18:26:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62512 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0W0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 18:26:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62D4C7B3AE;
        Tue, 27 Aug 2019 18:26:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1fntlwI899DkR6SQfeb1Q/W1sqE=; b=w0Oekd
        1n6eUdTIj4nV5RjZkz0OlvUzj56FCPYZhrI2MNUrKEvnK9to78A67YhKAS4evdFO
        ZB2MQjrzG7FNKMTDqyF+khwGomHjhoJIbRiKUhxSGbs1uPX9dgzExtFWkJ47TaNT
        FsJicRw4DuhZcjNrj9zkvkfcvsWAS6WG1W7rE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d5AoORGxKgZ24chZewjplxyrZLXkDTMK
        AjEdO/d2JV+KDTKe66Om+iGqLNtx/QL6dFnTsGKNIdXvHQ+fhN/WTzEfT1Om+43n
        4Wya7mtvfnplPca5oR0vtbWg17tl/ZpWMPdPRxdKsXN1/MYsnCUWe92c4m3eJ5e6
        BSRUOnSIm3U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A9D57B3AD;
        Tue, 27 Aug 2019 18:26:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A31FF7B3A8;
        Tue, 27 Aug 2019 18:26:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/11] Start to implement a built-in version of `git add --interactive`
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
        <0a5ec9345d2f9cc6cd348231219d4af428a28e94.1563289115.git.gitgitgadget@gmail.com>
        <xmqq1ry6qeg2.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1908262317250.46@tvgsbejvaqbjf.bet>
Date:   Tue, 27 Aug 2019 15:25:58 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908262317250.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 26 Aug 2019 23:26:22 +0200 (CEST)")
Message-ID: <xmqq5zmi2qkp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5EFDF44-C919-11E9-AB0A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Besides, I really hope that this would be only temporary,...

Oh, no question about it.  This should be temporary knob.

I still do worry about giving a bad example for others to copy.
People tend to copy & paste without thinking.  Either we come up
with and use a two-level name, or we add a comment to explain to
developers (not users---as this is merely a temporary thing) why
they should never follow suit using three-level names for things
like this one written in big red letters, or something, then perhaps
we won't have to worry about too much?  I dunno.

>> > +	if (use_builtin_add_i == 1 && !patch_mode)
>> > +		return !!run_add_i(the_repository, pathspec);
>>
>> I am hoping that eventually "add -p" will also be routed to the new
>> codepath.  Would it make sense to have "&& !patch_mode" here,
>> especially at this step where run_add_i() won't do anything useful
>> anyway yet?
>
> The `&& !patch_mode` is here to allow for a gradual adoption of the
> built-in parts. ...

Ah, so "add.usebuiltin = interactive patch" can (eventually) choose
to use the C code for both while "add.usebuiltin = interactive"
would not use it for the patch mode, or something?  Or even

	add.interactive.usebuiltin = yes
	add.patch.usebuiltin = no

perhaps?

> Of course, eventually this will be handled.

Yup, again, the knob is merely temporary.
