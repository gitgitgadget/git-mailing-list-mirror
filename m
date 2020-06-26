Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C33C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 06:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFE220768
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 06:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/UqRJ4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgFZGey (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgFZGex (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 02:34:53 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78EC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 23:34:53 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n24so8290877ejd.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 23:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+lG3va7VeFljg6ktMZiHfZfbAZV9je2SzjQqcuB0Yo=;
        b=g/UqRJ4PXL0mSwn78bpRNBcYDlFrqWeVu7lVBt9/yhorJeQpsHovYnxHMzbmP7beYB
         /bCKUSM8rQu2n+rYaoLojf7CC2JMNyAw+ERkmsSHiTGG1FK7uLKRANOKEfK+n4sqgiNX
         szRl0L0vGS4xObvkS4Vb52V1xxmeuh7n6kwlJwIJeRF1F3ppPFROPYtcNyanzKlIsBIZ
         nETejaaOKB7TI30zkqFlKvzapdlFjVlrg5adKLBtODjATzma7Nof7XBpPA5qGB8to6u+
         jWFp0PqsHgFqUYPJN2AwQ/TAiG46wL64wNh0VaggfEzw1m6u0g2a34+9C8MaHWo7Eva9
         F9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+lG3va7VeFljg6ktMZiHfZfbAZV9je2SzjQqcuB0Yo=;
        b=ANqvnDEsKdakhUzG0mFuaMoce1mE6Sre98tUqq/90JmXgaSjcnaktA0n0b8I8ukvXv
         FavX1Skau81AfzJV/EYGh1yJTCGhpPhr4GbqpCx5mzWi6bKiMPStFdjr9smy3SyZ2x05
         gvc5up+XPCtRhThmcM4n9o//lYphC+vxSG7yvVhTzaKkc7QJvrjlO86VKvUBP3FHJBF2
         fY1d44QpLwo88udPl75O/UFY/ERuTMHxbeOAjzumqTQ0I+UYhTzdhkBCQBxpcdBnxSSV
         fUMFsQrhg5fph+bNgkbjpTBxBp30AyspVVubFuOoQPNsnWS57F06k0AsdCU43zwKkdlg
         zg+g==
X-Gm-Message-State: AOAM5305IPFiayilYH5q4Bk5c/nhzvV4IV8/O4fsMg+GVQ8d2/dot5Ye
        vngWeipbBoLYnH92Er3edf0=
X-Google-Smtp-Source: ABdhPJyvlOIQV9OAQa7KfcuGJg2c24lY5JFLG0AI0TSw8EMrwhqqZfO1D9gvLlXPZ1nD3TKPrTgFHQ==
X-Received: by 2002:a17:906:d784:: with SMTP id pj4mr1189348ejb.405.1593153292400;
        Thu, 25 Jun 2020 23:34:52 -0700 (PDT)
Received: from szeder.dev (92-249-246-85.pool.digikabel.hu. [92.249.246.85])
        by smtp.gmail.com with ESMTPSA id m23sm1998475ejc.38.2020.06.25.23.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 23:34:51 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:34:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v4 12/15] revision.c: use Bloom filters to speed up path
 based revision walks
Message-ID: <20200626063450.GL2898@szeder.dev>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <617f549ef259424658a84dd67a98685328f6b850.1586192395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <617f549ef259424658a84dd67a98685328f6b850.1586192395.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 04:59:52PM +0000, Garima Singh via GitGitGadget wrote:
> +static void prepare_to_use_bloom_filter(struct rev_info *revs)
> +{
> +	struct pathspec_item *pi;
> +	char *path_alloc = NULL;
> +	const char *path;
> +	int last_index;
> +	int len;
> +
> +	if (!revs->commits)
> +	    return;
> +
> +	repo_parse_commit(revs->repo, revs->commits->item);
> +
> +	if (!revs->repo->objects->commit_graph)
> +		return;
> +
> +	revs->bloom_filter_settings = revs->repo->objects->commit_graph->bloom_filter_settings;
> +	if (!revs->bloom_filter_settings)
> +		return;
> +
> +	pi = &revs->pruning.pathspec.items[0];
> +	last_index = pi->len - 1;
> +
> +	/* remove single trailing slash from path, if needed */
> +	if (pi->match[last_index] == '/') {
> +	    path_alloc = xstrdup(pi->match);
> +	    path_alloc[last_index] = '\0';
> +	    path = path_alloc;

fill_bloom_key() takes a length parameter, so there is no need to
duplicate the path to be able to shorten it by one character to remove
that trailing '/'.

> +	} else
> +	    path = pi->match;
> +
> +	len = strlen(path);

'struct pathspec_item's 'len' field already contains the length of the
path, so there is no need for this strlen().

> +
> +	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
> +	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
> +
> +	free(path_alloc);
> +}

> @@ -3362,6 +3440,8 @@ int prepare_revision_walk(struct rev_info *revs)
>  				       FOR_EACH_OBJECT_PROMISOR_ONLY);
>  	}
>  
> +	if (revs->pruning.pathspec.nr == 1 && !revs->reflog_info)
> +		prepare_to_use_bloom_filter(revs);
>  	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
>  		commit_list_sort_by_date(&revs->commits);
>  	if (revs->no_walk)
                return 0;
        if (revs->limited) {
                if (limit_list(revs) < 0)
                        return -1;

I extended the hunk context a bit to show that
prepare_to_use_bloom_filter() is called before limit_list().  This is
important, because specifying exclude revs and pathspecs, i.e.  'git
log ^v1.2.3 -- dir/file' does perform a lot of diffs in limit_list(),
and this way we can take advantage of Bloom filters even in this case.

> @@ -3379,6 +3459,7 @@ int prepare_revision_walk(struct rev_info *revs)
>  		simplify_merges(revs);
>  	if (revs->children.name)
>  		set_children(revs);
> +
>  	return 0;
>  }
>  
> diff --git a/revision.h b/revision.h
> index 475f048fb61..7c026fe41fc 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -56,6 +56,8 @@ struct repository;
>  struct rev_info;
>  struct string_list;
>  struct saved_parents;
> +struct bloom_key;
> +struct bloom_filter_settings;
>  define_shared_commit_slab(revision_sources, char *);
>  
>  struct rev_cmdline_info {
> @@ -291,6 +293,15 @@ struct rev_info {
>  	struct revision_sources *sources;
>  
>  	struct topo_walk_info *topo_walk_info;
> +
> +	/* Commit graph bloom filter fields */
> +	/* The bloom filter key for the pathspec */
> +	struct bloom_key *bloom_key;
> +	/*
> +	 * The bloom filter settings used to generate the key.
> +	 * This is loaded from the commit-graph being used.
> +	 */
> +	struct bloom_filter_settings *bloom_filter_settings;
>  };
>  
>  int ref_excluded(struct string_list *, const char *path);
> -- 
> gitgitgadget
> 
