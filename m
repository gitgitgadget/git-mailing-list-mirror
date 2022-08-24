Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422CBC04AA5
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 22:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiHXWSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHXWSy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 18:18:54 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473D7DF6D
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:18:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g10-20020a63564a000000b0042aa3915494so4803734pgm.18
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=zG1dblgx5k71xltMK8nmCP/sIIuf0vqTfkIN3rJqRo4=;
        b=TZDRrkO9+Xi9mN5g2bbHwJhQ4XtcmxPERtEVfXbtSQzwjh+JMZG5kzmBC2orv3dbNx
         4EU0TRoXzpOt2d2BF+qRHBfshv0v00eeyBDzONVUfVLhXpzspBs7PCJ8HzGVrDDy1PbL
         4mVc6e65ayBU8rX6cI+cVSU8gkpVDBW2V9RXS7p2XbyTgAFQAD9z3+418WVyd0WobSGl
         kjcZ36yI6K8pInwyWGxKykLcG0XSSOHmoeGya2KdPpNEmqSgIDMWb6miHfIQea4MwIfO
         n4BZeSyEoUgJ6/zGxWNNaZ3TCRjFimyljNYgfkaYnuNCczpokxlf1JtVbrm1AOSDTN1c
         jtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=zG1dblgx5k71xltMK8nmCP/sIIuf0vqTfkIN3rJqRo4=;
        b=rGa2iZSAhiTVHMDyp/qfn5g+R7qyZFDtDIOJjchEETRzhmheykk6qqxP6zOoiUlVV3
         Zl7M4GcE9c02gyp3X7PpzR2jBYwizlB1U3os81vP6L7pV8GwT6Qwzs68W8RpWZOazzoe
         2njzijWZS/jPTR81dPFiD8IEp8pt67mOFBk6dEmH1F4CPnCuQUy910LXmna+OgoP4Io1
         uXGHev+K3xv6HAxx5zIitltx9j7eBJythBTAkRhQeFq460PWaOa0ALEHuSbqWVVb9u2q
         BZTLQx/CcynXklrm4iAYi3e6Wdv0fTU9OAwyuj3iKeNj+kooVluY8D1Coj3ruLSakf+m
         5WnA==
X-Gm-Message-State: ACgBeo03XqH14xHormmi811ms9B/rvkzDFZg/TJXbOhJDlmSlRRAQCzQ
        SiNtrgO/NNAH+uMyO367j4muxnlj8m8SxVJYnMYC
X-Google-Smtp-Source: AA6agR43UUqQkv96YShAZ+puITpnKaqURdlp56CP9tJqsxz1eZIYuThkB2A1tOcm0+1zlH3Cf+/5GxeFg7FAifsqQcBx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:fc20:0:b0:41d:234f:53e2 with
 SMTP id j32-20020a63fc20000000b0041d234f53e2mr778222pgi.199.1661379533637;
 Wed, 24 Aug 2022 15:18:53 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:18:50 -0700
In-Reply-To: <68bcd10949ec7767d1e0ee8e2f0730ca36bad1c5.1660576283.git.gitgitgadget@gmail.com>
Message-Id: <20220824221851.1684475-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH 5/5] rebase --keep-base: imply --no-fork-point
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -1240,6 +1240,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--onto");
>  		if (options.root)
>  			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
> +		/*
> +		 * --keep-base ignores config.forkPoint as it is confusing if
> +		 * the branch base changes when using this option.
> +		 */
> +		if (options.fork_point < 0)
> +			options.fork_point = 0;

Hmm..doesn't forkPoint decide the set of commits to be rebased, not the
point at which the new commits are created? If yes, that doesn't seem to
have much to do with --keep-base.
