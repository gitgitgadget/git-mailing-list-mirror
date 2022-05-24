Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B32C433FE
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbiEXVl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbiEXVlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:41:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4036159
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:41:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n23so24787712edy.0
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GtQM5umJNKJJzPlnYFVPre9cgvbY/my7u7+jZPd180o=;
        b=p7IeF9num9NQ06CBmreohhKQsKg+OPKx5oLPxXKrFZHrVjj/g0jP0uVN5Q++ICFex6
         fN2vi7wI6BAmfKqdZlaS8MgrszjfmXf4WSbfcFPop7yKe3SODZS94NxJkdxH4PPHVDpb
         m/iXKPmyYhfuYQILcoGac+++LmLVmwbz1c662ZjvdCkiptlfUxjU8xZ2oZrxTtQni6vl
         o8G7FA2PyBXYLhCvfSffS61PgXJU+NoLk5ScESioaq+hYYdF/HtolMjjQZJcO0yQvL02
         oAPKUWtTk9M3E8R3FOgf6hGh7KArkD2eUqdVGfNG0sQPQAYG+pnjrvy76ltIE5O1VNV7
         ZnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GtQM5umJNKJJzPlnYFVPre9cgvbY/my7u7+jZPd180o=;
        b=UgRq08uR7vZ0kQ6z29xVczl7Jhg4CeYLaX1DzNrv8uzzOisJmgnsCO9QMNtvmGxNco
         StLPpYu73ntg1Rb1tpBzGJF1AKZh6bY1vIzkkR1dfCznrqNccAXcH+QIwEa1As+F5VMS
         OXkFEbbHUDyQ9cVDWHuWpY2j5VLsvsp9dRDal1PQNpGeomL+uQIFpXKIT/TpKxqXWCqy
         TzSdNOD7IV5Xi0qBZsjhUFS4GKX0+dJ+BgzmEV0S41oOr9ZONHzl7Sq92PWIVih9UwG8
         Yb2dj2npH1J642qN6R2Et1OwjbnJxLh9BCCrbKx4pVZYdpdlgYJr79nQxHcVUdA0CJCz
         Fx1w==
X-Gm-Message-State: AOAM5339IpTpszr464FD4p55DM82qEy4bFuQas7rWZOZsWVg9qT+bX04
        C1D7J/SSKB8zvNllr/0QPeeqvn1ZqZc=
X-Google-Smtp-Source: ABdhPJzhuB1bv1B5G+X4lFKubZ5UKe+M1G1HWdQ2kIN8AcEDYUqFdT7FbNKsKvnJfIoKtK2SDL5nNA==
X-Received: by 2002:a05:6402:5205:b0:42b:2678:998a with SMTP id s5-20020a056402520500b0042b2678998amr24384528edd.250.1653428480294;
        Tue, 24 May 2022 14:41:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709070b1800b006f3ef214e5csm5638615ejl.194.2022.05.24.14.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:41:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntcHH-003bjz-80;
        Tue, 24 May 2022 23:41:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shao-Ce SUN via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Shao-Ce SUN <sunshaoce@iscas.ac.cn>
Subject: Re: [PATCH] Fix wrong info in `INSTALL`
Date:   Tue, 24 May 2022 23:39:31 +0200
References: <pull.1241.git.1653424998869.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1241.git.1653424998869.gitgitgadget@gmail.com>
Message-ID: <220524.86a6b6vcao.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Shao-Ce SUN via GitGitGadget wrote:

> From: Shao-Ce SUN <sunshaoce@iscas.ac.cn>
>
> The user prompt should be `$` instead of `#`.
>
> Signed-off-by: Shao-Ce SUN <sunshaoce@iscas.ac.cn>
> ---
>     Fix wrong info in INSTALL
>     
>     The user prompt should be $ instead of #.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1241%2Fsunshaoce%2Finstall-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1241/sunshaoce/install-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1241
>
>  INSTALL | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/INSTALL b/INSTALL
> index 4140a3f5c8b..7bb3f48311d 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -5,8 +5,8 @@ Normally you can just do "make" followed by "make install", and that
>  will install the git programs in your own ~/bin/ directory.  If you want
>  to do a global install, you can do
>  
> -	$ make prefix=/usr all doc info ;# as yourself
> -	# make prefix=/usr install install-doc install-html install-info ;# as root
> +	$ make prefix=/usr all doc info ; $ as yourself
> +	# make prefix=/usr install install-doc install-html install-info ; # as root
>  
>  (or prefix=/usr/local, of course).  Just like any program suite
>  that uses $prefix, the built results have some paths encoded,
> @@ -20,10 +20,10 @@ config.mak file.
>  Alternatively you can use autoconf generated ./configure script to
>  set up install paths (via config.mak.autogen), so you can write instead
>  
> -	$ make configure ;# as yourself
> -	$ ./configure --prefix=/usr ;# as yourself
> -	$ make all doc ;# as yourself
> -	# make install install-doc install-html;# as root
> +	$ make configure ; $ as yourself
> +	$ ./configure --prefix=/usr ; $ as yourself
> +	$ make all doc ; $ as yourself
> +	# make install install-doc install-html; # as root
>  
>  If you're willing to trade off (much) longer build time for a later
>  faster git you can also do a profile feedback build with
>
> base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c

This looks good to me, FWIW I dug into this slightly and didn't know
that POSIX had this to say about it:

        This variable is used for interactive prompts. Historically, the
        "superuser" has had a prompt of '#'. Since privileges are not
        required to be monolithic, it is difficult to define which
        privileges should cause the alternate prompt. However, a
        sufficiently powerful user should be reminded of that power by
        having an alternate prompt.

See https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xcu_chap02.html#tag_23_02_05_03

The one suggestion I have here is that the $subject should be clearer, e.g.:

    INSTALL: use '#', not '$' for root-run command prompt

Which in this case would both be better in --oneline output, and be
enough to get rid of the commit message body entirely (unless it wished
to say something more on the subject).
