Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9878AC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0A72098B
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CqpJ2Ysf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgDXUaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:30:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52736 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgDXUaD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:30:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3160C473CF;
        Fri, 24 Apr 2020 16:29:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wUZ21kOhI9PwDRkDUalTOt2GjWQ=; b=CqpJ2Y
        sfT5z9ydMh7RZhpyNpRsecrqUaoBf6AK9BtXLP8a+PtSQ1p9K1XCh+s5c0k8rX8f
        TaZ82xJNS7YeZm4KcUV7jGw8hG3fDoGQ90Tzz/GC7N62nRuvcghXMHXY/lpA2MPA
        l7hLIZJlgBzGIFyFbft4c1kJP/Npao0Vn+hQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KViDMUkjspHmXiSryM7dBRh64CHGs5QL
        ba8xZViGGCL89gBydsUXUAz8rB1lM8VKHtKqunhkYI1sxriehg1ve73IOo9V3AV1
        U4RV2eIREzKrmTjn5TYcrpeP2Dy0DvJdh1gyAuaVBnovLTTvmDks8rXfBRTYU6RL
        1PfxaCD/EOI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29B37473CE;
        Fri, 24 Apr 2020 16:29:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B30B8473CD;
        Fri, 24 Apr 2020 16:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] push: anonymize URLs in error messages and warnings
References: <pull.618.git.1587738008248.gitgitgadget@gmail.com>
        <20200424165042.GA58621@syl.local>
Date:   Fri, 24 Apr 2020 13:29:55 -0700
In-Reply-To: <20200424165042.GA58621@syl.local> (Taylor Blau's message of
        "Fri, 24 Apr 2020 10:50:42 -0600")
Message-ID: <xmqqy2qkbpa4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CA95612-866A-11EA-BDD0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Apr 24, 2020 at 02:20:08PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Just like 47abd85ba0 (fetch: Strip usernames from url's before storing
>> them, 2009-04-17) and later 882d49ca5c (push: anonymize URL in status
>> output, 2016-07-13), and even later c1284b21f243 (curl: anonymize URLs
>> in error messages and warnings, 2019-03-04) this change anonymizes URLs
>> (read: strips them of user names and especially passwords) in
>> user-facing error messages and warnings.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>     push: anonymize URLs in error messages and warnings
>>
>>     A token used by GitGitGadget was leaked by this bug. Thankfully, it
>>     seems nobody noticed, and I installed a patched Git on the self-hosted
>>     build agent so that this won't happen anymore.
>
> All looks good to me, thanks.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks for the patch and a quick review.

Will queue.
