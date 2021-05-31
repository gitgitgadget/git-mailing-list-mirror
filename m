Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109EEC47094
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E157A61220
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaFgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 01:36:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60356 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhEaFgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 01:36:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0CE4B2B95;
        Mon, 31 May 2021 01:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=G1VRtm3tp06mJVw2cx0QA+cer446iXyUn21QXaoUvNg=; b=jv8b
        0Dg1YLRVh8Y60FZ+/yLtVr1jMgtRyCTMhwSZnuiB1ndjiKaIK/bClqLrFCvYUhQi
        6jH0cF00ILhxD+OtPYkhRNgVVP8a89WvR7xYqg8wi/h2RW7T25nX0Hoysyfa5T9W
        opIi+6YLRgbzuA1ECToT4wedO6COaWgMjr1icWA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7417B2B94;
        Mon, 31 May 2021 01:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77E2EB2B93;
        Mon, 31 May 2021 01:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 1/2] [GSOC] ref-filter: add obj-type check in grab
 contents
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
        <pull.963.v2.git.1622379718.gitgitgadget@gmail.com>
        <e6c26d19a3f3b4791c435867550da538cfe6e287.1622379718.git.gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 14:34:51 +0900
Message-ID: <xmqqk0nfwjno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC80C6AA-C1D1-11EB-A072-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Only tag and commit will use `grab_sub_body_contents()`
> to grab object contents in origin implement. If we want
> to make blob, tree can also use `grab_sub_body_contents()`
> to get objects' raw data, a blob look like commit or tag
> will be wrongly regarded as commit, tag by `find_subpos()`.
>
> So we must add a test before `find_subpos()` to reject
> blob, tree objects. This will help us add %(raw) atom
> which can grab raw data of four type objects.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  ref-filter.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Thanks.  I'll rephrase the log message while queuing, but the change
as a separate preliminary step does make sense.

    ref-filter: add obj-type check in grab contents
    
    Only tag and commit objects use `grab_sub_body_contents()` to grab
    object contents in the current codebase.  We want to teach the
    function to also handle blobs and trees to get their raw data,
    without parsing a blob (whose contents looks like a commit or a tag)
    incorrectly as a commit or a tag.
    
    Skip the block of code that is specific to handling commits and tags
    early when the given object is of a wrong type to help later
    addition to handle other types of objects in this function.
