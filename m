Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17AAC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 09:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8429520658
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 09:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oo9AbmNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHSJ5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgHSJ5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 05:57:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A43C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 02:57:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so25527419ejb.11
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BkAK3RKk49ESMrayEbGPzGoCxYRn2UQwe1f+r5w6ZdY=;
        b=oo9AbmNpvezc6qHPJpAgfaCnKp63sRhu0ZlMSXx/dLpVIOUy9hmQUgG7mrIKOyE1es
         ODn4vrZeLi0Ur2BF0ysiOtLzCoTXwcAbatXKT6lrlrQt5Tr0RKRzt9yh7k2ZxI8ITUZ9
         jyFX00ZjfEw7KTYi+X3OI+GPlSmM8z7dUHiGd44Xsz355bcy1AroEt3kzawRxIU8S5Yv
         GiZkjM8QkjQRAd/GKDRsrh3fn4vt+dPi3dTFV0JPGFwyOQ0iQ2FO6Y1FB7y5svEg1uDr
         qSrODuksiQGvNpkUF5ufy9g6WCspdCd7D21Wkl6stVUIG9aG3Z0O+AWoJxdTRJgG0Gw3
         21eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BkAK3RKk49ESMrayEbGPzGoCxYRn2UQwe1f+r5w6ZdY=;
        b=HyUOr8+bTheUZOxvMgaliou3S6w8QjosgC5yiC8B84r7hAoETV1VooSf8jmyUcxgCM
         EqK8DjTztDGHHwwms0c/MamYaWc+qEjJKFGDtyMDAiCpX4/sRLBot3h1u1p2jZvM058J
         jzK5VvkDfPTfzSK8Re04h6dk8zpOomy6L0wtJXcEoCvo+b7wqpxva9wqlazsvcG8YERG
         wtpnHSKBV+vZ3bfxModZQ3rWnrTdCKC2qjuA3Z04gWIuDy/XDw09qRQXnxoLwcHne7Mt
         DosMKCe0jp0Mk+8s9LlVvOJkgRqBDykYhlHgWKkr+KRTsPDLBkUoRtbp8nuT9gBEkNOB
         ToVQ==
X-Gm-Message-State: AOAM532tqCo8wblpckXgDiqR00NXspVcszr0DCX2cytFBj7gsJ+pWmgn
        t0/U3eiCd57KwOb/lXatbZg=
X-Google-Smtp-Source: ABdhPJzLA8v67fdA0nrV/ztlTdXqt3n0JmVPii7jsqpo6HcNYSXaqLiketgXCmSNDGCUT0v0b1tnZA==
X-Received: by 2002:a17:906:5606:: with SMTP id f6mr23762092ejq.297.1597831020338;
        Wed, 19 Aug 2020 02:57:00 -0700 (PDT)
Received: from szeder.dev (84-236-109-47.pool.digikabel.hu. [84.236.109.47])
        by smtp.gmail.com with ESMTPSA id k17sm18279932eji.28.2020.08.19.02.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 02:56:59 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:56:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 13/14] commit-graph: rename 'split_commit_graph_opts'
Message-ID: <20200819095656.GD29528@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <b2e33ecba880f4b49af7a94fb0decb08929dff36.1597178915.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2e33ecba880f4b49af7a94fb0decb08929dff36.1597178915.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 04:52:11PM -0400, Taylor Blau wrote:
> In the subsequent commit, additional options will be added to the
> commit-graph API which have nothing to do with splitting.
> 
> Rename the 'split_commit_graph_opts' structure to the more-generic
> 'commit_graph_opts' to encompass both.

Good.  Note, however, that write_commit_graph() has a 'flags'
parameter as well, and when a feature is enabled via this 'flags',
then first a corresponding 'ctx->foo' field is set, and that
'ctx->foo' is checked while computing and writing the commit-graph.
With the generic options struct some other feature will be enabled via
the 'opts->bar' field, so simply 'ctx->opts->bar' is checked while
writing the commit-graph.

With the generic options struct there really is no need for a separate
flags parameter, the values in the flags can be stored in the options
struct, and we can eliminate this inconsistency instead of adding even
more.


> diff --git a/commit-graph.h b/commit-graph.h
> index ddbca1b59d..af08c4505d 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -109,7 +109,7 @@ enum commit_graph_split_flags {
>  	COMMIT_GRAPH_SPLIT_REPLACE          = 2
>  };
>  
> -struct split_commit_graph_opts {
> +struct commit_graph_opts {
>  	int size_multiple;
>  	int max_commits;
>  	timestamp_t expire_time;
        enum commit_graph_split_flags flags;

While this was 'struct split_commit_graph_opts *split_opts' it was
clear what kind of flags were in this 'flags' field.  Now that the
struct is generic it's not clear anymore, so perhaps it should be
renamed as well (e.g. 'split_flags'), or even turned into a couple of
bit fields.

> @@ -124,12 +124,12 @@ struct split_commit_graph_opts {
>   */
>  int write_commit_graph_reachable(struct object_directory *odb,
>  				 enum commit_graph_write_flags flags,
> -				 const struct split_commit_graph_opts *split_opts);
> +				 const struct commit_graph_opts *opts);
>  int write_commit_graph(struct object_directory *odb,
>  		       struct string_list *pack_indexes,
>  		       struct oidset *commits,
>  		       enum commit_graph_write_flags flags,
> -		       const struct split_commit_graph_opts *split_opts);
> +		       const struct commit_graph_opts *opts);
>  
>  #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
>  
> -- 
> 2.28.0.rc1.13.ge78abce653
> 
