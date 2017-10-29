Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0234A2055E
	for <e@80x24.org>; Sun, 29 Oct 2017 01:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbdJ2B0n (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 21:26:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62402 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751501AbdJ2B0n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 21:26:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A6F8ACEBE;
        Sat, 28 Oct 2017 21:26:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7uS/0cd2q67LfNytfPBDLGjqiMM=; b=GCDj2R
        zcNrMZVYKepcc40kfdE5Qtzxa+eKGgGDnEUjCq+c0fuyM2RdqTTcInnltaW1Vc43
        OkA3GgdNsBg1rKtOBiME56sNfNluMYkiR0AvSFnGwytyhd/ITAiSqKrcCxYMSLEz
        C7I0mUwqTM1BYIMD5EMszzYlA6pkFJr1OC/7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dzpP70+Q29H5z5hg/B405lH7L8+BgcQP
        kdPL7QFWoJ3HUerRqxafEj8AzpYMGWzvusrKgMMMqV7QtZ7gtd37d/NAr7fTQqyZ
        +YiqeXXnxKEp833iyLcdBcFASJosIQSmxiFtrNDFR00Wys2K5h5fvc0b2p3pfZQK
        55toJtH/UUE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 824D0ACEBB;
        Sat, 28 Oct 2017 21:26:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 036CBACEBA;
        Sat, 28 Oct 2017 21:26:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] reset: use DIFF_OPT_SET macro to set a diff flag
References: <20171027222853.180981-1-bmwill@google.com>
        <20171027222853.180981-3-bmwill@google.com>
Date:   Sun, 29 Oct 2017 10:26:40 +0900
In-Reply-To: <20171027222853.180981-3-bmwill@google.com> (Brandon Williams's
        message of "Fri, 27 Oct 2017 15:28:52 -0700")
Message-ID: <xmqq1slmbv73.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37F0ADB4-BC48-11E7-881B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Instead of explicitly setting the 'DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG'
> flag, use the 'DIFF_OPT_SET' macro.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

Looks good.  It's not like one of 1/3 and 2/3 could be a good idea
while the other is not, so it would make a lot more sense to combine
them into a single preliminary clean-up patch, though.  

In any case, these two are very good clean-up patches, whose value
does not diminish even we do not go ahead with 3/3 yet.  

Nicely spotted; thanks.


>  builtin/reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 9cd89b230..ea2fad5a0 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -166,7 +166,7 @@ static int read_from_tree(const struct pathspec *pathspec,
>  	opt.output_format = DIFF_FORMAT_CALLBACK;
>  	opt.format_callback = update_index_from_diff;
>  	opt.format_callback_data = &intent_to_add;
> -	opt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> +	DIFF_OPT_SET(&opt, OVERRIDE_SUBMODULE_CONFIG);
>  
>  	if (do_diff_cache(tree_oid, &opt))
>  		return 1;
