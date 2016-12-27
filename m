Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB389200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756132AbcL0TOC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:14:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56265 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754570AbcL0TN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:13:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F196E59B1B;
        Tue, 27 Dec 2016 14:13:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=2oU3YHfVUsG24qoibR54c1bC4Es=; b=bpHFjHZIMKEjLbHCkc2y
        udWxYlK1qvUsZG1P1pDrM900qKlskgm7mN6Cgz5sgGb0eNKWzxd1fuTWzk4ytGh9
        z7QmP6778V0S2gt30+vISDb+XhDwGwQi9/svdMRQezOl5vVI9orI8PER80Pdkwnk
        QRpT/2/cTirTBtSx4xZuqwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=pBPMFsGlPj4LFhSlBycWT6iazdKr90AIE171mBDg+AiEm1
        5nq6huXCKgLiKcYOSEbKaNVz+ZXa+wbyzELi447dndI/nLXL3orfvVL/epijwmYz
        pVvseC87noCy1K2NzEaja60/Nwi4MqzclLIQJyBhP/hlXwhrIJSHuF9UuaoU8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA11659B1A;
        Tue, 27 Dec 2016 14:13:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4861859B18;
        Tue, 27 Dec 2016 14:13:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 20/21] Documentation/config: add splitIndex.sharedIndexExpire
Date:   Tue, 27 Dec 2016 11:11:31 -0800
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-21-chriscool@tuxfamily.org>
Message-ID: <xmqqeg0t9oct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C63570E-CC68-11E6-9D55-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e0f5a77980..24e771d22e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2786,6 +2786,17 @@ splitIndex.maxPercentChange::
>  	than 20 percent of the total number of entries.
>  	See linkgit:git-update-index[1].
>  
> +splitIndex.sharedIndexExpire::
> +	When the split index feature is used, shared index files with
> +	a mtime older than this time will be removed when a new shared

As end-user facing documentation, it would be much better if we can
rephrase it for those who do not know what a 'mtime' is, and it
would be even better if we can do so without losing precision.

I think "shared index files that were not modified since the time
this variable specifies will be removed" would be understandable and
correct enough?

> +	index file is created. The value "now" expires all entries
> +	immediately, and "never" suppresses expiration altogether.
> +	The default value is "one.week.ago".
> +	Note that each time a new split-index file is created, the
> +	mtime of the related shared index file is updated to the
> +	current time.

To match the above suggestion, "Note that a shared index file is
considered modified (for the purpose of expiration) each time a new
split-index file is created based on it."?

> +	See linkgit:git-update-index[1].
> +
>  status.relativePaths::
>  	By default, linkgit:git-status[1] shows paths relative to the
>  	current directory. Setting this variable to `false` shows paths
