Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41051F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeHPUhK (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:37:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40637 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbeHPUhK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:37:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so5096369wma.5
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oCvF1eWqbKyEFqlkHO/afRdx0pgmMlfIV4AGpZK62Q4=;
        b=IOyB17bnEEG3SJZcrJF3FJdqXOAnPePFBANBLBQnUAImZ34tCN4dlhSKkph2yOP6oX
         QNFRtfldI2GMdbhv2MZtrNulMw/wak3efDqspgTkvsI9AC8o7ykcszCOm1Hv61UxW5RK
         WZs98trwvAqoYdK5BR4KAFTRWyW6pymx8ZVmE8qBbNyauTJW+Vq09WBNDRbJBnz05+jm
         vaIKfhLjMCPC4dnc+InKA+lgs0FzjCo09sGsv+UCll7yNyAgf8Lk/gtC83DdTRwc1lhP
         ljwngbZo3RkVVNERoX8zCbzqKOUIKDwsG46w1DSGhaiBrZIadsFIS3mTry8G7ma0yRj1
         6IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oCvF1eWqbKyEFqlkHO/afRdx0pgmMlfIV4AGpZK62Q4=;
        b=Md1Bz/nokJ4HpjU6ztjt6lWDILwqNVsf24qJ3Vz/MH79XNXeCebShmWTex2bx33UFH
         VxkWx/9gm2s2Ipydg7hGdUGyeGoOKVCT0uFu4PqJZwaQ7geIEfVOhhyAAqdwx2VlBe2h
         xKM+5pbYohmOXyuzLuWjbguyjegNpMoVbbCF5orL6Oyu20UPpxTYrV5yX8bcEfXr02vh
         4hd1wRnTnniFIWw4YEIP3vJRfsBwWD6Kxm22VvXwAtf/d4yQ6fa3HUtdflK7Ha3+Rl/g
         IBrKBAgESWjoCdlVYhlmwn3chuEsQY7Me1+jlp/IdYMKQa//IEm11LYN+7Q24kH8NDLV
         fICw==
X-Gm-Message-State: AOUpUlHzEG1xRXJWoiCTVnVOHMnuux2SwCpm5ySogNzPz+sxdKX+21i7
        PpasTrGqcVpAKWxa4ANm3sw=
X-Google-Smtp-Source: AA+uWPx4Qt+s3/DymAy0TR7cZRiNpCaQqEUkbEipr5Nw5K7Tns5+tjhs7fD7f/yIvXqrJ92OvN19hw==
X-Received: by 2002:a1c:3503:: with SMTP id c3-v6mr14502264wma.46.1534441038005;
        Thu, 16 Aug 2018 10:37:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t198-v6sm3007033wmd.16.2018.08.16.10.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 10:37:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com
Subject: Re: [PATCH 3/7] submodule: is_submodule_active to differentiate between new and old mode
References: <20180816023100.161626-1-sbeller@google.com>
        <20180816023100.161626-4-sbeller@google.com>
Date:   Thu, 16 Aug 2018 10:37:17 -0700
In-Reply-To: <20180816023100.161626-4-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Aug 2018 19:30:56 -0700")
Message-ID: <xmqq600afc1e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The change a086f921a72 (submodule: decouple url and submodule interest,
> 2017-03-17) enables us to do more than originally thought.
> As the url setting was used both to actually set the url where to
> obtain the submodule from, as well as used as a boolean flag later
> to see if it was active, we would need to keep the url around.
>
> Now that submodules can be activated using the submodule.[<name>.]active
> setting, we could remove the url if the submodule is activated via that
> setting.

... as the cloned submodule repository has $GIT_DIR/config which
knows its own origin, we do not need to record URL in superproject's
$GIT_DIR/config.  Back before we started using a directory under
$GIT_DIR/modules/ as a more permanent location to store submodule,
and point at it by a gitdir file in $path/.git to allow removal of a
submodule from the working tree of the superproject without having
to reclone when resurrecting the same submodule, it may have been
useful to keep custom URL somewhere in the superproject, but that no
longer is the case.

> In preparation to do so, pave the way by providing an easy way to see
> if a submodule is considered active via the new .active setting or via
> the old .url setting.

Makes sense.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 5 +----
>  submodule.h | 6 ++++++
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 6e14547e9e0..d56350ed094 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -221,9 +221,6 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
>  	return 0;
>  }
>  
> -/*
> - * Determine if a submodule has been initialized at a given 'path'
> - */
>  int is_submodule_active(struct repository *repo, const char *path)
>  {
>  	int ret = 0;
> @@ -267,7 +264,7 @@ int is_submodule_active(struct repository *repo, const char *path)
>  
>  	/* fallback to checking if the URL is set */
>  	key = xstrfmt("submodule.%s.url", module->name);
> -	ret = !repo_config_get_string(repo, key, &value);
> +	ret = !repo_config_get_string(repo, key, &value) ? 2 : 0;
>
>  	free(value);
>  	free(key);
> diff --git a/submodule.h b/submodule.h
> index 4644683e6cb..bfc070e4629 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -45,6 +45,12 @@ extern int git_default_submodule_config(const char *var, const char *value, void
>  struct option;
>  int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
>  						     const char *arg, int unset);
> +/*
> + * Determine if a submodule has been initialized at a given 'path'.
> + * Returns 1 if it is considered active via the submodule.[<name>.]active
> + * setting, or return 2 if it is active via the older submodule.url setting.
> + */
> +#define SUBMODULE_ACTIVE_VIA_URL 2
>  extern int is_submodule_active(struct repository *repo, const char *path);
>  /*
>   * Determine if a submodule has been populated at a given 'path' by checking if

This change assumes that all the existing return sites in the
is_submodule_active() function signals true with 1 (or at least some
value that is different from 2).

But the part that uses submodule.active as pathspec list calls
match_pathspec() and uses its return value to signal if the module
is active.  match_pathspec() in turn uses dir.c::do_match_pathspec()
which signals _how_ the set of pathspec list elements matched to the
given name by returning various forms of true, like MATCHED_FNMATCH,
etc.

So I think this patch is insufficient, and needs to at least change
the "submodule.active" codepath to return !!ret; otherwise, a caller
that now expects 0 (not active), 1 (active but can lose URL) and 2
(active and the presence of URL makes it so) will be confused when
one of the MATCHED_* constants from dir.h comes back.



