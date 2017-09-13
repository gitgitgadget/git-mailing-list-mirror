Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA3420286
	for <e@80x24.org>; Wed, 13 Sep 2017 22:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdIMWRj (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 18:17:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55545 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751128AbdIMWRi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 18:17:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93D2BAE40C;
        Wed, 13 Sep 2017 18:17:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/4NegJDCSMyORU9IOnbpMQEuryc=; b=JMfCz6
        IT/IEXd50X6g+1pfeKLWWfRatUViOeYIqLZ4W7Elz9tN8fHjKK7aJqQPwA9ZkTgD
        ziJlirjhkdZDs7jMQB+H8fvO6Z0nHLlKuyD46hM2pWKpJ1pK59Bwc0I0VMI8ILDv
        iL8BF6JLB3y2NCFRL/zwzP16wkTcrFhBoUvR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Na8f+LkT/bAXBxKeM2DzLpT8VaRAmrgc
        k+n7oHqG+YixzroxdeRdUtrBf4l7mmbIvdmuzfmfJydYOVK9xJZNOMZ6fDjz2RsL
        dl0fyS+WKuDEWjXokW0H6Ce9SodRHmEqgGSAFNA8W7Odu2a28X+WTtAV6+lRPuQZ
        CaYZyoefm58=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C383AE40B;
        Wed, 13 Sep 2017 18:17:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAE03AE408;
        Wed, 13 Sep 2017 18:17:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Kevin Willford <kewillf@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
        <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
        <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
        <CA+P7+xqxmxexWS=MWNd9=EqG81uhKY-OdG+1mpyWhst6DvH5AA@mail.gmail.com>
        <SN1PR21MB001473733DAF15BC91C0E58AB7690@SN1PR21MB0014.namprd21.prod.outlook.com>
        <CA+P7+xqcAh4v4gDQOm-feYGc1EmFztAu0zMg2xnp8Gn4=BzkoQ@mail.gmail.com>
Date:   Thu, 14 Sep 2017 07:17:35 +0900
In-Reply-To: <CA+P7+xqcAh4v4gDQOm-feYGc1EmFztAu0zMg2xnp8Gn4=BzkoQ@mail.gmail.com>
        (Jacob Keller's message of "Tue, 12 Sep 2017 18:39:16 -0700")
Message-ID: <xmqqy3piz1j4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 592CA5AE-98D1-11E7-A748-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> By definition if you do a sparse checkout, you're telling git "I only
> care about the files in this sparse checkout, and do not concern me
> with anything else"... So the proposed fix is "since git cleared the
> skip-worktree flag, we should actually also copy the file out again."
> but I think the real problem is that we're clearing skip worktree to
> begin with?

As this 100% agree with what I've been saying, I do not have
anything to add to the discussion at the moment, so I'll stop
speaking now but will continue to monitor the thread so that I may
hear a new argument and datapoint that would make me change my mind.

Thanks for a healthy discussion.
