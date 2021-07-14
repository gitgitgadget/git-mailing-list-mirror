Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F6AC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 07:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA39F60FDB
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 07:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbhGNHuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 03:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbhGNHuW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 03:50:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDFDC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 00:47:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hd33so1814218ejc.9
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=F0x+ffdUuXuyjbbS4oOqNfcAfLwW7sqRFeqHBWGQeO8=;
        b=uBDKZe3FYwgGVwuKeh0i2yGpKYl6RzPlw4rmnqf5+EdZjGMnHrEqPzn6uHQ9P+c8TB
         mQ1KzWwauGLxhuh9lY2iDe3Y3IJg74nZfkwoSjYTGsjJ1MlaMRMva2u4dDKd4DIl3nNN
         3oy2wxMP57lX/pEZQQ7bJL5WeuYZLZDzUa3kushLSg0BGcfKYsY2YuEGW1UgbebjOjI5
         vD+rRfP4EkOdsdPWswYi/uFZ3d89wLx1KhSRMRoSPsJ1wyWdFzIFpKmmG9PYOKbflAhL
         TOA5rCK8M5R0Aw+ZV4jJJaZqkr4hErrfGNw4KVhwrKejF7ZFP93S0V73GWGWr7Tmp/t1
         mZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=F0x+ffdUuXuyjbbS4oOqNfcAfLwW7sqRFeqHBWGQeO8=;
        b=BkaLkYEbUD0mlQAX9Fz8rcT9znheZ4fRjfeDjrmjAkFyeUyTOUxrz/Ja2MrOyUa6d6
         QWARR0Ghwe+QpBg/X1pR7Aa9wTJWDvRQR1DD0PTnavGLGx63JpCGtzAuTOT7hFwoXuql
         galeek2e25aqWYI7ijbOEEk59zCF6NT0Nud1vHWpNpU4KeIF7kg3TMODEZDKg5aCHKwt
         DwJqg5BpxIxxcIjgeiY6yhOtj+lyJz5k2uvUvGi7B5fkFXizUHm9atJWJ3sJQm8ARXnT
         oszZ7xmRqavqPrYEvbF9aXIPO4mtqGVifxAYW2OX+6rJY6oG6nMEuUMOtUg02dd4Ia5R
         DDeQ==
X-Gm-Message-State: AOAM530Q6dgqNMD2Ar4uehSoswTp4ZUFluVYByfUSt3cfManWkGxAaIS
        S/BXk0P9pQy/zfj2KoRLnCsjUiTvfwLB2+yc
X-Google-Smtp-Source: ABdhPJy7uCimUit3lW8dfqEvMrwcSPFT7+1I63r+1+3qNMWokU5XSBRiSosau3DmdFi0atGLSuGLcQ==
X-Received: by 2002:a17:906:1fd2:: with SMTP id e18mr10843728ejt.313.1626248849738;
        Wed, 14 Jul 2021 00:47:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w21sm562697edc.95.2021.07.14.00.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 00:47:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] doc: clarify documentation for rename/copy limits
Date:   Wed, 14 Jul 2021 09:37:58 +0200
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
 <4046993a9a2af79029c1ce94d20616831e94d786.1626225154.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <4046993a9a2af79029c1ce94d20616831e94d786.1626225154.git.gitgitgadget@gmail.com>
Message-ID: <87tukx1gmi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> A few places in the docs implied that rename/copy detection is always
> quadratic or that all (unpaired) files were involved in the quadratic
> portion of rename/copy detection.  The following two commits each
> introduced an exception to this:
>
>     9027f53cb505 (Do linear-time/space rename logic for exact renames,
>                   2007-10-25)
>     bd24aa2f97a0 (diffcore-rename: guide inexact rename detection based
>                   on basenames, 2021-02-14)
>
> (As a side note, for copy detection, the basename guided inexact rename
> detection is turned off and the exact renames will only result in
> sources (without the dests) being removed from the set of files used in
> quadratic detection.  So, for copy detection, the documentation was
> closer to correct.)
>
> Avoid implying that all files involved in rename/copy detection are
> subject to the full quadratic algorithm.  While at it, also note the
> default values for all these settings.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/config/diff.txt  |  7 ++++---
>  Documentation/config/merge.txt | 10 ++++++----
>  Documentation/diff-options.txt |  9 +++++----
>  3 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
> index 2d3331f55c2..e26a63d0d42 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -118,9 +118,10 @@ diff.orderFile::
>  	relative to the top of the working tree.
>  
>  diff.renameLimit::
> -	The number of files to consider when performing the copy/rename
> -	detection; equivalent to the 'git diff' option `-l`. This setting
> -	has no effect if rename detection is turned off.
> +	The number of files to consider in the exhaustive portion of
> +	copy/rename detection; equivalent to the 'git diff' option
> +	`-l`.  If not set, the default value is 400.  This setting has
> +	no effect if rename detection is turned off.

For both this...

>  diff.renames::
>  	Whether and how Git detects renames.  If set to "false",
> diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
> index 6b66c83eabe..aca0c92dbe6 100644
> --- a/Documentation/config/merge.txt
> +++ b/Documentation/config/merge.txt
> @@ -33,10 +33,12 @@ merge.verifySignatures::
>  include::fmt-merge-msg.txt[]
>  
>  merge.renameLimit::
> -	The number of files to consider when performing rename detection
> -	during a merge; if not specified, defaults to the value of
> -	diff.renameLimit. This setting has no effect if rename detection
> -	is turned off.
> +	The number of files to consider in the exhaustive portion of
> +	rename detection during a merge.  If not specified, defaults
> +	to the value of diff.renameLimit.  If neither
> +	merge.renameLimit nor diff.renameLimit are specified, defaults
> +	to 1000.  This setting has no effect if rename detection is
> +	turned off.

...and this we should really have some wording to the effect of:

    ..., defaults to XYZ. The exact (or even approximate) default of XYZ
    should not be relied upon, and may be changed (or these limits even
    removed) in future versions of git.

I.e. let's distinguish a "this is how it works now, FYI" from a forward
promise that it's going to work like that forever.

Which also leads me to:

>  merge.renames::
>  	Whether Git detects renames.  If set to "false", rename detection
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 32e6dee5ac3..11e08c3fd36 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -588,11 +588,12 @@ When used together with `-B`, omit also the preimage in the deletion part
>  of a delete/create pair.
>  
>  -l<num>::
> -	The `-M` and `-C` options require O(n^2) processing time where n
> -	is the number of potential rename/copy targets.  This
> -	option prevents rename/copy detection from running if
> +	The `-M` and `-C` options have an exhaustive portion that
> +	requires O(n^2) processing time where n is the number of
> +	potential rename/copy targets.  This option prevents the
> +	exhaustive portion of rename/copy detection from running if
>  	the number of rename/copy targets exceeds the specified
> -	number.
> +	number.  Defaults to diff.renameLimit.

This mention of O(n^2). This is not an issue with your patch/series, nd
this is an improvement.

But as a side-comment: Do we explain somewhere how exactly this
{diff,merge}.renmeLimit=N works for values of N? It's probably fine to
continue to handwave it away, but is there anything that say tells a
user what happens if they have 400 files in their repository in a "x"
directory and "git mv x y"? Will it work, but if they add a 401th file
it won't for diffs?

I *think* given a skimming of previous discussions that it's "no",
i.e. that this just kicks in for these expensive cases, and e.g. for
such a case of moving the same tree OID from "x" to "y" we'd
short-circuit things, but maybe I'm just making things up at this point.

Feel free to ignore me here, I guess this amounts to a request that it
would be great if we could point to some docs about how this works. It's
probably too much detail for Documentation/config/{merge,diff}.txt, so
maybe a section in either of git-{diff,merge}.txt ?
