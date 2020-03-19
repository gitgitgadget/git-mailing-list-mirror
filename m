Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D4C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 21:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB9F2076F
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 21:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r2nvpsu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCSVds (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:33:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65474 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCSVds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 17:33:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 467E8B0D9E;
        Thu, 19 Mar 2020 17:33:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y0kZZGtxBDUVU19vH/7bHTJfcrQ=; b=r2nvps
        u4ORoot+J1WY/Gac/+3B48NToGx46yowhhLmjvN3rbGTsoONlU2/bNXFIr/U59mL
        jpBSeCwHyoo00wIP/CH2wx5jae8Drsm+OG1tiUEB+ts97FJ9uWpVOgASAl/xg1y1
        eRY7tP0Qb675/mH4ZXP23wkGEYF5vRmGCWSXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ajwyegy9yUGQvaI6jsozWiaRufgqwDRx
        W+Wd/K+VWBZtleJ25BA9xcTmfnUSYE6hlwE6LuMgdCdqEnKSlTFsIXH224qF+bqr
        eBDzGojephbEchLvC+4rCGiMQvW8U4LLZQpOoc9WRx3Qc0F+iKw5H1ILN5oEMKZh
        HemhVH3P6s0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3ECB0B0D9D;
        Thu, 19 Mar 2020 17:33:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B169B0D9B;
        Thu, 19 Mar 2020 17:33:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     chriscool@tuxfamily.org, git@vger.kernel.org, jnareb@gmail.com,
        johannes.schindelin@gmx.de, newren@gmail.com, peff@peff.net
Subject: Re: RFC][Feature] submodule
References: <xmqqh7ylfnqi.fsf@gitster.c.googlers.com>
        <20200319171626.5723-1-shouryashukla.oo@gmail.com>
Date:   Thu, 19 Mar 2020 14:33:41 -0700
In-Reply-To: <20200319171626.5723-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Thu, 19 Mar 2020 22:46:26 +0530")
Message-ID: <xmqqh7ykdo7e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EC38FA2-6A29-11EA-BFF4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Also, what do you think may become a problem for large projects in
> here?

Perhaps

    "We want submodule A and B's sub(sub)*modules all the way down
    to the leaf submodule, but directory C houses many submodules,
    among which only one can be active, and we want C/X and its
    sub(sub)*modules all the way down to the leaf but not C/Y nor
    C/Z or any other C/<anything>."

and similar requests along the line.
