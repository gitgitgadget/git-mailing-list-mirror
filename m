Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4DEC433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 06:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B262071A
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 06:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD+vthZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgFMGxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 02:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMGxq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 02:53:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD3EC03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 23:53:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so11976949wru.12
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M2Vd6RQ07y+EB6U5M3ODs2JIz/t545EDGsSsqBl47+8=;
        b=dD+vthZd7DRlaIWMJzMCOBm9kmVbA0tT0GLTY/czGeHkQQD1c5f2ijmmEw+9SBdu7b
         w3y1oaqn+MoCJZW5plkbg7hS/M3szXc+sUl64gzKjZZ0rw0E7vmnggy648cCmVyhijZi
         TH2or7vFHU22fEuiOjqusMOQqOO9bm1xRtpV460f0x0sJC7kWtsgFLAfr4WjJdfZwKcK
         Xd1ngI7pWbryDkL8zXGTKyGzHzH9ZlNZ/2swwlbwwWPkwZuZXmbSL5LpAro8r1iIhq9/
         zVkuMkKBc2Jdq0qhwiNGLHbsVs0yfWo266ePJ/xbgqpTNbd1+vBkD2Vl9IxOZl6s9OLV
         aQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M2Vd6RQ07y+EB6U5M3ODs2JIz/t545EDGsSsqBl47+8=;
        b=gIIv/HF3yhDkjK/j0ZX9WWXGipFha6FdBESzweB5m77GQs/sLdtaa8hDSWq+C2zxu5
         sXcCxLJTuG7EL0TktX9d7wKJhOwu+RR1ZrUKDwZI/x78q/mqnNtHbqBALv9ZLyQ443k6
         eUxChZFB0Oc/QFNll0EK3RzN8cW1ag6tTopWQY6eDRVeKY+AbOStQE7hoCuxksml6JJX
         rjj4sqf5XAsvLtuDFFd/DeOy/aVPmCrcuBR7JIYiY5B2uNxbZHXfF/sonsMOhB77O0hR
         oMeu9hmcNmcZhFFXh8v3gmwyvu/H5IiYKoLNbV1soJMv9NxWgT2nFL0qyaPIYx3LgQ+Z
         wJCw==
X-Gm-Message-State: AOAM532ShMio/Pb1wH/oJd8uAZuU+TtbHWYXW56aNpkDTNXIHzcCiwGI
        pb4E4Wm5pvamVMm/avaESLI=
X-Google-Smtp-Source: ABdhPJz0bOUMVl+PuSreoTYOvIq7cRn5cLS0uql/uYbCJWHUHjBsHNTpKYO82rao9ilLdf9TdAKWCg==
X-Received: by 2002:adf:e744:: with SMTP id c4mr19750029wrn.71.1592031222968;
        Fri, 12 Jun 2020 23:53:42 -0700 (PDT)
Received: from szeder.dev (62-165-236-99.pool.digikabel.hu. [62.165.236.99])
        by smtp.gmail.com with ESMTPSA id b187sm12532665wmd.26.2020.06.12.23.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2020 23:53:42 -0700 (PDT)
Date:   Sat, 13 Jun 2020 08:53:39 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jnareb@gmail.com
Subject: Re: [PATCH v3 2/4] commit-graph: introduce commit_graph_data_slab
Message-ID: <20200613065339.GC2898@szeder.dev>
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
 <20200612184014.1226972-3-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200612184014.1226972-3-abhishekkumar8222@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 13, 2020 at 12:10:12AM +0530, Abhishek Kumar wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index 2ff042fbf4..91120ba3d3 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -87,6 +87,55 @@ static int commit_pos_cmp(const void *va, const void *vb)
>  	       commit_pos_at(&commit_pos, b);
>  }
>  
> +define_commit_slab(commit_graph_data_slab, struct commit_graph_data);
> +static struct commit_graph_data_slab commit_graph_data_slab =
> +	COMMIT_SLAB_INIT(1, commit_graph_data_slab);
> +
> +uint32_t commit_graph_position(const struct commit *c)
> +{
> +	struct commit_graph_data *data =
> +		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
> +
> +	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
> +}
> +
> +uint32_t commit_graph_generation(const struct commit *c)
> +{
> +	struct commit_graph_data *data =
> +		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
> +
> +	if (!data)
> +		return GENERATION_NUMBER_INFINITY;
> +	else if (data->graph_pos == COMMIT_NOT_FROM_GRAPH)
> +		return GENERATION_NUMBER_INFINITY;
> +
> +	return data->generation;
> +}
> +
> +static struct commit_graph_data *commit_graph_data_at(const struct commit *c)

  commit-graph.c: At top level:
  commit-graph.c:115:34: error: ‘commit_graph_data_at’ defined but not used [-Werror=unused-function]
   static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
                                    ^

Please make sure that each and every commit of your series can be
built with DEVELOPER=1 and passes the test suite.

> +{
> +	uint32_t i = commit_graph_data_slab.slab_count, j;
> +	uint32_t slab_size = commit_graph_data_slab.slab_size;
> +	struct commit_graph_data *data =
> +		commit_graph_data_slab_at(&commit_graph_data_slab, c);
> +
> +	/*
> +	 * commit-slab initializes elements with zero, overwrite this with
> +	 * COMMIT_NOT_FROM_GRAPH for graph_pos.
> +	 *
> +	 * We avoid initializing generation with checking if graph position
> +	 * is not COMMIT_NOT_FROM_GRAPH.
> +	 */
> +	for (; i < commit_graph_data_slab.slab_count; i++) {
> +		for (j = 0; j < slab_size; j++) {
> +			commit_graph_data_slab[i][j].graph_pos =

  commit-graph.c: In function ‘commit_graph_data_at’:
  commit-graph.c:131:26: error: subscripted value is neither array nor pointer nor vector
      commit_graph_data_slab[i][j].graph_pos =
                            ^

Once the next patch is applied Git can be built again, but then:

  $ ~/src/git/git -C webkit.git commit-graph write
  Finding commits for commit graph among packed objects: 100% (3984415/3984415), done.
  Expanding reachable commits in commit graph: 219420, done.
  Segmentation fault

Looking at it with a debugger:

  Program received signal SIGSEGV, Segmentation fault.
  0x00000000005079b2 in commit_graph_data_at (c=0x1ad9aa0) at commit-graph.c:131
  131                             commit_graph_data_slab.slab[i][j].graph_pos =
  (gdb) bt
  #0  0x00000000005079b2 in commit_graph_data_at (c=0x1ad9aa0)
      at commit-graph.c:131
  #1  0x000000000050a6a7 in compute_generation_numbers (ctx=0x9d61a0)
      at commit-graph.c:1304
  #2  0x000000000050d37d in write_commit_graph (odb=0x9d3d80, pack_indexes=0x0, 
      commits=0x0, flags=COMMIT_GRAPH_WRITE_PROGRESS, 
      split_opts=0x98e730 <split_opts>) at commit-graph.c:2178
  #3  0x000000000042bb7e in graph_write (argc=0, argv=0x7fffffffe2f0)
      at builtin/commit-graph.c:242
  #4  0x000000000042bc8d in cmd_commit_graph (argc=1, argv=0x7fffffffe2f0, 
      prefix=0x0) at builtin/commit-graph.c:278
  #5  0x00000000004061d1 in run_builtin (p=0x97b950 <commands+528>, argc=2, 
      argv=0x7fffffffe2f0) at git.c:448
  #6  0x0000000000406521 in handle_builtin (argc=2, argv=0x7fffffffe2f0)
      at git.c:673
  #7  0x00000000004067c9 in run_argv (argcp=0x7fffffffe18c, argv=0x7fffffffe180)
      at git.c:740
  #8  0x0000000000406c3a in cmd_main (argc=2, argv=0x7fffffffe2f0) at git.c:871
  #9  0x00000000004cfbda in main (argc=5, argv=0x7fffffffe2d8)
      at common-main.c:52
  (gdb) p commit_graph_data_slab
  $1 = {
    slab_size = 65532, 
    stride = 1, 
    slab_count = 4, 
    slab = 0x4f68690
  }
  (gdb) p i
  $2 = 0
  (gdb) p commit_graph_data_slab.slab[i]
  $3 = (struct commit_graph_data *) 0x0
  (gdb) p c->index
  $4 = 213506
  (gdb) up
  #1  0x000000000050a6a7 in compute_generation_numbers (ctx=0x9d61a0)
      at commit-graph.c:1304
  1304                    uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
  (gdb) p i
  $5 = 0


The way the loop variable 'i' is initialized and is used in the loop
header suggests that you assume that all slabs with an index
<slab_count are allocated.  That's not the case, only those slabs are
allocated that contain data associated with a commit that has already
been looked at.


> +				COMMIT_NOT_FROM_GRAPH;
> +		}
> +	}
> +
> +	return data;
> +}
> +
>  static int commit_gen_cmp(const void *va, const void *vb)
>  {
>  	const struct commit *a = *(const struct commit **)va;
> diff --git a/commit-graph.h b/commit-graph.h
> index 3ba0da1e5f..cc76757007 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -135,4 +135,14 @@ void free_commit_graph(struct commit_graph *);
>   */
>  void disable_commit_graph(struct repository *r);
>  
> +struct commit_graph_data {
> +	uint32_t graph_pos;
> +	uint32_t generation;
> +};
> +
> +/* 

This line adds a trailing space which is then removed in next patch.
Please don't add it in the first place.

> + * Commits should be parsed before accessing generation, graph positions.
> + */
> +uint32_t commit_graph_generation(const struct commit *);
> +uint32_t commit_graph_position(const struct commit *);
>  #endif
> -- 
> 2.27.0
> 
