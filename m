Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A4C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 19:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiBJTeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:34:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiBJTeD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 14:34:03 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F242D62
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:34:03 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q16-20020a170902edd000b0014d6be8d4b7so2081374plk.18
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=GIRPnrHULHqTPaJl2XHjp18gUoZLEsysfhh6+ViTvm4=;
        b=ZJXETu0ztckNkdtGt9SWF6md/iBjF+LAfIJo1ZIXWP6zC7yZA0UkyJtp3O2WHf9cGp
         AEx8NizV/nAjsM4PzRSShAg6DO3eg+8GyxF8QJcpHiQxjrpEczJEYKox/TBLY+Bl7Wt/
         SGF6r9MzAWI6V74gxfDDlt3hR8AAR7M6cDfN2rJDvUMdWCyDK3v9RMpEA/8ZNd1Zbwg/
         elxq1HcFZpNjurdp++B0zjkeCwmC6okME8KrUZFtaCPnq907bkGGzt7imjYqUUFT5FC7
         9Dzt28THVmf4xij5VO8tV2DWpkCyjfrN54rSPWQSU/geyZlzSl6tHMMTDvZ8PtllZch9
         HsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=GIRPnrHULHqTPaJl2XHjp18gUoZLEsysfhh6+ViTvm4=;
        b=phqyumKXNm3ZUi0ajLLVAM6LNbAx2cMXBEPud/U2lQuDPO8UAEVTZfs/RnjpJVaSw9
         iWMzQ3JkCk2u/dJM6GfQ63lC2SkCxFOlFHgy7ThUKeIZo9E7UJkpI6SMReoeyIdG/JRD
         DjTaBX5HHqkE0ZNJ2E7IJN0LWCMaf7Q5DCM9/nCMKDOtXO5DzotU9eo8JHntBKDPz25r
         dnMZB5+IrEfSnox7tSGntGqzWu1fCebwJkcNAVVzXPIe3wuIg8m0ARX3gTfg02UL1m3X
         CeMCBPykYwrrpqlQH9wM6eDwZGPrs+varWb5KqxaNV5zpVWr5x7/J9c3B/oB+Ff+6S7L
         j6AA==
X-Gm-Message-State: AOAM533Uw5puja+Ggkj43abNJcYSTBjbmwY/xK0mMpTiKUDMpcMR7Z9E
        hponJVH9X7DYp/+y8L7ZEj2y6psibZ64dlprCHcX
X-Google-Smtp-Source: ABdhPJzTmhYn+RqIEzQN3m/2hVAA/bW7QSmOtBOY6yUmtzs5dq94lADDp+WuIIHDViMNiwP9mDviusQm83xeUN86q0AW
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:1262:: with SMTP id
 34mr7347395pgs.194.1644521643004; Thu, 10 Feb 2022 11:34:03 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:33:59 -0800
In-Reply-To: <20220210044152.78352-7-chooglen@google.com>
Message-Id: <20220210193359.664132-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 6/8] submodule: extract get_fetch_task()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> Extract the index iterating code into an iterator function,
> get_fetch_task(), so that get_next_submodule() is agnostic of how
> to find submodules. This prepares for a subsequent commit will teach the
> fetch machinery to also iterate through the list of changed
> submodules (in addition to the index).

The transformation looks correct, but there are several things that
would have made it much easier to review.

> @@ -1507,41 +1505,17 @@ static int get_next_submodule(struct child_process *cp,

[snip]

> -		if (task->repo) {
> -			struct strbuf submodule_prefix = STRBUF_INIT;
> -			child_process_init(cp);
> -			cp->dir = task->repo->gitdir;
> -			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> -			cp->git_cmd = 1;
> -			if (!spf->quiet)
> -				strbuf_addf(err, _("Fetching submodule %s%s\n"),
> -					    spf->prefix, ce->name);
> -			strvec_init(&cp->args);
> -			strvec_pushv(&cp->args, spf->args.v);
> -			strvec_push(&cp->args, default_argv);
> -			strvec_push(&cp->args, "--submodule-prefix");
> -
> -			strbuf_addf(&submodule_prefix, "%s%s/",
> -						       spf->prefix,
> -						       task->sub->path);
> -			strvec_push(&cp->args, submodule_prefix.buf);
> -
> -			spf->count++;
> -			*task_cb = task;
> -
> -			strbuf_release(&submodule_prefix);
> -			return 1;
> -		} else {
> +		if (!task->repo) {
>  			struct strbuf empty_submodule_path = STRBUF_INIT;
>  
>  			fetch_task_release(task);
> @@ -1562,7 +1536,44 @@ static int get_next_submodule(struct child_process *cp,
>  					    ce->name);
>  			}
>  			strbuf_release(&empty_submodule_path);
> +			continue;
>  		}
> +		if (!spf->quiet)
> +			strbuf_addf(err, _("Fetching submodule %s%s\n"),
> +				    spf->prefix, ce->name);
> +
> +		spf->count++;
> +		return task;
> +	}
> +	return NULL;
> +}

You could have retained the "if (task->repo) { } else { }" structure
instead of adding a "continue;".

Also, the "if (!spf->quiet)" could be moved into get_next_submodule(),
but I see why it's there (it needs ce->name, which we otherwise don't
need), so leaving it where it is in this patch is fine too.

> +		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix,
> +			    task->sub->path);

It would have been clearer if this line wasn't rewrapped.

As a reviewer, sometimes it's hard to make the tradeoff between asking
the author to make formatting changes versus leaving it alone because
the reviewer has already inspected the changes and decided that any
errors are only in formatting, not in logic. In this case, though,
because there is only one more patch in the series and the formatting
change I'm suggesting here won't really affect it that much, I think
it's better if you make the formatting change for the benefit of other
reviewers who are currently reviewing this patch set, and anyone looking
at this commit in the future.
