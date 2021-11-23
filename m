Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119BDC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 10:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhKWKr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhKWKr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 05:47:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14012C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 02:44:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so45708528eds.10
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 02:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oA7dV5YwYISr437P/hCL86ag6zMWFyCi+RS2oQK9sp8=;
        b=n2SS/xHUzKxhNZMw0N0uwKmx59pO8kpjZrrU2PgtYYzCevVsfyUCZC8xo6ojcJ3z0j
         jJKzTnY6k7U/G2EUORdM7dQmggzlpDgYyb4jErzSoy54sRQ9CshiwdUXDtfpuTyu6T4n
         8hBgIDGKstXqcYnY0T57MgQmRBiuTSaNd3lSVg2baRuk5Q4HY0JmOukoO+1MwLbIjs/D
         DD3jbx56O4SeoblVuldLKDJagNZoKaE5ixziYrIFbvQtV8WTfNr/DspOc5TQmLr4Ptoa
         iLFh1qKp+IqUQ9FJOY67ZRPH4UGV5pzm6+W+ILvpo52PL5Ukhj/uFrq5FEKuy5wZTGUZ
         TgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oA7dV5YwYISr437P/hCL86ag6zMWFyCi+RS2oQK9sp8=;
        b=eZeyLav+TJu/3WQqZZ1m1ygH5pytBRXDdu8P1fXfwKqrBos0F/S8BHTQgEwTc4jOO1
         4hQ4dS4vjzk/feq30xaZ8Kgz/RU9RZIAxWI3c2nticUanq9gfXDKWda/vnYu6n3rh5V4
         rTg+Hbq6lNZJCZ/DidvU7Ly8fJk4D9nhex3OFBDbrEZmlnLSiFHVipR+MCUvlXWmqbJj
         0q/jI/a03C34FsduJp8nNxeFd9fiDgw6/6LPwUTMGhTpcGMUg5/hTde7QtW5VAIX+gWI
         T2M4SA7tEhGs/D803v0U9bche3VFD+eIWaA0JD0JYh8jpSxqXaKvdYUzmBJo4B8DF87o
         A1VQ==
X-Gm-Message-State: AOAM531uQiwo4Hbxv1kZt7pPZBHyDAUnJmjcoGxYMeHBG1yt8vHzy2uG
        6rQJZph4JumnzPuz1XxhyWGIfV7uJ1pStQ==
X-Google-Smtp-Source: ABdhPJxrKRfx8jblCC2n6g0mURRzUsGqPoEFsmuQhBHc0JY9POJgl8D6AwpxPqvuWBNURnTS92qQDQ==
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr7701003edd.198.1637664258378;
        Tue, 23 Nov 2021 02:44:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h10sm5562033edj.1.2021.11.23.02.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 02:44:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpTHd-001Jux-Gj;
        Tue, 23 Nov 2021 11:44:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/4] branch: add --dry-run option to branch
Date:   Tue, 23 Nov 2021 11:42:54 +0100
References: <20211122223252.19922-1-chooglen@google.com>
 <20211122223252.19922-4-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211122223252.19922-4-chooglen@google.com>
Message-ID: <211123.86zgpvup6m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Glen Choo wrote:

> Add a --dry-run option to branch creation that can check whether or not
> a branch name and start point would be valid for a repository without
> creating a branch. Refactor cmd_branch() to make the chosen action more
> obvious.
> [...]
> -'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
> +'git branch' [--track | --no-track] [-f] [--dry-run | -n] <branchname> [<start-point>]
>  'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
>  'git branch' --unset-upstream [<branchname>]
>  'git branch' (-m | -M) [<oldbranch>] <newbranch>
> @@ -205,6 +205,12 @@ This option is only applicable in non-verbose mode.
>  --no-abbrev::
>  	Display the full sha1s in the output listing rather than abbreviating them.
>  
> +-n::
> +--dry-run::
> +	Can only be used when creating a branch. If the branch creation
> +	would fail, show the relevant error message. If the branch
> +	creation would succeed, show nothing.
> +

The usage & test show that we've got --dry-run for branch creation, but
not the "creation" we do on --copy or --move.

The former is just a "create from source", but "move" maybe not.

In any case, any reason to leave those out?
