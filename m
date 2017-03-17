Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8C620323
	for <e@80x24.org>; Fri, 17 Mar 2017 05:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbdCQF04 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 01:26:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57991 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750866AbdCQF0z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 01:26:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5783F7169F;
        Fri, 17 Mar 2017 01:26:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aMV20tAYkPrQY6kUo0eMrEbJVaE=; b=aY1jyk
        azqxhiGi2KhoZ312HHGAH+ezvkC0nK2s0wRfH5FHnmYCZ/tvULmq5fYnnEQVinCe
        4N3EJuhnlV/3cRRdO5Ik6vgOuH5xGjRg4mimelXeJQ8GL7P50lCrQMbUfNOculSo
        JaO1zr75nkr2hCpzClRcBoZAPLBfLOZc1uTp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kWAG8CwqSL6SUI2xPLua3H2udvjysee2
        odyZYGPsHfZoioM6zxthpuj8G8SgX/HR/o82A0Wr7tQJLd0LRLAKDS+lTqxtmbYQ
        xSp3LCak3SGEH9GYhFi70zOR3r4WOGNC7ZTp33U5hL1KuamE3hb5+n3wuSnzlRCp
        qSb6zutwsy4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 506B57169E;
        Fri, 17 Mar 2017 01:26:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5E2C7169D;
        Fri, 17 Mar 2017 01:26:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] submodule sync: skip work for inactive submodules
References: <20170313214341.172676-1-bmwill@google.com>
        <20170316222952.53801-1-bmwill@google.com>
        <20170316222952.53801-4-bmwill@google.com>
        <CAGZ79kaP9ob+qvso=pV=PPaB5guaW18w297xA+bfDFASV0zibg@mail.gmail.com>
Date:   Thu, 16 Mar 2017 22:26:52 -0700
In-Reply-To: <CAGZ79kaP9ob+qvso=pV=PPaB5guaW18w297xA+bfDFASV0zibg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 16 Mar 2017 16:24:55 -0700")
Message-ID: <xmqq8to4a2xv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54A4E7D6-0AD2-11E7-BF62-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
>> Sync does some work determining what URLs should be used for a submodule
>> but then throws this work away if the submodule isn't active.  Instead
>> perform the activity check earlier and skip inactive submodule in order
>> to avoid doing unnecessary work.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>
>> +               # skip inactive submodules
>> +               if ! git config "submodule.$name.url" >/dev/null 2>/dev/null

Just a style thing, but ">/dev/null 2>&1" is probably shorter and
more idiomatic.

