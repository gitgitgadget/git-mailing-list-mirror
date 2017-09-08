Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6891FAD6
	for <e@80x24.org>; Fri,  8 Sep 2017 19:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756904AbdIHTMO (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 15:12:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62347 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756581AbdIHTMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 15:12:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 367C4A1938;
        Fri,  8 Sep 2017 15:12:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IfOySEV4TzRF07Wmiu4eMp7H4TE=; b=O6VH12
        Ca72jhKN5bNLluQg8+qr1G8DcS31B+5wqTNa/1AVJPqHUF+aAAUGRlnaP3wAs5Gq
        A096BFanfSnJUSiBUKJg0G/Jn7ae/wH78Z8GDsZyxZ5T8BAvFOOZi7cIwI+51TGq
        TVN5yqgYZtOpt5azrlG67DAHO8ynbM8LoZb1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XSnP2dx+XS9I9gBhEUYYCDYf9MGNO42J
        d3L2cVW1rfQ99y7RfgYC+1Xp/r8ZgNWnHUcB4e7ST4o5x9U9musZcuUwiJYRD0t/
        ZZToG+c+OxQliGj/cWQpPztRpj9x06DHiH2Phy3PuleJWTq5YmPxCH1WomUyYn0G
        WDD9NonLmMI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D239A1937;
        Fri,  8 Sep 2017 15:12:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BDE9A192F;
        Fri,  8 Sep 2017 15:12:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
Date:   Sat, 09 Sep 2017 04:12:11 +0900
In-Reply-To: <20170908180050.25188-2-kewillf@microsoft.com> (Kevin Willford's
        message of "Fri, 8 Sep 2017 12:00:50 -0600")
Message-ID: <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E6B1F58-94C9-11E7-ABBC-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kewillf@microsoft.com> writes:

> When using the sparse checkout feature the git reset command will add
> entries to the index that will have the skip-worktree bit off but will
> leave the working directory empty.  File data is lost because the index
> version of the files have been changed but there is nothing that is in the
> working directory.  This will cause the next status call to show either
> deleted for files modified or deleting or nothing for files added.  

Getting rid of sparseness may of course be one way to correct the
discrepancy, but it is unclear to me if that is the best way to do
so.  An alternative may be to add entries to the index that does
have the bit on for paths that are meant to be skipped due to
"sparse" thing, no?  Am I being naive, missing some reason why that
would give us a worse result?
