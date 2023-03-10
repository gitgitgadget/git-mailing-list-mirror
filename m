Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB768C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 19:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCJTQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 14:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCJTQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 14:16:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC92112EE7E
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 11:16:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so10889651pjb.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 11:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678475778;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fnJvKxHa4UEA0G1x5Rm105Mo1U6R9X6qIMBxRwX+B08=;
        b=Q+Cv9/llz7jLcP5ipuHCfVvcmat4HG958XXsVqt/rq7xn1ut8AqNUd86ix8cAtJxu/
         THvznTx5B4PtHSRH2A8+oS10QcXvcbQ2xoHhEMqMf41H6sWA7eid0HT8wKyN6NvLbOM4
         n7yYArO8ft3xI5Ghf36qA8IXRJusazwhrspyGsS1yy/hRM2VZGPyp2apuAesOx2h+mS/
         W1Sj7W3LGx/dKXiTQpUkU0smlA7gZ2lQ6hgtWI+MZ8XcUw5p59lGBnZQt+ao8Qy9ALCW
         YA6crw8MZ4w48RdO+fvZ/rEA4nH9XWMF9sJxZhujQSlaNIb1qkLRSz5xM5bw1kPMcE15
         G4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678475778;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnJvKxHa4UEA0G1x5Rm105Mo1U6R9X6qIMBxRwX+B08=;
        b=o2hacOtJ96u6wq0KAFWnFLNXrt2mLnGCgaqB8jsXQBSO7QhJUkOqITV8dV5YbUsrf7
         nwIxGr4FkkSYUCvnqdhx5h7rEctW9ig/5fnig/Q/80Ltif72R53lVp3Rm9L56a0OHAAw
         vhe8/OfhVQ8CFhsqCCF7tfnOlR+LpHSfprGB7G5vs2d5KdlsuB3ALlhBaaBseBaQSj0+
         PZ3cy/wEW0bim6FTWmtunTmVmdkPn9n8SCOzw6efMaAw8dKqd7RbASwIbbrxQax4prhI
         opA8Mpkg5RTUyeISJnEdwZSl6GJCeosRZZ9BX3gMlDI+QpPv/CTEOz3aHIPEfV5maVGd
         8Zbw==
X-Gm-Message-State: AO0yUKWIdVsWBY/u+J/hLvLxAYtJlIdcemfRbkA0wjpm7FUNEA4WnQrV
        2rdw6DuLQL+1Dyu2I4LMWv0=
X-Google-Smtp-Source: AK7set/BUyhOuoZ5XB0CJXtz7glpGK3YBQiy/AuAQXdxy/TNHc4kpW+joU0gmadpm3465XyWREoLwg==
X-Received: by 2002:a05:6a20:394f:b0:b8:4b1a:deb5 with SMTP id r15-20020a056a20394f00b000b84b1adeb5mr3526134pzg.18.1678475778010;
        Fri, 10 Mar 2023 11:16:18 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7811a000000b0058d92d6e4ddsm186662pfi.5.2023.03.10.11.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:16:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/8] ref-filter: ahead/behind counting, faster
 --merged option
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 11:16:17 -0800
Message-ID: <xmqqedpw5se6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I was
> initially concerned about the overhead of 'git for-each-ref' and its
> generality and sorting, but I was not able to measure any important
> difference between this implementation and our internal 'git ahead-behind'
> implementation.

That certainly is nice to know.

> However, for our specific uses, we like to batch a list of exact references
> that could be very long. We introduce a new --stdin option here.
>
> To keep things close to the v1 outline, I replaced the existing patches with
> closely-related ones, when possible.
>
> Patch 1 adds the --stdin option to 'git for-each-ref'. (This is similar to
> the boilerplate patch from v1.)
>
> Patch 2 adds a test to explicitly check that 'git for-each-ref' will still
> succeed when all input refs are missing. (This is similar to the
> --ignore-missing patch from v1.)

Sensible.

> Patches 3-5 introduce a new method: ensure_generations_valid(). Patch 3 does
> some refactoring of the existing generation number computations to make it
> more generic, and patch 4 updates the definition of
> commit_graph_generation() slightly, making way for patch 5 to implement the
> method. With an existing commit-graph file, the commits that are not present
> in the file are considered as having generation number "infinity". This is
> useful for most of our reachability queries to this point, since those
> commits are "above" the ones tracked by the commit-graph. When these commits
> are low in number, then there is very little performance cost and zero
> correctness cost. (These patches match v1 exactly.)
>
> However, we will see that the ahead/behind computation requires accurate
> generation numbers to avoid overcounting. Thus, ensure_generations_valid()
> is a way to specify a list of commits that need generation numbers computed
> before continuing. It's a no-op if all of those commits are in the
> commit-graph file. It's expensive if the commit-graph doesn't exist.

Reasonable.

> However, '%(ahead-behind:)' computations are likely to be slow no matter
> what without a commit-graph, so assuming an existing commit-graph file is
> reasonable. If we find sufficient desire to have an implementation that does
> not have this requirement, we could create a second implementation and
> toggle to it when generation_numbers_enabled() returns false.

At that point, it might make sense to find a way to make the work
ensure_generations_valid() had to spend cycles on not to go to
waste.  Something like "ah, you do not have commit-graph at all, so
let's try to create one if you can write into the repository" at the
beginning of the function, or something?  Just thinking aloud.

> Patch 6 implements the ahead-behind algorithm, but it is not connected to a
> builtin. It's a long commit message, so hopefully it explains the algorithm
> sufficiently. (The difference from v1 is that it no longer integrates with a
> builtin and there are no new tests. It also uses 'unsigned int' and is
> correctly co-authored by Taylor.)

Nice.

> Patch 7 integrates the ahead-behind algorithm with the ref-filter code,
> including parsing the "ahead-behind" token. This finally adds tests that
> check both ahead_behind() and ensure_generations_valid() via
> t6600-test-reach.sh. (This patch is essentially completely new in v2.)
>
> Patch 8 implements the tips_reachable_from_base() method, and uses it within
> the ref-filter code to speed up 'git for-each-ref --merged' and 'git branch
> --merged'. (The interface is slightly different than v1, due to the needs of
> the new caller.)

Very nice.

Having read all the patches, I am very impressed and pleased, but
are we losing anything by having the feature inside for-each-ref
compared to a new command ahead-behind?  As far as I can tell, the
new "for-each-ref --stdin" would still want to match refs and work
only on refs, but there shouldn't be any reason for ahead-behind
computation to limit to tips that are at the tip of a ref, so that
may be one downside in this updated design.  For the intended use
case of "let's find which branches are stale", that downside does
not matter in practice, but for other use cases people will think
of in the future, the limitation might matter (at which time we can
easily resurrect the other subcommand, using the internal machinery
we have here, so it is not a huge deal, I presume).

Thanks.

