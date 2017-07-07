Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A26F20359
	for <e@80x24.org>; Fri,  7 Jul 2017 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbdGGRK6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 13:10:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32929 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdGGRK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 13:10:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id e199so5333981pfh.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KvDo+2mVtyYDurJ9K4LREmFulsmranq0I2tKyMJGmhU=;
        b=MlPZXjfztSxBOwcvmYpyKjVYNIiKGp74qNviFwylOZQA4G1ALqRaZFqb3C0ibe4np0
         AA/p66G51bpcJ3kVREeSU651hq+je8XdBZFIMIDeJzq0+v3kCHXaMRj2F7T/cP3UvNRX
         vMUtjbrfHPmV+1o2oiJDQod6Cr8POiuURjq4at/iBX7vBHEe16DuhqFPW2nxWe+l3a3n
         9y/tooPxvkkWW3Ib8W6VshXL7Ey5gcF6BeeFWJ1qGiFzSq6BxIhBxnGdcTbipmdmwSWv
         0yeLm1Jo6qw/Z39iIl9qi82wI0hV1SQqtOCYNUM9Q3uMytMqKIDGugiM2cSz1iPlQM1/
         xRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KvDo+2mVtyYDurJ9K4LREmFulsmranq0I2tKyMJGmhU=;
        b=K1vA1Xlg2ZePn0cHFpLHn0sEQPz6cSzunZg5yqNZw0L8Nva1V8iyd57+sS5FmCewwq
         RoZSKzD23hkQ5ZxEcekOGHWy/jbtRODJcVJVM/y1JSlTc99yxFGufnboS4MQQY7gH32y
         bcF+5nyX7uqvtera4KmXO4ugzhfPxQh/NJKlwqFocNLCNaYorLU/fNxmCUdZgRaSJNMf
         nTWZSZL0g7P/LG4CixnTFVWu7gqm5UyrOsJaXwBmfsYA1cSjZW6fPBXFC/Idmh4RWGHD
         /utFzTjRvR95DXrcbDZd7JQJwgk28/7isi1gPWDtsACzXMO0ywtHtT4PhsyTQlZVmrHP
         atzw==
X-Gm-Message-State: AIVw112V44oxOe0Z7Cuh/JG/gEBSIAPvLv7aeerVks3YyFUanWWYDj1u
        54wkw6JOueyB8A==
X-Received: by 10.84.217.150 with SMTP id p22mr4164610pli.270.1499447456463;
        Fri, 07 Jul 2017 10:10:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id g79sm8069600pfg.121.2017.07.07.10.10.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 10:10:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 3/7] log: do not free parents when walking reflog
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
        <20170707090734.x2ki7lluawf66g4a@sigill.intra.peff.net>
Date:   Fri, 07 Jul 2017 10:10:54 -0700
In-Reply-To: <20170707090734.x2ki7lluawf66g4a@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 7 Jul 2017 05:07:34 -0400")
Message-ID: <xmqqwp7kb2ap.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we're doing a reflog walk (instead of walking the
> actual parent pointers), we may see commits multiple times.
> For this reason, we hold on to the commit buffer for each
> commit rather than freeing it after we've showed the commit.
>
> We should do the same for the parent list. Right now this is
> just a minor optimization. But once we refactor how reflog
> walks are performed, keeping the parents will avoid
> confusing us the second time we see the commit.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/log.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 8ca1de9894..9c8bb3b5c3 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -374,9 +374,9 @@ static int cmd_log_walk(struct rev_info *rev)
>  		if (!rev->reflog_info) {
>  			/* we allow cycles in reflog ancestry */
>  			free_commit_buffer(commit);
> +			free_commit_list(commit->parents);
> +			commit->parents = NULL;

After step 6/7, we no longer "allow cycles in reflog ancestry", as
there will be no reflog ancestry to speak of ;-), so it would be
nice to remove the comment above in that step.  But alternatively,
we can rephrase the comment here, to say something like "the same
commit can be shown multiple times while showing entries from the
reflog" instead.

>  		}
> -		free_commit_list(commit->parents);
> -		commit->parents = NULL;
>  		if (saved_nrl < rev->diffopt.needed_rename_limit)
>  			saved_nrl = rev->diffopt.needed_rename_limit;
>  		if (rev->diffopt.degraded_cc_to_c)
