Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEA5C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 01:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703BD2245C
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 01:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+qjbu3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLFBsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:48:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35539 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfLFBsG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 20:48:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so2018471plp.2
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 17:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P6nEYEGcOuJCMEuVEqOM3NTdEpY8kCQTuPWf2T5W1TE=;
        b=X+qjbu3BReUlvLt2rUgbqGsYAqhcVmlPT+VQS/1JqrFjJ1+8IggN0OBRW3OY/7L9Ox
         ULXScAfamriQ2bgkvAEuQRS2+JqxMbxaF2B2ZfGBphosAMHukXSDfM0esbqNvEkCxQ51
         olbZAC2n2FXD75dZMQlnEr34LS0bKllxam7pGIGA6AThIXqrmg/dQBAHEpHUPYaT2To/
         nOMh1iIKrAlIWHfmKwIPFU4uLj3mBuLehejdQ2C9Q3k/xyOd1wY5rpd6+YR0RCZvpyjH
         r/lnkJlTyu413meX3zzmTOX0K0270FsnG4wBg25p8aMdwge88coMbtzigGgYPVH3hWbu
         PU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P6nEYEGcOuJCMEuVEqOM3NTdEpY8kCQTuPWf2T5W1TE=;
        b=P4ohNH1pZjI56yB4ry2qA34oOgX7h1LDTC+Ezb5nmHWGpHOPJaW0ULyKZzwneyT18u
         g6Y15cosuET6MBP+hnXZwd2+RvdnaYgxfp40p3RRp3qot++EhD/T5CYNRBc7M9JSE1tK
         IsKZ+EoclVfmiXKjuarhsHoX1UNz9r3oOIMfVPLMs/QY77mKCsywSFbHa0XGoU83B522
         aLMnudIZ3n/JUxd4v3jd73vEuNKtjQUUqWtDbMEJ6u+aHsUV3hfZNKfN8NH/TrF/rTKk
         x/Hl9Ub3IALArycj9/23sn0dwTMREwz+gKzNON2xCfP4CimJcuuq0nd9zIRh9I3KvxLX
         IIgA==
X-Gm-Message-State: APjAAAXYwbyq7PKbIiD1HUNKPboRZ9t39G9XJd0BW+s6fX1o3sm6+2K6
        zQTyi+D+Upue4ADVvTbzL8E=
X-Google-Smtp-Source: APXvYqxKWrNXPfxKWhU43OHHEEIiqLMZzryDMg7OY/Z1E2kqwpXVSRQjuW2tAeoEstF601lYEYIo1w==
X-Received: by 2002:a17:90a:b009:: with SMTP id x9mr12795351pjq.124.1575596885302;
        Thu, 05 Dec 2019 17:48:05 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id b21sm14639559pfp.0.2019.12.05.17.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 17:48:04 -0800 (PST)
Date:   Thu, 5 Dec 2019 17:48:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Alex Torok <alext9@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rebase: find --fork-point with full ref
Message-ID: <20191206014828.GB16183@generichostname>
References: <20191205225322.5529-1-alext9@gmail.com>
 <20191205235704.31385-1-alext9@gmail.com>
 <20191205235704.31385-3-alext9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205235704.31385-3-alext9@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Thu, Dec 05, 2019 at 06:57:04PM -0500, Alex Torok wrote:
> rebase --fork-point needs to look up the full ref name before calling
> get_fork_point in the same manner that merge-base --fork-point does.
> 
> Signed-off-by: Alex Torok <alext9@gmail.com>
> ---
>  builtin/rebase.c             | 4 +++-
>  t/t3431-rebase-fork-point.sh | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e755087b0f..821994f676 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1980,8 +1980,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		struct commit *head =
>  			lookup_commit_reference(the_repository,
>  						&options.orig_head);
> +		char * full_name;

nit: * should be attached to the variable name.

> +		dwim_ref_or_die(options.upstream_name, strlen(options.upstream_name), &full_name);

Also, thinking about this more, would it be possible to put the dwim_ref
logic into get_fork_point() directly? There are currently only these two
callers so I suspect it should be fine and it'll result in cleaner
logic.

We could also squash it down into one patch.

>  		options.restrict_revision =
> -			get_fork_point(options.upstream_name, head);
> +			get_fork_point(full_name, head);
>  	}
>  
>  	if (repo_read_index(the_repository) < 0)
> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> index 78851b9a2a..6ecdae918e 100755
> --- a/t/t3431-rebase-fork-point.sh
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -49,6 +49,7 @@ test_rebase 'G F C D B A' --no-fork-point --onto D
>  test_rebase 'G F C B A' --no-fork-point --keep-base
>  test_rebase 'G F E D B A' --fork-point refs/heads/master
>  test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
> +test_rebase 'G F D B A' --fork-point --onto D master

It's not obvious why this was failing in the first place. Perhaps we
could document it better in the commit message?

Maybe something like:

	We used to pass in the upstream_name directly into the
	get_fork_point() machinery. However, get_fork_point() was
	expecting a fully qualified ref name even though most users use
	the short name for branches. This resulted in `--fork-point` not
	working as expected since, without the full ref name, the reflog
	lookup would fail and it would behave as if we weren't passing
	in `--fork-point` at all.

Also, I'm not why this test case in particular that was duplicated (and
not the one above) given that the first three `--fork-point` test cases
fail without the change to rebase. Perhaps we want to duplicate all
"refs/heads/master" tests with a corresponding "master" test?

Thanks,

Denton

>  test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
>  test_rebase 'G F C E D B A' refs/heads/master
>  test_rebase 'G F C D B A' --onto D refs/heads/master
> -- 
> 2.17.1
> 
