Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65397C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbhLUV2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbhLUV2P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 16:28:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA0C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:28:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id bm14so382066edb.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=S6Q35lsfJxUVYqnLA/SFMKzPD4jJj/mn8qo8b2ZIYJU=;
        b=cBCwVHrGRUZepSFNWSmfZ2Bpz47HVSMRlBiO8oaK7iXC1DTM/lnZMlsBpE2rlBNqtE
         Ai4GVqqn6hBkhCEkSAEHSzsUomyzmgA6ZYBAUCDpxH2yaMBxur+MwAi/aTlItNJOAebP
         PjriY6uSumKjGCcmAX9+971HFbuz//OAUaVSuOhUOcnjJswkB9sMND3Ef/WIzDUxo0Jo
         ndYkNQjxnFP60FXaC6Pa6780jHOLt1VFCiAvoS3Ba7G5LKYSViclt+l0MnSxu2I/JBq3
         4Ax+EjHnyEIdNkVA5OD1x2c0fbVSMi2AEPSaVqvStMdWPbIJGfb0yq1Vl+Xw8lMpH+QU
         EK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=S6Q35lsfJxUVYqnLA/SFMKzPD4jJj/mn8qo8b2ZIYJU=;
        b=Bjfn0XM6SWpTpN2ORc9yv5Ssmm1FFOC1nc98NOQD+G2kr9iK+2cAE1kCoIIOTPrs/d
         xOkBtuGp6klrwFK+IiILol9li3D47l8MDS+7U5mAIG1MB84yo+yE3Q6pyHa3sLk8VZoA
         NyoHiU4AcFGo/YZ/+gGL9zSILndhhZ9qFDuRgSLvy9FyxCxVDPRi+rVfZr0y39LcaO7W
         NoPDHFfuFnUv337bIVs8rN4Yj4y8rMPWpriSghe+yoCj3stxBEeD9Q/+lbgHU98wegJ4
         ioKMECuj0NdxrTtDOxQluk3W9BSejXM0krrYljI+OyIfFfQceYErmgOw7C1+T6FUBUwq
         dvfg==
X-Gm-Message-State: AOAM533LctQxJ9GVNL22m/Ej/9L24juYw33bRAMqCgxApBwGf13p2r+B
        Ypk5VhFDtM8R28aYlsLXxoJbbiq1zDk=
X-Google-Smtp-Source: ABdhPJwY95b2/woYIsfJXuN00/2cGfphe2BIswx/M27Gp4MwW6BnaNFF4agHzXGJfKOsTUcFC6Ii/g==
X-Received: by 2002:a17:907:7b9a:: with SMTP id ne26mr157384ejc.240.1640122093407;
        Tue, 21 Dec 2021 13:28:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ji4sm18888ejc.148.2021.12.21.13.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:28:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzmg8-000x1x-A8;
        Tue, 21 Dec 2021 22:28:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 8/9] show, log: provide a --remerge-diff capability
Date:   Tue, 21 Dec 2021 22:23:41 +0100
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <5d5846be0bd67b8fd850ef2583beef064481a67d.1640109948.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <5d5846be0bd67b8fd850ef2583beef064481a67d.1640109948.git.gitgitgadget@gmail.com>
Message-ID: <211221.864k71r6kz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>

> +	if (rev->remerge_diff) {
> +		rev->remerge_objdir = tmp_objdir_create("remerge-diff");
> +		if (!rev->remerge_objdir)
> +			die(_("unable to create temporary object directory"));

It looks like the tmp_objdir_create() API is rather bad about mixing
errors that would come with an errno with others, but shouldn't this be
die_errno() in the case where it would fail due to a syscall? Even
better would be passing a "gentle" to it and have it emit the
appropriate errors.

> +	if (rev.remerge_diff)
> +		die(_("--remerge_diff does not make sense"));

s/_/-/


> +	struct merge_options o;
> +	struct commit_list *bases;
> +	struct merge_result res;

nit: could use "= { 0 }" instead of memset below.

> +	/* Re-merge the parents */
> +	merge_incore_recursive(&o,
> +			       bases, parents->item, parents->next->item,
> +			       &res);

style: odd not to have arguments that fit on the line on
the line, i.e. "&o, bases, ...".

> +	/* Clean up the temporary object directory */
> +	if (opt->remerge_objdir != NULL)

style: if (!x) not if (x != NULL)
