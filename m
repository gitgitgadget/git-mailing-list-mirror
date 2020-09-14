Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC5CC43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B79208DB
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QoTo17r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgINUHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:07:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53908 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINUHc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:07:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF2C473F60;
        Mon, 14 Sep 2020 16:07:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=64jeV8DTD78IgdBGNfSUx3sfX/I=; b=QoTo17r/iue/loD6uu8q
        gLzx78/fUdm5vD62sptZc1fr4LXxTaNbTPQxD4UaXqn3Eu3LxSAJb0NJ70j8nYo4
        OQujdFCozYxO3MG8Tn2JoBKoBSx4URqTREDApVAtLGBFHC9vRVDL6FB7a1Maj/kA
        kg/EdqZJHst9FZyqUp0NIJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=rGIFJCgyTZGDXynVGE70XD89O6uNCdtqOUSspyeUAjk6g9
        ItUpP57xTWjZHHx7+eHIKG46LLA8+XV+KuJOQHCUzUS2MmGmDhFORl5zZ+YaAq8T
        PEA6WaMq0Dx8LEq8+U9yp14I7RSAMOc+vuyeyQ8mlRq+JpcU6tM7XxMae5poc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6A0973F5D;
        Mon, 14 Sep 2020 16:07:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 679F373F5C;
        Mon, 14 Sep 2020 16:07:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Aaron Lipman <alipman88@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] t3201: test multiple branch filter combinations
References: <20200911185754.64173-3-alipman88@gmail.com>
        <20200913193140.66906-1-alipman88@gmail.com>
        <20200913193140.66906-2-alipman88@gmail.com>
        <CAPig+cRrgC5vz9S1qDpEjoEvniBLCbuWt=bkpa2fj=suUm3Bog@mail.gmail.com>
Date:   Mon, 14 Sep 2020 13:07:27 -0700
Message-ID: <xmqqd02oktq8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA148D20-F6C5-11EA-9D75-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> A few comments:
>
> I didn't examine it too closely, so this may be a silly question, but
> is there a reason to start from scratch (by deleting all the branches)
> rather than simply using or extending the existing branches like the
> other tests do?
>
> If it really does make sense to start from scratch (ignoring the
> existing branches), then an alternative would be to create a new
> repository and run the tests in that repository instead. Whether or
> not doing so makes sense in this case is a judgment call. For
> instance:
>
>     test_create_repo features
>     (
>         cd features
>         ...setup stuff...
>     )

Good comments; I agree with both.

> It's a bit concerning to see output from porcelain git-branch being
> fed to 'grep' and 'xargs'. More typically, you would instead rely upon
> the (stable) output of a plumbing command. For instance:
>
>     git for-each-ref --format="%(refname:short)" refs/heads/ | ...
>
> In new test code, normally avoid having a Git command upstream of a
> pipe since its exit code will be lost. Thus, you might instead write:
>
>     git for-each-ref ... >heads &&
>     grep -v master heads | xargs git branch -D &&

Again, good recommendation.

Thank you always for helpful reviews.
