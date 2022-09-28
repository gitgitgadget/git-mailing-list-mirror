Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47D5C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 06:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiI1GBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 02:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiI1GBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 02:01:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743F115A52
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 23:01:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c30so14724775edn.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=hRigmy2Uh77wvD8yvyHPXwPA1sS2z3DuuLk51RJ8u4Q=;
        b=ESHuT1rrojKV7oRi/r2c/lQklx6tdB+dDpkEfGr/hlunTnKYb3lIKBkatXhv9ToWVp
         c/PDdgyOXrsY2qkzH04SMpJzKEo/fbgVAFPjVc3ZRNCSF9aP+AY450LzfubBEMk+iPXZ
         grOnmwKT7jlPJv+tdxfSRjWI25UfKla2I+hWrOXojFCIqLNtqFb7ZuvqWExWoobD91M6
         SrzbHw1nap5bBSOEWaNUjRWX8ExZ0Oc1eI0LFZApeJ57cssBEkwFROMfR6d0xY8jEZJ+
         /BSvXXgLr3ksbGZQYmeY6B64OGGSWtOyY8gdqeCDDWQciVvNH+mFL88js/TEETT9266c
         BgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hRigmy2Uh77wvD8yvyHPXwPA1sS2z3DuuLk51RJ8u4Q=;
        b=1S5pFa6vwl6s0tNjruOAzCyK5hRcgDO/suJtxMHIzNHklkWj/fst8sBLacxOPUx++2
         Ux6kxuHYTTcBfoMiTqvE6bzKK/iRfKq7puR21IQOguGEha0kUl5EEw5FBmZN2zYpTKf+
         K36Se3eCnkhBvQTQIXVNpcu18INRw4h9twZ1TwGMOpEzPTZHsZuAG6tqeiEVJAC6/g2T
         SNldq832ladEoZjfAnYOi2OBMUC/kWtmJktKWIx2U9S1RkD4N+wUqbvKcn5hozsNc9X1
         GcNYl0sWT3EGEM/JbIBJveAv/591gc0Zfnf9xXYdKU/8BgRK2RYMh+QMG1HIGueMQyMp
         LaZA==
X-Gm-Message-State: ACrzQf1ocBrwZMXCjfGxgeNknGXWCUclpT8H1nXj7NXLhF3irtt+3N6Q
        QngrD9AhDdSBstgNtfRnOpk=
X-Google-Smtp-Source: AMsMyM63J07+Er2kjEQ+C5kDFxQUYltsAJmpN/5N3vUrwjkhv/NvJo7SPuMJJmD1ZgrVwpbc6K8eTw==
X-Received: by 2002:a05:6402:40d1:b0:44f:e974:f981 with SMTP id z17-20020a05640240d100b0044fe974f981mr31972140edb.222.1664344869251;
        Tue, 27 Sep 2022 23:01:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906318d00b0078128c89439sm1820371ejy.6.2022.09.27.23.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 23:01:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odQ83-000o7Q-2I;
        Wed, 28 Sep 2022 08:01:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v13 4/6] fsmonitor: deal with synthetic firmlinks on macOS
Date:   Wed, 28 Sep 2022 07:55:56 +0200
References: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
 <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
 <324eb5acd856f6a8122a5239f9fa1a9a8ecc9ee3.1664312254.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <324eb5acd856f6a8122a5239f9fa1a9a8ecc9ee3.1664312254.git.gitgitgadget@gmail.com>
Message-ID: <220928.867d1oxckc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>


> +	if (fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)) {
> +		err = error(_("could not get worktree alias"));

We could keep this, but if we'd error() in the function itself we'd just
emit two error() lines when one would do.



> +	dir = opendir("/");

We should have a:

	const char *const dir = "/";

So we can pass it to this..


> +	if (!dir) {
> +		error_errno("opendir('/') failed");

...and as a parameter to a _()-translated string. That way the next
translation doesn't need to translate opendir('/home') or whatever.

> +		return -1;

Just skip the braces and do "return error_errno()", these functions return -1 for thath reason.

> +	strbuf_init(&alias, 256);
>
> +	/* no way of knowing what the link will resolve to, so MAXPATHLEN */
> +	strbuf_init(&points_to, MAXPATHLEN);

Still need manual memory juggling? Ok.

> +
> +	while ((de = readdir(dir)) != NULL) {
> +		strbuf_reset(&alias);
> +		strbuf_addch(&alias, '/');
> +		strbuf_add(&alias, de->d_name, strlen(de->d_name));

	strbuf_addf(&alias, "/%s", de->d_name);

Or rather:

	strbuf_addf(&alias, "%s%s", root_dir, de->d_name);

If you split that "/" into a variable?

> +
> +		read = readlink(alias.buf, points_to.buf, MAXPATHLEN);
> +		if (read > 0) {
> +			strbuf_setlen(&points_to, read);
> +			if ((!strncmp(points_to.buf, path, points_to.len))
> +				&& path[points_to.len] == '/') {
> +				strbuf_addbuf(&info->alias, &alias);
> +				strbuf_addbuf(&info->points_to, &points_to);
> +				trace_printf_key(&trace_fsmonitor,
> +					"Found alias for '%s' : '%s' -> '%s'",
> +					path, info->alias.buf, info->points_to.buf);
> +				retval = 0;
> +				goto done;
> +			}
> +		} else if (!read) {
> +			BUG("readlink returned 0");
> +		} else if (errno != EINVAL) { /* Something other than not a link */
> +			error_errno("readlink('%s') failed", alias.buf);
> +			goto done;
> +		}
> +	}
> +	retval = 0; /* no alias */
> +
> +done:
> +	if (closedir(dir) < 0)
> +		warning_errno("closedir('/') failed");

Why not return an error for this? If you can't close the dir that
usually means the write or similar didn't work.
