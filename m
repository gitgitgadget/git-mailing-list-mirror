Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B6B01F405
	for <e@80x24.org>; Tue, 18 Dec 2018 03:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeLRDqw (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 22:46:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36201 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbeLRDqv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 22:46:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so7145363plo.3
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 19:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D7iqLPR6wtFmfDSxNXDAqg8SYZ+udF7Ta6JRy8lEO4k=;
        b=ssanG/THsga6j/O9H2kYuSKdDkvIiIOIv974/oT09whQj9buvLOUQp2MGCuayHIkjA
         3sXj+xkrOGt8BgNx+6L3MasRTafbGn909JSn8pKaej1H2h5Iv7HgqLHqjr5sXLfLor1K
         YI6Xh8isL2mKX5qC/esMSqJ552tNFBQA0VHsqaZ72M9sFH0miUJT4t29dgzAjoOt1166
         XLZfYQTvnvgNVX4oSISN5alS9Il3H4WSs8uawPP7xHu9yyUrTU3M3d8ZcTvSyymHfVNe
         9KHntVFHDYi7bBouRN6JqxnxpbdCPP7xRPaSkDwENKkD93+ApSLD+rFriW+M4aqocDjE
         UsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D7iqLPR6wtFmfDSxNXDAqg8SYZ+udF7Ta6JRy8lEO4k=;
        b=oMSpcBUSTDqbKPmwf7XNpU/83PkQV344HzqIfdTINYppcfmPvtEqHtjFwUnSgO11SU
         PHuoNUasIxk0mimrDh0+xzeHvR13EZTwlr45VoinzhDA2k/IQiA/IT4yUdoy4yZ6MyPT
         Rl/93RJYNAIeBHENRlkEVV1xS6AnrFmleTJO+VkQnH5rlX6pi4bjEollYluGjmW/F7om
         lncL5z91tq0j8JCkaebubjXxUIm6vc/VKqBga3LIxb+8c4IOKP00T4HN0nEEQbuokeuj
         1QTx6oTdzWTNyv086+mKRyylTd02vc3N91E3BNKD2qMVj08PC/LaiHpCR6nJi5aMyyue
         YM2Q==
X-Gm-Message-State: AA+aEWZ48Bkb/fSQLO1qwd22JaH4PHwE9MTOHZAN+1kA9EtW7u406zRn
        qviCAFE0WRFehmPzNQNAKVI=
X-Google-Smtp-Source: AFSGD/XBmNGPKJYw8EmYw5fUUx95gmVFpTsVGF5sUGdlrfd1fqU2WJhTfvDz1N4EMHknkRVDlztmdg==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr15122437plr.128.1545104810655;
        Mon, 17 Dec 2018 19:46:50 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r12sm15916201pgv.83.2018.12.17.19.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 19:46:50 -0800 (PST)
Date:   Mon, 17 Dec 2018 19:46:48 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] shallow: clear shallow cache when committing lock
Message-ID: <20181218034648.GA221428@google.com>
References: <20181218010811.143608-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218010811.143608-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> When setup_alternate_shallow() is invoked a second time in the same
> process, it fails with the error "shallow file has changed since we read
> it". One way of reproducing this is to fetch using protocol v2 in such a
> way that backfill_tags() is required, and that the responses to both
> requests contain a "shallow-info" section.
>
> This is because when the shallow lock is committed, the stat information
> of the shallow file is not cleared. Ensure that this information is
> always cleared whenever the shallow lock is committed by introducing a
> new API that hides the shallow lock behind a custom struct.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This was discovered with the help of Aevar's GIT_TEST_PROTOCOL_VERSION
> patches.

Good catch.  I think the above note should go in the commit message,
since it would be very useful to anyone looking back at this commit
message and trying to find a quick reproduction recipe.

[...]
> I couldn't figure out if the test case included in this patch can be
> reduced - if any one has any idea, help is appreciated.

It's short enough to be comprehensible, so I wouldn't worry too
much. :)

> I'm also not sure why this issue only occurs with protocol v2. It's true
> that, when using protocol v0, the server can communicate shallow
> information both before and after "want"s are received, and if shallow
> communication is only communicated before, the client will invoke
> setup_temporary_shallow() instead of setup_alternate_shallow(). (In
> protocol v2, shallow information is always communicated after "want"s,
> thus demonstrating the issue.) But even in protocol v0, writes to the
> shallow file go through setup_alternate_shallow() anyway (in
> update_shallow()), so I would think that the issue would occur, but it
> doesn't.

Good question.  I'll try to poke more tomorrow morning, too.

[...]
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1,7 +1,6 @@
>  #include "builtin.h"
>  #include "repository.h"
>  #include "config.h"
> -#include "lockfile.h"
>  #include "pack.h"
>  #include "refs.h"
>  #include "pkt-line.h"
> @@ -864,7 +863,7 @@ static void refuse_unconfigured_deny_delete_current(void)
>  static int command_singleton_iterator(void *cb_data, struct object_id *oid);
>  static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>  {
> -	struct lock_file shallow_lock = LOCK_INIT;
> +	struct shallow_lock shallow_lock;

Interesting.  Is there another name that can convey what this object
does more clearly?  At first glance I would expect this to be a less
deep kind of lock.

I'm awful at naming, but a couple of ideas to get things started:

- 'struct shallow_update', since this represents a pending update to
  the .git/shallow file?

- struct lock_file_for_shallow?

- struct locked_shallow_file?

- "struct shallow_file" or "struct shallow_commits_file"?  This is a
  handle representing the state of what will become .git/shallow file
  once the caller commits the update.

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
[...]
> @@ -1660,7 +1659,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>  			error(_("remote did not send all necessary objects"));
>  			free_refs(ref_cpy);
>  			ref_cpy = NULL;
> -			rollback_lock_file(&shallow_lock);
> +			rollback_shallow_lock(&shallow_lock);

For a moment, I was worried that this line could be reached without
setup_alternate_shallow having been called first.  Fortunately,
shallow_lock is static so it is zero-initialized automatically, making
that harmless.

[...]
> --- a/shallow.c
> +++ b/shallow.c
[...]
> @@ -358,6 +359,22 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
>  	strbuf_release(&sb);
>  }
>  
> +int commit_shallow_lock(struct shallow_lock *shallow_lock)
> +{
> +	int ret;
> +
> +	if ((ret = commit_lock_file(&shallow_lock->lock)))
> +		return ret;
> +	the_repository->parsed_objects->is_shallow = -1;
> +	stat_validity_clear(the_repository->parsed_objects->shallow_stat);

In 'next', some other functions in this file handle an arbitrary
repository argument 'r'.  Should this one as well?  (I.e. can this
patch come with a conflict-resolution patch to handle that?)

[...]
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -471,6 +471,22 @@ test_expect_success 'upload-pack respects client shallows' '

Yay, thanks for the test.  I'll study it more closely tomorrow.

Thanks and hope that helps,
Jonathan
