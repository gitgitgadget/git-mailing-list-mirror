Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F4C433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 17:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738C764DF5
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 17:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhA3RvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 12:51:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55124 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhA3RvB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 12:51:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83D9810BEC9;
        Sat, 30 Jan 2021 12:50:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=41TXSNByZ6yJK2gFPLfnF9AJ/i0=; b=icnwyb
        KIUYF3f/bEQP4fR/qpvdn7L4a2WxHsrGfzljtYbBv/a1hA8VYZx8W39FVabow11r
        hfgVIrrebTZyNy4CQpyspEvBDDDDTvew/itBk4pMIWFlGfjvKBRF0y2eMEEWkkwx
        3yiyDYUhUhCOIycJWj00WUv/M6eyUYJ1zMi50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VWQ5kGuZ+ssXcN64A8poJKwg2evk21+Z
        BBCGuiO8Izp6QfiQk5ZcOa34EhhJk9Ci/O/1t12n2xL4XnvPN+J9O4M7DWJWnHvS
        Ad0mX8K6KOyfAdYAqq61sr+TjK/4fjqlEkfAtn0QGVnEruB3Ta8mim4Oj9MOeqrn
        DiDfdaClucs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7991410BEC8;
        Sat, 30 Jan 2021 12:50:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A4E5710BEB9;
        Sat, 30 Jan 2021 12:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/7] teach `worktree list` verbose mode and prunable
 annotations
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
        <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
        <CAPig+cTt-TyOR8kc6YvBVLpf-bgFdJ+FVYA2NvG_Vvn7tMbBkQ@mail.gmail.com>
Date:   Sat, 30 Jan 2021 09:50:14 -0800
In-Reply-To: <CAPig+cTt-TyOR8kc6YvBVLpf-bgFdJ+FVYA2NvG_Vvn7tMbBkQ@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 30 Jan 2021 02:04:50 -0500")
Message-ID: <xmqqim7epb55.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C9443CC-6323-11EB-A829-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jan 27, 2021 at 3:03 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> Changes in v4
>>  * Added documentation to explain that the lock reason is quoted with
>>    the same rules as described for `core.quotePath`.
>>  * The `worktree unlock` issued in the test cleanup is splitted and
>>    executed after each `worktree lock` to ensure the unlock is only
>>    done after we know each locked command was successful.
>>  * Fix a couple of grammos in the [4/7] commit message.
>
> I just gave v4 a complete read-through and it looks great. All review
> comments on previous rounds have been addressed, and I didn't find
> anything important to comment on in v4. Very nicely done.
>
> Please consider this entire series:
>
>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>
> Junio: Perhaps the summary of this series in the merge message can be
> refined a bit, as it only talks about verbose mode, but this series
> does a bit more than that. Heres a proposal:
>
>     `git worktree list` now annotates worktrees as prunable, shows
>     locked and prunable attributes in --porcelain mode, and gained
>     a --verbose option.

Nicely done.  Thanks for excellent contribution, both of you.

