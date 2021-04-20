Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF73C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 01:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11B0613AC
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 01:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhDTBqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 21:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhDTBqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 21:46:19 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8888C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 18:45:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a18so3896195qtj.10
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 18:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=repRylwPIoeIsxZyqRm0Dv+BguHYLlMn/FUCdGtxFqE=;
        b=Nr+gQge0b4kcPg+hCnuqsvMRWjnzdF9NW/prAvbhZ3G3pFI0p96ceS73pFm44AQoAW
         hgyf+L+1ZDFNIXe70R/P68N2bgQAlOd/LowzfURkmd7mavg8iqJXV9qSxcAYYHBs5sHg
         Ing3Q2RFYVa31q5gfk83ize0dI94tO7jU9YxHLvlhq7AMzGjrO6t8FGIZglKvYccl2yh
         e/U4XYcMXguwfuotNCLCjgxvyrCTyxYaZDlnDSckfJTCtNiZfjO5X8cIW1s1qynLO16i
         Zi5OIeAyygrJ57OomU0fkjzrUvZWhUd2WUZUEv2q60z/IQCloC1qIVzCxtyOKClj6Fvq
         DHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=repRylwPIoeIsxZyqRm0Dv+BguHYLlMn/FUCdGtxFqE=;
        b=QSfblUhVG3rNSEuFm8S+LXGZiP0Oicbt4/x+EihjZxDfaETkp64g7FPXuaeNvHQ8qh
         eSznksgjO9Gs4o6zaWVnQxhp+jKRL/YlkUUa1D/rQy3zGsHC+HeK4zl9xE4wiFjHQnvP
         kRe74st19d4ZtBbyeVxr4PQjScYX7AX1ufKalw7PHvpc/OKC0HNhi38lygzrbct9FV6W
         mokE8bifqbVRbPzEW0Ot95Hyu8Gls0zeUOVi377fU8fek6+4fCCahLKlyHbltgV42RzD
         IYkQYAx+m57TTx34SPra2YXgXZQYJJAKB9PMa0UIwMoq1Z07xmm5mLNaKH+4Vk+96FTt
         w7cg==
X-Gm-Message-State: AOAM530ZNBE3BMwBaSgUWlQe71zkK62lD1hCxrIY4mac2eR09TqMW2Kz
        Uh/xrKDhUBrAwg5GugWUb610Cg==
X-Google-Smtp-Source: ABdhPJw8R2W2lR+HDgOqZTYShi2IGw3YxIVLTo1IroLtVc9bzCV4VUh+94OyiIXjTE9PgPacMwKXgQ==
X-Received: by 2002:a05:622a:46:: with SMTP id y6mr13904849qtw.44.1618883147996;
        Mon, 19 Apr 2021 18:45:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:6e34:2cc5:33ff:681d])
        by smtp.gmail.com with ESMTPSA id h62sm11200761qkf.116.2021.04.19.18.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 18:45:47 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Mon, 19 Apr 2021 21:45:46 -0400
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] fast-export, fast-import: implement signed-commits
Message-ID: <YH4yN2OAghWB9/97@nand.local>
References: <20210419225441.3139048-1-lukeshu@lukeshu.com>
 <20210419225441.3139048-4-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419225441.3139048-4-lukeshu@lukeshu.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 04:54:41PM -0600, Luke Shumaker wrote:
> From: Luke Shumaker <lukeshu@datawire.io>
>
> fast-export has an existing --signed-tags= flag that controls how to
> handle tag signatures.  However, there is no equivalent for commit
> signatures; it just silently strips the signature out of the commit
> (analogously to --signed-tags=strip).
>
> While signatures are generally problematic for fast-export/fast-import
> (because hashes are likely to change), if they're going to support tag
> signatures, there's no reason to not also support commit signatures.
>
> So, implement signed-commits.
>
> On the fast-export side, try to be as much like signed-tags as possible,
> in both implementation and in user-interface; with the exception that
> the default should be `--signed-commits=strip` (compared to the default
> `--signed-tags=abort`), in order to continue defaulting to the
> historical behavior.  Only bother implementing "gpgsig", not
> "gpgsig-sha256"; the existing signed-tag support doesn't implement
> "gpgsig-sha256" either.
>
> On the fast-import side, I'm not entirely sure that I got the ordering
> correct between "gpgsig" and "encoding" when generating the commit
> object.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
>  Documentation/git-fast-export.txt | 12 +++++
>  Documentation/git-fast-import.txt |  7 +++
>  builtin/fast-export.c             | 86 +++++++++++++++++++++++++------
>  builtin/fast-import.c             | 15 ++++++
>  t/t9350-fast-export.sh            | 70 +++++++++++++++++++++++++
>  5 files changed, 174 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> index d4a2bfe037..6fdb678b54 100644
> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -39,6 +39,18 @@ warning will be displayed, with 'verbatim', they will be silently
>  exported and with 'warn-verbatim', they will be exported, but you will
>  see a warning.
>
> +--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
> +	Specify how to handle signed commits.  Since any transformation
> +	after the export can change the commit (which can also happen
> +	when excluding revisions) the signatures will not match.
> ++
> +When asking to 'abort', this program will die when encountering a
> +signed commit.  With 'strip' (which is the default), the commits will
> +silently be made unsigned, with 'warn-strip' they will be made
> +unsigned but a warning will be displayed, with 'verbatim', they will
> +be silently exported and with 'warn-verbatim', they will be exported,
> +but you will see a warning.
> +

OK, this all seems normal to me. But it may be worth shortening it to
say "behaves exactly as --signed-tags, but for commits", or something.

>  --tag-of-filtered-object=(abort|drop|rewrite)::
>  	Specify how to handle tags whose tagged object is filtered out.
>  	Since revisions and files to export can be limited by path,
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 458af0a2d6..3d0c5dbf7d 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -437,6 +437,7 @@ change to the project.
>  	original-oid?
>  	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
>  	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
> +	('gpgsig' LF data)?

Is this missing a LF after data?

> +static const char *find_signature(const char *begin, const char *end)
> +{
> +	const char *needle = "\ngpgsig ";
> +	char *bod, *eod, *eol;
> +
> +	bod = memmem(begin, end ? end - begin : strlen(begin),
> +		     needle, strlen(needle));
> +	if (!bod)
> +		return NULL;
> +	bod += strlen(needle);
> +	eod = strchrnul(bod, '\n');
> +	while (eod[0] == '\n' && eod[1] == ' ') {
> +		eod = strchrnul(eod+1, '\n');
> +	}
> +	*eod = '\0';
> +
> +	while ((eol = strstr(bod, "\n ")))
> +		memmove(eol+1, eol+2, strlen(eol+1));

Hmm. I'm not quite sure I follow these last two lines. Perhaps a comment
would help? The rest of this patch looks reasonable to me.

Thanks,
Taylor
