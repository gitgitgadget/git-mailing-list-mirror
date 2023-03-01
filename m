Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52449C678D4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 23:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCAXqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 18:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCAXqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 18:46:43 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF1F51FA2
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 15:46:14 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id cl18-20020a17090af69200b0023470d96ae6so1231472pjb.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 15:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677714362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=40brvOkCscjNrHnUeDgqVv82gvYQy+4kd5sr0JPvdqw=;
        b=dE/k7ZzcANysG60kxbFlPLbxDaUNTJNjIzi2WgQFFZjLnZH3RXUwJXdt1v/KpjfpOv
         elye8wUVVwQEyTo7rAY2jxViByFBkNinERDiav4bZNnDoEDLmd1gF9TG+v2HK1qlqUnK
         AcKV4qPJZLYkivflrGelgUy/lY0bqKfktO8P0DWfg47/HgdO1LGMlYeLx5mNd6jQ8bh8
         pEh1jmSlJ+KkpSxwVlzH6VmKXUgdkc0dHe7tUQc3uRUFIgOpHyPAGUtOXKE06g36v3w2
         YE5g6nhNYg3yl9SMY9JarNvzg286HLWzysLoSwX85lcyqt6LuzQ2cFGVJQaLON4LWGg9
         evng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677714362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40brvOkCscjNrHnUeDgqVv82gvYQy+4kd5sr0JPvdqw=;
        b=kJeEjE9ZYZkZaVx7MWhumrD/APg8gQ6xBri+dgfQw9OLBu1QO8s+0MIGyYXDL8TvjS
         SuKzMsJ+lDhRu2Aa8RVTh2YOn1vYrYJi2YjF6b3aA7VbnOZpU4egkcUMPlkX5pKWPb7D
         LOnvr5DEffel1fYIceFQZosgDYK/XY8aVti83VOCkaWtOgD57aZGpO0nNbmejIL4Sprm
         B6SDpaEDAFD0Db1Zv1We/nyMHyRJrLI7FNGw1a4MceW6zxZlbpqbTjalB0/tSrtqGDD9
         Fjw4wZ3ypTIvwsTHQ0vvlXhaXZNpfc10Hwd2dLvVo09iknPQAUrqMTA+NhhYDQKB2t2o
         Ag/Q==
X-Gm-Message-State: AO0yUKW/a+eceaSF5cj2tpg0q5s7IZERmCfQyE1JQjKs3wWToiTBBWgD
        ukNEw5O2zMfScBIUCKcPpr0LJjrdbl5SBw==
X-Google-Smtp-Source: AK7set+yaQoN5uDdT3cv/RkKR7b2AA7gqq2YPyIup65LPcvFV2wuM1dTPl2N5mP/YTU6aWTFiZKg64Vq2QyAwg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a62:d44c:0:b0:592:5eb2:84ea with SMTP id
 u12-20020a62d44c000000b005925eb284eamr3120894pfl.4.1677714362093; Wed, 01 Mar
 2023 15:46:02 -0800 (PST)
Date:   Wed, 01 Mar 2023 15:46:00 -0800
In-Reply-To: <20230225180325.796624-3-alexhenrie24@gmail.com>
Mime-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com> <20230225180325.796624-3-alexhenrie24@gmail.com>
Message-ID: <kl6lmt4w3uiv.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 2/3] rebase: deprecate --rebase-merges=""
From:   Glen Choo <chooglen@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
> empty string argument) has been an undocumented synonym of
> --rebase-merges=no-rebase-cousins.

[...]

>  	if (rebase_merges) {
>  		if (!*rebase_merges)
> -			; /* default mode; do nothing */
> +			warning(_("--rebase-merges with an empty string "
> +				  "argument is deprecated and will stop "
> +				  "working in a future version of Git. Use "
> +				  "--rebase-merges=no-rebase-cousins "
> +				  "instead."));
>  		else if (!strcmp("rebase-cousins", rebase_merges))
>  			options.rebase_cousins = 1;
>  		else if (strcmp("no-rebase-cousins", rebase_merges))

As I mentioned in my review of patch 3/3, I think we might be better
served by saying that --rebase-merges="" is a synonym of --rebase-merges
(aka give me a sane default) instead of giving a specific value like
"no-rebase-cousins". This would be give us leeway to change the default
behavior in the future.
