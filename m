Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD69C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CC9610F7
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhDHWZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:25:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53183 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHWZu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:25:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C06DB11739D;
        Thu,  8 Apr 2021 18:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WrxKrqhM7QJy
        2HG9TP246twI6z8=; b=BPcpfVcf7CQJ7Hyg1hAEJTCKaZ83kP+9qRVE6j9Hy388
        xbyYCvBQHl3wc9hAIXzSHoE0HMyl83QI/fvmlfpSfXn1P8quBsGhZySa0F/VGP0v
        hcQ+AbZv4cRqNtgdK8Uycs+LfCY+eyjHnFMEpkp66bs2jJt5mISWxgx3HW0ZyCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QiWmpT
        SCFNrWwmD/E6OolgcTs/XGr18vfPR2f6C0OhF4RhD+oaRPMA3C4laViHTmh+q7e5
        gBGMr8sfXOuIGW97YYqEjZ5kDDpdz7CpEXynjE6p2iMM2VAIhySxC5oWlSgB/0bv
        fJJafCEMT8frY9MuAqjgG6vFZMZ/jrAyuW6TY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B933611739C;
        Thu,  8 Apr 2021 18:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A010117398;
        Thu,  8 Apr 2021 18:25:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v13 4/5] bugreport: add uname info
References: <20200416211807.60811-1-emilyshaffer@google.com>
        <20200416211807.60811-5-emilyshaffer@google.com>
        <87mtu8ifmj.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 15:25:34 -0700
In-Reply-To: <87mtu8ifmj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Apr 2021 00:19:16 +0200")
Message-ID: <xmqqv98wquqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 56FA8B34-98B9-11EB-ACE9-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 16 2020, Emily Shaffer wrote:
>
>> The contents of uname() can give us some insight into what sort of
>> system the user is running on, and help us replicate their setup if ne=
ed
>> be. The domainname field is not guaranteed to be available, so don't
>> collect it.
>
> Even with _GNU_SOURCE would anyone care about the domainname (the NIS/Y=
P
> name, not DNS) these days, as opposed to the portable POSIX "nodename"
> field you're not including?
>
> In any case, I'd think it's a good idea to omit both. People tend not t=
o
> want to want to include their FQDN (e.g. their employer), and I can't
> think of a reason we'd care about it for debugging git.
>
>> [...]
>> +		strbuf_addf(sys_info, "%s %s %s %s\n",
>> +			    uname_info.sysname,
>> +			    uname_info.release,
>> +			    uname_info.version,
>> +			    uname_info.machine);
>
> Since this is completely free-form I'd think:
>
>     "sysname: %s\nrelease: %s\nversion: %s\nmachine: %s\nnodename: %s\n=
domainname: %s\n",
>
> Or something like that would be better (after pruning out the fields we
> don't care about).

All true.

By the way, what's this sudden interest in re-reviewing an age old
topic?
