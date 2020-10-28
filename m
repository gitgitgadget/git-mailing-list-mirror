Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6DFC5517A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E092A221F8
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gR5rywWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgJ1Vsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:48:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60144 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgJ1Vmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:42:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 290E88AF99;
        Wed, 28 Oct 2020 16:24:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ExFP9sAdXFrUzRmhinXHIUpKuZw=; b=gR5ryw
        WGpeYmbJlk/SfOumxbalFR/ANpZkPfPiuRhRrYx3K1VGHyzfbIpJElEyFKov2Egl
        zDgiLdm6oLUT7ezqW9otOxdRAZkZ8Y6j6k81GXzcojtzq9ahJT6Z5ZYNdOAXJhhz
        55yQ+ewR/Ld7hAjYYYAgVLukWfth73x/OxpCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qu+Ag7NXwWvxnfnZ7e63m9n1lAIQDy23
        BjQBT1ArWuVtxDKCunWM1Jotm7fAyQyxatHpE0GTkgtMWkz0vB9S2byv45R54vEu
        ClxGH90yqaX9sXYGg2rj5AnFsWwojDoITzIpiahI0PuGgE6ZSLJ3C5vR+eFIZYv6
        9W8kORphiPc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F44C8AF98;
        Wed, 28 Oct 2020 16:24:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 670228AF97;
        Wed, 28 Oct 2020 16:24:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/2] ref-filter: handle CRLF at end-of-line more
 gracefully
References: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
        <pull.576.v4.git.1603335680.gitgitgadget@gmail.com>
        <03b2d7d78a15d15130a68ed1e6092072aa0807cd.1603335680.git.gitgitgadget@gmail.com>
        <xmqq8sbxlq62.fsf@gitster.c.googlers.com>
        <FFAF7079-C759-43F3-96AA-CAF3B73B55B4@gmail.com>
Date:   Wed, 28 Oct 2020 13:24:46 -0700
In-Reply-To: <FFAF7079-C759-43F3-96AA-CAF3B73B55B4@gmail.com> (Philippe
        Blain's message of "Thu, 22 Oct 2020 21:46:26 -0400")
Message-ID: <xmqq1rhi9jzl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F8C24D0-195B-11EB-9693-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> Having said all that.
>> 
>> Here is how I explained the topic in the "What's cooking" report.
>> 
>>     A commit and tag object may have CR at the end of each and
>>     every line (you can create such an object with hash-object or
>>     using --cleanup=verbatim to decline the default clean-up
>>     action), but it would make it impossible to have a blank line
>>     to separate the title from the body of the message.  Be lenient
>>     and accept a line with lone CR on it as a blank line, too.
>
> Just for the sake of searchability, I think it would be good to have 
> CRLF spelled out in this topic description (since I gather this is what 
> ends up in the release notes). But I don't feel that strongly
> about that.
>
>> Let's not call this change a "bug fix".  The phrase you used in your
>> title, "more gracefully", is a very good one.
>
> It was your suggestion ;) 
>
>> In the meantime, I've squashed your "oops forgot ||return 1" change
>> into [PATCH 2/2].
>
> Thanks for squashing it in.

Squashing in the "oops forgot || return 1" was the only thing I did.
I did not rewrite (and will not do so myself) the proposed log
message 1/2, which needs to happen before the topic can hit 'next'.

Thanks.
