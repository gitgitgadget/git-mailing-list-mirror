Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE29C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjEARGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjEARFv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:05:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0615E59DE
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:00:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso881803a12.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682960349; x=1685552349;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1E8KRVd9qidQejcLIYY/k3yfpi7jlFHrwCGIKeQx0Q=;
        b=WL499O8ggQoqybMcdzPRENia2aig28K4EbsdiuYkR3kFRDTcVRFEluYLwBd9vo24Ss
         o9B/OCjAagzGZ2oqR1Zv4PBO1VnPkOlXF0pMfgjCyIY3LRHQ9D9WsFq6r50YgP04qfok
         sDRIhnrs94AaG5ZE6jtrGq+YVkQH54pXWndiYJLf7bJQv66yTnuPYLzfjw3uCRpLMNwM
         BmZYFFPmAhhh/Kn1/+mOIj+cukwtJ20lFsUUku/FdAXw3VJmQf0TAJ87mUi4F2olxQui
         CELX4+doR+B+tKZNg1TgzNIN8EetK54xVIp4hePtQVLPgbTiUvhmpFfpDhnWUCcZzSAh
         IGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960349; x=1685552349;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1E8KRVd9qidQejcLIYY/k3yfpi7jlFHrwCGIKeQx0Q=;
        b=BG5ppi6iHVtrjfwDk86JGr2JnGyXbtKU0CpCFvesAq4Guj9NgLIg0yXUg39iEWlcng
         Qg3dUBOqq1fEwunoyzQsHyXc2LYdp9GTk4R/plzfg+kByVbwKcYdQ5boDUhui1fDc98Z
         +bnx0nxHYy69uV36pZlFb+0i7i+OLtWZyNh0nyLBCCHiUy2qf3isj3oXOibxOfkwFPSg
         FjZJK4wmG1tSJkX3/kqM6SB3gUwgVrLfFycEkJ3rH7ZdO4UkhmbH+jL46n4+QRAnq2jU
         sqv3dautCz2tG0K09EaNxXukSdo0slVX9goY8ioixcxEfFzYsRT+rEh/u+LY+Xxojv1O
         dlsg==
X-Gm-Message-State: AC+VfDxTLWUj+qCj4Tyzwoqhhtmfpy1/lzjZPOdTWWqYPK9eYIJkifcF
        jhI03pIUsjPhwTFfxOozoKPOOHFy7pA=
X-Google-Smtp-Source: ACHHUZ7JBWNadKvBuQl9LtrJAJQHK7Jwbx9y66bp4Pf5bugiteSqjIh7mU8AiSo9vG6m5dqo5XyrLw==
X-Received: by 2002:a05:6402:b05:b0:508:4d66:e666 with SMTP id bm5-20020a0564020b0500b005084d66e666mr6484224edb.32.1682960348599;
        Mon, 01 May 2023 09:59:08 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id n11-20020aa7c68b000000b0050bc6983041sm1125380edq.96.2023.05.01.09.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:59:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptWrj-000Eko-2F;
        Mon, 01 May 2023 18:59:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 19/22] commit.h: reduce unnecessary includes
Date:   Mon, 01 May 2023 18:52:52 +0200
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
 <7479e72ffd612addd9d71118647849d99c5870f8.1682194652.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <7479e72ffd612addd9d71118647849d99c5870f8.1682194652.git.gitgitgadget@gmail.com>
Message-ID: <230501.86mt2ohtt0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>

Re earlier comments: If I rebase to make this the first commit
everything compiles, i.e. nothing here relied on the earlier split-offs
of cache.h into other headers.

You need to make a choice of whether to first split out cache.h, and
then do commits like these, or the other way around.

I'm not sure whether it's better to do it the other way around. If you
do that it's clear e.g. add-interactive.c's implicit dependency on
tree.h via commit.h has nothing to do with what would be the subsequent
split-up of cache.h.

Or maybe this is fine. I'm just trying to get some picture of what
depends on what in this series...
