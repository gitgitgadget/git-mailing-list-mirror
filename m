Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784AEC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 22:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjASW5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 17:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjASW5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:57:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC48E59E0
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:40:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b6so2761345pgi.7
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlsyjiZF3af8aWx/llgYYh3BOPOhfORfP6H6HbiHcuw=;
        b=o0fEkaF4LeJqW98p/yQicF11BlsD6G1QGWuAboqmIdybswLYEn73W0hoL/CrOiCKhc
         DS+X39ff4LtdTcYdYB2t1tNBaEeI8C3jhHMvWIQB14bI+9PM7+pBl62cE6K+bW8e04V7
         7Wl57eWKtCKW0aSDhQSrjGMbcEg1RNoBVfEkhsm4Ldx7RJg5OSO8EsHFQ9fKA4aflWk5
         Wd0GhbOekLtHHobMf+m8BxVBDCFuZQbJWYO9ozG9BosXtG6ZpSGBnzjXcvR6MJzi7/2Y
         a5k9UXcAp6oeLoKSjSTQZhW/QrXz1cX6zz7jeGAHXzFrHUe9cGoxNKDePQGoMmOOl5Vj
         0Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LlsyjiZF3af8aWx/llgYYh3BOPOhfORfP6H6HbiHcuw=;
        b=hb9JTC0vrkiYPZkSx7xThIQGeXvBU/UGnpJEjruNLaocARfbSku0710laxxqLpO4pS
         pMMkQldhc9D26zvZc20lX3kLXBmFLLBduYMYZHawMVNLHrxrzYuP9KyrF7w1c99FEeR3
         VI1gTQzc75FBVr7u15Y0tg91dQJEJdupIpHjtiiFQXe0TcRLcRKjtqs0rtuxGT6yAfaC
         T3UnyKq/IMRJwwpoVnhZUpNmu9VNHucxCGlq7ph7uUO3pt5w5qhf3ROMueYsI+ceLGqp
         J30RGnDkOapkaHEtOKG+VFqZGDPM+kp9gobpP8AFxV2jHRS31a7oueQfAcO6Olkbht4L
         SNng==
X-Gm-Message-State: AFqh2kpJbSSyfAOxhYqPXsViM4rjJO/ucjKLqqyf+lyphEX0u290glSu
        kKTO9DAbcICOC8k+BSAYplg=
X-Google-Smtp-Source: AMrXdXuBmyKphshhDYPEm6gXJ82+Qez3giEYJtIdqshcNqPw59O7rCcciJrpv9SaJmnv2WQQWT+lqw==
X-Received: by 2002:aa7:98ce:0:b0:58b:25f9:52c1 with SMTP id e14-20020aa798ce000000b0058b25f952c1mr39407820pfm.31.1674168046092;
        Thu, 19 Jan 2023 14:40:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x1-20020aa78f01000000b005882b189a44sm21159959pfr.104.2023.01.19.14.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:40:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: fix duplicate remote parallel fetch bug
References: <20230119220538.1522464-1-calvinwan@google.com>
Date:   Thu, 19 Jan 2023 14:40:45 -0800
In-Reply-To: <20230119220538.1522464-1-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 19 Jan 2023 22:05:38 +0000")
Message-ID: <xmqq8rhy172q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Fetching in parallel from a remote group with a duplicated remote results
> in the following:
>
> error: cannot lock ref '<ref>': is at <oid> but expected <oid>
>
> This doesn't happen in serial since fetching from the same remote that
> has already been fetched from is a noop. Therefore, remove any duplicated
> remotes after remote groups are parsed.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  builtin/fetch.c          | 1 +
>  t/t5506-remote-groups.sh | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b06e454cbd..508ab2670c 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2225,6 +2225,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			argv++;
>  		}
>  	}
> +	string_list_remove_duplicates(&list, 0);

As it always is possible to edit .git/config manually, it is
necessary to perform deduplication like this patch does on the
consumer side of the list, but do you know if our tool create
duplication, or is it entirely something the end-user does manually?

If it is the former, I am wondering if we should also fix such a
code path that does so in the first place.

Will queue.  Thanks.
