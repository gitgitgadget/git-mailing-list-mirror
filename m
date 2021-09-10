Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B2EC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D7960FE3
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhIJFIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 01:08:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64888 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhIJFIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 01:08:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E0AB143F28;
        Fri, 10 Sep 2021 01:07:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8ikVLKciShciQxaGGnvI2sj8lxIupOwASL21dN
        s9sEI=; b=AitFlYQIeaZVWTiEuB5WsNkEPkm9DfpXmHCVg8LzVD3zfLbTz+KVGp
        HvbxScXDTM45gK51Zag9+FtP31K1ydFD3SR89lpnxR/W5LeGoXHI1twsVW/Rp0U+
        Px+rXkQxE3m0M0y6RM3iXwyBDd6EAU9oV8xQ9tmIm5bz5FcPfzy5s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46E53143F26;
        Fri, 10 Sep 2021 01:07:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82938143F25;
        Fri, 10 Sep 2021 01:07:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Miriam Rubio <mirucam@gmail.com>
Subject: Re: mr/bisect-in-c-4, was Re: What's cooking in git.git (Sep 2021,
 #02; Wed, 8)
References: <xmqqsfyf5b74.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2109091308200.59@tvgsbejvaqbjf.bet>
Date:   Thu, 09 Sep 2021 22:07:28 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109091308200.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 9 Sep 2021 13:08:47 +0200 (CEST)")
Message-ID: <xmqqr1dxuigf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFF3CAE8-11F4-11EC-8DBE-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 8 Sep 2021, Junio C Hamano wrote:
>
>> * mr/bisect-in-c-4 (2021-09-02) 6 commits
>>  - bisect--helper: retire `--bisect-next-check` subcommand
>>  - bisect--helper: reimplement `bisect_run` shell
>>  - bisect--helper: reimplement `bisect_visualize()`shell function in C
>>  - run-command: make `exists_in_PATH()` non-static
>>  - t6030-bisect-porcelain: add test for bisect visualize
>>  - t6030-bisect-porcelain: add tests to control bisect run exit cases
>>
>>  Rewrite of "git bisect" in C continues.
>
> From my point of view, this is ready for `next`.

You agreed that redirection with dup2()'s in [5/6] was good enough
for now [*1*], but in that case, we need to add a few fflush(stdout)
around the dup2() dance [*2*].

So this is not quite ready for 'next' yet, although it is almost
there, I'd think.


[References]

*1* https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109090922310.55@tvgsbejvaqbjf.bet/

*2* https://lore.kernel.org/git/xmqqtuj2h7cp.fsf@gitster.g/
