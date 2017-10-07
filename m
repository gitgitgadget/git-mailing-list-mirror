Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C5720372
	for <e@80x24.org>; Sat,  7 Oct 2017 01:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbdJGBbo (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 21:31:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60194 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752155AbdJGBbn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 21:31:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E70A99405D;
        Fri,  6 Oct 2017 21:31:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZK+sYhs3Ee70bYKkGs+g6l0SE2I=; b=RPinyQ
        VtWHON5l96w53Rgq7AYo3ReRColzOEfjwyON04O5RR+VoB4mTZEDLbqhi8jrUTlz
        xs8rTdutSGafGIVkUjWg/jzf//qLPULj9LVexQkyoEAg0FyHuku2If4gvRmjTRR5
        tmU/nyiIzZolfqvtl7ls8mTyke9cJ6bliMaDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iUXix+o62upAx/h95XUf0J5G8hUoDapW
        ZqiYTJdLySE30eoQ+ujiAsM//SkkvXozWqZAOVZk/3NzCk/JwrdrZTb/eGlYNk3R
        bddoUWT6Jf19RUUs1XFQ4+Ma7Qdc9vyII88dwclRP3Xta/jgPiyk/LGJWOmt6lHs
        RLzZ1vLly1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFB789405C;
        Fri,  6 Oct 2017 21:31:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5003A9405B;
        Fri,  6 Oct 2017 21:31:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Krey <a.krey@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Users <git@vger.kernel.org>
Subject: Re: Regression in 'git branch -m'?
References: <20171005172552.GA11497@inner.h.apk.li>
        <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net>
Date:   Sat, 07 Oct 2017 10:31:41 +0900
In-Reply-To: <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 6 Oct 2017 10:37:45 -0400")
Message-ID: <xmqq60brvj42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 467E043A-AAFF-11E7-8255-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Earlier I blamed Duy's 31824d180d. And that is the start of the
> regression in v2.15, but only because it fixed another bug which was
> papering over the one I'm fixing here. :)

I haven't read Michael's reply, but 2/2 is very well explained and
looks correct.

Thanks for digging this through to the root.  

>   [v1 1/2]: t3308: create a real ref directory/file conflict
>   [v1 2/2]: refs_resolve_ref_unsafe: handle d/f conflicts for writes
>
>  refs.c                  | 15 ++++++++++++++-
>  t/t1401-symbolic-ref.sh | 26 +++++++++++++++++++++++++-
>  t/t3200-branch.sh       | 10 ++++++++++
>  t/t3308-notes-merge.sh  |  2 +-
>  4 files changed, 50 insertions(+), 3 deletions(-)
>
> -Peff
