Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8CCC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB47624640
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 18:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCKHTFIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369288AbgJVScx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 14:32:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54847 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508325AbgJVScx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 14:32:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4404181506;
        Thu, 22 Oct 2020 14:32:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7+LBGP25Y+CFQpuPI0sibZOTHPs=; b=nCKHTF
        IqP0HN91A1SIRG0GkUEF52NddQ8KezkrAC/AIEQ+MvdihWmCHKFBeuDHpGct/PZq
        gtzEzCpFGCEuzDM3BCWZ8xnuEAopRbQQjaon2/WLakjdhVR/A5jr2AiJcX6T4A0Y
        UMh1aG8vFXPsLWHB03pn1IMN0zQf0Hb0WaOhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NoL+TX6Y2zb1WgYGZd9NDS9l2AXSq50S
        Tf8Jh2JfgdZlM7kH+panZWpKeQlLvqcSvs9HPwX2Qv0ik6gdgYO5RW3g2V+mYGSo
        tXuArh4g4TDJJpGFc4bErCmm/2c/GHN2+xMWN/0pZZE8/Vnzq9ZwYVF0/Hv6NwrP
        cS+bNXkjq0Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BA4A81503;
        Thu, 22 Oct 2020 14:32:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B990C81502;
        Thu, 22 Oct 2020 14:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>
Subject: Re: [PATCH v2 0/2] fsmonitor inline / testing cleanup
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
        <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
        <20201022174043.GA775513@nand.local>
Date:   Thu, 22 Oct 2020 11:32:51 -0700
In-Reply-To: <20201022174043.GA775513@nand.local> (Taylor Blau's message of
        "Thu, 22 Oct 2020 13:40:43 -0400")
Message-ID: <xmqqblgum7qk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE3920B2-1494-11EB-8ACC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Nipunn,
>
> On Thu, Oct 22, 2020 at 12:21:04AM +0000, Nipunn Koorapati via GitGitGadget wrote:
>> UPDATE SINCE v1
>>
>>  * Removed include of dir.h from fsmonitor.h as it's no longer needed
>
> This version all looks sensible to me.
>
> I'm still iffy on whether or not this series makes sense to apply
> without the rest of the code that depends on it, but I'll leave that up
> to Junio whether he wants to take the series as it is now, or wait for
> other patches to come in on top.

Sorry but I am not sure what you mean by "the code that depends on
it".  Are these two functions unused anywhere in the code?  If so,
the right way to clean them up may not be to turn them from inline
to a proper definition, but to remove them ;-).  

If they have existing callers and it can be demonstrated that their
callers do not benefit from them being inline, that by itself is a
worthy clean-up, without adding any more callers, no?

Confused...

> In either case, these two patches are:
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,
> Taylor
