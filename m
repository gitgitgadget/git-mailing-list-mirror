Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738CCC2D0E1
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CECF21941
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RiPg5y6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgIJSkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:40:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57646 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgIJSif (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 14:38:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B372276E02;
        Thu, 10 Sep 2020 14:38:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fpHH6e4Wr+DBeDMtUCkL6WX/988=; b=RiPg5y
        6Ph+hePbrb8VGtjSBGmibuO9Ouc1OQncNiqwe3To8I+2hiY+VBtyr5Fbvez2U8Zu
        /hNhoHLKF/D1TuqjuktsSwki9EbHJRFUUawHTHivgjVIO6KgAqQ0VTacCViNab5J
        iJaG2WyoZTkoQVbPFIFS1p/v1h0WSUa+lDDTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rGSJxTJEDYmnxkADVG81/TLUicg0mquu
        WkdANKhs7+G77d1F5vQBq3R9A3y/vtDrw3/Uklr9hfNV/1hTNRf453HAC6TdpDMi
        XU+0dt+fSvyDFnZC/l70M9yTaKRASK/qxfgGfJLGJ8JmmTWbniOOcuBMyrW1jw9K
        y6b1MVbXEUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB42C76E01;
        Thu, 10 Sep 2020 14:38:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2295B76DFF;
        Thu, 10 Sep 2020 14:38:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/7] wt-status: consistently quote paths in "status --short" output
References: <20200908205224.4126551-1-gitster@pobox.com>
        <20200910170159.1278781-1-gitster@pobox.com>
        <20200910170159.1278781-6-gitster@pobox.com>
        <20200910181300.GB1917207@coredump.intra.peff.net>
Date:   Thu, 10 Sep 2020 11:38:31 -0700
In-Reply-To: <20200910181300.GB1917207@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 10 Sep 2020 14:13:00 -0400")
Message-ID: <xmqqft7ppjdk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3C1884A-F394-11EA-9F62-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 10, 2020 at 10:01:57AM -0700, Junio C Hamano wrote:
>
>> Tracked paths with SP in them were cquoted in "git status --short"
>> output, but untracked, ignored, and unmerged paths weren't.
>
> By the way, the long status output will quote paths as appropriate, but
> _not_ apply this "we should quote spaces" rule. I'm not sure if that
> came up in earlier discussion or not. Certainly we're free to do
> whatever looks nicest to humans there, so maybe we prefer to avoid
> quoting as much as possible.

Yup, the long output format is strictly for human consumption and
one fewer case to enclose the path in a dq-pair is good ;-).

