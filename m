Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD19C433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D35C64E2A
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBGTFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 14:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGTE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 14:04:59 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26EC06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 11:04:19 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id y9so21221928ejp.10
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uW4LYUu5e2Fv0CLPo+RzozBB7iTp4l6H0UfDPhWXDnI=;
        b=lZQsPY05i/vzbsZLYBLJ6GiOdzJy0YfGmHAHuC6YvP1kL96JZauM/D2fqJ1OJvHgpM
         Nui4dsDZ8glM/A0JW9uABQD5QjJZnHgW4jOE+vE3kPobT+RUUV2qmXJvbQ9UZjw2ScGH
         ILUji4IORPRe7anxcE2g4EtdtBGgjb94+SNx00p1/nJk5lObkdfaen9sfigtH2t/Hfw/
         GKJDZqJmxf6puNVvpocJaGBdvpAAy9+AWE/TPxHgn11NN6q+dJWR3fCvEvEmS6tYpU23
         kwDHjXI3rzZsYVjC9ASZbFBzKzHuOP0VFZNwfz//qWP/JZ6RHmgGjqWb5b3uZOvyoJ9K
         ogHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uW4LYUu5e2Fv0CLPo+RzozBB7iTp4l6H0UfDPhWXDnI=;
        b=iaUMRcXDML0cH9+67420wznIGxTcsbfz5j0+mS7SdVdM80x9k1bc0Qz5kR4PNlE7mV
         MS8K5YB95cf4jcUXudE6tWlo4TkhJdP0CYZ4638vJOIPG9Z3br2uhFKRNj4jlqQF6VG5
         4aiSh4SCrGew7tJDEaWlTcMtufVNt5n32cZByFg2xexMN3mWIHFdk7Ev/PlR9E1PagPs
         ePia821vcSbhnqSAWBp/rUO+Qp2ED9LDXKTt6ybnuNE92Wb16zcRdrcCk8QXi9M6OHIn
         7KicgHRvhhVcv8XFUGKRhHJMHBz9SPszJMB/Ko1vukPBFJh3EHfSly6K3pgl4fYzndKL
         SLEA==
X-Gm-Message-State: AOAM530aY+pAqrT1+jBxDV/6qco7U69++dI+krfoYoO2l2MrjSUagpz5
        CMJrEoBKfzOzFNfNf/t85bU=
X-Google-Smtp-Source: ABdhPJxhoFPKmwK8Z0G92p9OOocYzRikJyP61x8quHc+oVFMuiNhQ9hg2eqoJgToSYn79oE9hR8RLg==
X-Received: by 2002:a17:906:39c6:: with SMTP id i6mr14195386eje.433.1612724657998;
        Sun, 07 Feb 2021 11:04:17 -0800 (PST)
Received: from szeder.dev (62-165-236-114.pool.digikabel.hu. [62.165.236.114])
        by smtp.gmail.com with ESMTPSA id bo24sm7863164edb.51.2021.02.07.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 11:04:17 -0800 (PST)
Date:   Sun, 7 Feb 2021 20:04:15 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        abhishekkumar8222@gmail.com, Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
Message-ID: <20210207190415.GB1015009@szeder.dev>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
 <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
 <YBn3fxFe978Up5Ly@google.com>
 <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
 <xmqq7dnpewg4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dnpewg4.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 06:06:51PM -0800, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> >> - what is the recommended way to recover from this state?  "git fsck"
> >>   shows the repositories to have no problems.  "git help commit-graph"
> >>   doesn't show a command for users to use; is
> >>   `rm -fr .git/objects/info/commit-graphs/` the recommended recovery
> >>   command?
> 
> "rm -f .git/objects/info/commit-graph" as well, no?
> 
> > That, followed by `git commit-graph write --reachable [--changed-paths]`
> > depending on what they want.
> 
> Just out of curiosity, how important is "--reachable"?  It only
> traverses from the tips of refs and unlike fsck and repack, not from
> reflog entries (or the index for that matter, but that shouldn't
> make much difference as there is no _commit_ in the index).

Scanning all objects in all packfiles is a very inefficient way to
find the commits to be recorded in the commit-graph, and depending on
the repository's shape and size can have several times higher runtime
and memory footprint.

