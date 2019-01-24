Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D0C1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfAXVMS (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:12:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34252 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAXVMS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:12:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so8095790wrp.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=o8WildGFtm5X5/GQOB59oPVyk98TL0xAb0JaQF1cAbY=;
        b=KvgsWAQPHWuw65ZaKuxlxTtvGk0YCCcL+QtOSn1/zAOt6m+pGyWyai+7UoQ1LAUCDU
         E2wt6xwjDzWTbhgzvFfofo47G4bnY+BS9Hce1v11qASjIwipdWOdoigJQsNv+smO/mFW
         w4Lz8MJGZ9TjT/aEMCgOMe5G8jLbD6FbOdBQhUINSrsAaHZXQlYIuWaaVnV+/dWvzYPI
         AIyBXjYuHwGd46h4Mt2VMwTINyEd3xOaszhF7oXKro/zlccTHsLB3Z/rVe43J6/JO5db
         YEqNNS8j2NfGsEC9y+3uth7P6N0QBN111IyqPBpsk+tXMvYOhqdUOUrQCRsvhdstbw4X
         Zcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=o8WildGFtm5X5/GQOB59oPVyk98TL0xAb0JaQF1cAbY=;
        b=mlR3HKUm2MvMR+cZKWz1IL5yyK8HnHdTwQh46s/hatSjbCNSChvybtd5/nWGI97Qei
         RaHGPEP0UsA+EFb0dNeSXX3Hg1EviDSwm3kLBjcRzIK7ZTtZ3a89SspDp50waCpukRrm
         ow7c0vpwuYXl0SnXRD3ErxYJgrk561lnBbl+LnWY8gGN1KRJalcQB/dnHZZfwa7rrf+s
         oj9N0UROkIp6AIqwNPcH4wr8SrdyWvY7SKtDYrqwTnMxzDJIq/NWu/t9jz6JJpwMG2u5
         vkp4602A8auw39EacuI9bjBrjb9RQfj5ieE/CMO7Kajs2X33Y25fF4piFnqCluI9DJlN
         mjWA==
X-Gm-Message-State: AJcUuke/4U6KfHzS+386Agv+KKA+KNIvh1XMYHNRlaLyATDzxjK0y85L
        VW+CFjeutpXpbaouh1M43qI=
X-Google-Smtp-Source: ALg8bN4fl4VI5HGY943knLwDp2QobL+ev3lSuXf4QJ1Wxe21gVNHrXgKzfV46JYyNnm/MNCc5gFCpA==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr8890667wrx.146.1548364336167;
        Thu, 24 Jan 2019 13:12:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t199sm46169008wmt.1.2019.01.24.13.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 13:12:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joey Hess <id@joeyh.name>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Subject: Re: [PATCH] avoid unncessary malloc of whole file size
References: <20190122220714.GA6176@kitenet.net>
        <20190124121037.GA4949@sigill.intra.peff.net>
        <20190124183810.GC29200@kitenet.net>
        <20190124191836.GA31073@sigill.intra.peff.net>
        <20190124203639.GA17595@kitenet.net>
Date:   Thu, 24 Jan 2019 13:12:15 -0800
In-Reply-To: <20190124203639.GA17595@kitenet.net> (Joey Hess's message of
        "Thu, 24 Jan 2019 16:36:39 -0400")
Message-ID: <xmqqlg39hia8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Hess <id@joeyh.name> writes:

> When a worktree file is larger than the available memory, and a clean
> filter is in use, this avoids mallocing a buffer the whole size of the
> file when reading from the clean filter, which caused commands like git
> status and git commit to OOM.
>
> Often in this situation the clean filter will produce a short identifier
> for the file, so such a large buffer is not needed.
>
> When the clean filter does output something around the same size as the
> worktree file, the buffer will need to be reallocated until it fits,
> starting at 8192 and doubling in size. Benchmarking indicates that
> reallocation is not a significant overhead for outputs up to a
> few MB in size.

Problem description first, then solultion.  "... this avoids ..." is
already talking about solution while forcing the readers to know
what the problem is.

    When a worktree file is ... filter is in use, we allocate a
    buffer for the whole size of the file when reading from the
    clean filter.  This can force us to overallocate if the clean
    filter is used to radically shrink a huge file and replace it
    with a small token (e.g. git-annex or git-lfs) and lead to OOM
    at the worst case.  Reading from the filter and growing the
    buffer as we go would avoid such an unnecessary OOM.

    When the clean filter does output ...
    ... few MB in size.

perhaps.

> Signed-off-by: Joey Hess <id@joeyh.name>
> ---
>  convert.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/convert.c b/convert.c
> index 0d89ae7c23..85aebe2ed3 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -732,7 +732,7 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
>  	if (start_async(&async))
>  		return 0;	/* error was already reported */
>  
> -	if (strbuf_read(&nbuf, async.out, len) < 0) {
> +	if (strbuf_read(&nbuf, async.out, 0) < 0) {
>  		err = error(_("read from external filter '%s' failed"), cmd);
>  	}
>  	if (close(async.out)) {
