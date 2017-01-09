Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57AC1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 14:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942457AbdAIOem (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 09:34:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61673 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S940133AbdAIOel (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 09:34:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE4235D2E8;
        Mon,  9 Jan 2017 09:34:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gtIPHjLFPAcuceiYoMFOdVyeD1o=; b=KUrFd5
        12zt0CTOXaZ6jsmUbFPnMQ+dWLMPVK3HE9q6BPXcT8BwC0s8g8073LkmbjSC57jh
        TcDsOD6wHfAZ/GHup7EaGInLYjxmNMSNJFn/Y9Zx5N1SR1lU4aNZO04C1Q3H/ywG
        0nBwMqshkjPnte6a0fRVbW327WDmiPPpdiutc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a17wPhFpfDT7dzaepOhN3D3aCBvxEddc
        lVe0BYiSYR93dHsT2N2CmOztumusksWTkbDIqWNOTXgh2kRxhiunS6gW9y1JZB0V
        4s38W2UZxeSTSvOxcXoKnId5u2Vup0hxDrTroBJVpiHELkRna8OPKBzbF8B5EyGl
        lA2h9rCQ0lw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B69E65D2E5;
        Mon,  9 Jan 2017 09:34:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10E5D5D2E4;
        Mon,  9 Jan 2017 09:34:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-15-chriscool@tuxfamily.org>
        <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
        <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
Date:   Mon, 09 Jan 2017 06:34:38 -0800
In-Reply-To: <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 9 Jan 2017 17:55:52 +0700")
Message-ID: <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0D3697A-D678-11E6-A502-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Jan 8, 2017 at 4:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> So what should we do if freshen_file() returns 0 which means that the
>>> freshening failed?
>>
>> You tell me ;-)  as you are the one who is proposing this feature.
>
> My answer is, we are not worse than freshening loose objects case
> (especially since I took the idea from there). 

I do not think so, unfortunately.  Loose object files with stale
timestamps are not removed as long as objects are still reachable.
For the base/shared index file, the timestamp is the only thing that
protects them from pruning, unless it is serving as the base file
for the currently active $GIT_DIR/index that is split.

>> What is the failure mode after such a premature GC happens?  What
>> does the end-user see?  Can you try to (1) split the index (2)
>> modify bunch of entries (3) remove the base/shared index with /bin/rm
>> and then see how various Git commands fail?  Do they fail gracefully?
>>
>> I am trying to gauge the seriousness of ignoring such an error here.
>
> If we fail to refresh it and the file is old enough and gc happens,
> any index file referenced to it are broken. Any commands that read the
> index will die(). The best you could do is delete $GIT_DIR/index and
> read-tree HEAD.
