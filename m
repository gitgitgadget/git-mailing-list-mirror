Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B290EC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787A920888
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A7I1YH7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHSQIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:08:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54442 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHSQIa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 12:08:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E83170D43;
        Wed, 19 Aug 2020 12:08:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+KzdZN6gQI4AZLeEWe23JRxk4m0=; b=A7I1YH
        7P/oo8/Fs3n2LlvzWFO+S/ReN5i/IJ4xRC7BZN1vpsv1b0oy/kK5OnY6KwpEg/kB
        ElMCgBOFnty1Sr5koo5ljOAdJ2kOJp2BQMYvGR6LYZtJ+dhx281ZCIZWUhPlUhj/
        48us1wH/JFzTqMs13i39xVvf2hsQjlJ0Zennk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FEiNzvts/357u4AGXt+5InHXqZkJGak2
        tdf87N/0prLhO5959yziVPJ6TYxk6Ej5p5xJkSE3MbOhDJ6FsEp0IIv0f/mipPdh
        AykCg/jwR2sKCYztMWCemLvCVLJ9FSJ8DXK4xcrgKPARGpw2lOFwk5ic8Ddz6O3o
        HQDN54lfvv4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16A5270D42;
        Wed, 19 Aug 2020 12:08:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C98A70D40;
        Wed, 19 Aug 2020 12:08:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v3 7/9] pretty: refactor `format_sanitized_subject()`
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <0ad22c7cdd3c692aa5b46444e64a3b76f1e87b4c.1597687822.git.gitgitgadget@gmail.com>
        <xmqqpn7p1373.fsf@gitster.c.googlers.com>
        <CA+CkUQ9tkwXmrHq_ZV+RCgwoFHZ0M4dEhBkjUd97Xi+3shB-WQ@mail.gmail.com>
        <xmqqimdevd4l.fsf@gitster.c.googlers.com>
Date:   Wed, 19 Aug 2020 09:08:26 -0700
In-Reply-To: <xmqqimdevd4l.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 19 Aug 2020 09:01:14 -0700")
Message-ID: <xmqqeeo2vcsl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37870BCC-E236-11EA-A6CC-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hariom verma <hariom18599@gmail.com> writes:
>
>>> Also, because neither LF or SP is a titlechar(), wouldn't the "if
>>> r[i] is LF, replace it with SP" a no-op wrt what will be in sb at
>>> the end?
>>
>> Maybe its better to directly replace LF with hyphen? [Instead of first
>> replacing LF with SP and then replacing SP with '-'.]
>
> Why do you think LF is so special?
>
> Everything other than titlechar() including HT, '#', '*', SP is
> treated in the same way as the body of that loop.  It does not
> directly contribute to the final contents of sb, but just leaves
> the marker in the variable "space" the fact that when adding the
> next titlechar() to the resulting sb, we need a SP to wordbreak.

I was undecided between mentioning and not mentioning the variable
name "space" here.  On one hand, one _could_ argue that "space" is
used to remember we saw "space and the like" and if it were named
"seen_non_title_char", then such a confusion to treat LF so
specially might not have occurred.  But on the other hand, "space"
is what the variable exactly keeps track of; it is just the need for
space on the output side, i.e. we remember that "space needed before
the next output" with that variable.

I am inclined not to suggest renaming "space" at all, but it won't
be the end of the world if it were renamed to "need_space" (before
the next output), or "seen_nontitle".  If we were to actually
rename, I have moderately strong preference to the "need_space" over
"seen_nontitle", as it won't have to be renamed again when the logic
to require a space before the next output has to be updated to
include cases other than just "we saw a nontitle character".

Thanks.
