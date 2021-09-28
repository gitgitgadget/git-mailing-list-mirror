Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D40C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F28560F41
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhI1DBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 23:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhI1DBC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 23:01:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF82C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:59:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x7so62645007edd.6
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CkZA9fQ3PKGzECX4ZER+C/lejrK7HEq0Rh+Tb4gKbmY=;
        b=quhQMn+Hv4sW20Eiok69iFU1NkQN39YKUS9i2nRak/rMs28KOxEpJFzWAeCvGTzaBA
         j/36jmun+tafVLonzyBxb1+f+jcvl+P6tkzP5IoZ+WplXLBSGldyjk3JRmw8w1xc5q96
         fd7yqSTnZ3cuFlyIsI6QLCweMsot+n5KCE+3CX0GmG1elTHpoe/5+4X/4zKkRAm0XpJa
         kOx4nSujWh11edvtgXELc13SJ9mw+wjXUgcW9JCGzcW3aQdjlv4++HKXA7NzcLNATjuP
         EhK+m8GAgeJmjMj/wWTTvefUZcSjJJyZOQmTyFNozpZPMOzqeEkkh0HFodpRPYDOGodx
         Uygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CkZA9fQ3PKGzECX4ZER+C/lejrK7HEq0Rh+Tb4gKbmY=;
        b=Uyej2YY7EgdYz3xr/LG0rBw3+KW0dO5fWtMs+QNgrWR/JAEhsEhIPOoHoo08DA/1z3
         1T5bN1Mz706VZy+oXjIdM6r8B0E2WoPYj3E7PLe4K+l5e09aEWu8KkjU4LoLUFdF3/d0
         aUJcqtDtIp42Fv//fOwSPoShDzF6ZCa8Z9vL/lhCEZsg2rCRYRdAJ3Re7hfEEe1wVyU6
         noZvpEScO3e7yj3hFGl4mj3T3cV4F6IgSk4WLe0LpOr3sjB8d+Oo3I+wMw/WFhRawoVh
         PPAN4Wh+W9E9jtbm5srFBP2o9NVaIgZyffCbcqzDcWmEhFcf8TLBq9VpS8gewGS1JbBt
         9cZQ==
X-Gm-Message-State: AOAM532GHbnVPOcpYY4yrw2GfuVdXCJ3MEo1tKpj525nUoWf1CuOcOkw
        k+ulGRcmo5LheG0kokmUzKrPoV9Q1gM8hQ==
X-Google-Smtp-Source: ABdhPJyLB9I9d6HMENQ3qgnBF19V7DmbWxV+f9GTlNpy01Z7e+SZNuT6esCDfZYkAJpTtI9jW/IGdA==
X-Received: by 2002:a17:906:a246:: with SMTP id bi6mr3998506ejb.389.1632797961807;
        Mon, 27 Sep 2021 19:59:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k21sm9283791ejj.55.2021.09.27.19.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:59:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Don't ignore transport_disconnect error codes in fetch
 and clone
Date:   Tue, 28 Sep 2021 04:56:37 +0200
References: <20210928001726.2592734-1-mh@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210928001726.2592734-1-mh@glandium.org>
Message-ID: <874ka5z9pz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Mike Hommey wrote:

> When a remote-helper fails in a way that is not directly visible in the
> remote-helper protocol, the helper failure is ignored by git during
> fetch or clone.
>
> For example, a helper cannot directly report an error during an `import`
> command (short of sending `feature done` to the fast-import file
> descriptor and not sending a `done` later on).
>
> Or if the helper crashes at the wrong moment, git doesn't notice and
> thinks everything went well.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  builtin/clone.c | 5 +++--
>  builtin/fetch.c | 6 +++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> What I'm not sure about is whether a message should be explicitly
> printed by git itself in those cases.
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 66fe66679c..f26fa027c5 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1398,7 +1398,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	submodule_progress = transport->progress;
>  
>  	transport_unlock_pack(transport);
> -	transport_disconnect(transport);
> +	err = transport_disconnect(transport);
>  
>  	if (option_dissociate) {
>  		close_object_store(the_repository->objects);
> @@ -1406,7 +1406,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	junk_mode = JUNK_LEAVE_REPO;
> -	err = checkout(submodule_progress);
> +	if (!err)
> +		err = checkout(submodule_progress);
>  
>  	free(remote_name);
>  	strbuf_release(&reflog_msg);

This seems buggy in some cases, e.g. just because we couldn't close()
some final socket we should just not run the checkout at all? Shouldn't
we note the disconnect status, but still see if we can do the checkout
etc?

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 25740c13df..66bccf6f50 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1886,7 +1886,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
>  {
>  	struct refspec rs = REFSPEC_INIT_FETCH;
>  	int i;
> -	int exit_code;
> +	int exit_code, disconnect_code;
>  	int maybe_prune_tags;
>  	int remote_via_config = remote_is_configured(remote, 0);
>  


> @@ -1952,9 +1952,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
>  	exit_code = do_fetch(gtransport, &rs);
>  	sigchain_pop(SIGPIPE);
>  	refspec_clear(&rs);
> -	transport_disconnect(gtransport);
> +	disconnect_code = transport_disconnect(gtransport);
>  	gtransport = NULL;
> -	return exit_code;
> +	return exit_code || disconnect_code;
>  }
>  
>  int cmd_fetch(int argc, const char **argv, const char *prefix)

This seems like it really needs fixes in other areas,
i.e. disconnect_git() returns 0 unconditionally, but should check at
least finish_connect(), no?

Also once that's done you'll have a logic error here where you're
conflating exit and error codes, we should not return -1 from main() (we
do in a few cases, but it's nasty)>
