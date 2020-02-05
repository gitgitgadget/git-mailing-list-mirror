Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FE5C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 19:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB57C214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 19:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xUng5pgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBETBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:01:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53509 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBETBG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 14:01:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB762447DC;
        Wed,  5 Feb 2020 14:01:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xpva/Ch3OD5mNYWoRaIWofzNv8s=; b=xUng5p
        giRFhjZxh06Y55JQi7dkXYNYQkFOoE7R1tFgP2M3sjGnrdhMrSKWQ8DmbIfsEWy/
        nXdn7bJe8dTWvX9GJ46Mnu9hjOTHgFEv5q911hCwsPXQG2ZWBB34uX6/p9DDJfsj
        6IjUZAloiJNf29kxt73aY0HyIW9Ki84WRkTAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IhgexJWXjuAOc5JeZQee3LMDihjeXtl2
        JPag2pMhvyPQKBcLzNoDmmTsgH/oM6paQ3/v30GRJP1Mim/z/DlBGW3WSwZRcxk5
        bYTUnJl1GGUcRQXvHRISvcqOHVFI+Na5EdrErHIg3HzhWbiJ4InZyGw+mwNXDLG3
        jWPhHZCKkEU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8539447DB;
        Wed,  5 Feb 2020 14:01:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D7F6447D7;
        Wed,  5 Feb 2020 14:01:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v6 6/6] config: add '--show-scope' to print the scope of a config value
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
        <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <fc141e86896edb4241e84cc300e191889a3fa4ea.1580268865.git.gitgitgadget@gmail.com>
        <8ede2f21-46a8-b95f-6425-c0ee54abdad6@googlemail.com>
        <CAOjrSZtx+Qr4HsaptaxseTa_8oCwRyVE+Jf95_z51fGmXBjsTQ@mail.gmail.com>
Date:   Wed, 05 Feb 2020 11:01:00 -0800
In-Reply-To: <CAOjrSZtx+Qr4HsaptaxseTa_8oCwRyVE+Jf95_z51fGmXBjsTQ@mail.gmail.com>
        (Matt Rogers's message of "Wed, 29 Jan 2020 18:03:34 -0500")
Message-ID: <xmqqr1z86eqb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA720594-4849-11EA-9C6B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Rogers <mattr94@gmail.com> writes:

>> for clarity, I think this patch should be split up further.
>>
>> For example:
>>
>>   - moving an enum and adding a new entry should be avoided
>
> As far as adding a new entry, that could probably be done in a separate patch.
> The submodule scoping is correct (mostly so config options that come from
> submodule blobs have a sane value to set the new scope field of
> git_config_source), but moving it is unavoidable as I'd either have to move
> config_scope or git_config_source for this patch to work, and moving
> git_config_source seemed like a ton more work
>
>>   - does the changes to '/config.c' fix something?
>
> Another thing, that in hindsight could probably be split out. The other changes
> do fix the fact that previously recursive calls to do_git_config_sequence()
> would blow awway the current_parsing_scope information for higher level callers.
> This is not super common, but does occur when --show-scope is used with the
> --blob option.
>
>>   - exposing config_scope_name should have been done before PATCH 4/6 already
>
> If that's better/more convenient, I don't have a problem breaking that
> out and moving
> it there.

Alright.  Thanks for another round of review.
