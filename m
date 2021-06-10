Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBD8C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC7F613F5
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJK4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 06:56:49 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:41575 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFJK4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 06:56:44 -0400
Received: by mail-ej1-f46.google.com with SMTP id ho18so32457449ejc.8
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:user-agent:message-id:mime-version;
        bh=TC5lYBoske9Nqrh1xk48OHdXtmo8i8VIUGD9nVcrfvM=;
        b=qALVUU3qyywA1GT4f1srgL/0Y6E+xpfcAuXyL2JE0ZR3LB0LsAbhG79BGp0q/o02A9
         bZmqXs0qauDhGPZ9GiRhN8aHWTSay6dB1qoidFQTVjYHy7CK+92fafFHwUFDbOmPFvue
         fDMb5ViqHrf1KmKVfTA/2Hexsp/uUVrlGGCYYmW6mZlxoywFIFQPWHB8nbWakP1FLz1p
         TEpWGEMQ03/nMvkysJJZr0n/NDnFEHFK2rc9V8Kt3SnX+gRPhiPzIDaXg8F9SYhiYX4X
         vV64uEPfbVpnIZyceUzsYAZ39G59J2uBPIpjlj+3bwmmgKse3tSz5KRYO7ig5I2JAL4Q
         Q6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:message-id
         :mime-version;
        bh=TC5lYBoske9Nqrh1xk48OHdXtmo8i8VIUGD9nVcrfvM=;
        b=ncldR2zi7/E28HS9SQVZFP/BAnoxyx9ocggQg3DxaGPHsqslqCYP7I1T/wFiYCT3bo
         GS0VaC8h1gS/R2dXofcQBFIfu+KpuWkLZEZxKIVQRhZExxtgGQt19+NUoOQkIU4DQpEV
         nxs5Iegdx5YxgglPm6qZd4RhBn/YMI0ry+HrA6NFKUt5DxOkn3v8Gqfj+/DIgl4CAL7R
         EfwMvfeefaLN+YZSwqV0gz3+oNravVU5wBYas54pk3+nhHugttq2YuuzI/GK2loKjA1e
         TMsWOeAm98WOH0glLavVCgN4Mp/iQ1ndvz9sBSU8kM9KyLs7dqXnU9C6IztIB5Ollcgf
         o6TQ==
X-Gm-Message-State: AOAM531DRs1KoRlCXJLnhV1qEmym5wb3aiwxldlmFZgywKaqVVjNVJrA
        o/+47BY6z8DvcV1n8f4+sBI=
X-Google-Smtp-Source: ABdhPJwZ2ExfOmkOC397F7QFBk+fUl1SVSbQ2FQnj98KS7bxwDdYZ1qbxzvCcHbfr+WDBS2EiFtNlg==
X-Received: by 2002:a17:906:5593:: with SMTP id y19mr3790275ejp.195.1623322427229;
        Thu, 10 Jun 2021 03:53:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lv25sm864570ejb.100.2021.06.10.03.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 03:53:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Making split commit graphs pick up new options (namely
        --changed-paths)
Date:   Thu, 10 Jun 2021 12:40:33 +0200
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
Message-ID: <871r9a2dol.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 16 2020, Taylor Blau wrote:

Replying to
http://lore.kernel.org/git/ccb6482feb8d8606d82b5ab97e33184f26d6c5b6.1600279373.git.me@ttaylorr.com
as a start-off point for discussion;

> Introduce a command-line flag to specify the maximum number of new Bloom
> filters that a 'git commit-graph write' is willing to compute from
> scratch.
>
> Prior to this patch, a commit-graph write with '--changed-paths' would
> compute Bloom filters for all selected commits which haven't already
> been computed (i.e., by a previous commit-graph write with '--split'
> such that a roll-up or replacement is performed).
>
> This behavior can cause prohibitively-long commit-graph writes for a
> variety of reasons:
>
>   * There may be lots of filters whose diffs take a long time to
>     generate (for example, they have close to the maximum number of
>     changes, diffing itself takes a long time, etc).
>
>   * Old-style commit-graphs (which encode filters with too many entries
>     as not having been computed at all) cause us to waste time
>     recomputing filters that appear to have not been computed only to
>     discover that they are too-large.
>
> This can make the upper-bound of the time it takes for 'git commit-graph
> write --changed-paths' to be rather unpredictable.
>
> To make this command behave more predictably, introduce
> '--max-new-filters=<n>' to allow computing at most '<n>' Bloom filters
> from scratch. This lets "computing" already-known filters proceed
> quickly, while bounding the number of slow tasks that Git is willing to
> do.
> [...]
> @@ -67,6 +67,11 @@ this option is given, future commit-graph writes will automatically assume
>  that this option was intended. Use `--no-changed-paths` to stop storing this
>  data.
>  +
> +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
> +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
> +enforced. Commits whose filters are not calculated are stored as a
> +length zero Bloom filter.
> ++
> [...]

Is there any way with an existing --split setup that introduces a
--changed-paths to make the "add bloom filters to the graph" eventually
consistent, or is some one-off --split=replace the only way to
grandfather in such a feature?

Reading the code there seems to be no way to do that, and we have the
"chunk_bloom_data" in the graph, as well as "bloom_filter_settings".

I'd expect some way to combine the "max_new_filters" and --split with
some eventual-consistency logic so that graphs not matching our current
settings are replaced, or replaced some <limit> at a time.

Also, am I reading the expire_commit_graphs() logic correctly that we
first write the split graph, and then unlink() things that are too old?
I.e. if you rely on the commit-graph to optimize things this will make
things slower until the next run of writing the graph?

I expected to find something more gentle there, i.e. marking that file
as obsolete, not making it part of the new chain (replacing it), and
then unlinking only things not part of the current chain of data that
are too old. But perhaps I'm just misreading or misunderstanding the
behavior...
