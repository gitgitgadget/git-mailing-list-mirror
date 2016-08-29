Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D891FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755269AbcH2Uc7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:32:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53006 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754321AbcH2Uc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:32:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F3793A997;
        Mon, 29 Aug 2016 16:32:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=efVxXsT6saq+XPOFLwLqnJWt/Hw=; b=Koi2To
        4Cemjjsp3sHHWQQF7PROr2HfzXJ3iPLURd01SxCG+Q0X7P2KjW99gdOz8R3SWxst
        pAISs/LXT9WLDE8ZGsrXqd3MdkcQslzrkm0KMduUblm5hBSiufTy46S0h1bPJGed
        q6WEknl9K4K3PIJ+swuYOG1IjXos3QMxg2Xsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v70EB4alKR07HVbb8MhB4IkMOcDfzd1b
        jOIb3bMaXI3Vc3bC9MnltHQusjbsD8ypHeJKJlxJ6foacamaEpcq2HzrlYXti9Pq
        dkU8oQcN/CapRKJTS2gXVFEOABs6GYaVMv8kqo2TBo227BLo2kJUs54a2XohG0UG
        vq3bhNySLpM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 970933A995;
        Mon, 29 Aug 2016 16:32:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06D443A993;
        Mon, 29 Aug 2016 16:32:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/14] sequencer: lib'ify do_pick_commit()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <cover.1472219214.git.johannes.schindelin@gmx.de>
        <39d03662fc6ea81d737c0650bb9b7292e812ae02.1472219214.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 13:32:54 -0700
In-Reply-To: <39d03662fc6ea81d737c0650bb9b7292e812ae02.1472219214.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 26 Aug 2016 15:47:39 +0200
        (CEST)")
Message-ID: <xmqqbn0b9uyx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4792952-6E27-11E6-A611-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Instead of dying there, let the caller high up in the callchain notice
> the error and handle it (by dying, still).
>
> The only two callers of do_pick_commit(), pick_commits() and
> single_pick() already check the return value and pass it on to their
> callers, so their callers must be already prepared to handle error
> returns, and with this step, we make it notice an error return from
> this function.
>
> So this is a safe conversion to make do_pick_commit() callable from
> new callers that want it not to die, without changing the external
> behaviour of anything existing.
>
> While at it, remove the superfluous space.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index f6cdf65..7eef512 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -464,7 +464,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		 * to work on.
>  		 */
>  		if (write_cache_as_tree(head, 0, NULL))
> -			die (_("Your index file is unmerged."));
> +			return error(_("Your index file is unmerged."));

Makes sense.

do_pick_commit() still calls fast_forward_to(), which was silently
half libified in 3/14 but can still die in checkout_fast_forward(),
though.
