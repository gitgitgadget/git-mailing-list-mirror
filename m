Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680B1C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 11:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31862206A2
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 11:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWvrg3Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897925AbgDOLzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897909AbgDOLzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 07:55:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560ABC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 04:55:23 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so16826066qke.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lw0UA60z+5C/aBBEBlKwZ8qldOFvw4992xxCAnRXeOY=;
        b=EWvrg3Zt5yQGf1juUGJtN56Ylkt52/EcCFapNcaIsMOdEXH0vs561OKg9FL+Zwp5Zp
         7yUvW9oJ/t0GlaYt77wBBFcdJ5k7I/n0XLS3XlzxwwK4XNh0PCoIW9L0qPf2HO3y0Hfb
         dcM5bhaoAGZEFWDXYPumhQZJ1tuqujtynrLMMroUIxv0cBszsCkCo80GepQjTN0mOdTc
         cQhHK2uhF1olg0VvFP0N+Ms2nuA61ZExNWhK5oQO7Hm+UlLhEImOh10DubB0S7dQiweG
         gKZ3qZEpRz67c1I9ghh4C5hJNsvzpewd0iGQIB4rsZUv9nr0jvQtcZZk3TG6el07OeJn
         z8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lw0UA60z+5C/aBBEBlKwZ8qldOFvw4992xxCAnRXeOY=;
        b=E/y/bFkd8TJlqth1eMOggfoenJuhXpFoKIgUcOCewDqSvv+whbi0Aw5hHq2urBV/7s
         YMpw7SdOzfWOMBhVJ/RsKkLQ/lzsGECrbP6Wdr9FKi4XTi1m9s8S9XiaK+nVGQcvdXVN
         WN1rU8fdj1ZFeqSLV8MKTXRIsJntTYmjpmh5mBipDWOkz35+UtZ2GAH30z0kz4AdCGln
         ZBnj14X74+bzzw3rzroNLLCbv65ibPQRM3ChPYighWEOUSn+hpF4w52Lz5XMdkZ9i+po
         rI/y7W4xk+lJ97TgMAhzmWvlC8z4Oys8PQaxZKALCD/m2YwCrsIFxFWchbDK/ml0q81W
         z99A==
X-Gm-Message-State: AGi0Pua/7npIalooRh4Bo0vYoEtjzh9hdvdNrMPLpsJUggGQ2yUxf+JO
        /2q1vFUFMGrTxN4FB+hC3MtWZkOpBCQ=
X-Google-Smtp-Source: APiQypL4mXYvXbuf64n4/expmzWLGcn3XQI/GVClYmHJAEVQFGHs80/4F3BtPNzTRcJ2S8EpZkAxYw==
X-Received: by 2002:a05:620a:64f:: with SMTP id a15mr25896507qka.228.1586951722003;
        Wed, 15 Apr 2020 04:55:22 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m11sm12145061qkg.130.2020.04.15.04.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 04:55:21 -0700 (PDT)
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
 <aca12331-f8e3-28a2-acb6-df9d7e2e70e1@gmail.com>
 <20200414235057.GA6863@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cdc80c0b-696f-19b8-d132-592782537b03@gmail.com>
Date:   Wed, 15 Apr 2020 07:55:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200414235057.GA6863@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2020 7:50 PM, Taylor Blau wrote:
> On Tue, Apr 14, 2020 at 04:31:19PM -0400, Derrick Stolee wrote:
>> On 4/14/2020 4:22 PM, Elijah Newren wrote:
>>> Hi,
>>>
>>> I was building a version of git for internal use, and thought I'd try
>>> turning on features.experimental to get more testing of it.  The
>>> following test error in the testsuite scared me, though:
>>>
>>> t5537.9 (fetch --update-shallow):
>>>
>>> ...
>>> + git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
[snip]
>> Well, commit-graphs are not supposed to do anything if we have
>> shallow clones. We definitely don't load a commit-graph in that
>> case. Seems like we need an extra check in write_commit_graph()
>> to stop writing in the presence of shallow commits.

Here, I assumed that the commit-graph wasn't checking the shallow status
appropriately, but...

> This rang a bell to me, too. There's a bug, but it's due to the mutative
> side-effects of 'is_repository_shallow' along with '--update-shallow' (a
> normal 'git fetch' works fine here, with or without
> fetch.writeCommitGraph).

...this makes sense as to why this particular case failed.

(Please allow me this brief moment to communicate my extreme dislike
of shallow clones. There, I'm done.)
 
> Here's a patch that I didn't sign-off on that fixes the problem for me.
> 
> --- >8 ---
> 
> Subject: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
> 
> In bd0b42aed3 (fetch-pack: do not take shallow lock unnecessarily,
> 2019-01-10), the author noted that 'is_repository_shallow' produces
> visible side-effect(s) by setting 'is_shallow' and 'shallow_stat'.
> 
> This is a problem for e.g., fetching with '--update-shallow' in a
> shallow repsoitory with 'fetch.writeCommitGraph' enabled, since the

repository

> update to '.git/shallow' will cause Git to think that the repository
> *isn't* shallow when it is, thereby circumventing the commit-graph
> compatability check.

compatibility

> This causes problems in shallow repositories with at least shallow refs
> that have at least one ancestor (since the client won't have those
> object(s), and therefore can't take the reachability closure over
> commits to be written to the commit-graph).
> 
> Address this by introducing 'reset_repository_shallow()', and calling it
> when the shallow file is updated, forcing 'is_repository_shallow' to
> re-evaluate whether the repository is still shallow after fetching in
> the above scenario.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit.h     |  1 +
>  fetch-pack.c |  1 +
>  shallow.c    | 15 ++++++++-------
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/commit.h b/commit.h
> index 008a0fa4a0..ee1ba139d4 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -251,6 +251,7 @@ int register_shallow(struct repository *r, const struct object_id *oid);
>  int unregister_shallow(const struct object_id *oid);
>  int for_each_commit_graft(each_commit_graft_fn, void *);
>  int is_repository_shallow(struct repository *r);
> +void reset_repository_shallow(struct repository *r);
>  struct commit_list *get_shallow_commits(struct object_array *heads,
>  					int depth, int shallow_flag, int not_shallow_flag);
>  struct commit_list *get_shallow_commits_by_rev_list(
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 1734a573b0..051902ef6d 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1630,6 +1630,7 @@ static void update_shallow(struct fetch_pack_args *args,
>  		if (*alternate_shallow_file == '\0') { /* --unshallow */
>  			unlink_or_warn(git_path_shallow(the_repository));
>  			rollback_lock_file(&shallow_lock);
> +			reset_repository_shallow(the_repository);
>  		} else
>  			commit_lock_file(&shallow_lock);
>  		alternate_shallow_file = NULL;
> diff --git a/shallow.c b/shallow.c
> index 7fd04afed1..fac383dec9 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -40,13 +40,6 @@ int register_shallow(struct repository *r, const struct object_id *oid)
> 
>  int is_repository_shallow(struct repository *r)
>  {
> -	/*
> -	 * NEEDSWORK: This function updates
> -	 * r->parsed_objects->{is_shallow,shallow_stat} as a side effect but
> -	 * there is no corresponding function to clear them when the shallow
> -	 * file is updated.
> -	 */
> -

It's always good to remove these NEEDSWORK comments. I wonder if the
problem is more complicated than your patch makes it seem, or else
the original author would have done it correctly at first.

But you are definitely closing out one dangling side-effect, which is
an improvement.

>  	FILE *fp;
>  	char buf[1024];
>  	const char *path = r->parsed_objects->alternate_shallow_file;
> @@ -79,6 +72,12 @@ int is_repository_shallow(struct repository *r)
>  	return r->parsed_objects->is_shallow;
>  }
> 
> +void reset_repository_shallow(struct repository *r)
> +{
> +	r->parsed_objects->is_shallow = -1;
> +	stat_validity_clear(r->parsed_objects->shallow_stat);
> +}
> +
>  /*
>   * TODO: use "int" elemtype instead of "int *" when/if commit-slab
>   * supports a "valid" flag.
> @@ -362,6 +361,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
>  		 * shallow file".
>  		 */
>  		*alternate_shallow_file = "";
> +	reset_repository_shallow(the_repository);
>  	strbuf_release(&sb);
>  }
> 
> @@ -411,6 +411,7 @@ void prune_shallow(unsigned options)
>  			die_errno("failed to write to %s",
>  				  get_lock_file_path(&shallow_lock));
>  		commit_lock_file(&shallow_lock);
> +		reset_repository_shallow(the_repository);
>  	} else {

These are likely good places to call reset_repository_shallow(),
but perhaps we should also call it here in commit-graph.c?

 static int commit_graph_compatible(struct repository *r)
 {
        if (!r->gitdir)
                return 0;
 
        if (read_replace_refs) {
                prepare_replace_object(r);
                if (hashmap_get_size(&r->objects->replace_map->map))
                        return 0;
        }
 
        prepare_commit_graft(r);
        if (r->parsed_objects && r->parsed_objects->grafts_nr)
                return 0;
+       reset_repository_shallow(r);
        if (is_repository_shallow(r))
                return 0;
 
        return 1;
 }

Or am I misunderstanding the state that reset_repository_shallow()
puts us in? My expectation is that is_repository_shallow() will
act as if the shallow variables had never been set and will look
for shallow data from disk.

Thanks,
-Stolee
