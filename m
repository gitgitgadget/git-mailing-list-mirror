Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2B1C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9A061100
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhIHWEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbhIHWEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 18:04:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51566C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 15:02:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so4212513yba.6
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GMg3JVJVwarqPFTIrZUGie7Ws3GhSLjTg6EQWwCBff8=;
        b=itGflVjzOp7pEx2aq2sptON/mS4aQr2rgqFB894aMXSn8X8MSAFGlR32v+kXo55hFW
         41+7Qdxpdy+Q9Mi8TmkSxRPWgaPw2hziUShYqSmVPDY05eRcBoGnoNNKFK/NTD0xdbRA
         kuyFFUBb1/hbCeSG6R4xq+BmHwcbo2VF7rCh5prfmHLaFZbbOrGzPT5fObzMCjErkIKY
         yltTWjCabDcq5EIgH5SYtbVaMYz1dSrHut0UdE1x4Kh8tpyahczSHSXT+glaa65GycKn
         fSlh8oT0nLnYQI2kFde2kjPPcCJw4kq9bR+ZFyuNhGvVNygHM5iTsSoJ5Q6mza0zoLB9
         jUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GMg3JVJVwarqPFTIrZUGie7Ws3GhSLjTg6EQWwCBff8=;
        b=SKr/bsKshU0s1CxkNF01Yce8P+PXtX5u71lLP7FCBuqhrJ3c0KvxukYUVWSqVv8rRJ
         InIKEuoTwR5gMUtZgjUpgJEccJQ8phc8TYJaGIBYiGpANT9282RkoG1qZQgd9i19ED45
         8oZ5BuBWpRluCh859nYB13Suq7svYFGCAfiSBPOp2kTwztsDfWTfHmyyTzLIImltbVua
         zLlpjy7gl9GTpLY47c1PxyXxLmI41dPD/QwLZqdTzYyP5VwWbEQha93NmIg6M7j5bpp2
         3B4iU8CEZXwlpE+kTBgHbGvsHXo9ucf4j7YZR3pJhjjmkEVEoIaRzLEd2v9XLc/drlwv
         w0mQ==
X-Gm-Message-State: AOAM531q8d548CN7sS6CGCpZBzI6pIDQ3U4d1AKlKQ7GdKOc8yn4r2sa
        +6rYK53Omz2uWsoTU2DJW3Oi2XjYy0VhO6ec37N3
X-Google-Smtp-Source: ABdhPJxHfVqIsFSM+MrOknt98tUXB0ehKsmtVUVx7cQWWTBAY7YVDzyxf1KV7q6EVZIj+hyde7iZeYGiN8RlBQOifKwF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d497:: with SMTP id
 m145mr589430ybf.389.1631138575610; Wed, 08 Sep 2021 15:02:55 -0700 (PDT)
Date:   Wed,  8 Sep 2021 15:02:52 -0700
In-Reply-To: <942d3ce2d3cf96192c7e9d5860a18c333dd08acf.1631123754.git.jonathantanmy@google.com>
Message-Id: <20210908220252.3799351-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <942d3ce2d3cf96192c7e9d5860a18c333dd08acf.1631123754.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: Re: [PATCH 1/3] t6437: run absorbgitdirs on repos
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The submodule merge code is being transitioned away from
> add_submodule_odb() to repo_submodule_init(), and the latter does not
> support submodules that have their .git directories in the worktree
> (instead of in .git/modules). Migrate the test code by calling
> absorbgitdirs wherever necessary to place the .git directories of
> submodules in .git/modules of the superproject.

Upon further work, there seems to be quite a lot of test code to
migrate, and it might be easier instead to add support for unabsorbed
submodules to repo_submodule_init() (say, following what
open_submodule() in submodule.c does). Feel free to comment on this or
other aspects of the patch set, and in the meantime, I'll investigate
that.
