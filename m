Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D88820899
	for <e@80x24.org>; Mon, 14 Aug 2017 18:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbdHNSve (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 14:51:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53040 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751604AbdHNSvd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 14:51:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8968CABD91;
        Mon, 14 Aug 2017 14:51:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PneUJzT+HrSBqXkiYw2VtQs8TdA=; b=eSghwh
        XMynQZvR8bVoBzmBkQ6y02qrfnG43TMCIl54B/PQ3Kz5OALKRDaKUIUzBkuD8oNY
        zV5LVKNt9QCquTKo6Jpbcz1HcDWGGgsWlP745P0eOyK9xe+Wrlfo8wTck6+58K17
        G7AivXaGbfvVOxr26eLx52j/WeN23qEUiGRO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cin/SmJUgnwH1pvggyxw3DaMe/bh7n90
        H+z/j9WmvrH4xihsVvHyPHZiQOwDksOUBVO3t5oi58TOc7zaaaJSnuugNrY9YRZX
        O72P/p/fVklC/rLTGtROdN8XcowdnEQVB9E5NS6tMGXyf/3/QD91XJRHtudnDDOI
        lFpc76jRVVY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80AA3ABD8F;
        Mon, 14 Aug 2017 14:51:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7F5EABD8C;
        Mon, 14 Aug 2017 14:51:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Kevin Willford <kcwillford@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] cache-tree: remove use of strbuf_addf in update_one
References: <20170810184723.12424-1-kewillf@microsoft.com>
        <CAGZ79kaB7w+OD_8LOgqHjBJ8gCtXUGWPj7Cw8bWXEEQweqMaFw@mail.gmail.com>
        <20170810190349.jxlp6i7c6q5hpari@sigill.intra.peff.net>
Date:   Mon, 14 Aug 2017 11:51:30 -0700
In-Reply-To: <20170810190349.jxlp6i7c6q5hpari@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Aug 2017 15:03:49 -0400")
Message-ID: <xmqqo9riugnh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96956236-8121-11E7-8AEF-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 10, 2017 at 11:58:34AM -0700, Stefan Beller wrote:
>
>> On Thu, Aug 10, 2017 at 11:47 AM, Kevin Willford <kcwillford@gmail.com> wrote:
>> > String formatting can be a performance issue when there are
>> > hundreds of thousands of trees.
>> 
>> When changing this for the sake of performance, could you give
>> an example (which kind of repository you need for this to become
>> a bottleneck? I presume the large Windows repo? Or can I
>> reproduce it with a small repo such as linux.git or even git.git?)
>> and some numbers how this improves the performance?
>
> I was about to say the same thing. Normally I don't mind a small
> optimization without numbers if the result is obviously an improvement.
>
> But in this case the result is a lot less readable, and it's not
> entirely clear to me that it would always be an improvement (we now
> always run 3 strbuf calls instead of one, and have to check the length
> for each one).
>
> What I'm wondering specifically is if vsnprintf() on Kevin's platform
> (which I'll assume is Windows) is slow, and we would do better to
> replace it with a faster compat/ routine.

Yeah, I had the same reaction.

