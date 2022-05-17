Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A2C433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 15:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349551AbiEQPAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349535AbiEQPAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 11:00:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC194BB96
        for <git@vger.kernel.org>; Tue, 17 May 2022 08:00:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m12so7300822edb.6
        for <git@vger.kernel.org>; Tue, 17 May 2022 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eN90coae9ANGsG3DStWBDrc1Dnwn0ESPhRBBmIxPaf0=;
        b=j966wK2ZDuO2t4mYh1O0IL2O8dLqezLvrcHwFAHDNKHd3Ui3zRMiYVfTjj6yWDg+VC
         0YDBHPEra8p7iHxiowS3kEwP6DZDGG9uArbQn824k3aY6sF0eQq6HjgLS5h3/xbV7SaP
         ynC+nXzgxPJn3mg4Oxs66w+s5a8pfnDqIhPjM5fu5JyeLB1BVNRb3g0MYSzyVKhk0fe9
         8Ka43bWNvon35Xvex3gEKpXm8hEqE1unZGa6fIJsPqbDvSth5WoqvhubxGIY3do5QSYz
         c0sf5+FnkgdMUucSNivps4cJP2ElXkPiHCM+7j1QHsqbd/ofY0Z0qI2pnvCeMVd/oubM
         TLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eN90coae9ANGsG3DStWBDrc1Dnwn0ESPhRBBmIxPaf0=;
        b=QWknSZWC8Vz5c4clI/XLTBY6zrG62hvh7zDpW+B4r7VhD2PHB+xff8RU8bo6e5psZI
         jwekXAE8RKfBtEBJ/Q2ZK3un7L/vfmdejHHgRD51YFAVEmlx50EqJiB109QF2ah4Ly0G
         Qxa0S0zzzJ4lcYRuGwTbY418tcC2+tpuTeoruiJp4SaIcZu2VjNWQ7rEA5O83pCdORnk
         SxQVAtqt4L8JZl6C2RiMXIJ0VYHiclVk4mlX4PDCw979qE6xhfJBoglUNtIH9DCJPCYm
         6Hg1q2nnBbyd5ZB1wWHjiE7qkEv3zQsDhtHQUXtW2cSIlbUAJBa8JE82uBCL9N0H4sOF
         ShMg==
X-Gm-Message-State: AOAM531HwrC1L3Y4+DHxc2MJylIL2BPynnFjFCnQriCvwjRlTDP7WImn
        NG2ahqbscpSMc6JpzGJQyPFsLvf8fzU=
X-Google-Smtp-Source: ABdhPJyA0XBhNPkoTWkSPt1O8ngbgUbqDfQ29OJ6Jlttp/flJCu1SM2xrABkrAb57XeXiFY9p+Al4Q==
X-Received: by 2002:a05:6402:268e:b0:427:bb19:f889 with SMTP id w14-20020a056402268e00b00427bb19f889mr19600903edd.33.1652799603483;
        Tue, 17 May 2022 08:00:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i10-20020a50870a000000b0042617ba63cdsm7092536edb.87.2022.05.17.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:00:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nqyg6-001dZ7-BR;
        Tue, 17 May 2022 17:00:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 4/7] Implement `scalar diagnose`
Date:   Tue, 17 May 2022 16:53:17 +0200
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
 <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
 <87bdc22322b0f58bf153b963207cffe4f41c9ae9.1652210824.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <87bdc22322b0f58bf153b963207cffe4f41c9ae9.1652210824.git.gitgitgadget@gmail.com>
Message-ID: <220517.8635h86w7h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 10 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Over the course of Scalar's development, it became obvious that there is
> a need for a command that can gather all kinds of useful information
> that can help identify the most typical problems with large
> worktrees/repositories.
>
> The `diagnose` command is the culmination of this hard-won knowledge: it
> gathers the installed hooks, the config, a couple statistics describing
> the data shape, among other pieces of information, and then wraps
> everything up in a tidy, neat `.zip` archive.
>
> Note: originally, Scalar was implemented in C# using the .NET API, where
> we had the luxury of a comprehensive standard library that includes
> basic functionality such as writing a `.zip` file. In the C version, we
> lack such a commodity. Rather than introducing a dependency on, say,
> libzip, we slightly abuse Git's `archive` machinery: we write out a
> `.zip` of the empty try, augmented by a couple files that are added via
> the `--add-file*` options. We are careful trying not to modify the
> current repository in any way lest the very circumstances that required
> `scalar diagnose` to be run are changed by the `diagnose` run itself.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/scalar/scalar.c          | 144 +++++++++++++++++++++++++++++++
>  contrib/scalar/scalar.txt        |  12 +++
>  contrib/scalar/t/t9099-scalar.sh |  14 +++
>  3 files changed, 170 insertions(+)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 00dcd4b50ef..367a2c50e25 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -11,6 +11,7 @@
>  #include "dir.h"
>  #include "packfile.h"
>  #include "help.h"
> +#include "archive.h"
>  
>  /*
>   * Remove the deepest subdirectory in the provided path string. Path must not
> @@ -261,6 +262,47 @@ static int unregister_dir(void)
>  	return res;
>  }
>  
> +static int add_directory_to_archiver(struct strvec *archiver_args,
> +					  const char *path, int recurse)
> +{
> +	int at_root = !*path;
> +	DIR *dir = opendir(at_root ? "." : path);
> +	struct dirent *e;
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t len;
> +	int res = 0;
> +
> +	if (!dir)
> +		return error(_("could not open directory '%s'"), path);


s/error/error_errno/, surely?

> +	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
> +	strbuf_addftime(&zip_path,
> +			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);

Would we be worse off if we stole this timestamp from some known file
(or HEAD), and thus made a second run of this reproducable?
