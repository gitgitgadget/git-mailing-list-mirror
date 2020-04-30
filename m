Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32DDC4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFA72166E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhFPsQZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgD3VYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726818AbgD3VYQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 17:24:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E3C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 14:24:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so1419191pjb.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IpwxBqXdYPEQynwz+Lj5VUFIxT9NdVntJB5aoFFNiS8=;
        b=DhFPsQZFb/OOEXkKVsyCV0jcqBguvBeGuiJdIhshSglCsnjjHve1N/oLXz5UPi82OL
         WO5iSltWxrfZMB8rYDj8RkDeMVp8Rg8HK2sQD0cIVL92SfAqPvs4vBLhfCMnxK6/3UIn
         QofNE/851gWD3HtJvn2mHVuSJovTcH6zKmKWcO8+kMpQUIJ4Mh5Rw5NNDPv9K6Wm+BvL
         +n4oEK+S3LDhMZzoodnSa+nnHKzgSXJktaG2A/sDAhJKH6a7T12lij2lVRR1V5nMqKrt
         eKv+ROnhawhyZq9+vvX/kiPRd8swKCujjtdwy9Q6gxIJdhHqeNwANv9dt3bJAIIa713M
         S7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IpwxBqXdYPEQynwz+Lj5VUFIxT9NdVntJB5aoFFNiS8=;
        b=QwUp0ABD56ji5JwazZAsBMXumuVlZOfTqju6smnlqsSvbpKd+M5F9AfX/gQwhmLpM/
         IlVkvl4ULcbN/8a8NDSvrGowYyDjViRfMRSQIHZkHXGJrLYOlys078k8TD+lkm2Nsp3Z
         6rqyZHRRbhFeUUOfxcNW2oBsi4x4L3xTdImrwzlIrhKnYVkdPbntgUhA7C3vpOHcHP1d
         IyI23H1B6EOEZprqU41Z0K/GjGNDZQJjyDZkBaP+UOsdNwoA1RU4Toll+sec4uRaANUa
         4hj+BWruTZqeCoCjB5wqpZebOmzyCRzs92ac0TDfLjOla1IdAvfXu7/yyM+9U25T5w24
         xsqg==
X-Gm-Message-State: AGi0Puaf2EybKrvo5WrdyuD5TXhXTsYyfbpt66oyryUqX5yxq8q9YGmS
        7JogZ/S79MTmEmmgILWq6FvZqg==
X-Google-Smtp-Source: APiQypIHOSjbnyNhp5m2mDQtySlQglBKQ/uFY23xC9NA2DKmI3JNhfWNeBSIJjjPIPCgtFeRJ9p+8A==
X-Received: by 2002:a17:902:ea86:: with SMTP id x6mr904024plb.75.1588281855679;
        Thu, 30 Apr 2020 14:24:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 141sm583078pfz.171.2020.04.30.14.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:24:15 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:24:10 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v10 03/12] create .git/refs in files-backend.c
Message-ID: <20200430212410.GF77802@google.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
 <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
 <bc89bcd9c8c9b33e517a21bbe7c441538e288ebc.1588018418.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc89bcd9c8c9b33e517a21bbe7c441538e288ebc.1588018418.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 08:13:29PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> 
> 
> This prepares for supporting the reftable format, which will want
> create its own file system layout in .git
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  builtin/init-db.c    | 2 --
>  refs/files-backend.c | 6 ++++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 0b7222e7188..3b50b1aa0e5 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -251,8 +251,6 @@ static int create_default_files(const char *template_path,
>  	 * We need to create a "refs" dir in any case so that older
>  	 * versions of git can tell that this is a repository.
>  	 */
> -	safe_create_dir(git_path("refs"), 1);
> -	adjust_shared_perm(git_path("refs"));

Is the reftable completely replacing the refs/ dir? Or is the idea that
the refs/ dir is only used by the files backend? The commit message
makes it sound like it's an additional format to support, so I'm a
little confused. Why does the other currently-existing backend not need
the refs/ dir at this stage?

>  
>  	if (refs_init_db(&err))
>  		die("failed to set up refs db: %s", err.buf);
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 561c33ac8a9..ab7899a9c77 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3157,9 +3157,15 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
>  		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
>  	struct strbuf sb = STRBUF_INIT;
>  
> +	files_ref_path(refs, &sb, "refs");
> +	safe_create_dir(sb.buf, 1);
> +	/* adjust permissions even if directory already exists. */
> +	adjust_shared_perm(sb.buf);
> +
>  	/*
>  	 * Create .git/refs/{heads,tags}
>  	 */
> +	strbuf_reset(&sb);
>  	files_ref_path(refs, &sb, "refs/heads");
>  	safe_create_dir(sb.buf, 1);
>  
> -- 
> gitgitgadget
> 
