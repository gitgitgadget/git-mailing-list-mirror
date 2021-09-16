Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0BBC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8973B60041
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhIPFdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:33:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52854 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbhIPFdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:33:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D6A5D22FA;
        Thu, 16 Sep 2021 01:31:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tfT5ld6EKubCjL9lBG/WPvUkSd2inl6TphuDdb
        0AQWc=; b=JZ/GA5KJkV7/x6Ucw8kv7lLobDWMnQ05xAUCXT8xHtIeBpKZVT08Jl
        rSXw5AEAaykmNLCuHDKX2WYLQUVEzCdq+oBee9+2qBXcbKU9l+dMcv+n+Vq8peRN
        r8F60YsCTfA6ncKjiN04MnVAp47v6WPYJUDl934exQtmqfL99x4Kw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7606AD22F9;
        Thu, 16 Sep 2021 01:31:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDDE7D22F8;
        Thu, 16 Sep 2021 01:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] (experimental) diff --quote-path-with-sp
References: <20210915223316.1653443-1-gitster@pobox.com>
        <YUK7Bl9uzNE1YErg@tilde.club>
Date:   Wed, 15 Sep 2021 22:31:51 -0700
In-Reply-To: <YUK7Bl9uzNE1YErg@tilde.club> (Gwyneth Morgan's message of "Thu,
        16 Sep 2021 03:33:26 +0000")
Message-ID: <xmqqh7elulvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65848E24-16AF-11EC-B0CB-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gwyneth Morgan <gwymor@tilde.club> writes:

> On 2021-09-15 15:33:14-0700, Junio C Hamano wrote:
>> Long time ago, we had a discussion with GNU patch/diff maintainer
>> and agreed that pathnames with certain "difficult" bytes needs to be
>> quoted to ensure the resulting patch is machine parseable in an
>> unambiguous way [*1*].  Recently, we saw a report that found that
>> GNU patch is unhappy with our diff output for a path with SP in it
>> [*2*].
>> 
>> With this experimental option, the beginning part of the patch
>> output will have pathnames with SP in them enclosed inside a pair of
>> double quotes, like so:
>> 
>> 	diff --git "a/A Name" "b/A Name"
>> 	--- "a/A Name"
>> 	+++ "b/A Name"
>
> I believe GNU patch is fine with unquoted spaces in the "--- a/path"
> and "+++ b/path", and only has an issue with unquoted spaces in the
> "diff --git" line. busybox patch does seem to have an issue with quoted
> filenames in the "---" and "+++" lines but is fine if those lines are
> unquoted. Maybe we could leave spaces unquoted in those lines, only
> quoted if there's some other character that needs it.

Well, if they are so inconsistent, perhaps we shouldn't bend over
backwards to cater to them, I would have to say.  I do not think we
want to break the convention that these a/ & b/ labeled paths are
spelled exactly the same way, only to please external tools.

Thanks for a quick report.
