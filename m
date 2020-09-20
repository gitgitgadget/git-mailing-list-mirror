Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B3C43463
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278DB20874
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 15:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Lysm3061"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgITPjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 11:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITPjT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 11:39:19 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9660C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 08:39:19 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v123so12351675qkd.9
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O+UsnGvsSBQUku5KckHAlbvjvx+OiMpqPIcEDqFmiHo=;
        b=Lysm3061HQ6W5UZooL4UjmdWKEPn/D1Xvto2Z2C3/6sU1M05UBOqmkhIKRKpW7Cg7p
         fgnnUy0q8V4JrVTYiAKSbHqY00+UXRHi/UQAc9N1MXtz58WtGSeIIck+0TJY4VWyTEfa
         CEzhysKV8OqNELmJ6irKCBD+I1heJYhrJiB8vLg+CFAW2s2LoW3Wd161G7EvlY47ZLES
         7PjZZv7acOrPdlm4hg4XA/d7zMT3FH0i38sCfUL1enBB8h4HeImNgdAPfWaaczm3O8mP
         CQaYUAw7k2YwgpDbXK+MhWMkleV1zgOuwzaSSne9n7kKHdeL4wI7WN+kOLxTqBWKwnmA
         LuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O+UsnGvsSBQUku5KckHAlbvjvx+OiMpqPIcEDqFmiHo=;
        b=mAsrrdVVA8GE3C9zm2YCZ+irBEoQttYdsGb2MJKK0CR1Bmbo+25JJkzqoMdfZFfvxb
         /Mj0kFFcktl7nUk8HtYv1miYp41QBv0RbNOZYkzR6Fb1pu66KpLzJR6gTH0K6MJteCFM
         0ldJrI0uWhxKFp8WgpXqULEjRWSnq+ZzqjoqUtdXH4hdNd8gYZPuHX7ii4QxwCvyiMZY
         wnYxtwYfr6WBEjcDgKMRlBh3ucOdRnwUnZgKmnqjoW74IAC8wbkHva6XNn7y3MsxUa71
         1+q2yOHfoyd4ueNaz7V37M+FEpZs8kROr8Lm+xSfmESzMfpWcujfCm9Ut30WjEKjUOJv
         6SNQ==
X-Gm-Message-State: AOAM531oXVaF6KXT3B0YUaKSJ9f2toSbHpcKDooyklmxm3YR0POu8kBT
        t1IKHz4WdKGObqpat1XqgfWI+Q==
X-Google-Smtp-Source: ABdhPJwLaGiYDbsLFnF9TwZF3Jk7phJsgvWnQA0pahh9P1MrH88JXR4jh7Plh3jQrJ0OsCoRMFK3jQ==
X-Received: by 2002:a37:b87:: with SMTP id 129mr4331208qkl.38.1600616358905;
        Sun, 20 Sep 2020 08:39:18 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e586:7467:2d4a:d620])
        by smtp.gmail.com with ESMTPSA id g45sm7622015qtb.60.2020.09.20.08.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 08:39:18 -0700 (PDT)
Date:   Sun, 20 Sep 2020 11:39:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     git@vger.kernel.org, dermoth@aei.ca, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
Message-ID: <20200920153915.GB2726066@nand.local>
References: <20200918113256.8699-2-tguyot@gmail.com>
 <20200920130945.26399-1-tguyot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200920130945.26399-1-tguyot@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 20, 2020 at 09:09:46AM -0400, Thomas Guyot-Sionnest wrote:
> In builtin_diffstat(), when both files are coming from "stdin" (which
> could be better described as the file's content being written directly
> into the file object), oideq() compares two null hashes and ignores the
> actual differences for the statistics.
>
> This patch checks if is_stdin flag is set on both sides and compare
> contents directly.
>
> Signed-off-by: Thomas Guyot-Sionnest <tguyot@gmail.com>
> ---
> Range-diff:
> 1:  479c2835fc ! 1:  1f25713d44 diff: Fix modified lines stats with --stat and --numstat
>     @@ -20,8 +20,12 @@
>       	}
>
>      -	same_contents = oideq(&one->oid, &two->oid);
>     ++	/* What is_stdin really means is that the file's content is only
>     ++	 * in the filespec's buffer and its oid is zero. We can't compare
>     ++	 * oid's if both are null and we can just diff the buffers */
>      +	if (one->is_stdin && two->is_stdin)
>     -+		same_contents = !strcmp(one->data, two->data);
>     ++		same_contents = (one->size == two->size ?
>     ++			!memcmp(one->data, two->data, one->size) : 0);
>      +	else
>      +		same_contents = oideq(&one->oid, &two->oid);

After reading your explanation in [1], this version makes more sense to
me.

Thanks.

[1]: https://lore.kernel.org/git/f4c4cb48-f4b5-3d4d-066d-b94e961dcbb5@gmail.com/

Taylor
