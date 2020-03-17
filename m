Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F32C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 03:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D968B20679
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 03:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaLq7Tqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgCQDNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 23:13:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33324 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgCQDNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 23:13:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id f13so21121755ljp.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vpSdWEgt8awSbJPWVc61Xnr0SzwdGEJZ38Y5/ZW0Ews=;
        b=RaLq7TqpSptsr/KA4RAxSYxqCC2MArS4YfJwmNDvmLJOLhrndugVqx4H6rBTmncI9y
         e73Af/UmlRZy3LGRJHt0K4AbqRQrVWzHEhjug1Tg1MUdnuYhQnB1NC6p8t93Dcb20cqq
         VTrHRScJ8eazw5XGPEAbYApqFJZ1ME2kcWkLeh5d2G5uf9Gm8Jt2st4cJ5li9w4WlDAK
         1ZmNf0mfotyFCENFbUWnUZmyyThtFmkbbk/WvS4bbMsYIwktDZoaeUPWmIiGr3HZi0OM
         GvagFYPIRbb83NdUUn4Zj2jOqsmL2YJPXhUqn//jCg3bQiSoW102eu5QL1TqOFDAraLD
         t+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=vpSdWEgt8awSbJPWVc61Xnr0SzwdGEJZ38Y5/ZW0Ews=;
        b=tmfJA1AhMLPyqG/iOhL/U2oKDf16YBppfdAjlDB3FPrp3OTrY6arjgslHzT/wAcX8q
         Xxo+ZgNGrOGvvE07prqzZ+drqwC7SqURO7oET1NwXrrkkit7hbAi3t75p+yxkx53Hf4l
         37b3qFYZ4Ms+1wDGrUVzoch03ErHnqe46IQx+fWVdBTq1XLu7EnkWEMYyo0JsFrxNQ+6
         hS3p/QVmyuvmvR/LAJ8S0q8EUz4zU1ny69/FtQMdx4KzmRz5TR1E65TOH3zq1BI3oiO3
         DTB3gmZeornAlNTCu8QhHHB6L45ZMUIy93ER8V7vO9P0fPgm4w59iCGYCqTeTzrjoOhk
         JJ0g==
X-Gm-Message-State: ANhLgQ0N92fBrwJqc32BTyDOW+1B6RrIYobWNbEVV7H8Dsyk0flI5H+6
        6gQahW0NRD1YtPktelEq5WM=
X-Google-Smtp-Source: ADFU+vuEFQZgi9+hnauI9XOCm+pJNwXtYudP6fg4o2wRI9Nu2G+UF3Hnv4OROWlEflwNEObNAIl2Xg==
X-Received: by 2002:a2e:7a0d:: with SMTP id v13mr1324175ljc.173.1584414827625;
        Mon, 16 Mar 2020 20:13:47 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u15sm1167669lju.14.2020.03.16.20.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 20:13:46 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com>
Date:   Tue, 17 Mar 2020 04:13:41 +0100
In-Reply-To: <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com> (Derrick
        Stolee's message of "Mon, 16 Mar 2020 08:44:54 -0400")
Message-ID: <86d09b7jx6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added other people who might be interested to Cc.

Derrick Stolee <stolee@gmail.com> writes:
> On 3/10/2020 10:50 AM, Jakub Narebski wrote:

>> Here below is a possible proposal for a more difficult Google Summer of
>> Code 2020 project.
>>=20
>> A few questions:
>> - is it too late to propose a new project idea for GSoC 2020?
>> - is it too difficult of a project for GSoC?
>>=20
>> Best,
>>=20
>>   Jakub Nar=C4=99bski

https://git.github.io/SoC-2020-Ideas/#commit-graph-labeling-for-speeding-up=
-git-commands

>> --------------------------------------------------
>>=20
>> ### Graph labelling for speeding up git commands
>>=20
>>  - Language: C
>>  - Difficulty: hard / difficult
>>  - Possible mentors: Jakub Nar=C4=99bski
>>=20
>> Git uses various clever methods for making operations on very large
>> repositories faster, from bitmap indices for git-fetch[1], to generation
>> numbers (also known as topological levels) in the commit-graph file for
>> commit graph traversal operations like `git log --graph`[2].
>>=20
>> One possible improvement that can make Git even faster is using min-post
>> intervals labelling.  The basis of this labelling is post-visit order of
>> a depth-first search traversal tree of a commit graph, let's call it
>> 'post(v)'.
>>=20
>> If for each commit 'v' we would compute and store in the commit-graph
>> file two numbers: 'post(v)' and the minimum of 'post(u)' for all commits
>> reachable from 'v', let's call the latter 'min_graph(v)', then the
>> following condition is true:
>>=20
>>   if 'v' can reach 'u', then min_graph(v) <=3D post(u) <=3D post(v)
>
> I haven't thought too hard about it, but I'm assuming that if v is not
> in a commit-graph file, then post(v) would be "infinite" and min_graph(v)
> would be zero.

Or we can simply add a check if v is in a commit-graph file; this might
be not a good idea from the performance point of view.

> We already have the second inequality (f(u) <=3D f(v)) where the function
> 'f' is the generation of v. The success of this approach over generation
> numbers relies entirely on how often the inequality min_graph(v) <=3D pos=
t(u)
> fails when gen(u) <=3D gen(v) holds.

True.  It may turn out that additional negative-cut filters do not bring
enough performance improvements over topological levels or corrected
commit date (or monotonically increasing corrected commit date) to be
worth it.

I think they can help in wide commit graphs (many concurrently developed
branches with many commits and few merges), and when there is orphan
branch (like 'todo' in the git.git, or 'gh-pages' for storing
per-project GitHub Pages) that is somehow entangled in query.

>> If for each commit 'v' we would compute and store in the commit-graph
>> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
>> that were visited during the part of depth-first search that started
>> from 'v' (which is the minimum of post-order number for subtree of a
>> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
>> Then the following condition is true:
>>=20
>>   if min_tree(v) <=3D post(u) <=3D post(v), then 'v' can reach 'u'
>
> How many places in Git do we ask "can v reach u?" and how many would
> return immediately without needing a walk in this new approach? My
> guess is that we will have a very narrow window where this query
> returns a positive result.

As I wrote below, such positive-cut filter would be directly helpful in
performing the following commands:

 - `git merge-base --is-ancestor`
 - `git branch --contains`
 - `git tag --contains`
 - `git branch --merged`
 - `git tag --merged`

It would be also useful for tag autofollow in git-fetch; is is N-to-M
equivalent to 1-to-N / N-to-1 `--contains` queries.

I am quite sure that positive-cut filter would make `--ancestry-path`
walk faster.

I think, but I am not sure, that positive-cut filter can make parts of
topological sort and merge base algorithms at least a tiny bit faster.

> I believe we discussed this concept briefly when planning "generation
> number v2" and the main concern I have with this plan is that the
> values are not stable. The value of post(v) and min_tree(v) depend
> on the entire graph as a whole, not just what is reachable from v
> (and preferably only the parents of v).
>
> Before starting to implement this, I would consider how such labels
> could be computed across incremental commit-graph boundaries. That is,
> if I'm only adding a layer of commits to the commit-graph without
> modifying the existing layers of the commit-graph chain, can I still
> compute values with these properties? How expensive is it? Do I need
> to walk the entire reachable set of commits?

I think it would be possible to compute post(v) and min_tree(v) using
incremental updates, and to make it compatibile with incremental
commit-graph format (with the commit-graph chain).  But I have not
proven it.

This incremental update would find _a_ post(v) number and min-post
interval labeling, but that might not be exactly the same as one would
get if it was computed in one shot, from scratch.  The result may be
suboptimal, but perhaps it would be still good enough.

I have added the explanation of this idea to v1.2 of my slides:

https://drive.google.com/open?id=3D1psMBVfcRHcZeJ7AewGpdoymrEfFVdXoK
https://drive.google.com/file/d/1psMBVfcRHcZeJ7AewGpdoymrEfFVdXoK/view?usp=
=3Dsharing

https://www.slideshare.net/JakubNarbski/graph-operations-in-git-version-con=
trol-system-how-the-performance-was-improved-for-large-repositories-how-can=
-it-be-further-improved

There you can find on slides 65/58 and later (page 90 out of 99)
*illustrated* explanation of the idea.

Excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D

For each layer in the \texttt{commit-graph} chain store (in relevant chunks=
):
 - min--post interval labels
 - list of tips (heads) in the commit-graph; possibly also list of their in=
tervals
 - for each layer in chain, except for base layer,
   store ajustments for 'post(v)' labels for previous layer
   (only needed for tips)
=20=20=20
    - adjusting values of labels consist of adding a constant value to
      both sides of interval for a whole subtrees starting from
      old branch tips

HTH

>> The task would be to implement computing such labelling (or a more
>> involved variant of it[3][4]), storing it in commit-graph file, and
>> using it for speeding up git commands (starting from a single chosen
>> command) such as:
>>=20
>>  - git merge-base --is-ancestor A B
>>  - git branch --contains A
>>  - git tag --contains A
>>  - git branch --merged A
>>  - git tag --merged A
>>  - git merge-base --all A B
>>  - git log --topo-sort
>
> Having such a complicated two-dimensional system would need to
> justify itself by being measurably faster than that one-dimensional
> system in these example commands.

That is true.  Git is certainly fast already thank to serialized commit
graph and generation numbers.  Such extra positive-cut / negative-cut
filter subsystem would be maintenance burdern (though I think it could
be nicely isolated with a good API).

On the other hand repositories re gettting larger and larger...

>
> The point of generation number v2 [1] was to allow moving to "exact"
> algorithms for things like merge-base where we still use commit time
> as a heuristic, and could be wrong because of special data shapes.
> We don't use generation number in these examples because using only
> generation number can lead to a large increase in number of commits
> walked. The example we saw in the Linux kernel repository was a bug
> fix created on top of a very old commit, so there was a commit of
> low generation with very high commit-date that caused extra walking.
> (See [2] for a detailed description of the data shape.)
>
> My _prediction_ is that the two-dimensional system will be more
> complicated to write and use, and will not have any measurable
> difference. I'd be happy to be wrong, but I also would not send
> anyone down this direction only to find out I'm right and that
> effort was wasted.

That might be a problem.

This is a bit of a "moonshot" / research project, moreso than others.
Though it would be still valuable, in my opionion, even if the code
wouldn't ultimately get merged and added into Git.

>
> My recommendation is that a GSoC student update the
> generation number to "v2" based on the definition you made in [1].
> That proposal is also more likely to be effective in Git because
> it makes use of extra heuristic information (commit date) to
> assist the types of algorithms we care about.
>
> In that case, the "difficult" part is moving the "generation"
> member of struct commit into a slab before making it a 64-bit
> value. (This is likely necessary for your plan, anyway.) Updating
> the generation number to v2 is relatively straight-forward after
> that, as someone can follow all places that reference or compute
> generation numbers and apply a diff

Good idea!  Though I am not sure if it is not too late to add it to the
https://git.github.io/SoC-2020-Ideas/ as the self imposed deadline of
March 16 (where students can start submitting proposals to GSoC) has
just passed.  Christian, what do you think?

Would you agree, Stolee, to be a _possible_ mentor or co-mentor for
"Generation number v2" project?

> [1] https://lore.kernel.org/git/86o8ziatb2.fsf_-_@gmail.com/
>     [RFC/PATCH] commit-graph: generation v5 (backward compatible date cei=
ling)
>
> [2]
> https://lore.kernel.org/git/efa3720fb40638e5d61c6130b55e3348d8e4339e.1535=
633886.git.gitgitgadget@gmail.com/
>     [PATCH 1/1] commit: don't use generation numbers if not needed

Best,
--=20
Jakub Nar=C4=99bski
