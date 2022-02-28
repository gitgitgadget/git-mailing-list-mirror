Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23C6C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 11:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiB1LFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiB1LFR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 06:05:17 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD2F25C7B
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:04:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s1so16979534edd.13
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=y3++7TZtMYH6B8dqaf6RPrlJ8cx5gzjXBAcO0d8+q70=;
        b=l7W1rPkxzeeEEBuN+SQN6XfZxogdR87EPmwLhgNQSw8PkLjoKUXwpIuMy2El8T1iAY
         i9/yMoKcrhYmFTZF58uKJMqmrBQEJg/d+2Tbe1Vb4aP4fqyHZt+ATmW1Lft5oCX5C98t
         MLP05JuIFPJzm482nzBXtdPHpMKOxqso3WdrNSdY469H5sl6v3ytWQjq37ikPj0pwjZ4
         jDZxWB9acc8QX/Mb+UoACK4w+uuvu4X8FkiwgifthFIOquwj2WaLAp+RUouuHnTuqVnQ
         pw3bVD75W9xZsyRE2ZqZbNChhh60bCqyyAowJwAo0c9VlXN2upW9JjxLCuPi0od6MptA
         Y0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=y3++7TZtMYH6B8dqaf6RPrlJ8cx5gzjXBAcO0d8+q70=;
        b=BwOY7aRqyhlU6J2jycNI+dQgIpvrKpqI6YcruR+/7r/IksXcAzRlqbW+ZfogsawkPG
         yGnHKhAtDuZSMNsKkHXN/Eqf6hppG6E1nWEVAe/jrEIJJ2F3KpP5IOpZRZNj5u7/MKps
         lslbJEOXd6zhby4ZtZoxW7rnkas8VXjKyEWB9BCS3TSyjT8oRN6NIwsn/JH6lg/2jhSR
         CXOiq5N69ahIqnKlkcNFuj42SG0kCyDICQ4MlxZyP6Ux6b6nsqjaKyUaodwWkWC0s1YM
         G3xPOfswsyaiwwBtIcCUjyiQdpKu2zn043oEHxhwLuabEFnrz1GTMZ4p6OOmL4ImejKV
         9MLg==
X-Gm-Message-State: AOAM5319TbZaRFenmkyYb9pyKcDvQuRfJhe2zOmWB9pAOtyBaG9T5FCx
        Na/an5OUE5tc5pBmn/+Xx5J8/gNcN8g=
X-Google-Smtp-Source: ABdhPJwU78bGDrV55uKVjYGyJuQjEjWJ0k/YEYiFuVYo2TMwU35TkbpH8hoWlH55UVe1F9LYPsKX9A==
X-Received: by 2002:a50:cdc1:0:b0:413:a9ac:aa19 with SMTP id h1-20020a50cdc1000000b00413a9acaa19mr6069466edj.9.1646046277293;
        Mon, 28 Feb 2022 03:04:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k17-20020a1709062a5100b006d5c69301e4sm4248518eje.202.2022.02.28.03.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:04:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOdpU-001J1F-BP;
        Mon, 28 Feb 2022 12:04:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH 0/2] Reduce explicit sleep calls in t7063 untracked
 cache tests
Date:   Mon, 28 Feb 2022 12:03:04 +0100
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
Message-ID: <220228.86bkyr5k1n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Tao Klerks via GitGitGadget wrote:

> As noted in a recent proposed patch to t/t7519-status-fsmonitor.sh, a number
> of test cases in t\t7063-status-untracked-cache.sh explicitly sleep a
> second, in order to avoid the untracked cache content being invalidated by
> an mtime race condition.
>
> Even though it's only 9 seconds of sleeping that can be straightforwardly
> replaced, it seems worth fixing if possible.
>
> Replace sleep calls with backdating of filesystem changes, but first fix the
> test-tool chmtime functionality to work for directories in Windows.

Thanks, it will be nice to have that test run a bit faster in wallclock
terms.

> I do have a question to the list here: Do mingw.c changes need to be
> upstreamed somewhere? I don't understand the exact relationship between this
> file and the MinGW project.

No, it's 100% ours. We just put (somewhat inconsistently in some cases)
our own code that is only needed for "compat" with some "platforms" into
compat/*.

Well, somewhat/mostly, then "contrib/" is supposed to be third-party
imports, but some code in both is 100% ours, some is out-of-tree, some
is effectively perma-forked and has no "upstream" anymore etc.
