Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D27D1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKBHem (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 03:34:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60865 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKBHem (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 03:34:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F13338E63;
        Sat,  2 Nov 2019 03:34:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sIFZXx9cghsr5mhrZV8Rab4qHP0=; b=Sy1srs
        qh1Iat4ZdLXC8dk2e+uJCsiGWsC9Dw1nn4Wz2JhdKIORcycQR/esocC/KeGwk5PR
        s/BtMR9c4bXHYBzrx2rshKTv0hU8bYJ2EosCXMnzONpgt5uEvChhhXFUUdKeC2Ve
        lQs2Q5pUX/GqwUNvj2YWciXFo20L74c+i1aHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EJl4QudO9g3Sml6lfluSrPsdCfm+UERL
        ZcdZi1nwQIa2Ub0yoW9m7ke0F6IJExPJvoE4/1tQKF7FHyLmeK5jGa0DhbaO1rwp
        mVfuV1OANYqvIWuriDtCjBiSWK9V62QRAor/qga4VhcpfH0oI6JDFV4FqJoqUeQc
        fJzwj0uXb1U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA9DE38E62;
        Sat,  2 Nov 2019 03:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4619C38E61;
        Sat,  2 Nov 2019 03:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v5 6/6] rebase: add --reset-author-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
        <20191101140003.13960-7-rohit.ashiwal265@gmail.com>
Date:   Sat, 02 Nov 2019 16:34:38 +0900
In-Reply-To: <20191101140003.13960-7-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Fri, 1 Nov 2019 19:30:03 +0530")
Message-ID: <xmqq5zk23f5d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A3A14E6-FD43-11E9-AA1E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

>  --ignore-date::
> +--reset-author-date::
>  	Instead of using the given author date, reset it to the
>  	current time. This implies --force-rebase.
>  +
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 7edae668f8..edefdd016b 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1455,6 +1455,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "committer-date-is-author-date",
>  			 &options.committer_date_is_author_date,
>  			 N_("make committer date match author date")),
> +		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
> +			 "ignore author date and use current date"),
>  		OPT_BOOL(0, "ignore-date", &options.ignore_date,
>  			 "ignore author date and use current date"),

One of them should say it is a mere synonym to the other (or hide
from the "git rebase -h" listing altogether).  Otherwise readers
would be puzzled what the difference between the two are.

Thanks.

