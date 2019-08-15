Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28831F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 16:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfHOQgM (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 12:36:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55764 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbfHOQgL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 12:36:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 940C516D43F;
        Thu, 15 Aug 2019 12:36:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sIqAE8/pf7wB
        yVO2rVlq+Ci5WtY=; b=og/YTFDcdfr1fW7RAaTzeijSKrVuMBrtOJV6ori8q3x9
        Iuavh8DJqspgJ2LpkSm8f94Ji5SWmBBeFKsEBiCbrwfFVFo2U5hofgdskaZGeeNL
        uQ3Rb+rg1H6dKChQdjFWsvQcEdRqry8Bv+W9E8Vf8nb/7r+Xvnr9QExewC2lFbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S1ohSQ
        cTab99VzP+5FCy7FZnuKDTIuHwtTN/76WPs7qIBNQsQjQYTiLZeUMNuzX/kJLi2E
        lHR7xqEKRDMoISIDwM8539+X+by2x6Mf76h01VhbEXAykDGMeUHltNqhARwCnrYD
        vBFR7hyjoesfJpLc1YhBxJNJdfUYy4o+a0vL4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B91316D43E;
        Thu, 15 Aug 2019 12:36:09 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F182016D43D;
        Thu, 15 Aug 2019 12:36:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: minor interactive rebase regression: HEAD points to wrong commit while rewording
References: <20190812175046.GM20404@szeder.dev>
        <2a7d69a9-cb3e-eb84-188f-5713876f6d78@gmail.com>
        <20190814212036.GQ20404@szeder.dev>
        <026d6615-3420-eb31-8c93-a6245f3be503@gmail.com>
Date:   Thu, 15 Aug 2019 09:36:07 -0700
In-Reply-To: <026d6615-3420-eb31-8c93-a6245f3be503@gmail.com> (Phillip Wood's
        message of "Thu, 15 Aug 2019 14:47:17 +0100")
Message-ID: <xmqqpnl64c94.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C8F6E3B4-BF7A-11E9-894F-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 14/08/2019 22:20, SZEDER G=C3=A1bor wrote:
>
> I changed the sequencer to always commit the cherry-pick and then run
> 'git commit --amend' for rewords [1]. Running
>
> 	time env GIT_EDITOR=3Dtrue GIT_SEQUENCE_EDITOR=3D'sed -i
> s/pick/reword/' ../bin-wrappers/git rebase -i --root
>
> over 100 commits I cannot see any real difference in the timings
> between master and that branch. Any difference is within the variation
> of the times of multiple runs. The change also fixes a bug when
> rewording a re-arranged root commit.

I guess that settles the "efficiency" story; besides, showing a
wrong intermediate state to users and scripts efficiently is just as
bad as showing a wrong state less efficiently.

