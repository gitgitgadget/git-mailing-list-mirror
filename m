Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF21C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 16:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIZQfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIZQfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 12:35:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B0125DA3
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:23:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bj12so14783359ejb.13
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=ZqMSZdXkuXwIboagWKzkD/dq12w3yWgEd1+wH/rzUB0=;
        b=XyYcFtWonxGpSA7T7AKFybTW/eTD0yjUlLm+ISBLotF/x+lEixswFTAzmxJdqNfUxZ
         iOEvie2HZ0NQ+0WYU15CPB6aQNr1d9aQHlAUJQm3SlLAGTLYYhVlQWyzZfsuNheGKzYP
         V2i0h30DLFHbiPEj0/jraeSfTuHX7FZu+E5ueONMaPvmF+IWkP9YhAv0oo+1l6jrgoc3
         G43MNWNTfEovPkDovExr9/dTxky3jdFXTRPJWQcYG49UDY5n84JDcsrdJlTdHmH46pDN
         rkNfyEGNM1hO9fNYRkT8kuBnbM5K5b6Asf+yxS4XzWSu4ktoYZGb6Cw6WsmAKFpQcXSm
         QcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZqMSZdXkuXwIboagWKzkD/dq12w3yWgEd1+wH/rzUB0=;
        b=UJq45zFpbVG6VJJXipEAGcHe81KOtzpW76YqL1/0WL26AbUZMJmHSkHTq/O/wuNteJ
         UOzIndmt0xrJSXS4C8n66FwaIDFATrqM2Pfe0ZkxYIkFFzsx3PQ5jpcxx+f6K6R1TTiG
         Ej/lf6DWtkHlt1+KH+r6X8vHiKJ/cmDusRE67NH4Dg4AHm65aKV3xNZ1Q6o9xmqV+zOH
         4EqlhVnrg2fVtG56dR96jOEoGlLYmBLXY/HCtgNpG6+q7VioLqCCMvoTjbpddOJXu6E+
         HoZ2E22Y8OQyYTC2EPkSwe23F3P1BRILfNeXPpQigH5eb/akMKTvffm21zGdAOi2RG1e
         q2PA==
X-Gm-Message-State: ACrzQf2t01+36Iuz1NXwNS+DSXAggE7qYix7VgRZ3wBfWsDKjdMNVaU/
        /FCbE8bwV7Q0Phq9iGSjn0I=
X-Google-Smtp-Source: AMsMyM6u5vonBvKv9yfaVMzf+sIMasth/Cn8F2kUgAxJNsMsbH5EhN7CARAyCSXNonN5UBqsJ7Nxmg==
X-Received: by 2002:a17:906:730d:b0:782:a4e0:bb54 with SMTP id di13-20020a170906730d00b00782a4e0bb54mr14501283ejc.659.1664205782507;
        Mon, 26 Sep 2022 08:23:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090609c200b0073dc4385d3bsm8434429eje.105.2022.09.26.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:23:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocpwi-000ACO-2F;
        Mon, 26 Sep 2022 17:23:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v12 4/6] fsmonitor: deal with synthetic firmlinks on macOS
Date:   Mon, 26 Sep 2022 17:16:23 +0200
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
 <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
 <6efdc6ed74ec9224d93a1b88ff8be85d533cb30f.1664048782.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <6efdc6ed74ec9224d93a1b88ff8be85d533cb30f.1664048782.git.gitgitgadget@gmail.com>
Message-ID: <220926.86zgemyxbf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 24 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
> [...]
> +	state.alias.alias = NULL;
> +	state.alias.points_to = NULL;
> +	if (fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)) {
> +		err = error(_("could not get worktree alias"));
> +		goto done;
> +	}

As we can see here this is in the one-off setup code...

> +int fsmonitor__get_alias(const char *path, struct alias_info *info)
> +{
> +	DIR * dir;
> +	int read;
> +	int retval;
> +	struct dirent *de;
> +	struct strbuf alias;
> +	struct strbuf points_to;

...more of a code clarity comment than anything, else, but...

> +
> +	retval = 0;
> +	dir = opendir("/");
> +	if (!dir)
> +		return -1;
> +
> +	strbuf_init(&alias, 256);
> +	strbuf_init(&points_to, MAXPATHLEN);


...can't we just use the STRBUF_INIT macro here instead? most paths are
nowhere near MAXPATHLEN, but more importantly we try to avoid these
sorts of memory micro-managements except for hot codepaths.

In this case it's just the one-off setup of fsmonitor, isn't it? So just
using the default allocation pattern seems worthwhile, and will save
e.g. anyone grepping for MAXPATHLEN looking for bugs (the MAXPATHLEN is
sometimes not the actual maximum pathlen).

> +
> +	while ((de = readdir(dir)) != NULL) {
> +		strbuf_reset(&alias);
> +		strbuf_addch(&alias, '/');
> +		strbuf_add(&alias, de->d_name, strlen(de->d_name));
> +
> +		read = readlink(alias.buf, points_to.buf, MAXPATHLEN);
> +		if (read > 0) {
> +			strbuf_setlen(&points_to, read);
> +			if ((strncmp(points_to.buf, path, points_to.len) == 0)

We usually do (!strcmp()), not strcmp() == 0, ditto strncmp. See
CodingGuidelines.
> +	done:

Nit: labels shouldn't be indented.

> +	closedir(dir);

We checked the opendir() return value, why not closedir() too?

> +	if ((strncmp(info->alias, path, len) == 0)

ditto !foo() v.s. foo() == 0.

> +		&& path[len] == '/') {
> +		struct strbuf tmp;
> +		const char *remainder = path + len;
> +		int ptr_len = strlen(info->points_to);
> +		int rem_len = strlen(remainder);

Make these s/int/size_t/.

> +
> +		strbuf_init(&tmp, ptr_len + rem_len);

And use st_add() here instead of " + ". I don't think it'll overflow,
but it's good to guard overflows out of habit...

> +		strbuf_add(&tmp, info->points_to, ptr_len);

Earlier you constructed a strbuf, and then strbuf_detached() it into
this new "struct alias_info" you made. And now we're having to strlen()
that to get the lenght that we knew earlier?

Can't we just make the member a "struct strbuf" instead? Maybe not, I
have not reviewed that aspect carefully...
