Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF7FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 23:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiCDX4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiCDX4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:56:52 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572AC27B910
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:56:03 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id a21-20020a1709027d9500b00151cc484688so363697plm.20
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 15:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=yWrSpUE2GOUHpChG4THBU7iVLtDYyeIw7a9EkpmIKs0=;
        b=h2QS4zDFbIKCyblPS4ptEtWi4Cguzuwit3f9DHxP6xfA4Dh9u78bCWo4ESN+KT5Rjp
         MovuyNlgAeYPCyYpMklm28UZFIQ41TNtwBds3uxS0Gm2UfcXSgmnevJM9Zv+TFlNw0Fe
         KB4PMDq2ke/bdhA8D+lqqYs/w2B3PBJIfNxDbyxNNE7Di5h7utO0ieKDWFcAT8AuzSMJ
         s5nI7LoZmDfTaEbxp5eawLWPra6BUS7X2kkCRK3msJZI2vByxIYvPJEKv/BqBBSn0Imp
         fBVltKNxWmLTOqOo8+znSU4b4R0u9RKsgrIUcXG7UZXr6OCJ6RxduJq8W0O0x8bqO9C3
         MVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=yWrSpUE2GOUHpChG4THBU7iVLtDYyeIw7a9EkpmIKs0=;
        b=TOhUojIv1JHMbAyKhAwQW6Lk8+1QIIbO8TigQDzdecifdEWsftttrlE780MoGzXU3P
         XgZUbpvoM6EVDuovL8DYzv1ePYPOckajFIV876FOXz0ZQACUc7XzxiNhRSc2m4svoFtY
         X+hJM2XsAFlVb2bUremAtgRm/2/ITHJRxpFKK7zNAVmIHd676uRW9sH3xWR2xlQrkSw5
         VbTbBCwnHpqN3Sp+d4/VJtGpfKcHfICyhYS1/oqIXd9tzm8QdK+4gV+zj2Dp3rEU8X9Q
         EI/pZ/lTMG4sfzBEuj+OXJeZMXn0r8BgmNSAIQyOchWVfUwU89FxhxGEVYM+CpX4EwEa
         CFIw==
X-Gm-Message-State: AOAM533hf2sDmedYSSPKAz2iM1z+/mIebza5Vq4S1sqQ47R3+EtQ10Bg
        w1+Qnmc/9KFv0yyj7uX17Abas/IgA/Kmy0THgNJQ
X-Google-Smtp-Source: ABdhPJwXPl0c5hUaBUTVC6/pNkceDJrN4QrI5pQVW2MK/0XprP71YszylHDGAe+t/QSY54AuWJ4DTg5DbuR533EsPAGL
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:24c7:b0:4e1:cb76:32d1 with
 SMTP id d7-20020a056a0024c700b004e1cb7632d1mr1218012pfv.36.1646438162866;
 Fri, 04 Mar 2022 15:56:02 -0800 (PST)
Date:   Fri,  4 Mar 2022 15:56:00 -0800
In-Reply-To: <20220304005757.70107-10-chooglen@google.com>
Message-Id: <20220304235600.650580-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: Re: [PATCH v4 09/10] fetch: fetch unpopulated, changed submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> +		/*
> +		 * NEEDSWORK: Submodules set/unset a value for
> +		 * core.worktree when they are populated/unpopulated by
> +		 * "git checkout" (and similar commands, see
> +		 * submodule_move_head() and
> +		 * connect_work_tree_and_git_dir()), but if the
> +		 * submodule is unpopulated in another way (e.g. "git
> +		 * rm", "rm -r"), core.worktree will still be set even
> +		 * though the directory doesn't exist, and the child
> +		 * process will crash while trying to chdir into the
> +		 * nonexistent directory.
> +		 *
> +		 * In this case, we know that the submodule has no
> +		 * working tree, so we can work around this by
> +		 * setting "--work-tree=." (--bare does not work because
> +		 * worktree settings take precedence over bare-ness).
> +		 * However, this is not necessarily true in other cases,
> +		 * so a generalized solution is still necessary.
> +		 *
> +		 * Possible solutions:
> +		 * - teach "git [add|rm]" to unset core.worktree and
> +		 *   discourage users from removing submodules without
> +		 *   using a Git command.
> +		 * - teach submodule child processes to ignore stale
> +		 *   core.worktree values.
> +		 */
> +		strvec_push(&task->git_args, "--work-tree=.");
> +		return task;

Thanks - this is a good comment.

I've also written other comments on this patch that are easier to
describe in the context of an earlier conversation, so I've written
these as replies to an earlier email:

https://lore.kernel.org/git/20220304234622.647776-1-jonathantanmy@google.com/
https://lore.kernel.org/git/20220304235328.649768-1-jonathantanmy@google.com/
