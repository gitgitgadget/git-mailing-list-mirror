Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45D0C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9174120CC7
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gU+WN5aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgDXAqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:46:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61311 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgDXAqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:46:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76A3C4E8B6;
        Thu, 23 Apr 2020 20:46:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2kjFgH/ahXeIjpc26WxF1cXAjO8=; b=gU+WN5
        aIXq1XzObASTFCD8a2CvW3JtVuytMDbZ3O0WiXjlaHgE3blwRqOmnYrC0kg2HKn4
        iVtdIyFMWuAY5W0uLDd4ha22mlLB6XjL+XjRb04fME+AnWo+61QdmP5hXEsdHUiH
        eEquaNB9P8yOH5WZUXWK0/85CnV68gsUCEhvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c9N+gzdZaidFqpvFK1ePucrvO6iifX8Z
        ZdlqRqbyQXf8ixkTzVFRaMdUh6ogw58lMGDe0quGTCQv/IWKcbVOB6G/fwS82Cod
        MjEiYdkR3JetL29v/NDzHg0di3Chn0Opw+acQAwhJ88KoaeWnfJlwalnYW5fBjD3
        ktPgU9rlAj0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C9054E8B5;
        Thu, 23 Apr 2020 20:46:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C38F34E8B1;
        Thu, 23 Apr 2020 20:46:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/2] date.c: skip fractional second part of ISO-8601
References: <cover.1586856398.git.congdanhqx@gmail.com>
        <cover.1587559135.git.congdanhqx@gmail.com>
        <c6d42785bb762f691b00c48b57c73a1933fadbc3.1587559135.git.congdanhqx@gmail.com>
        <xmqqk127jvrh.fsf@gitster.c.googlers.com>
        <20200423011812.GA1930@danh.dev>
        <xmqqmu72gfxu.fsf@gitster.c.googlers.com>
        <1861c472-7756-d433-9185-d83c03d72b9b@iee.email>
        <20200424000707.GB1949@danh.dev>
Date:   Thu, 23 Apr 2020 17:46:20 -0700
In-Reply-To: <20200424000707.GB1949@danh.dev> (Danh Doan's message of "Fri, 24
        Apr 2020 07:07:07 +0700")
Message-ID: <xmqqh7x9emn7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03DE0474-85C5-11EA-AA3C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2020-04-23 21:41:49+0100, Philip Oakley <philipoakley@iee.email> wrote:
>> On 23/04/2020 20:28, Junio C Hamano wrote:
>> > Danh Doan <congdanhqx@gmail.com> writes:
>> Would is_hhmmss() and is_yyyymmdd() be more obvious abbreviations for
>> most readers?
>> 
>> Now that I type them, they do feel that bit too long... , as naming is
>> hard, maybe stick with the yms and hms, though I do keep wanting to type
>> ytd for the former..
>
> Not sure if I interpret your opinion correctly,
> Did you mean s/yms/ymd/ and s/ytd/ymd/?
>
> Even that, I couldn't grasp the meaning of the last phase?

Here is how I understood it.

Philip thinks, and I admit I have to agree with, that HMS would not
be understood as hour-minute-seconds by most people, and YMD would
not be as yearh-month-day, either.

His "yms" in "stick with the yms and hms" is a typo of "ymd".  He is
saying that even though YYMMDD and HHMMSS would look a lot more
natural, it is too long to type so YMD and HMS may not be so
terrible a compromise.

With the "ytd" in the last one, he is saying that another downside
of saying "ymd" (other than that it is not how we usually spell
year-month-date), even though "ymd" might be an acceptable
compromise, is that it is too easy to get confused with year-to-date
that is commonly abbreviated as "YTD".
