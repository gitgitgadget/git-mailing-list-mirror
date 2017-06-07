Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7EB1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 18:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbdFGSaL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 14:30:11 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35417 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdFGSaL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 14:30:11 -0400
Received: by mail-pg0-f47.google.com with SMTP id k71so7966814pgd.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AVx3+zTsgz/+gp6BGd0SYk1nqGOm+IhirkmLfqBRrJc=;
        b=R4mya4t4vVCsBU3akKRkt2/q7UD2Yo4A1O2Wnzb1ypMszRcgzhI7FcIOodbUWgXJEO
         PB52vhI28m+5zG4yWtAU19Uel7pt3ea1g0XTGAgpiE5cZrlyMD140qsZwOBuWrleWdal
         4mW/711wWv2MnawEDie4L13oETvZTch2hply0+ZRFPUn4Ahmjcqzgfw7+zGnbfU7+bfE
         VfNgIvrI7tXTmF6ZH9AMxxFw6vlkYOP7GZsBB8FupVzdPgAODK9wLvBA2vXmmVkFub60
         YYzWXMyw97yrk35jQAnefXWNKqdyhnsAq1IFigqSWiRQjhoezAQjxrXpHtYXEjtyRBui
         5uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVx3+zTsgz/+gp6BGd0SYk1nqGOm+IhirkmLfqBRrJc=;
        b=MHZ7lvgLU/AdZag+69YWXZeUGhUurNG0U5//BFwkZCb3f2DttUk+VbDr9quV+lfIuK
         m3ztd6P0mo2AMrQwkmYbddHOkyso2cHISs2u4KL8nxBQk9vC5/C9be8QcsqsEN+9zCn6
         CPpHxa9A3mOMrvNNVJGkMh02881hv8Pm2MNsD+jYoZi1d0hmtfH2BE3DtbtSJjJOWV2V
         u7scLN9VUiN+XvyOeSlvQeaQ6P6zerVG6xRyAwJcGQd64O80U+IskXE9cEq6fw8mYZyU
         EPGbJIRymKEUqbOomaMKkpARmwxx+/wfFyt6UUNYwdqXqdsF1zlsvFQCHV/xtkt2fAEe
         hzlw==
X-Gm-Message-State: AODbwcCctSRZebQMq4Ka6UxrixdONXXk811IMl1mp4684yMimj73pxaa
        IwHtli+JM65TL22y
X-Received: by 10.98.37.68 with SMTP id l65mr33397503pfl.175.1496860210121;
        Wed, 07 Jun 2017 11:30:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:793b:8a31:813b:ceb2])
        by smtp.gmail.com with ESMTPSA id c67sm5533826pfe.37.2017.06.07.11.30.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 11:30:09 -0700 (PDT)
Date:   Wed, 7 Jun 2017 11:30:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Avoid problem where git_dir is set after alias
 expansion
Message-ID: <20170607183008.GG110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07, Johannes Schindelin wrote:
> When expanding an alias in a subdirectory, we setup the git_dir
> (gently), read the config, and then restore the "env" (e.g. the current
> working directory) so that the command specified by the alias can run
> correctly.
> 
> What we failed to reset was the git_dir, meaning that in the most common
> case, it was now pointing to a .git/ directory *in the subdirectory*.
> 
> This problem was identified in the GVFS fork, where a pre-command hook
> was introduced to allow pre-fetching missing blobs.
> 
> An early quick fix in the GVFS fork simply built on top of the
> save_env_before_alias() hack, introducing another hack that saves the
> git_dir and restores it after an alias is expanded:
> 
> 	https://github.com/Microsoft/git/commit/2d859ba3b
> 
> That is very hacky, though, and it is much better (although much more
> involved, too) to fix this "properly", i.e. by replacing the ugly
> save/restore logic by simply using the early config code path.
> 
> However, aliases are strange beasts.
> 
> When an alias refers to a single Git command (originally the sole
> intention of aliases), the current working directory is restored to what
> it had been before expanding the alias.
> 
> But when an alias starts with an exclamation point, i.e. referring to a
> command-line to be interpreted by the shell, the current working
> directory is no longer in the subdirectory but instead in the worktree's
> top-level directory.
> 
> This is even true for worktrees added by `git worktree add`.
> 
> But when we are inside the .git/ directory, the current working
> directory is *restored* to the subdirectory inside the .git/ directory.
> 
> In short, the logic is a bit complicated what is the expected current
> working directory after expanding an alias and before actually running
> it.
> 
> That is why this patch series had to expand the signature of the early
> config machinery to return the additional information for aliases'
> benefit.
> 

Looks good, I don't have any major issues with the series, just some
comments for clarity mostly.  And relevant to this series, you may be
interested in looking at patch 03/31 in my repository object series as
that may have an impact on the early config stuff.

> 
> Johannes Schindelin (9):
>   discover_git_directory(): avoid setting invalid git_dir
>   config: report correct line number upon error
>   help: use early config when autocorrecting aliases
>   read_early_config(): optionally return the worktree's top-level
>     directory
>   t1308: relax the test verifying that empty alias values are disallowed
>   t7006: demonstrate a problem with aliases in subdirectories
>   alias_lookup(): optionally return top-level directory
>   Use the early config machinery to expand aliases
>   TODO:
> 
>  alias.c                | 33 +++++++++++++++++++++-------
>  builtin/help.c         |  2 +-
>  cache.h                |  7 +++---
>  config.c               |  7 +++---
>  git.c                  | 59 ++++++--------------------------------------------
>  help.c                 |  2 +-
>  pager.c                |  4 ++--
>  setup.c                | 13 +++++++++--
>  t/helper/test-config.c |  2 +-
>  t/t1308-config-set.sh  |  4 +++-
>  t/t7006-pager.sh       | 11 ++++++++++
>  11 files changed, 70 insertions(+), 74 deletions(-)
> 
> 
> base-commit: 8d1b10321b20bd2a73a5b561cfc3cf2e8051b70b
> Published-As: https://github.com/dscho/git/releases/tag/alias-early-config-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git alias-early-config-v1
> -- 
> 2.13.0.windows.1.460.g13f583bedb5
> 

-- 
Brandon Williams
