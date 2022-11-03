Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860C7C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 00:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiKCAU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 20:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCAUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 20:20:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B090765E
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 17:20:23 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d123so157469iof.7
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l73N3f+aIg4t72BNlda9hKTS4egFMuEpFXBmBrQSgkE=;
        b=1HJhXEKnvkkh9SQC17I8cJVm4q5xTwqXZTvlFj5gPw7xMizRGinrkdlPPqHI964/51
         vXRR5ZDFD/GVp3rvbTmJPLUVOMHX681KVyrIOztP0cuOt4ESN2SHygNApI/vV9BAaAQT
         KTE6elwd0UskaJDNPaebiEgFP3KgQH0oNV5AUsE8a1HTo9IWR6N3A+S503fjloDjlxsf
         okuuoq0CrNRcYcLWNMxYgCQ2Db7KBBp1gmcPhuAUwbVBPECXX54vCCBtdKSmgVlorCR6
         7Z+/6puMleJncqcXANGXEENDNIAEDWhqCUOXbtRDYu2EEHIS3FwsJSYXRO1tjvVXCy7p
         bY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l73N3f+aIg4t72BNlda9hKTS4egFMuEpFXBmBrQSgkE=;
        b=QrafJViZTVmPqs9LV5sNXS7thdxCCH6XUuLGwW4ghgb1sshVPSXFN9+CMHrAJYlTCf
         JFikEaayBqx3f7RY1KMchx0GvEtUs/aMSsVjnxm6nXjerNUv/qJcaRiD0Iyf2TFYQtZU
         Yh+GIxQIDgMNpNEIU8tfCoCSLvOG8RVxSYKWjhNZaSafZqjvxLSl68gxdFG9qYov2P9X
         B1sOfvpGTN3nPz6WwYnt5OOojfdcI/V9JN5IndHkrf6R1A22kcfPVsRwc4RSaUEu5iLJ
         VrXZCtWkFp557UdG0Z9TpVfa0gZY3vIvl+wI0CD2KgkRWHiuahWplz3FzPh9L9yDkAGt
         h4Hw==
X-Gm-Message-State: ACrzQf1xa2N31Zt+JMXjfOAPLw0VvN9TElQ4KYg0eeYKHW9N115molL0
        eNjbuDsnNVFD/FalHlUCfMt3v2Z2kLqi98n1
X-Google-Smtp-Source: AMsMyM4kgnSccH/9Xf7aK7LoR4IPzB6Dy1PJ4CP7adPYpGMWPysOiscijQQ/NbaQtmS4uIuzDNFN0A==
X-Received: by 2002:a05:6638:1185:b0:375:2fbd:cdbe with SMTP id f5-20020a056638118500b003752fbdcdbemr17356468jas.289.1667434822956;
        Wed, 02 Nov 2022 17:20:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d20-20020a0566022d5400b006c720d63356sm4443918iow.33.2022.11.02.17.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:20:22 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:20:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 1/3] line-log: free diff queue when processing non-merge
 commits
Message-ID: <Y2MJRRfwG7rSp6Ra@nand.local>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
 <20221102220142.574890-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102220142.574890-2-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 11:01:40PM +0100, SZEDER Gábor wrote:
> When processing a non-merge commit, the line-level log first asks the
> tree-diff machinery whether any of the files in the given line ranges
> were modified between the current commit and its parent, and if some
> of them were, then it loads the contents of those files from both
> commits to see whether their line ranges were modified and/or need to
> be adjusted.  Alas, it doesn't free() the diff queue holding the
> results of that query and the contents of those files once its done.
> This can add up to a substantial amount of leaked memory, especially
> when the file in question is big and is frequently modified: a user
> reported "Out of memory, malloc failed" errors with a 2MB text file
> that was modified ~2800 times [1] (I estimate the leak would use up
> almost 11GB memory in that case).
>
> Free that diff queue to plug this memory leak.  However, instead of
> simply open-coding the necessary three lines, add them as a helper
> function to the diff API, because it will be useful elsewhere as well.

Nicely explained.

> ---
>  diff.c     | 7 +++++++
>  diffcore.h | 1 +
>  line-log.c | 1 +
>  3 files changed, 9 insertions(+)

And all looks reasonable here, good...

> diff --git a/diff.c b/diff.c
> index 35e46dd968..ef94175163 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5773,6 +5773,13 @@ void diff_free_filepair(struct diff_filepair *p)
>  	free(p);
>  }
>
> +void diff_free_queue(struct diff_queue_struct *q)
> +{
> +	for (int i = 0; i < q->nr; i++)
> +		diff_free_filepair(q->queue[i]);
> +	free(q->queue);
> +}

Though I wonder, should diff_free_queue() be a noop when q is NULL? The
caller in process_ranges_ordinary_commit() doesn't care, of course,
since q is always non-NULL there.

But if we're making it part of the diff API, we should probably err on
the side of flexibility.

Thanks,
Taylor
