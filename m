Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1F0C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiGZOm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiGZOmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 10:42:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0532A252
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:42:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m8so17964687edd.9
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fVmO8pHRPbao+l4wqjagT+HnRGGm4O0U1hRR61n3Te8=;
        b=HyOD6yDJiykuz4e3pj8WaRnZlQ70ma8Xx1+HzDERZc3MSswT1S2gzM/qLty/ADS1UJ
         nGttuhiGf1Qe5Bx1JbF4Gv5B7GgQb+y76dHf3i4uxtajyiyOUDj++gWVCIi1Sooe9IUi
         SaLJ4k+1PP9etZkB9ixtUZRJ9WSL2orU1pFfv992JgMqixEjrhWmiAICom+qkjnftvdN
         ZFiiyMxzEcXzBomIblbJzSBp5/tl1ILq6dIY3Jb9nD1YK/GtnRzYXysfWC7pP+C1kr8n
         I2YLSMqHsQzHVc8z8ZlPBugUN/05xEdxMK8FTY/gmLHoXuRh57HLWFa9RBVAcJYaCgW3
         wmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fVmO8pHRPbao+l4wqjagT+HnRGGm4O0U1hRR61n3Te8=;
        b=xv6n0lI4G7OsNM5u6P9M34oFwq6RrB+mZckaK+WnaRvF8Sm+8yHj3EMEn1ihKTWJCZ
         qHHUHATLUamwS/JmDgXajbt561VcVtSpWltgecevp57pl+sGmdnSinT6XZFo71nxuIKY
         ycX7FbQ18vCjOkpo1KQejgf43Op8HlxcNmZieppTmtQX6TMSsJpE12nT8l23zMogs1PT
         D1lDOjql8yAQ9Yw8ROLQFr81jc1hjjxzDlFn6vL1let8s8MraQ6afjOHsZVJYc8nF4x1
         I/zV9sNOiDMWOiAGAuYW06GhG38K27FP91TruiMKW0emIOu4bXyGIsayfGoFQaBmNhem
         h0vQ==
X-Gm-Message-State: AJIora+xc5/nk2xNvfmezJ1/eHDi7CVEHalQCNA0320PcEeAFMPOgHon
        K6Z+8i4bmXLpQaYDFs5WOBw=
X-Google-Smtp-Source: AGRyM1sAZeV9pTIJCDxKXYy+I+9PTaiWINfXRoRSs8TVJfjMw+6qZQKLA1M9Rdv4IoLCFDwAW0U7gw==
X-Received: by 2002:a05:6402:35c1:b0:43b:e079:83be with SMTP id z1-20020a05640235c100b0043be07983bemr15763410edc.80.1658846542716;
        Tue, 26 Jul 2022 07:42:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709067c1200b0070b7875aa6asm6470181ejo.166.2022.07.26.07.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:42:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGLlN-006A7v-3O;
        Tue, 26 Jul 2022 16:42:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/3] log: add default decoration filter
Date:   Tue, 26 Jul 2022 16:39:06 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
Message-ID: <220726.86y1wglyuq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
>  test_expect_success 'log.decorate config parsing' '
>  	git log --oneline --decorate=full >expect.full &&
>  	git log --oneline --decorate=short >expect.short &&
> @@ -2198,6 +2204,23 @@ test_expect_success 'log --decorate includes all levels of tag annotated tags' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log --decorate does not include things outside filter' '
> +	reflist="refs/prefetch/ refs/rebase-merge/ refs/bundle/" &&
> +
> +	for ref in $reflist
> +	do
> +		mkdir -p .git/$ref &&

Let's not use -p, and fail if .git doesn't exist?

> +		echo $(git rev-parse HEAD) >.git/$ref/fake || return 1

Hiding the exit code of the "git rev-parse here, but aside fram that why
is the echo needed at all, can't we just:

	git rev-parse HEAD >.git/ref/fake

But even more generally can't we:

	git update-ref $ref/fake HEAD

?

If we need to manually munge the ref store let's add REFFILES prereq.
