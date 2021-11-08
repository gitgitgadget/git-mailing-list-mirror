Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B7FC433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7456F61506
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhKHTLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbhKHTLA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 14:11:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C189AC061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 11:08:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b15so47301122edd.7
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 11:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pdkCXzZE7pnaZoHSOFViWt9gmScBQbZEAweP+mwL4P0=;
        b=kptYkcUeQEpvxR7y2fq9XO12S8Iy3/l6J/004Rekx9U7xASpxamMLqibTMLpt+uGlj
         5nFYHSV590NhZ1tXGGJ67/t2EpzjsbHE2LcN6m/Xjn7HTyYfie3Jw1IQ2H+aatFXEjN2
         sVxNcSJRDvhl+87y1nbjq8MA0iRvwlaSuNO6oyPj4dqCrTsAE838e1Ilm1BNXrxOB6Dl
         5Clsy8hcsRQRWSLvPN6BJqvfzKURohcgXFZ79G+qncgJBdQGt/BTOTesOX2rU/n7ECAG
         TQvgJzvRxK9P+c9unZgBFT5LxM+7F2Pq2srjaOlh5Ju0BPrent0MAxtPauEIrxdvsAEz
         aiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pdkCXzZE7pnaZoHSOFViWt9gmScBQbZEAweP+mwL4P0=;
        b=H1EreGrptrc4+0lwdbRv9pO+avKtaN1VJp8PVzgb3V1+9tLU05Qi2abdJzeiXv8i5Q
         gH6vqL/ZiEErxDHB+hbgIZB0/JIoWjgurHB76JUQvcYxQ/Ut9lg58OKcpd6WOA8vbKgs
         R0puYbpLZlLjNJtiTSsbNPYt2vq7DftKWw+pvSdwqgdVNilYnEsEbH17LdtU72/jWzuz
         WmUTdx9X5e7Exw+XCfO4jhE4vNxH5DvhV/ECUdYk/AIWqZsUfriSHoAI+Li+AfzT07Rq
         5LT0hstXVHzOdTfH+OqcvxHbEbuuyQYaotc2j3qvmz0B5EEoMXX5fcyNcpMmWS+7fQkQ
         g9mg==
X-Gm-Message-State: AOAM53211T7Jf7wGYotgNx8+tTbuVIqWzVc5GkFBdxT8qa3jw2DqNmM7
        3wirSCJOBdxpKBLN30Al8xMQPboNSg0=
X-Google-Smtp-Source: ABdhPJxR9nuZ9oCe6QAyVNURvuhpVR9EMVLbZhsUYNou9vow4ETbkYPdVj6GGuP0bpHH5OVQPDC/YA==
X-Received: by 2002:a17:906:1913:: with SMTP id a19mr1894105eje.484.1636398494242;
        Mon, 08 Nov 2021 11:08:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx27sm9966701edb.7.2021.11.08.11.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:08:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkA05-001Dfq-1w;
        Mon, 08 Nov 2021 20:08:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Birk Tjelmeland <git@birktj.no>,
        git@vger.kernel.org
Subject: Re: [PATCH] stash: show error message when lockfile is present
Date:   Mon, 08 Nov 2021 20:05:47 +0100
References: <20211107213012.6978-1-git@birktj.no>
 <YYiXw41upJfPS7l0@nand.local> <xmqqlf1zunqe.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqlf1zunqe.fsf@gitster.g>
Message-ID: <211108.868rxyfote.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 07 2021, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> I wonder if there are callers of repo_refresh_and_write_index() that
>> don't want any errors reported. Not having thought about it too hard
>> (much less looked through any of these callers), I would expect that
>> having the choice to either error() or die() is something worth keeping.
>> But I do not know if there are callers which want neither.
>> ...
>>>  add-interactive.c | 4 ++--
>>>  add-patch.c       | 4 ++--
>>>  builtin/am.c      | 2 +-
>>>  builtin/merge.c   | 4 ++--
>>>  builtin/stash.c   | 6 +++---
>>>  cache.h           | 4 ++--
>>>  read-cache.c      | 3 ++-
>>>  7 files changed, 14 insertions(+), 13 deletions(-)
>
> I think most of the changes in this patch, other than the ones to
> builtin/stash.c, are unwanted, and I suspect what you wondered above
> may be the same thing.  Take for example this hunk:
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index a0ccc8654d..977fcc4e40 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -501,7 +501,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  	const struct object_id *bases[1];
>  
>  	read_cache_preload(NULL);
> -	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> +	if (refresh_and_write_cache(REFRESH_QUIET, 0, LOCK_REPORT_ON_ERROR, 0))
>  		return -1;
>  
>  	if (write_cache_as_tree(&c_tree, 0, NULL))
>
> Telling the function to be quiet and at the same time be noisy on
> only one particular kind of error sounds somewhat strange.  I do not
> think of any reason why we should believe that failing to lock will
> be the only special kind of failure to be of interest to the users.
>
> I would think the "fix" should look more like this:
>
>  	read_cache_preload(NULL);
> 	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> - 		return -1;
> + 		return error(_("failed to refresh the index"));
>
> That is, tell the function that the caller will do the error
> reporting (i.e. "QUIET") and do so.
>
> Thanks.

We shouldn't be doing that because we won't get an error that's as
meaningful as what we'll get from unable_to_lock_message().

I think the patch as-is is taking the right approach. It would be nice
to see a re-indentation of the argument list, and perhaps we should
provide another macro name for this one caller, but those are all nits.

The "quiet" here is orthagonal, it's to disable the chatty output from
read-cache.c.
