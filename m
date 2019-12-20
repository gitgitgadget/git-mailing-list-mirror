Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74431C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDD1206C3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o8aQRtsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLTRzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:55:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55911 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTRzU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:55:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BD912EB33;
        Fri, 20 Dec 2019 12:55:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IFCzWuAruHinvM+1bc+4pGKd2Lc=; b=o8aQRt
        sUiiGI9XvaC610r1QveBN83ChWe/ScolppT6ajIjxl61G2WD4BDx7DlUgPO0E9NH
        mSaR7X7H3WTXgWDm8wgRQ0Z6H155okWBqNYhzEEjIY14XL1lzV0gJEcPW7oh23VZ
        KO74/7QNwXcvPR+GXqn/92lv6l3CLuMBM1X+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZcdKfI8RVr1YvJlY9GWiZnrPOa/JtS0a
        2UX3Npx8b6Mqn6is1INKiOp4zrFN0V5DJwio6Rpa9814VYjfE8poIRaQrcetSUzx
        dPZLNwcDNF2Pu2XxoFOSt655nIOPXBkpUUZBynA8t4T3btgT7AJY7oItsY30qUB8
        JvDwoQ9qsO8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93C2F2EB32;
        Fri, 20 Dec 2019 12:55:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0019B2EB31;
        Fri, 20 Dec 2019 12:55:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ed Maste <emaste@FreeBSD.org>,
        git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3] sparse-checkout: improve OS ls compatibility
References: <20191219015833.49314-1-emaste@FreeBSD.org>
        <20191220153814.54899-1-emaste@FreeBSD.org>
        <9c3d10c3-76fb-9e9e-013b-b3f66b934dd6@gmail.com>
Date:   Fri, 20 Dec 2019 09:55:15 -0800
In-Reply-To: <9c3d10c3-76fb-9e9e-013b-b3f66b934dd6@gmail.com> (Derrick
        Stolee's message of "Fri, 20 Dec 2019 11:05:22 -0500")
Message-ID: <xmqqpngianlo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E176DB98-2351-11EA-AB11-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/20/2019 10:38 AM, Ed Maste wrote:
>> On FreeBSD, when executed by root ls enables the '-A' option:
>> 
>>   -A  Include directory entries whose names begin with a dot (`.')
>>       except for . and ...  Automatically set for the super-user unless
>>       -I is specified.
>> 
>> As a result the .git directory appeared in the output when run as root.
>> Simulate no-dotfile ls behaviour using a shell glob.
>
> This patch looks good to me and seems to match where the
> discussion landed. Thanks for finding and fixing this!

Thanks, all.  Will queue.
