Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8015DC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B32520829
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ub87jMam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407997AbgJPT0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 15:26:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62331 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393104AbgJPT0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 15:26:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04FBF812DA;
        Fri, 16 Oct 2020 15:26:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1xWYmZoJYINRIIBa98zLEK5r17g=; b=Ub87jM
        ampNMdM9c7fFIjoXd6FkhXqe8MWIzeRFhHeApE+RXBnL6lXf2m8sobykj8mIbmkV
        hQiYLVVnltCMmKkJw4Z0H7c5LpNJqZCUFww8HmFIl1fRHvdWswSGLzpVdVHxetM5
        NnRyHM+npMmArBX5V6rycGHr0rsl1LWSPQhAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RNDAS7ExO+7gRRTxwZ32oaZgvo5Elm+w
        sVU45k/geDg8C64cmbRfyXzvEOKJzo8d6v7q9Y7gS+NMmWP30Gq4MQLpj+PreFvx
        zcbujI6tKZa/Swe15vQOfsjvFxTtZKsnBWLyk5jHid0KsfLtCrsD5mJ0nj0QNo78
        5toNfqqJw4k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0E03812D9;
        Fri, 16 Oct 2020 15:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75F12812D8;
        Fri, 16 Oct 2020 15:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v11 0/7] Finish converting git bisect to C part 2 subset 2
References: <20201015133838.85524-1-mirucam@gmail.com>
        <nycvar.QRO.7.76.6.2010152241230.56@tvgsbejvaqbjf.bet>
Date:   Fri, 16 Oct 2020 12:26:13 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010152241230.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 15 Oct 2020 22:41:58 +0200 (CEST)")
Message-ID: <xmqqmu0mas6i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74B6A73C-0FE5-11EB-A35C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Miriam,
>
> On Thu, 15 Oct 2020, Miriam Rubio wrote:
>
>> These patches correspond to a second part of patch series
>> of Outreachy project "Finish converting `git bisect` from shell to C"
>> started by Pranit Bauva and Tanushree Tumane
>> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
>> continued by me.
>>
>> This patch series version is composed by the last seven patches of part2
>> set.
>>
>> These patch series emails were generated from:
>> https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v11-subset2.
>>
>> I would like to thank Johannes Schindelin for reviewing this patch series.
>
> Thank you so much for driving this forward.
>
> This entire series is Reviewed-by: me.

Will, queue; thanks, both.
