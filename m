Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC364C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 16:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjB0QAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB0QAf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 11:00:35 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E9420D1A
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 08:00:34 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so10623463pjh.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 08:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKGvaTREuAXKzOX+JmG05afPokt0LiWgEOdx0ZSQFVs=;
        b=l2Xf+xz3K/onjGK5v++eyxE8FfApFha+Rg9UxLY23JPRaq7iOnKGgu1EDLW9qJqz9e
         inz0F8KsAJjbjn7A1tlgBuzVDvCzlBL/eLEULWpyGCtv2LVCOwb+BDDDv938S0pcaR5c
         iRH7ndNrDXCwlCeUpLLujo2RzDsUZlHCi2XJn36hGob23+BqxlMaa/2XrFX+mbdEdqrZ
         YkJQsxobOCarIftZOt4BD+2LprJXEIZJske1GNK2gDUVhg38RCFrabycVt2pNM/T0WUN
         hPWyhitigObPOJVMsCtSIxdijq6V9g6SllSRws6+EhewrEPmau1799zcz3OXXmCSQCQo
         X3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XKGvaTREuAXKzOX+JmG05afPokt0LiWgEOdx0ZSQFVs=;
        b=LzLiZcRhSt47MalsyqJNlnctVZEraYEPt/QlB1u3Tta7UD0QJSGb0cDvotLAjAimq0
         RTLRMZN/tjyDk6Iuq4ESSUYEqBJO1XJhZOF/nYatQqs35NBfwBDbKiwO4eZVjMUWhSaB
         xP0CK2AKaG41QtIg7CBFnFJ8fPtNe01yzmKvvLGxurt0tHy03UGvVw7Au8ZAsm2Ji7q2
         Lp0DvApTijtNgOoBQt2cWcv3nNeC/T5EKDk3SkdnHLlGhUsXQWdZVSYVB8evazaYITe9
         YJpdtpMLxIMorL0hsZbzidgbE8ekhjZnSDi8Qk+xhPMqC1yZBuiUG24wNz/z+yEk/xgO
         Z+vg==
X-Gm-Message-State: AO0yUKXQssXy+JEh+BBTfxxmAB9twF1Uoo1MRSzg35T5Kk02MumIClCg
        q2/nG7kgXk+KR7ZKhUbAvqg2XiyrKN4=
X-Google-Smtp-Source: AK7set92xbTprBHiXrX0F0uARydP7/C1rtA+Lg/PlnjkdWfRnwPvq3+5HE3GvxdjU2yqLzTzh4r5+A==
X-Received: by 2002:a17:90a:1997:b0:230:c272:3cfa with SMTP id 23-20020a17090a199700b00230c2723cfamr25947471pji.22.1677513634130;
        Mon, 27 Feb 2023 08:00:34 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a348200b00233567a978csm6348365pjb.42.2023.02.27.08.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:00:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] gpg-interface: lazily initialize and read the
 configuration
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
        <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
        <xmqqmt5orqgv.fsf@gitster.g> <xmqqh6vwrpce.fsf@gitster.g>
        <xmqqlel7rj9z.fsf_-_@gitster.g>
        <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net>
        <xmqqwn4qokug.fsf@gitster.g> <xmqqpmaimvtd.fsf_-_@gitster.g>
        <Y/vf7n2+LN/3Nddi@coredump.intra.peff.net>
Date:   Mon, 27 Feb 2023 08:00:33 -0800
In-Reply-To: <Y/vf7n2+LN/3Nddi@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 26 Feb 2023 17:40:46 -0500")
Message-ID: <xmqqpm9vt7xa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Sorry, I seem to have missed this when you originally posted it. And I
> saw it marked as "will merge to next?" in the latest what's cooking. It
> looks good to me, and I think we can proceed with it (though of course
> it is not urgent and can probably wait until post-2.40).
> ...
> Yes, I think it is good not to do so in this patch. If we want to do it
> now on top, here's a patch. Though I could also see the argument for
> just leaving them.

Ah, of course I completely forgot about the patch and mentioning a
possible follow-on work.

> I looked over the output of:
>
>   git grep --function-context 'return git_default_config'
>
> to see if there were other cases, not caused by fd2d4c135e. But I didn't
> see any.
>
>  builtin/am.c            | 7 +------
>  builtin/commit-tree.c   | 7 +------
>  builtin/verify-commit.c | 7 +------
>  builtin/verify-tag.c    | 7 +------
>  4 files changed, 4 insertions(+), 24 deletions(-)

Nice to see these reductions.  Thanks.

> diff --git a/builtin/am.c b/builtin/am.c
> index 40126b59c5..fccf40f8ee 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2312,11 +2312,6 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
>  	return 0;
>  }
>  
> -static int git_am_config(const char *k, const char *v, void *cb UNUSED)
> -{
> -	return git_default_config(k, v, NULL);
> -}
> -
>  int cmd_am(int argc, const char **argv, const char *prefix)
>  {
>  	struct am_state state;
> @@ -2440,7 +2435,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(usage, options);
>  
> -	git_config(git_am_config, NULL);
> +	git_config(git_default_config, NULL);
>  
>  	am_state_init(&state);
>  
> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
> index f6a099d601..c0bbe9373d 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -37,11 +37,6 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
>  	commit_list_insert(parent, parents_p);
>  }
>  
> -static int commit_tree_config(const char *var, const char *value, void *cb)
> -{
> -	return git_default_config(var, value, cb);
> -}
> -
>  static int parse_parent_arg_callback(const struct option *opt,
>  		const char *arg, int unset)
>  {
> @@ -118,7 +113,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	git_config(commit_tree_config, NULL);
> +	git_config(git_default_config, NULL);
>  
>  	if (argc < 2 || !strcmp(argv[1], "-h"))
>  		usage_with_options(commit_tree_usage, options);
> diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
> index 3c5d0b024c..7aedf10e85 100644
> --- a/builtin/verify-commit.c
> +++ b/builtin/verify-commit.c
> @@ -52,11 +52,6 @@ static int verify_commit(const char *name, unsigned flags)
>  	return run_gpg_verify((struct commit *)obj, flags);
>  }
>  
> -static int git_verify_commit_config(const char *var, const char *value, void *cb)
> -{
> -	return git_default_config(var, value, cb);
> -}
> -
>  int cmd_verify_commit(int argc, const char **argv, const char *prefix)
>  {
>  	int i = 1, verbose = 0, had_error = 0;
> @@ -67,7 +62,7 @@ int cmd_verify_commit(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	git_config(git_verify_commit_config, NULL);
> +	git_config(git_default_config, NULL);
>  
>  	argc = parse_options(argc, argv, prefix, verify_commit_options,
>  			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index ecffb069bf..5c00b0b0f7 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -19,11 +19,6 @@ static const char * const verify_tag_usage[] = {
>  		NULL
>  };
>  
> -static int git_verify_tag_config(const char *var, const char *value, void *cb)
> -{
> -	return git_default_config(var, value, cb);
> -}
> -
>  int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  {
>  	int i = 1, verbose = 0, had_error = 0;
> @@ -36,7 +31,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	git_config(git_verify_tag_config, NULL);
> +	git_config(git_default_config, NULL);
>  
>  	argc = parse_options(argc, argv, prefix, verify_tag_options,
>  			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
