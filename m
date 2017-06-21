Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 091DD20401
	for <e@80x24.org>; Wed, 21 Jun 2017 16:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbdFUQjR (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 12:39:17 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35083 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbdFUQjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 12:39:15 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so27171138pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MLW2LbIaMnRNeumbisAwWhRz54bq5qqp4K0DWXZfUPM=;
        b=jhX4srE/h+TpP0Y/wbg4UmhDxOxfNvN3/Nw51pYdQvvK96Z9/eGK3Xp8de1bAWAsTu
         2bv4L9mkxAdpg1Ac+8G1WbnKs5w9OJnVC/ILKO7yVAYtR9sGpdHXj1Im02CQk99BzSx2
         +moReVWMVLtJmPYo9YJwrOAYzzz/HxHOyyzM5IKedGCPGMYe8pwVB6969AZCJBQGCDFW
         yrf+kAsI8/N+meRD+0SfcLHVxuNR8cWkSM7d238AIR7mYF/VCDGrERSALKAocaGEnDQw
         HL7tK2rQBhl8jCWF+PhBtNMwiqcAq54xr8q9NBiL1pW23/S+o2FMILzrq0vlc2FjaNrf
         ebcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLW2LbIaMnRNeumbisAwWhRz54bq5qqp4K0DWXZfUPM=;
        b=QnUtU50Oz85aIdscV2a/hDNAiT7aoHylvfo/8GMz+DpNc1U/1yKBHHiIQV1jUKAicy
         JTBcpTojuDOQVBlnFTTIJhkdp5I6TJwfRMGAh93q/EyTGV2BRPFUWL3iF1Ab7+7b3aKP
         Nh8v9Hh7PYcA66CKeeUfMcSqBuv+EZRMQwL4B3P+vEAjusm5RqVbNyq+CAiPgH0Z+kie
         7Q6Q5Dno26Ji4KHH6PMW68XeQ42o/7u5eoQXBARhC95qJn1WOvTKabb9ZS6GsjCpfEUD
         CXWMQkQVuyXvBuhOsnplUsLRC/WoxMjWDdDDwx1gffz1HUXXTyqo7GNqX3SDg/VOd71g
         3zFA==
X-Gm-Message-State: AKS2vOzuEvHdCje0cLlrSt+XuAj7QxxZqDFqmg91Rx9HtjPJCtmKwDqA
        bNN7QbWj4YCtNCrwBCe5dA==
X-Received: by 10.84.195.1 with SMTP id i1mr42556288pld.120.1498059813436;
        Wed, 21 Jun 2017 08:43:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:d052:1af5:b2b3:bc81])
        by smtp.gmail.com with ESMTPSA id p90sm29754173pfj.8.2017.06.21.08.43.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 08:43:32 -0700 (PDT)
Date:   Wed, 21 Jun 2017 08:43:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 11/20] path: construct correct path to a worktree's
 index
Message-ID: <20170621154330.GA53348@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-12-bmwill@google.com>
 <20170621021024.GC60603@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170621021024.GC60603@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/20, Jonathan Nieder wrote:
> Hi again,
> 
> Brandon Williams wrote:
> 
> > When working with worktrees the git directory is split into two part,
> > the per-worktree gitdir and a commondir which contains things which are
> > shared among all worktrees (like the object store).  With this notion of
> > having a split git directory, 557bd833b (git_path(): be aware of file
> > relocation in $GIT_DIR) and c7b3a3d2f ($GIT_COMMON_DIR: a new
> > environment variable) changed the way that 'git_path()' functioned so
> > that paths would be adjusted if they referred to files or directories
> > that are stored in the commondir or have been changed via an environment
> > variable.
> >
> > One interesting problem with this is the index file as it is not shared
> > across worktrees yet when asking for a path to a specific worktree's
> > index it will be replaced with a path to the current worktree's index.
> > In order to prevent this, teach 'adjuct_git_path' to replace the
> > path to the index with the path recorded in a repository (which would be
> > the current, active worktree) only when not asked to construct a path
> > for a specific worktree.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  path.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Digging more into it with your help, I ran into v2.5.0-rc0~143^2~34
> and v2.11.0-rc0~15^2 (git-svn: "git worktree" awareness, 2016-10-14),
> which uses this function:
> 
>  -	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
>  +	my $index = command_oneline(qw(rev-parse --git-path index));
> 
> That rules out my hope of making git_path stop being aware of the index
> at all.
> 
> That also made it a little clearer to me what is going on with this
> function.  I had previously misread !wt as meaning that git_dir is
> not under worktrees/ (or in other words as !wt->id).  Instead, it
> means that the caller does not want to use some other work tree in
> preference to git_dir.
> 
> With that piece in place, the patch starts making more sense to me.
> When !wt, repo->index_file is going to have the same value as
> getenv("GIT_INDEX_FILE") ?: buf->buf already, since repo->index_file
> refers to the current work tree git dir's index file.  When wt != NULL,
> we don't want to use that file and have requested to grab the index
> from a specific work tree git dir instead.
> 
> And patch 05/20 (environment: place key repository state in
> the_repository) had no effect since no one calls worktree_git_path
> with argument "index", nor with a user-specified path.
> 
> How about the following?  I found it a little easier to understand.

So your suggestion is to completely avoid doing any location when asking
for a worktree_git_path, I guess those code paths which request those
paths should be aware enough that if they need something in commondir to
use git_common_path instead.  My only worry is that it may be difficult
to catch misuse of worktree_git_path during code review, at least that
was one of the motivating factors for originally respecting
GIT_INDEX_FILE and the like.

> 
> -- >8 --
> From: Brandon Williams <bmwill@google.com>
> Subject: worktree_git_path: do not let GIT_INDEX_FILE override path to index
> 
> git_path (and variants like strbuf_git_path) is designed to behave
> like a convenience function that produces a string $GIT_DIR/<path>.
> In the process, callers automatically get support for path relocation
> variables like $GIT_OBJECT_DIRECTORY:
> 
> - git_path("index") is $GIT_INDEX_FILE when set
> - git_path("info/grafts") is $GIT_GRAFTS_FILE when set
> - git_path("objects/<foo>") is $GIT_OBJECT_DIRECTORY/<foo> when set
> - git_path("hooks/<foo>") is <foo> under core.hookspath when set
> - git_path("refs/<foo>") etc (see path.c::common_list) is relative
>   to $GIT_COMMON_DIR instead of $GIT_DIR
> 
> worktree_git_path, by comparison, is designed to resolve files in a
> specific worktree's git dir and should not perform such relocation.
> Do so by skipping the relocation step in worktree_git_path.
> 
> Fortunately no current callers of worktree_git_path pass such
> arguments.  Noticed due to an interaction between two patches under
> review, one of which introduced such a caller:
> 
> * One made "git prune" check the index file in each worktree's git dir
>   (using worktree_git_path(wt, "index")) for objects not to prune,
>   triggering the unwanted relocation code by mistake and allowing
>   objects reachable from worktree indices to be pruned if
>   GIT_INDEX_FILE is set.
> 
> * The other simplified the relocation logic for index, info/grafts,
>   objects, and hooks to happen unconditionally instead of based on
>   whether environment or configuration variables are set, causing the
>   relocation to trigger even when GIT_INDEX_FILE is not set.
> 
> [jn: rewrote commit message; skipped all relocations instead of just
>  the index]
> 
> Change-Id: I2ba0a48a48b7e9a9c2e3ef97648cf53cb913bdd9
> Signed-off-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  path.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/path.c b/path.c
> index c1cb1cf62..4c3a27a8e 100644
> --- a/path.c
> +++ b/path.c
> @@ -397,7 +397,8 @@ static void do_git_path(const struct worktree *wt, struct strbuf *buf,
>  		strbuf_addch(buf, '/');
>  	gitdir_len = buf->len;
>  	strbuf_vaddf(buf, fmt, args);
> -	adjust_git_path(buf, gitdir_len);
> +	if (!wt)
> +		adjust_git_path(buf, gitdir_len);
>  	strbuf_cleanup_path(buf);
>  }
>  
> -- 
> 2.13.1.611.g7e3b11ae1
> 

-- 
Brandon Williams
