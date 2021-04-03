Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65791C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 04:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195FA611ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 04:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhDCEbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 00:31:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64405 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhDCEbW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 00:31:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D01E1CAD9C;
        Sat,  3 Apr 2021 00:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Re+2h7J7+6OhzgE2zwfXfHNO4w4=; b=qy5L8I
        qyfuK3JtAf2J1/X7UBMrwBYVTwVWTfa23RiVIfCbIZLroKv22M7F6WzAoLyaePHu
        nPe0ukp1wF0oum3t3eCUOkx46y91xTY7lPf34mCxwKYpfBXKg1mqE8K6Ywiz178b
        c91uw3guNXiXNywBcp3sS3zmKmuYbpXx+SpIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w7MZckHokTS9OL9AdLCpsNtk3s6bPS/c
        lwER0uLxauPeeoslYIXkygTBTwtBBZCFn9Yg77blPzuhyu8hLYvRgnP1nmLvVhWC
        DV/5yokHCmKSFLgRmYmaMjdsIwPS401D5nr4a6GxjucKK4nx5CGB5gn71oOGD+YA
        EENPU8Q3npU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C21EFCAD9B;
        Sat,  3 Apr 2021 00:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D805CAD9A;
        Sat,  3 Apr 2021 00:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config
 option
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
        <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
        <xmqq35w82qvu.fsf@gitster.g>
        <CAOLTT8TaUkfdOhD4+P=VVxuy3dPCaf4KNC8+1hBQnxSjpvO4HQ@mail.gmail.com>
Date:   Fri, 02 Apr 2021 21:31:18 -0700
In-Reply-To: <CAOLTT8TaUkfdOhD4+P=VVxuy3dPCaf4KNC8+1hBQnxSjpvO4HQ@mail.gmail.com>
        (ZheNing Hu's message of "Sat, 3 Apr 2021 11:22:26 +0800")
Message-ID: <xmqqtuoo0z1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FB6D976-9435-11EB-B54C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Little bug, Change it like this will work:
>
>         } else if (conf->command) {
>                 strbuf_addstr(&cmd, conf->command);
> -               strvec_push(&cp.args, cmd.buf);
>                 if (arg)
>                         strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
> +               strvec_push(&cp.args, cmd.buf);
>         }

It means the coverage of the test included in this patch was not
sufficient, right?

I queued this separately from the "commit --trailer" topic in
tonight's pushout, but it may make sense to queue this step
immediately on top of the "commit --trailer" patch.

In any case, I suspect we would not hear from Christian right away
due to timezone differences, so perhaps let this v6 simmer on the
list, and then hopefully update the documentation part with his
input.

Thanks.
