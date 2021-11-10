Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E44C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 04:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D365461175
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 04:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhKJEOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 23:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhKJEOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 23:14:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6527FC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 20:11:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b15so5104720edd.7
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 20:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ph6VE8PpzDXtb8X0OthF/7VDGBWCs4pCcorJMoAR/Lg=;
        b=e64tFZ/6TQqTKPPVjSuoxIh0cVqIJEIxvLMcSIIVgVlMZKB4tLNub9OjcHT5MFInX9
         xyGKzbi3qh96mNw4oPdUHQqrqMTTfx4sBkAZyF++XgyiUL027I1ZZt5eaHxIkpIJ7uID
         7FcawoK/5UPfJAZDs/ZkLrurINA36+wAj+MdwQ9FBn2qg4bI4Vmu/n7+H8A8HI1qnmEk
         +rszWrF9ZahjtRRpWDuQmLuGvNVY4B6wwVpSINjXWR5wEWNCpccNH0rzYEGVri69RDNH
         BaMevoGlh6fA/rWkkgfRFPeQqyDZgVFFDz37ZVGpYd+aJ/FloB4JNWI0WHv8w3esaZYt
         P3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ph6VE8PpzDXtb8X0OthF/7VDGBWCs4pCcorJMoAR/Lg=;
        b=QxVrz8XJi59qeExdceh0UUXry/c419origWxKgPYL9QEpgPY8jyJLnBdpJGUA83rfc
         CrhKnkvjf29vqN8JQaPS5ofm+gVf6R8sccbEy1vB3WTVe8E89gkdmrH2fintehmRo/o2
         wqajIBWCZdUtQIwB5y36kToatZIOxEfOhLw3Jj8l9vK+4v3POYAxz/LhZ/FVoXapXzj7
         GU6gw3RHgTT1AMJI124MCJLykJti46brB5IVCxfig2osf7boctmn4RQSNH0E69EUNZJz
         fqJhyuP6JR9Jn8LLnUB1O0ByPatwNXjR3LNd2ZjGtO9lqUegtr2LQHtZPKOUptChUNEp
         o+Gg==
X-Gm-Message-State: AOAM532m5PgTp/E632KQn5drCS6pJ6Ix8VAmvOhGEmzqaXdRMeK9bBF1
        /do8vstXgtNdFL6MWCNRUNOp1LbF3CPjSA==
X-Google-Smtp-Source: ABdhPJxow5u11nucN5edD16J/HgM3IrgMK+4UQE2JLM73jtMFnnsqJjID1cRjU5kK/Ea3bzkxl2d6Q==
X-Received: by 2002:a05:6402:3552:: with SMTP id f18mr17749914edd.129.1636517478926;
        Tue, 09 Nov 2021 20:11:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cw20sm10416555ejc.32.2021.11.09.20.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 20:11:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkexB-000o9L-Mf;
        Wed, 10 Nov 2021 05:11:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 4/4] branch: Protect branches checked out in all
 worktrees
Date:   Wed, 10 Nov 2021 05:03:24 +0100
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
 <20211109230941.2518143-1-andersk@mit.edu>
 <20211109230941.2518143-4-andersk@mit.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211109230941.2518143-4-andersk@mit.edu>
Message-ID: <211110.86pmr8ira2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 09 2021, Anders Kaseorg wrote:

> [...]
>  	if (!validate_branchname(name, ref))
>  		return 0;
> @@ -208,9 +208,11 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
>  		die(_("A branch named '%s' already exists."),
>  		    ref->buf + strlen("refs/heads/"));
>  
> -	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
> -	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
> -		die(_("Cannot force update the current branch."));
> +	wt = find_shared_symref("HEAD", ref->buf);
> +	if (wt && !wt->is_bare)
> +		die(_("Cannot force update the branch '%s'"

die() etc. messages should start with lower-case. See CodingGuidelines.

Here you're changing an existing die() message, but since it's something
translators will need to re-do let's fix it while we're at it.
