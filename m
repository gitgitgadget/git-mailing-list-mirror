Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7570C47E48
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2358613D6
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhGNU7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:59:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58523 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhGNU7F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:59:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ACBC3130E39;
        Wed, 14 Jul 2021 16:56:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W2IOIjDuGdfe7Ko6/ovRM2CPZiaaO0aWOBJSxJ
        d7z8E=; b=l/XWqPW84nwxByNCIumsmz3uTqUwOorOetc0RtGXEun2UWr9L+GzLu
        G7uHUUGLXbSKXx/aLr3NVwdQ10Ao9Q2A86pwl3QIPIpyFIGQV94iaPSWWT7/IzfG
        osfsDT8LkIVC9fePlhHrscfjsqWTKf65FEMSNVwmj3FqUYQOaXhIE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A5BCE130E38;
        Wed, 14 Jul 2021 16:56:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 287EB130E33;
        Wed, 14 Jul 2021 16:56:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
        <xmqqbl7525w7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107141124530.76@tvgsbejvaqbjf.bet>
        <xmqq35sgzy0d.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107142252060.59@tvgsbejvaqbjf.bet>
Date:   Wed, 14 Jul 2021 13:56:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2107142252060.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 14 Jul 2021 22:54:07 +0200 (CEST)")
Message-ID: <xmqqa6movcly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB555E94-E4E5-11EB-A958-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 14 Jul 2021, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > Which means that the likelihood of a run to fail increases with the number
>> > of jobs in said run (even innocuous problems such as transient failures to
>> > download an Ubuntu package), and it also makes it much more painful to
>> > re-run the entire thing because you may well end up wasting a grand total
>> > of ~370 minutes even if only a 30-second-job would need to be re-run.
>> >
>> > Having said that, I think you're right and the upside of keeping things
>> > together may outweigh that downside.
>>
>> I wasn't make a request or a demand to change or not to change
>> anything, so in this particular exchange there was no point where I
>> was right (or wrong, for that matter ;-).  I was asking if there was
>> a solid reasoning behind the split, and if there is, I am perfectly
>> happy to see it done as a separate workflow with the log message
>> that explains why it is separate.  I am also perfectly fine with
>> this rolled into the primary one, with clear reasoning behind the
>> choice recorded in the log message.
>
> I do not think that it would be an improvement to defend the default
> choice (i.e. to add this new job to `.github/workflows/main.yml`) in the
> commit message. It is the default for new CI stuff to go, after all, and
> we do not need to clutter the message by stating the obvious.

It wasn't quite obvious why we justify spending 370 minutes one more
time only to rerun 30-second job, though.
