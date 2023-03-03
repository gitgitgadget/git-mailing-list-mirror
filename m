Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00152C64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 18:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCCSCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 13:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCCSCG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 13:02:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B845C121
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 10:02:01 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so3029789pja.5
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 10:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If1xzg0uDtSsxoU6ZZo0S19LtmkTiuV/l85xcdDVDMc=;
        b=SMlG1AoUlM34EVnyPnxqbaIOAsDX93eZ3PxK5xRXC+nV3RRMq/8PqXBjeaUIaiYkbk
         U+u+tuqP+1gs4eVKZBwx8QgIvhR7JtYI5B3IeIO9fjeGVNmsT0F2er3IMppZNzKYZjOa
         1+q6QFWC7p4Jr3taNtS3KaYJDUnxcKjcJWIYwMh3dypBKa02KwoiCLQ6b4WABBToXAc6
         6eIVPFIR6mzbrIgYuSfgooSVAXwbLorAO4CnQy+Uv3RqyG+t8PAQAgh1qRxgj8HLXmUB
         YhpuzBo9FhZP78AeUQ8tK1r86BFnOB4MNqE5IdXtBCFDFIVfTJ4pilo/6arfsLVVW6YS
         GWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=If1xzg0uDtSsxoU6ZZo0S19LtmkTiuV/l85xcdDVDMc=;
        b=VCE7JcSs9owV1JTwcKf6m0bYUlMuMdQrlSTUb7UmGydWPXyrTi5ZC5vXTwMfPsAE73
         Z4rqeRhNpI3dXa1DDFz0QH/GnQPLBHVXvqEgZ5xBFRPhdocHEgoOSshwBkzWAEY9DzbT
         aZwU6QI9cgKmITgxVeprUlYk1eCx1+Nu+tAA4ptyC6xzDJcfMsM/b9/SFfGiCquWTIfK
         pvp70/lWYtyUo+EdKgmLm/ymjW8wq1bvyLIGLDoPq/ZgmDf8mTsmYGoOW452rqUIfXVV
         FbAXu1gdNNOwgMueLxrKobLEslNzXATOO4VknHuHPM0XAg6EhRMTpEMFvpk1uL1kIrBi
         Y96g==
X-Gm-Message-State: AO0yUKXogmUPVPS6SfC1C9uqF7u+NinefTW00CiPM2KBlRLqyrLswcaM
        cQs+ImQpKk52MghAV9KKmc0=
X-Google-Smtp-Source: AK7set+lC0iTPR9lyRioxBdKMVA/km6bqcH9rAxw5fIaO58+Z5MgW1m9Opv/0/2Lqs0Y2VenmvRRwQ==
X-Received: by 2002:a17:902:d4c3:b0:19c:c184:d211 with SMTP id o3-20020a170902d4c300b0019cc184d211mr3064491plg.37.1677866521232;
        Fri, 03 Mar 2023 10:02:01 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id kr14-20020a170903080e00b0019ac7319ed1sm1807105plb.126.2023.03.03.10.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 10:02:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/6] config.c: plumb config_source through static fns
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <ad513d832d8267f9e4805db5e7a9e8915fc62a23.1677631097.git.gitgitgadget@gmail.com>
Date:   Fri, 03 Mar 2023 10:02:00 -0800
In-Reply-To: <ad513d832d8267f9e4805db5e7a9e8915fc62a23.1677631097.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Wed, 01 Mar 2023 00:38:12
        +0000")
Message-ID: <xmqqh6v1g1d3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static int handle_path_include(const char *path, struct config_include_data *inc)
> +static int handle_path_include(struct config_source *cs, const char *path,
> +			       struct config_include_data *inc)

Because handle_path_include() has no remaining reference to cf after
this patch, it may make sense to name the parameter "cf", instead of
"cs", taking advantage of the fact that it will cover/hide the global.

> -static int prepare_include_condition_pattern(struct strbuf *pat)
> +static int prepare_include_condition_pattern(struct config_source *cs,
> +					     struct strbuf *pat)

Ditto.

> -static int include_by_gitdir(const struct config_options *opts,
> +static int include_by_gitdir(struct config_source *cs,
> +			     const struct config_options *opts,
>  			     const char *cond, size_t cond_len, int icase)

Ditto.

> +static int include_condition_is_true(struct config_source *cs,
> +				     struct config_include_data *inc,
>  				     const char *cond, size_t cond_len)

Ditto.

> @@ -441,16 +445,16 @@ static int git_config_include(const char *var, const char *value, void *data)

Adding a member to the callback data struct to pass cf around would
be the natural next step, I presume.  I wonder if that makes the
result too big if it is done in this same commit.  I suspect that it
would be easier to grok the whole picture if it were done in the
same commit, though.

If not (IOW, if we deliberately leave some use of the global in the
callchains unfixed with this step), it may make the resulting patch
much easier to read if you (1) rename the global to a longer name
that stands out more, e.g. cf_global, and (2) add a new parameter
'cf' to these helper functions and pass 'cf_global' through to the
callchain.

> -static int get_next_char(void)
> +static int get_next_char(struct config_source *cs)

Ditto for "cs" -> "cf".

> -static char *parse_value(void)
> +static char *parse_value(struct config_source *cs)

Ditto.

> -static int get_value(config_fn_t fn, void *data, struct strbuf *name)
> +static int get_value(struct config_source *cs, config_fn_t fn, void *data,
> +		     struct strbuf *name)

Ditto.

> -static int get_extended_base_var(struct strbuf *name, int c)
> +static int get_extended_base_var(struct config_source *cs, struct strbuf *name,
> +				 int c)

Ditto.

> -static int get_base_var(struct strbuf *name)
> +static int get_base_var(struct config_source *cs, struct strbuf *name)

Ditto.

> -static int do_event(enum config_event_t type, struct parse_event_data *data)
> +static int do_event(struct config_source *cs, enum config_event_t type,
> +		    struct parse_event_data *data)

Ditto.

> -static int git_parse_source(config_fn_t fn, void *data,
> -			    const struct config_options *opts)
> +static int git_parse_source(struct config_source *cs, config_fn_t fn,
> +			    void *data, const struct config_options *opts)
>  {

Ditto.

> -static void die_bad_number(const char *name, const char *value)
> +static void die_bad_number(struct config_source *cs, const char *name,
> +			   const char *value)

Ditto.

> @@ -1304,7 +1312,7 @@ int git_config_int(const char *name, const char *value)
>  {
>  	int ret;
>  	if (!git_parse_int(value, &ret))
> -		die_bad_number(name, value);
> +		die_bad_number(cf, name, value);

And using a more visible name like cf_global will leave us a
reminder here what is remaining to be converted, like this place and
the callback function driven by config_with_options().


