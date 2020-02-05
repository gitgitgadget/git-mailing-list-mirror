Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49AAC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 21:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876AA217F4
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XSWZu53s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBEVHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:07:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54875 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgBEVHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 16:07:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8668B7381;
        Wed,  5 Feb 2020 16:07:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F+UdZX+/WTFHr5hHq6AtSZXrleM=; b=XSWZu5
        3sm/jp52wo7QBWPjD6RdZ2dTO1mfOFWYV1VWAKdr2dmioN+UQWXDP/3xuSvAoW2y
        ucD1QwfWEzZ+WtZsJjBN5s5JNCOOy8eoVLmqQc62Anzae+MFfFUAk4TRoc0TSFlW
        o65FJXM3xVQYrt8gYZqWMtAVwNt22HkkItYa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tNLQgbyG3+MMJ9uwuevUkkN8eSX0I+D4
        SaakaKGAbmbShcPHecyCYC+5N/aDstV1jp+XryjwldZ4NDpXfP7H8RdFj7/ZTOti
        PQFVSnBDCP2cr5zVetW6wVZSZqy2kOgA5THm113gakKBYHcHvpWsepUZtItn2L/P
        BhjBGLZIPwA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0405B7380;
        Wed,  5 Feb 2020 16:07:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CEED6B737E;
        Wed,  5 Feb 2020 16:07:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, liu.denton@gmail.com,
        plroskin@gmail.com, alban.gruin@gmail.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 00/19] rebase: make the default backend configurable
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <47e7c9e6-7d83-185d-792d-f8e084c1a7a1@gmail.com>
Date:   Wed, 05 Feb 2020 13:06:58 -0800
In-Reply-To: <47e7c9e6-7d83-185d-792d-f8e084c1a7a1@gmail.com> (Phillip Wood's
        message of "Fri, 17 Jan 2020 16:58:31 +0000")
Message-ID: <xmqqa75w68wd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73B4FC0A-485B-11EA-AEF1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Changes possibly missing from this version, for discussion:
>>
>>   * I did not remove the --am option as suggested by Phillip, since Junio and
>>     Phillip were still discussing whether it is wanted/needed.
>>   * I did not address the last two items Jonathan brought up as I 
>>     couldn't find enough information to reproduce or understand the problems.
>
> I think I've got a fix for the failure with
> --committer-date-is-author-date that Jonathan reported which I'll post
> next week - the bug was not in this series, it was just exposed by
> it. I'll try and read through this series next week as well.
>
> Best Wishes

Thanks.

As to the "--am" option, I do not care too deeply about it anymore,
so if there is nothing else that we need to further polish, should
we move this forward to 'next' soonish?
