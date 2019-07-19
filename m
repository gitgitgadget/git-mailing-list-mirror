Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFAB1F461
	for <e@80x24.org>; Fri, 19 Jul 2019 21:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfGSVdx (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 17:33:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50563 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfGSVdx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 17:33:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02A481624D0;
        Fri, 19 Jul 2019 17:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EvFR8QtDQWqPUe6hB54GiMuAOzQ=; b=EqzRbt
        LP6qQM5GbABMjSU5BEzLXMGMIGlKJuxIOoBsB3PlYP+EyaFSjhemkKq1cZZneOYc
        rOWP/VIvwKdAngPcn8imSbESwOtCjgg9mpOLufCVTq6tB0UvZPxH11w29Jj1aA4c
        YKap6E1Y6mXcpG21rqca1deiHboIrSjM318yM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cthqpnatCxYvKIpJFB4FxYIdfpKAEtvB
        Y348t7B82XOGNaPVS/N09Dt2POKlP619sxZ+p3nOIo1RizvUSSrG5R2uOq3KHTVL
        eZ0AVmZOazjRT8WQiA0ZEVJm0aHxZ0JohlBN6Su979pOIDcU5/rVb5jFs78xBl00
        OC906w1DK90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC83A1624CF;
        Fri, 19 Jul 2019 17:33:50 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D13A1624CE;
        Fri, 19 Jul 2019 17:33:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 1/1] rebase -i: add --ignore-whitespace flag
References: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
        <20190718185514.20108-1-rohit.ashiwal265@gmail.com>
        <20190718185514.20108-2-rohit.ashiwal265@gmail.com>
Date:   Fri, 19 Jul 2019 14:33:49 -0700
In-Reply-To: <20190718185514.20108-2-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Fri, 19 Jul 2019 00:25:14 +0530")
Message-ID: <xmqq5znxvhdu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E607A268-AA6C-11E9-8ADD-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

>  t/t3431-rebase-options-compatibility.sh | 66 +++++++++++++++++++++++++

Isn't 3431 already taken?

>  5 files changed, 97 insertions(+), 6 deletions(-)
>  create mode 100755 t/t3431-rebase-options-compatibility.sh
> ...
> +	git checkout --orphan master &&
> +	q_to_tab >file <<-EOF &&
> +	line 1
> +	        line 2
> +	line 3
> +	EOF

This will trigger "indent-with-space".  Instead of using q-to-tab,
perhaps something like this would be more appropriate (not limited
to this piece, but also other ones in this script that actually do
use Q to visualize a tab)?

	sed -e "s/^|//" >file <<-EOF &&
	|line 1
	|        line 2
	|line 3
	EOF

