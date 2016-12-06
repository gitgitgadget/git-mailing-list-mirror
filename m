Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB5781FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbcLFVLY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:11:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63083 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751327AbcLFVLX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:11:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC7EB541F0;
        Tue,  6 Dec 2016 16:11:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8/91heoaDZP8
        bcfv9O6MUcGThA4=; b=bIk0jyojIDq2vciuILmU2TEmBk0hii2D8f7vtGzhBrKT
        XAvBQnFMS22Q30+0vyDT+S6AdGH2IPYS8Z3w4d1oEc38BMllPPgnj9YNIMrNvj6N
        qLXoptmJI9ZTLuw21XbkwyiQwxHrhWfpZlizHji7B0zxaKVEas9aoXa+YfaQfrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ip2OF8
        JY2Wic8DUMQLQfP/cNfhEL0owYehKgtp19Clwxbi+juXDGjCG9omioep/Rbtk0R1
        DvAGhaF65gnnmXI/c/n9xPMZmWIzQfuop54yAc4ejzoQXVR6hhJQRYABc6uC1Dzc
        tVXXFTqSo8MayKj4SazK1tM2swbvA6D/g2eoE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A271E541EF;
        Tue,  6 Dec 2016 16:11:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13AC6541ED;
        Tue,  6 Dec 2016 16:11:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2] tag, branch, for-each-ref: add --ignore-case for sorting and filtering
References: <20161130123502.12973-1-pclouds@gmail.com>
        <20161204025225.11158-1-pclouds@gmail.com>
Date:   Tue, 06 Dec 2016 13:11:20 -0800
In-Reply-To: <20161204025225.11158-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 4 Dec 2016 09:52:25 +0700")
Message-ID: <xmqqpol4zrt3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89E225AE-BBF8-11E6-9BFE-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This options makes sorting ignore case, which is great when you have
> branches named bug-12-do-something, Bug-12-do-some-more and
> BUG-12-do-what and want to group them together. Sorting externally may
> not be an option because we lose coloring and column layout from
> git-branch and git-tag.
>
> The same could be said for filtering, but it's probably less important
> because you can always go with the ugly pattern [bB][uU][gG]-* if you'r=
e
> desperate.
>
> You can't have case-sensitive filtering and case-insensitive sorting (o=
r
> the other way around) with this though. For branch and tag, that should
> be no problem. for-each-ref, as a plumbing, might want finer control.
> But we can always add --{filter,sort}-ignore-case when there is a need
> for it.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---

It took me a while to figure out the interactions with topics in
flight, but I think I resolved it correctly now.  There was a topic
that added "--format" to branch and tag.

Will be pushed out as part of today's integration cycle.

Thanks.
