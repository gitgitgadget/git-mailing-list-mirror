Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1339E1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeHHVxO (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:53:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46392 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHVxO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:53:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so2979388wrw.13
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EqpMREtmeVj1Hr6APoYalN+fjQYSnK5d80XMTERjMpM=;
        b=W0CO0lkpxwZj16egkbz4o/oXflBbBaPrtKBNnCBwD/ksADWGSi3mxbEXF6VrQH9tTR
         7r+weDLDmpXcZw2fgYr7PFZNqM0huOqcRE+lixoG5/LSoqzX8CFEpo5MlGDdlDS+z3AK
         3lr4WrVBnWdh1Jk89evf7a8QrJWhY25LWFx13iJweAqRBTZRH0+rGOHQ+LD+IMwwQq7F
         j8syu4hKuTyK76fCxaxsBljnleO8qps1hQnaJfZKjQa24j0fUmllgfTUJCxEVi7pDv6F
         Zl02RojFEpO7q6H7Mda+k49uC7jnSa0hTaku+IRUevLP2J1oyrQTyswzvjEnVy6tHpN6
         D3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EqpMREtmeVj1Hr6APoYalN+fjQYSnK5d80XMTERjMpM=;
        b=k6H0XZ7yLLQ9TvPxSW8lH5tucca+qoLw/AP9/Usc13lafqb/iDFBikLz5MAkYcBD0p
         fveSMjt0MW/YLW2TcrsQCx2zZxiIiElG0garw+TiAjaMXa+vm48gwXR+TG/Liq4UfnnQ
         KGwzGlvo44GLZUiW0LwQGneJJBVD/XisE6LKHjRXo4y24evdz/J5g0kkKmMU3b3xSgLI
         a0WXIv4ZiSIWceyfEiXWhc+ythU8n9OEBADMsxJvXxDeR+x4OpR3QYN2SxBpMApdmbJB
         CVjdJQdEWPpAOSTdakRy7XO+ckGDu6lTus4g3o25iSiiN3Ze2JWvO0WF+07zexXGV61R
         ELFQ==
X-Gm-Message-State: AOUpUlFn6rqTngdUgpbyKZYWayUDpM0krbtcIgoiPhSKs65176VvyMij
        giz1y4PtmnquBoOKtdNQ0mU=
X-Google-Smtp-Source: AA+uWPySnxU+hsfuy/i71x0o8wIwoIDM28oaIHdLu4TpO6eMFJ3x6wtTO8NXTlJA9tpiGU5zubnvFg==
X-Received: by 2002:adf:a557:: with SMTP id j23-v6mr2656203wrb.220.1533756724211;
        Wed, 08 Aug 2018 12:32:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g125-v6sm6272448wmf.16.2018.08.08.12.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 12:32:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH 03/11] builtin rebase: handle the pre-rebase hook (and add --no-verify)
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <20180808134830.19949-4-predatoramigo@gmail.com>
Date:   Wed, 08 Aug 2018 12:32:02 -0700
In-Reply-To: <20180808134830.19949-4-predatoramigo@gmail.com> (Pratik Karki's
        message of "Wed, 8 Aug 2018 19:33:22 +0545")
Message-ID: <xmqqwot0fydp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> This commit converts the equivalent part of the shell script
> `git-legacy-rebase.sh` to run the pre-rebase hook (unless disabled), and
> to interrupt the rebase with error if the hook fails.
>
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---

Introduction of upstream_arg in this step looked a bit
surprising, but the hook invocation is the only thing that uses it,
so it is understandable.

"rebase: handle the re-rebase hook and --no-verify" would have been
sufficient, without "add" or parentheses.

>  builtin/rebase.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 38c496dd10..b79f9b0a9f 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -70,6 +70,7 @@ struct rebase_options {
>  	const char *state_dir;
>  	struct commit *upstream;
>  	const char *upstream_name;
> +	const char *upstream_arg;
>  	char *head_name;
>  	struct object_id orig_head;
>  	struct commit *onto;
> @@ -310,6 +311,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	};
>  	const char *branch_name;
>  	int ret, flags;
> +	int ok_to_skip_pre_rebase = 0;
>  	struct strbuf msg = STRBUF_INIT;
>  	struct strbuf revisions = STRBUF_INIT;
>  	struct object_id merge_base;
> @@ -317,6 +319,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "onto", &options.onto_name,
>  			   N_("revision"),
>  			   N_("rebase onto given branch instead of upstream")),
> +		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
> +			 N_("allow pre-rebase hook to run")),

Do we need to catch "--no-no-verify" ourselves with NONEG bit, or is
this sufficient to tell parse_options() machinery to take care of
it?

>  		OPT_END(),
>  	};
>  
> @@ -382,6 +386,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		options.upstream = peel_committish(options.upstream_name);
>  		if (!options.upstream)
>  			die(_("invalid upstream '%s'"), options.upstream_name);
> +		options.upstream_arg = options.upstream_name;
>  	} else
>  		die("TODO: upstream for --root");
>  
> @@ -430,6 +435,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			die(_("Could not resolve HEAD to a revision"));
>  	}
>  
> +	/* If a hook exists, give it a chance to interrupt*/
> +	if (!ok_to_skip_pre_rebase &&
> +	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
> +			argc ? argv[0] : NULL, NULL))
> +		die(_("The pre-rebase hook refused to rebase."));
> +
>  	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
>  	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1))
>  		die(_("Could not detach HEAD"));
