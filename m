Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7C2C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 01:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E992173E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 01:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYVQH33p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfLFBXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:23:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40574 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFBXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 20:23:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so2455114pfh.7
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 17:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w+sMcBSuynazz0YrTQrHKtdXwsmNladIf0+1qvZJF4c=;
        b=IYVQH33pHOwEktUWlwzlD2LnZ/Zc7x1QrSunVKatT3YAN92l/LQHc2DxHzEeQ8GFcB
         1oh/L3sJMwLeCDtHYkDorFBobA6ruVqs0I/rP/3s0PMMfP5b+KkKmFZay2WkKBbsRWza
         ugm+w9Bs7RzBN9w24jfmhnEdRkHb2Ay4pVCHsAlepE299qR9IZ7yTzgcKm6OpDXOgK+1
         ldiOQRHOVFl5e+QVs/zDSqsGIRt5cVqpn8PWZCl/J0aAWH0Ztp0iLMYjE5Pu5zzCP0Nf
         1lLQnQERPDDNrqFZQ/etUo1qQmq5WzOO2wLCriqG2wEppSfCr/2aRMJu6GfhvyMVQgTH
         rxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+sMcBSuynazz0YrTQrHKtdXwsmNladIf0+1qvZJF4c=;
        b=jJTWw98mDAiFvrSgVL1123k4/RTsIezmlc7BhunPvQx5mjxXceN8SR27oovEs6A8VF
         bCu4z9HKRctNyFHAplHKypRBHVzoQs5s+svrP77p6TS2sPM2LMe1gfbar7zoeYwiK4tT
         OWEc+y1h/JlIB7Rlj6Oh7z008QJ/GLmevjJfs8FzPlMIINxQVJ9BpKzwMfRVlvkOEIAb
         yH5HE0UVlXISsT+DaQ8x0uRgiZx3XBQ08Q7gGOBG387lhvt8Bje9jfssPmNE+Q1VGVvN
         8nHT3sdhBqYZbY3TGGAXfltRDvR6fsOyFbtKaG9I8dfaGCqP6wCjPaEbyjxWeUUbGDlJ
         pTQQ==
X-Gm-Message-State: APjAAAVuCh8KI3lwEdbhlMivI9LYAcFjThtMOsFO5KMGrFMsy+oG3+XH
        F8K2fvHs75Cl5W1iye5JHE8=
X-Google-Smtp-Source: APXvYqwV1/3FTEKFN/8CqkCAQ5YLmIXNAriSKaYkS+Iha+Kp1vrz6ia7AS+BhTscaR4Tby/xV/Q0jA==
X-Received: by 2002:a63:1418:: with SMTP id u24mr636798pgl.279.1575595393052;
        Thu, 05 Dec 2019 17:23:13 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id z19sm12841432pfn.49.2019.12.05.17.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 17:23:12 -0800 (PST)
Date:   Thu, 5 Dec 2019 17:23:35 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Alex Torok <alext9@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rebase: refactor dwim_ref_or_die from merge-base.c
Message-ID: <20191206012335.GA16183@generichostname>
References: <20191205225322.5529-1-alext9@gmail.com>
 <20191205235704.31385-1-alext9@gmail.com>
 <20191205235704.31385-2-alext9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205235704.31385-2-alext9@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

Thanks for the contribution.

On Thu, Dec 05, 2019 at 06:57:03PM -0500, Alex Torok wrote:
> Pull logic for getting the full dwim ref name from a passed in ref name
> out of the handle_fork_point function of merge-base.c. This will allow
> git-rebase --fork-point to use the same method for getting the full ref
> name before calling get_fork_point.
> 

The remaining paragraphs shouldn't end up going into the commit message
since they're more like "notes to reviewers". You should place these
notes under the `---` below so that they won't end up in the final
commit message.

> I saw other *_or_die methods in other places and using that pattern
> seemed sane here.
> 
> I'm not 100% sure about the name or signature of dwim_ref_or_die. I feel
> like it should be named something like dwim_ref_name_or_die,
> unique_dwim_ref_or_die, or should be including the object_id argument
> even though it isn't used by the calling merge_base code, and won't be
> used in rebase.
> 
> This is my first patch submission for git, and I'd appreciate some
> feedback on naming/style wrt to this.
> 
> Signed-off-by: Alex Torok <alext9@gmail.com>
> ---
>  builtin/merge-base.c |  9 +--------
>  refs.c               | 14 ++++++++++++++
>  refs.h               |  1 +
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index e3f8da13b6..edd16f9fcd 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -118,14 +118,7 @@ static int handle_fork_point(int argc, const char **argv)
>  	struct commit *derived, *fork_point;
>  	const char *commitname;
>  
> -	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
> -	case 0:
> -		die("No such ref: '%s'", argv[0]);
> -	case 1:
> -		break; /* good */
> -	default:
> -		die("Ambiguous refname: '%s'", argv[0]);
> -	}
> +	dwim_ref_or_die(argv[0], strlen(argv[0]), &refname);
>  
>  	commitname = (argc == 2) ? argv[1] : "HEAD";
>  	if (get_oid(commitname, &oid))
> diff --git a/refs.c b/refs.c
> index 1ab0bb54d3..3b778f2df9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -639,6 +639,20 @@ int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
>  	return repo_dwim_ref(the_repository, str, len, oid, ref);
>  }
>  
> +void dwim_ref_or_die(const char *str, int len, char **ref)
> +{
> +	struct object_id discard;
> +	switch (dwim_ref(str, len, &discard, ref)) {
> +	case 0:
> +		die("No such ref: '%s'", str);

I see that this code is copied so I'm fine with leaving it as is. But if
you need to do any rerolls, it would be nice to, as a prepatory step,
introduce a patch which 1. marks these strings for translation and 2.
lowercases the first letter of the sentence which is the convention for
messages that are seen by the end-user.

Perhaps:

	die(_("no such ref: '%s'"), str);

> +	case 1:
> +		break; /* good */
> +	default:
> +		die("Ambiguous refname: '%s'", str);

Same comment here.

Thanks,

Denton

> +	}
> +}
> +
> +
>  int expand_ref(struct repository *repo, const char *str, int len,
>  	       struct object_id *oid, char **ref)
>  {
> diff --git a/refs.h b/refs.h
> index 730d05ad91..a961662382 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -154,6 +154,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
>  int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
>  int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
>  
> +void dwim_ref_or_die(const char *str, int len, char **ref);
>  /*
>   * A ref_transaction represents a collection of reference updates that
>   * should succeed or fail together.
> -- 
> 2.17.1
> 
