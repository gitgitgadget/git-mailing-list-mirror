Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D047420281
	for <e@80x24.org>; Mon,  6 Nov 2017 01:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750904AbdKFBXd (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 20:23:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54968 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750750AbdKFBXc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 20:23:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BF5EB3ACB;
        Sun,  5 Nov 2017 20:23:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V+sTeCDuCFTFA5FKvVxBlXKnlL8=; b=H9huye
        Ptw0acMSqNeaB4j2gvbCd/kBEC7GgxTe67e3iCsyPoj9eruhlOUoTTwX3xitchAd
        CpRVhUX8CZ/F/kbjNGwqRAg/GOYmtUbSOGDyEbhSa5EF+dhzByGBNt+K8DXezZp2
        C3LcZZKxBwLx3c43vOw72Fm42Fe5yg2QU8+2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xyjCcjvEcHa0KzuJQM3G7h89rNlVGjf+
        2xN9iD0uQd3OvmsVWoG2cvSvh44fGmFrZRljQxw6xToisCJbSs9RXP0iFswBrYZV
        Szcgfy3fsr7SJ7r3x8dC5Fe3VMdfu3/0ziyAPvxrJITJbjjXUWxll2bVFUuF9tXI
        WtjbMqYP+ZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 419CDB3ACA;
        Sun,  5 Nov 2017 20:23:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A407FB3AC9;
        Sun,  5 Nov 2017 20:23:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        pclouds@gmail.com, ilari.liusvaara@elisanet.fi
Subject: Re: [PATCH v1 1/2] refs: extract function to normalize partial refs
References: <20171104004144.5975-1-rafa.almas@gmail.com>
        <20171104004144.5975-2-rafa.almas@gmail.com>
        <4dc4eefc-56b9-1b13-ae46-83a3af9c7ee3@alum.mit.edu>
Date:   Mon, 06 Nov 2017 10:23:30 +0900
In-Reply-To: <4dc4eefc-56b9-1b13-ae46-83a3af9c7ee3@alum.mit.edu> (Michael
        Haggerty's message of "Sun, 5 Nov 2017 14:42:34 +0100")
Message-ID: <xmqqwp34jj3h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19D545DE-C291-11E7-AF32-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> [1] I say "almost entirely" because putting them in one function means
> that only `pattern` needs to be scanned for glob characters. But that is
> an unimportant detail.

That could actually be an important detail, in that even if prefix
has wildcard, we'd still append the trailing "/*" as long as the
pattern does not, right?
