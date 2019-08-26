Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D2D1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbfHZThX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:37:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63521 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbfHZThW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:37:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39D8D162B5E;
        Mon, 26 Aug 2019 15:37:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WCADue2W7l+0
        rVmS/gXMvyV6v8s=; b=dL2TEi64W8bn4D2rJZKitUftRsnwfe4EOzYSqHhKpeGZ
        EcRT8udGk90zAU5LwBe/PAjNImh9g2ChH2tY0GWi5eoDU/8FurL2SsHTcycYMWqq
        GAcEHxppE/sI2iKYA58OWuyhFWscnd+MeIltLqmJcrgQSS7Q2Dm2beu2IQ2yNFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bfrP9p
        b1a6Uqc9b8zGZMwlY9NL1OGUvVkvqoElTQfvm6qLvdYM2RhLXgfZ/mLjmkHNJF5U
        c5cT2fobRA1UnKCx6SLWdQSV9sQZ34SvYM+KyZe9UFXcR99FWMPICNpC1zXM/Oem
        b5tjP4IyLFO/F+Q67G/3garW7+OCcJVxPydcE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 316F5162B5D;
        Mon, 26 Aug 2019 15:37:22 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FE59162B5C;
        Mon, 26 Aug 2019 15:37:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v9 0/9] rebase: learn --keep-base and improvements on fast-forward behaviour
References: <20190508001252.15752-1-avarab@gmail.com>
        <cover.1566724236.git.liu.denton@gmail.com>
Date:   Mon, 26 Aug 2019 12:37:20 -0700
In-Reply-To: <cover.1566724236.git.liu.denton@gmail.com> (Denton Liu's message
        of "Sun, 25 Aug 2019 05:11:54 -0400")
Message-ID: <xmqqtva3g1lb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC15D46A-C838-11E9-B673-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi all, it's been a while but I guess now's a good time as any to
> resurrect this topic. This is basically a resubmission of =C3=86var's W=
IP v8
> but I fixed a couple of minor whitespace issues.
>
> In addition, I opted to drop patches 9-13 from v8 since I don't think I
> can do a good enough job polishing them up and I don't really understan=
d
> the intricacies of this part of the rebase code. Hopefully, =C3=86var w=
ill
> pick them up at a later time.

Thanks; let's queue this with an updated base (the tip of master) as
we are now in a new cycle.
