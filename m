Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430CCC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 15:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAB52075B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 15:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PPBpOZET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgFEP3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:29:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63800 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgFEP3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 11:29:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 602AED2F3D;
        Fri,  5 Jun 2020 11:29:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EAtNLQfLksCwYA6rffOWRwPQ9H0=; b=PPBpOZ
        ETyctAxKpvTUfK+M64T1niFexsNd8T9CNAkEFS6DeuCEztHFyfIQgS8vC1IkJVPY
        GhKPjRZR2tQ/TAmMTFYUKMbPt4Pci0ShRIE8b6bOwXOPSJDXCf3U0GUD7qUWOl2Q
        y250abQnbgLLpU52y390V3aOvfho6bHCfiAPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gv/Fdn8Ie6Yg3DUa36vfzLH+2rKe4w1Y
        8IjMnr5yRBFvVYArWQQrpGvTc9CEIdVORU8hp7S0lE3EWCc4qa8J/OP8120XpKFP
        SY8BWKgteEVbKc3AvNDfGfE3wLZzuLC5tkYbvSVL5cc319nS7QTdVIU++o3jpUtW
        LgkFk2u838s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4446FD2F3C;
        Fri,  5 Jun 2020 11:29:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 596D0D2F36;
        Fri,  5 Jun 2020 11:29:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Elijah Newren <newren@gmail.com>,
        Md Naeim <naeim249@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [BUG?] 'git rebase --abort' couldn't abort aborted rebase
References: <CADhmr77EbC+3f=Oa+bm18Z_SSEMK8vCjNHQniuvkdfaZdRT_5A@mail.gmail.com>
        <CABPp-BGh0T1xio-pRb=JVNbJDK1PWpo+v877nDfjcm6khn6NDg@mail.gmail.com>
        <63139842-8548-6c64-1214-5469eedb8d4f@virtuell-zuhause.de>
        <b83568b8-e465-243e-cd84-eba88c4e95d9@gmail.com>
Date:   Fri, 05 Jun 2020 08:29:27 -0700
In-Reply-To: <b83568b8-e465-243e-cd84-eba88c4e95d9@gmail.com> (Phillip Wood's
        message of "Thu, 4 Jun 2020 11:19:56 +0100")
Message-ID: <xmqqpnado7jc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58DD7C46-A741-11EA-82C4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Although my test case uses EOL normalization, I think the real issue is
>> that autostashing for the rebase fails (in the sense that the working
>> tree is clean afterwards) and that is unexpected.
>
> Yes. I'm not sure what to do for the best. A simple fix to the stash
> failure is to check for a clean worktree after we've stashed and apply
> the stash and exit if the worktree is not clean.

The suggested fix covers all cases where the auto-stash step fails
to revert the index and the working tree to the prestine state for
any reason, not limited to the eol normalization.  It is not just a
simple but necessary fix, regardless of what other things we do.

Why doesn't the internal "stash" fail to clean the index and the
working tree to pristine state in the first place, though?  It may
be another thing that needs fixing, but in a sense, that is of
secondary importance.

Thanks.


