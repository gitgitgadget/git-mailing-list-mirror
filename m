Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF31C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 09:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiAXJ4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 04:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiAXJ4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 04:56:01 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8BC06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 01:56:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id j2so19636271ejk.6
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 01:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jF9uxY7ayWkepQxnvzg8LXFpEYXbGG0YdssBC4ze+VU=;
        b=pV3Hb5qPw1PhKqj7P4mT2kcOxfJJSPzsjDyT84NMO4OBH/JgW5c9YnoeWB8FgNVB80
         a6japqMQEWmNcyeYiM5U0WCsVZ18sP6/CzEgzTXDR0OZ3cPqH+0WGF41w3QvOZeEVTTI
         OMO0ijfSP32Hy+buIrhCKFPEX28w+DI7SHHlAyYxnJ0AGLMZEGzCHdEQ8eFLZzfPPx5V
         Wl9hRC6l4zNAYu+9TSJovoxI6ak/FMBzAdwW7Us+KeAxDmmi2+4IIDiQRC1RFNhT3duh
         UxuBqhk45BkWS0Hn4OOWdluxgNJ4MpGyLJPBCXStPnMVJ6Y4nu/cdC4HNoJWHfy9tVWR
         /9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jF9uxY7ayWkepQxnvzg8LXFpEYXbGG0YdssBC4ze+VU=;
        b=iFmz5iY+U79EJSu41QWFdSuYlclXYm0xWIIImDlaltDTyFIjSuJsShQWGtgqu8PJ/5
         qwgg/JsSLfA/QsidvOmFP5MatdbsgwHhUz4KwR7pdrOVyDvoDoEhCJx3+tY60QpinEEd
         whsDPVwBor7PEOd7N+TCyX0Splg/XYn4jJXrI5TjHDVJNyxq27+8AOTp8M1KRWOxulH3
         LmUCtewlFcBN6WMoh4HTFYUQ9kp3xe2/EBYic7nykggcDkMunbLu0UwpV3DCs2v3og8b
         D0oJoatdoGHY08flteRKwQUROxEU3rXTKOVUuYpfJsEYq8zgIHSnYdVQtSHHqSJ4LrV7
         yEHQ==
X-Gm-Message-State: AOAM530jpJy5D10VKDfH7ecGXK/H4TumuhtxzhEUS6HffwH/5OKrVmiR
        HZWiEXI1i4yj0c2ZoKGKA7jxLZjBAhI=
X-Google-Smtp-Source: ABdhPJzxjeXnsAGbC6WQ6pZlo3GQ8Lmj3WWd409b/eQe+HWDIX3WXb6o0UPAu8OAfstfWdQW5hGG2Q==
X-Received: by 2002:a17:906:3986:: with SMTP id h6mr11252459eje.733.1643018159195;
        Mon, 24 Jan 2022 01:55:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id by22sm4680571ejb.5.2022.01.24.01.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 01:55:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nBw4r-002QEe-W9;
        Mon, 24 Jan 2022 10:55:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 04/12] merge-tree: implement real merges
Date:   Mon, 24 Jan 2022 10:51:13 +0100
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <05bd17686e1404c81542b6bbf69dcd3decb83c5b.1642888562.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <05bd17686e1404c81542b6bbf69dcd3decb83c5b.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <220124.86h79tihjm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:

> +	/*
> +	 * TODO: Support subtree and other -X options?
> +	if (use_strategies_nr == 1 &&
> +	    !strcmp(use_strategies[0]->name, "subtree"))
> +		opt.subtree_shift = "";
> +	for (x = 0; x < xopts_nr; x++)
> +		if (parse_merge_opt(&opt, xopts[x]))

Better omitted WIP code in a non-RFC series?

> +			die(_("Unknown strategy option: -X%s"), xopts[x]);

As a general issue with this series, die(), BUG() etc. messages should
start with a non-capital letter.

> +	printf("%s\n", oid_to_hex(&result.tree->object.oid));

And for both this...

> +		printf(_("Conflicts!\n"));

... and this we can just use puts(). For the former it's just less code,
but for the latter translators also don't need to see the always-there
\n in the translated message.

> +# This test is ort-specific
> +test "${GIT_TEST_MERGE_ALGORITHM:-ort}" = ort || {

Is this ${} trickery really needed? We're not testing with "set -u". So just:
	
	if test "$GIT_..." != "ort"
	then
		...
	fi

> +test_expect_success 'Barf on too many arguments' '
> +	test_expect_code 129 git merge-tree --write-tree side1 side2 side3 2>expect &&
> +
> +	grep "^usage: git merge-tree" expect
> +'

Nit: In most other tests these usage assertions are at the top of the
test, and for those we also make do with just testing the 129 exit code,
which is probably enough here too...
