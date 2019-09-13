Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44841F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403783AbfIMN0X (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:26:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45529 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403777AbfIMN0V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id z67so28027309qkb.12
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uQ2nRPUkaDrbqfwX5kzEHjMmAwPf/HlcKFGCzh4wHU8=;
        b=GMUxJXqCAQ9ikKFjATZ5BB0XBq6Z7AcGOImCFZ/c4TMwTknQixE/jP1jnTgKt44xdW
         FURYc22yoUA0vCMutmc1Us840gqKdV/pW3p83rpmEldqKkbsdX0vpC6hZz7ys9gKjVH7
         5zib3SMfMLRuNFpYYuNSvUBUKQ2lIYtOHX0ANcp+7DcGX1Irz1NFUx4a0GI9i3DEgbko
         2ZC+13wxjVLJ9633QG7Fo9XPsvD3S7nNxGDmOlzpjceBjyo4CKXA/z2OgtpotYUJuuMF
         vI5LJyyic2Kp601TOZuSBl7LMOAI2pxjjfsQ/+1DL70sheJfhDdmcPcEZg70LnO3g3sH
         YJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uQ2nRPUkaDrbqfwX5kzEHjMmAwPf/HlcKFGCzh4wHU8=;
        b=dCzQKTKZ8qkpCktGjE5uuukFV8OzBJFl376U9X8I3a20LttEzADkXffQPUYRNqsmYr
         9sscj0E6Q1vTUra0MzXP4wui9fsJYpHYq2HhWHM13+ENKkPe6wpMH5e0/GRnC4Rvkf7h
         9rj51YwnGczyzXefIepuPh3Exxgg4kiqaRmQnqTavoepgrUcZTK2uqDrD5MqxoG0Usk3
         SyYJ43bRNKNGTcEkgo6AOvZICWVtozFB2bjs7rX1WKzPWyZsNn3tw0MyJurGUrnOky55
         RkEa/kgu06p5p6/U5at9oFH0L3XhXLHufb/uIeuSRqnb1wFWoBINADBq2KV1VrJ8UiaT
         P6TQ==
X-Gm-Message-State: APjAAAUsuCAKHzgoyzHJTqJGkhn5fux7crC8iGxLvPZjgJBE2Bbd8mBa
        GMLnFijbZ/lY8qY1w3OCAnjfojTbjD0=
X-Google-Smtp-Source: APXvYqzqoAQPrOAqfz9UVj9b/71jUQRMLjy9vv5E2uz66LLnWND6Ewlq1uhK2PfM8Z6xOa6UTcRs+Q==
X-Received: by 2002:a37:95c6:: with SMTP id x189mr45687823qkd.323.1568381180505;
        Fri, 13 Sep 2019 06:26:20 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1480:61d4:2a67:bfe? ([2001:4898:a800:1010:c5b5:61d4:2a67:bfe])
        by smtp.gmail.com with ESMTPSA id z15sm5556761qts.90.2019.09.13.06.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 06:26:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] upload-pack: disable commit graph more gently for
 shallow traversal
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190912144122.GA27815@sigill.intra.peff.net>
 <20190912144444.GB25101@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ef18a12f-fbae-4f78-4426-11ec1515530b@gmail.com>
Date:   Fri, 13 Sep 2019 09:26:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190912144444.GB25101@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/12/2019 10:44 AM, Jeff King wrote:
> When the client has asked for certain shallow options like
> "deepen-since", we do a custom rev-list walk that pretends to be
> shallow. Before doing so, we have to disable the commit-graph, since it
> is not compatible with the shallow view of the repository. That's
> handled by 829a321569 (commit-graph: close_commit_graph before shallow
> walk, 2018-08-20). That commit literally closes and frees our
> repo->objects->commit_graph struct.
> 
> That creates an interesting problem for commits that have _already_ been
> parsed using the commit graph. Their commit->object.parsed flag is set,
> their commit->graph_pos is set, but their commit->maybe_tree may still
> be NULL. When somebody later calls repo_get_commit_tree(), we see that
> we haven't loaded the tree oid yet and try to get it from the commit
> graph. But since it has been freed, we segfault!
> 
> So the root of the issue is a data dependency between the commit's
> lazy-load of the tree oid and the fact that the commit graph can go
> away mid-process. How can we resolve it?
> 
> There are a couple of general approaches:
> 
>   1. The obvious answer is to avoid loading the tree from the graph when
>      we see that it's NULL. But then what do we return for the tree oid?
>      If we return NULL, our caller in do_traverse() will rightly
>      complain that we have no tree. We'd have to fallback to loading the
>      actual commit object and re-parsing it. That requires teaching
>      parse_commit_buffer() to understand re-parsing (i.e., not starting
>      from a clean slate and not leaking any allocated bits like parent
>      list pointers).
> 
>   2. When we close the commit graph, walk through the set of in-memory
>      objects and clear any graph_pos pointers. But this means we also
>      have to "unparse" any such commits so that we know they still need
>      to open the commit object to fill in their trees. So it's no less
>      complicated than (1), and is more expensive (since we clear objects
>      we might not later need).
> 
>   3. Stop freeing the commit-graph struct. Continue to let it be used
>      for lazy-loads of tree oids, but let upload-pack specify that it
>      shouldn't be used for further commit parsing.
> 
>   4. Push the whole shallow rev-list out to its own sub-process, with
>      the commit-graph disabled from the start, giving it a clean memory
>      space to work from.
> 
> I've chosen (3) here. Options (1) and (2) would work, but are
> non-trivial to implement. Option (4) is more expensive, and I'm not sure
> how complicated it is (shelling out for the actual rev-list part is
> easy, but we do then parse the resulting commits internally, and I'm not
> clear which parts need to be handling shallow-ness).
> 
> The new test in t5500 triggers this segfault, but see the comments there
> for how horribly intimate it has to be with how both upload-pack and
> commit graphs work.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c        | 12 ++++++++++++
>  commit-graph.h        |  6 ++++++
>  repository.h          |  3 +++
>  t/t5500-fetch-pack.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  upload-pack.c         |  2 +-
>  5 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index baeaf0d1bf..bbde647f8b 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -468,6 +468,13 @@ static int prepare_commit_graph(struct repository *r)
>  {
>  	struct object_directory *odb;
>  
> +	/*
> +	 * This must come before the "already attempted?" check below, because
> +	 * we want to disable even an already-loaded graph file.
> +	 */
> +	if (r->commit_graph_disabled)
> +		return 0;
> +
>  	if (r->objects->commit_graph_attempted)
>  		return !!r->objects->commit_graph;
>  	r->objects->commit_graph_attempted = 1;
> @@ -2101,3 +2108,8 @@ void free_commit_graph(struct commit_graph *g)
>  	free(g->filename);
>  	free(g);
>  }
> +
> +void disable_commit_graph(struct repository *r)
> +{
> +	r->commit_graph_disabled = 1;
> +}

Thanks for the additional comment and using the repo struct. LGTM.

-Stolee
