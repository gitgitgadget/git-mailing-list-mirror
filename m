Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B06C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 00:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKCAYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 20:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiKCAYM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 20:24:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A542160D2
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 17:24:11 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r2so296404ilg.8
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 17:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xiaIv3RGM9rQrMGVKBrp0XvgrU38RckSR3C/52RPYXM=;
        b=3BDNgcUTfegh57iqtqneD6pmjiZmWj3uA8sAhnoy/NO8eEAYzPMxJ99DNPfVX9wcUL
         6SWFbTrEfitOVOnFVIovcMBXHpQGnAk6EZSZc6yBnWSqjrmeNyMK3qP6whBu7vO53sQj
         LxncfFOdgafGBa9MbrksbUV1KwlixURUQ3mnCzpBd0ohOyT+A9APZGgXnl0DfcRm6n0f
         HQ5gV6ydLpaSbN+LR3BFCWewVfTf4S/pa4Fd1WCmkggX8ZfftE737cs9ClMLIT6pNI9B
         NiMdwpp+PTsR7s/tYJtoUyQ2/3lzWwrs6a8+2wmP08hbgfXSm5xuBQeM7fEVwkx9XHtz
         3DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiaIv3RGM9rQrMGVKBrp0XvgrU38RckSR3C/52RPYXM=;
        b=40JC2/pi5VmutZ9ebErO8o+gly9qHUj9EV0VDnSAC0tGosJ+4V6Nr1Uv1fCEx5diJY
         3M1U4krnVNpLikhlGp+GIVcjq72JhlJsrutZevE+YI5I6FMVzpt0gWOZEM0tkMNh5CMr
         Tbi/EXuhzku5Ovluowwixje5JC9s8K6hi0FVI0Ss1iH/W03dyHTzOgC0tMeDMSW9xrPq
         7l0lhFNf7KheBVS3rgVfLED80HfsK8Wp55JMPYqYbl9VY/h9jNaLRKUjScX+u/pRvR3p
         YAho+Wr9uVKdsQvYCoITR1gY3/Z4aoYECWMrq6JZPiA+VQYQryN9QfuFiKhYD2sCYoBe
         PRsA==
X-Gm-Message-State: ACrzQf2liQns3spr4R/qpNq32//CtaONaaofbXabaNQrTIH7ri9wHaJs
        pm+t2I+04ffMDv7HYs9gVDe+Fw==
X-Google-Smtp-Source: AMsMyM7lQV6IF8EW5OOYuRKQobXnONSl5uNjP6KVk3PkjAQj3m4iKOQAGv03z9FiC9KryMq7nVOi9g==
X-Received: by 2002:a05:6e02:12e8:b0:300:f67:9047 with SMTP id l8-20020a056e0212e800b003000f679047mr16434313iln.14.1667435050966;
        Wed, 02 Nov 2022 17:24:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i7-20020a02c607000000b003734c4d01d2sm1867662jan.61.2022.11.02.17.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:24:10 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:24:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 3/3] diff.c: use diff_free_queue()
Message-ID: <Y2MKKTz4nK0L8uW5@nand.local>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
 <20221102220142.574890-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102220142.574890-4-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 11:01:42PM +0100, SZEDER Gábor wrote:
> Use diff_free_queue() instead of open-coding it.  This shortens the
> code and make it less repetitive.
>
> Note that the second hunk in diff_flush() is interesting, because the
> 'free_queue' label separates the loop freeing the queue's filepairs
> from free()-ing the queue's internal array.  This is somewhat
> suspicious, but it was not an issue before: there is only one place
> from where we jump to this label with a goto, and that is protected by
> an 'if (!q->nr && ...)' condition, i.e. we only skipped the loop
> freeing the filepairs when there were no filepairs in the queue to
> begin with.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  diff.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index ef94175163..03e6ffb5e4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6337,13 +6337,9 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
>  int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
>  {
>  	struct diff_queue_struct *q = &diff_queued_diff;
> -	int i;
>  	int result = diff_get_patch_id(options, oid, diff_header_only);
>
> -	for (i = 0; i < q->nr; i++)
> -		diff_free_filepair(q->queue[i]);
> -
> -	free(q->queue);
> +	diff_free_queue(q);
>  	DIFF_QUEUE_CLEAR(q);

So, this all looks fine to me. But I did a quick grep around for
DIFF_QUEUE_CLEAR(), and this macro is used in quite a few places.
Mostly, as far as I can tell, to "empty" out the diff-queue by setting
its 'queue' pointer to NULL, and its 'nr' back to 0.

Should we be freeing the memory held by the queue there more
aggressively? I.e., should we make sure that there is a
diff_free_queue() call above each expansion of the DIFF_QUEUE_CLEAR()
macro?

Thanks,
Taylor
