Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070FD1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 02:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeJ3LUB (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 07:20:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33866 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3LUB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 07:20:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id l6-v6so10837561wrt.1
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 19:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0wEU3c+ipejkUmuHd1lX7eU4ESd/tGh6DCg/GcpQwgA=;
        b=QQkJpfs8LufUukfh4QVgJv+DxQ+Na2J1uLnDfQbOt59H2IktQk+QcRUZ6GtsKWhvCS
         M0+ZGpFzBOYZz9w8gf+aK98jHwdhAqGWrxsSItYl6gaDZQSFAfSaBupTK/J5l7FgRs1Q
         S+TUXs4hh0mw/O8yzx7YXAML2ma9zA5lROjrAL/h3yI5wfjZx6fBqiB94KPi85LHeS1f
         Kn46C6q2ceivgbZ4eeE3X+v/bX72L66nJfXffmlrmFJKr6wERKomiYq/SWlV0tQntArv
         SnFb5r08d2Kk2Z37d3FKQzzvtkiKMBcyumbnFCFQmXCfDdMNMO9lvMBexlAcHihtpJJo
         DJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0wEU3c+ipejkUmuHd1lX7eU4ESd/tGh6DCg/GcpQwgA=;
        b=NLryuQ44RfYAp9KENfoakzwDnic0IL7jCmqC72HowJ0mgrPCF+3CB0OSwAdUAZxdlE
         oJfaHMLnalw1ZawbLgMzKVjHWSNZnrk9jQI75+DmVQsV4KOWY1R29yOwfi712+OOIJFC
         ZzNwSktbjITzexgdZtoJ0QjXxjp+kXn6XUaFY/m5sRU7/ZVI4M1kGSWI3HtLn/+8vaVj
         oIuVEhXbox7HOFy+5RJIIJ2DOEVPrXoxW2T0ZAE+ane54M0O0DcLiknrEVqRCfR0L2pz
         gr1GkhNk62hwSsMsebtk6z+crgvxhIO+kf5YAsCJvo5M6kb1TBUPsx0ut8JKRR8Uj6Sg
         ZHFw==
X-Gm-Message-State: AGRZ1gJB/Y1WVRKgtE53txZ2bpmmSkg+AVPmjFYOpq6/5ZA89LLyvqrX
        qOmPrxcXdP5yrOiocVfQ8dA=
X-Google-Smtp-Source: AJdET5ecqN4pFuMQArLrvJCpQg47e+DuynjMLZctQxhs2WrEiVLzVnWLhIk8PEBULw1EuTx/w0Gzqg==
X-Received: by 2002:adf:916a:: with SMTP id j97-v6mr17442258wrj.179.1540866509458;
        Mon, 29 Oct 2018 19:28:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d6-v6sm21255707wro.72.2018.10.29.19.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 19:28:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1] speed up refresh_index() by utilizing preload_index()
References: <20181029204159.18208-1-peartben@gmail.com>
Date:   Tue, 30 Oct 2018 11:28:28 +0900
In-Reply-To: <20181029204159.18208-1-peartben@gmail.com> (Ben Peart's message
        of "Mon, 29 Oct 2018 16:41:59 -0400")
Message-ID: <xmqq7ei02mnn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> From: Ben Peart <benpeart@microsoft.com>
>
> Speed up refresh_index() by utilizing preload_index() to do most of the work
> spread across multiple threads.  This works because most cache entries will
> get marked CE_UPTODATE so that refresh_cache_ent() can bail out early when
> called from within refresh_index().
>
> On a Windows repo with ~200K files, this drops refresh times from 6.64
> seconds to 2.87 seconds for a savings of 57%.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---

OK.  We used to only expose the whole "read the index file into an
istate, and then do the lstat() part in parallel", but now we also
make the "do the lstat() part" available separately.

Which makes sense.


> diff --git a/cache.h b/cache.h
> index f7fabdde8f..883099db08 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -659,6 +659,9 @@ extern int daemonize(void);
>  /* Initialize and use the cache information */
>  struct lock_file;
>  extern int read_index(struct index_state *);
> +extern void preload_index(struct index_state *index,
> +			  const struct pathspec *pathspec,
> +			  unsigned int refresh_flags);
>  extern int read_index_preload(struct index_state *,
>  			      const struct pathspec *pathspec,
>  			      unsigned int refresh_flags);
> diff --git a/preload-index.c b/preload-index.c
> index 9e7152ab14..222792ccbc 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -9,7 +9,7 @@
>  #include "progress.h"
>  
>  #ifdef NO_PTHREADS
> -static void preload_index(struct index_state *index,
> +void preload_index(struct index_state *index,
>  			  const struct pathspec *pathspec,
>  			  unsigned int refresh_flags)
>  {
> @@ -100,9 +100,9 @@ static void *preload_thread(void *_data)
>  	return NULL;
>  }
>  
> -static void preload_index(struct index_state *index,
> -			  const struct pathspec *pathspec,
> -			  unsigned int refresh_flags)
> +void preload_index(struct index_state *index,
> +		   const struct pathspec *pathspec,
> +		   unsigned int refresh_flags)
>  {
>  	int threads, i, work, offset;
>  	struct thread_data data[MAX_PARALLEL];
> diff --git a/read-cache.c b/read-cache.c
> index d57958233e..53733d651d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1496,6 +1496,12 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
>  	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
>  	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
> +	/*
> +	 * Use the multi-threaded preload_index() to refresh most of the
> +	 * cache entries quickly then in the single threaded loop below,
> +	 * we only have to do the special cases that are left.
> +	 */
> +	preload_index(istate, pathspec, 0);
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce, *new_entry;
>  		int cache_errno = 0;
>
> base-commit: c670b1f876521c9f7cd40184bf7ed05aad843433
