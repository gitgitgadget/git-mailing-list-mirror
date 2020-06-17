Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB920C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 14:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1EEF20890
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 14:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR5CVgiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQOux (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQOux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 10:50:53 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC14C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 07:50:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g18so1671746qtu.13
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uHFTpM9jlu9lxhkWr7h55Hx4vfzeiWlml9Z757XzBwk=;
        b=BR5CVgiFwS45WUsy5RwglQrU+6HoV4pClsLC6s7gt6WtEBlIDWXzATdMTyosJZN1vm
         65Z3StmEplDO5nQJVGDTZKKSz7l4Zq7kdjQWzm53ycTc8hu0Fgo8jldqcpiY2Gb1OLWL
         oCL133KVWR2aA4FktXAgWjKnhYWZE72INmm9uYYaOv9+gGSVWKDXpdDOhvC6hsRi/WXg
         p6TEjzYj0xlOWbj80Pia0C+iUoxqiAH6nJ8qYDdioK1rwyi2druKHzOL6Z8pB1r+NVbO
         bfsfaXPQQgRHYh1dmtEojGwN0VNM0fXPsBLZOQv3tiHYAdRBPWVBC66clbDvPgsJSKUP
         5mLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHFTpM9jlu9lxhkWr7h55Hx4vfzeiWlml9Z757XzBwk=;
        b=hhskLe5KZiA/dm3TNlAOLpiXSt1zNVv4XYr6mcah5GaZYfH04kn9iibuRfIrmqoThs
         NDxtVexpo57E2XXsc+bc8xl+d185lak0QrLAvKad741geKo7Fms25te/Kzj/qulnhQpJ
         O4psGQXGfsnS4TnO1buX668jFPD68fgWdb0SNu6PIbB22fUdPCDNy64wwJ6D8vCvdS7F
         NRagEWDVokOa6SjunfKYzil/m7kHUIr3tgnBq020+L6bCBdHgvIgwjSrb35CqqLT/tku
         WNH5D0VGHoqXqJYWJ6Cx2wAdOTZef2h5Kfu4IHtRzfbv6W+gd9skOEs//DpejS+bBrEP
         pupA==
X-Gm-Message-State: AOAM5319h1IVPd/ClMzAxWANtrGdI5fWupcOFNWTyLYH1Wz37ird2n0B
        cQncMyTphth+FTmYmvROg1ASOnrB5lU=
X-Google-Smtp-Source: ABdhPJyN8QjJ2tVPUfdG0/b+91Z1wrZiD0ljaP1vfGOXhkm1gZ5bQM4p4yCFWoMxfE3sabQFJwQuZg==
X-Received: by 2002:ac8:16b7:: with SMTP id r52mr1161557qtj.14.1592405450817;
        Wed, 17 Jun 2020 07:50:50 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z20sm47807qtn.93.2020.06.17.07.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 07:50:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] [RFC] wt-status: show sparse checkout status as well
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     dstolee@microsoft.com, Elijah Newren <newren@gmail.com>
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
 <462cee857ef30c413eda0abe655b123f32b3877e.1592350413.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e8e59662-7e8b-6aae-da28-c4b5ee225ac8@gmail.com>
Date:   Wed, 17 Jun 2020 10:50:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <462cee857ef30c413eda0abe655b123f32b3877e.1592350413.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/16/2020 7:33 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Some of the early feedback of folks trying out sparse-checkouts at
> $dayjob is that sparse checkouts can sometimes be disorienting; users
> can forget that they had a sparse-checkout and then wonder where files
> went.  Add some output to 'git status' in the form of a simple line that
> states:
> 
>     You are in a sparse checkout with 35% of files present.

I like this idea.

Aside: I think there was some ideas around a "git sparse-checkout stats"
subcommand that would help users identify how large their sparse-checkout
definition is compared to the full index. That would also want to drill
down into directories, so it would need to be more advanced than what you
have here.

There is some prior work in the "gvfs health" commmand in VFS for Git.
We use this to help users self-diagnose when they have "over hydrated"
their working directory. Here is a sample use:

  /c/_git/t/ForTests/src (master)
  $ gvfs health
  
  Gathering repository data...
  
  Health of directory:
  Total files in HEAD commit:           548 | 100%
  Files managed by VFS for Git (fast):   30 |   5%
  Files managed by Git:                   1 |   0%
  
  Total hydration percentage:                   6%
  
  Most hydrated top level directories:
   19 / 524 | GVFS
    0 / 8   | GitHooksLoader
    0 / 3   | Scripts
  
  Repository status: OK
  
  /c/_git/t/ForTests/src (master)
  $ cd GVFS
  
  /c/_git/t/ForTests/src/GVFS (master)
  $ gvfs health
  
  Gathering repository data...
  
  Health of directory: GVFS/
  Total files in HEAD commit:           524 | 100%
  Files managed by VFS for Git (fast):   19 |   4%
  Files managed by Git:                   0 |   0%
  
  Total hydration percentage:                   4%
  
  Most hydrated top level directories:
   0 / 33 | FastFetch
   0 / 92 | GVFS.Common
   0 / 97 | GVFS.FunctionalTests
   0 / 22 | GVFS.GVFlt
   0 / 7  | GVFS.Hooks
  
  Repository status: OK

This is just a reference for something that has been helpful
for some users. In VFS for Git, the hydration is not explicit
but instead implicit by filesystem use. There could still be
some value in the sparse-checkout case.

> where, obviously, the exact figure changes depending on what percentage
> of files from the index do not have the SKIP_WORKTREE bit set.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  wt-status.c | 35 +++++++++++++++++++++++++++++++++++
>  wt-status.h |  1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/wt-status.c b/wt-status.c
> index 98dfa6f73f9..687d2ab1ba1 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1484,6 +1484,16 @@ static void show_bisect_in_progress(struct wt_status *s,
>  	wt_longstatus_print_trailer(s);
>  }
>  
> +static void show_sparse_checkout_in_use(struct wt_status *s,
> +					const char *color)
> +{
> +	if (s->state.sparse_checkout_percentage != -1)
> +		status_printf_ln(s, color,
> +				 _("You are in a sparse checkout with %d%% of tracked files present."),
> +				 s->state.sparse_checkout_percentage);

There is some concern over breaking third-party tools that
parse "git status". However, we have had the machine-readable
formats out for a long time.

I briefly thought about putting this message to stderr to be
safe, but some tools scan stderr (incorrectly) to say "any
output to stderr must mean an error in the process."

> +	wt_longstatus_print_trailer(s);
> +}
> +
>  /*
>   * Extract branch information from rebase/bisect
>   */
> @@ -1623,6 +1633,27 @@ int wt_status_check_bisect(const struct worktree *wt,
>  	return 0;
>  }
>  
> +static void wt_status_check_sparse_checkout(struct repository *r,
> +					    struct wt_status_state *state)
> +{
> +	int skip_worktree = 0;
> +	int i;
> +
> +	if (!core_apply_sparse_checkout) {

Since this method is static, we can assume that it is only
called after the index was loaded, which requires reading
the config and initializing this value. Good.

> +		state->sparse_checkout_percentage = -1;
> +		return;
> +	}
> +
> +	for (i = 0; i < r->index->cache_nr; i++) {
> +		struct cache_entry *ce = r->index->cache[i];
> +		if (ce_skip_worktree(ce))
> +			skip_worktree++;
> +	}
> +
> +	state->sparse_checkout_percentage =
> +		100 - (100 * skip_worktree)/r->index->cache_nr;
> +}
> +
>  void wt_status_get_state(struct repository *r,
>  			 struct wt_status_state *state,
>  			 int get_detached_from)
> @@ -1658,6 +1689,7 @@ void wt_status_get_state(struct repository *r,
>  	}
>  	if (get_detached_from)
>  		wt_status_get_detached_from(r, state);
> +	wt_status_check_sparse_checkout(r, state);
>  }
>  
>  static void wt_longstatus_print_state(struct wt_status *s)
> @@ -1681,6 +1713,9 @@ static void wt_longstatus_print_state(struct wt_status *s)
>  		show_revert_in_progress(s, state_color);
>  	if (state->bisect_in_progress)
>  		show_bisect_in_progress(s, state_color);
> +
> +	if (state->sparse_checkout_percentage != -1)
> +		show_sparse_checkout_in_use(s, state_color);
>  }
>  
>  static void wt_longstatus_print(struct wt_status *s)
> diff --git a/wt-status.h b/wt-status.h
> index 73ab5d4da1c..4550004003a 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -90,6 +90,7 @@ struct wt_status_state {
>  	int bisect_in_progress;
>  	int revert_in_progress;
>  	int detached_at;
> +	int sparse_checkout_percentage; /* -1 == not in sparse checkout */

My only complaint is that maybe this "-1" should be a
#define macro with a name such as SPARSE_CHECKOUT_DISABLED.

Thanks,
-Stolee

