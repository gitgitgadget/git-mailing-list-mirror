Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C9CC10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1F020746
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 14:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP4WsKFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCMOfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:35:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41490 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgCMOfD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 10:35:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id q10so8052933lfo.8
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XFnFfZAjPWBta+v7NPkFBYzvoCXztvXBhCsKYNpE+0Y=;
        b=EP4WsKFLESxbNVBwZ8e4IQm1zVbsOLbn1ev/jV0bHbj8H1VlZgOniok4ZjZHWH4REC
         660oWiepLmfxjfiSHRh07XA06bYGnQleTqgfEQspyhVC7SOQLvQUvmrt4XamiroDRtDE
         iYrdPOhW+2+WTPhu8bLnw5eI3JAf0P9j8Q0LhM1FvVNUUIzC07Hi09qzOP1VOTs/oBdq
         GieBG9hGOZH3RMen1+R0zvl8522iV7Ruh4kCp8kMNFM/sGBVSwKrZ1LFfl22YsCV22lK
         VFyBScJoGCvBvu1YMbD/wjeh2RRY6HNYUQKK9q1QtguCDOJb5LP0EoFCzrOuzj2V4fSx
         zYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=XFnFfZAjPWBta+v7NPkFBYzvoCXztvXBhCsKYNpE+0Y=;
        b=p3yuRMvcR8rzbRMV7BOcGlPJZee5BUNE363+jvyHBv40QPJ6OL5ZS4/Cy7ZKxO0zLu
         xkmdQoPpSblPQ3iRyAYFPg2EhuxSTfelIlYTky3LamPF07/uUb9b1vQZEpC3NjFISCw8
         AtHFwNnTq3eL4d/J0Czl8YsIMU1THJ6i59TXrFX5TlZJeudcoPU2i2c+qoqqbUX/QUcI
         YE+yhYJB72bGBsYwLZJQJHh2Jg7BN55pxoYfiw8Gi08Cz8KF41Nk9ZCllGw6sKmXjRRW
         uAYAVyWYUNPHO1VVUSByzVUsYfQ+cbZeogSrqrbYlAkVEnDDf7bMTL9HRNSe4GT4yGIN
         OQcQ==
X-Gm-Message-State: ANhLgQ1nB3Di350O1/FbIUB1dyIWkd9EqQ0lEVA65H6Fq55Ve7jnk7bH
        AD2Bo+qxQWwVONcn3YzcNtI=
X-Google-Smtp-Source: ADFU+vvWfzXpSjqRvTDL7OyDtL/mGwpTOFO+a3ves7D3Hfs7NH6YI7Typuxy7emFNzRMYLYZPp80EA==
X-Received: by 2002:a19:2247:: with SMTP id i68mr2646338lfi.22.1584110101011;
        Fri, 13 Mar 2020 07:35:01 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id s14sm4122592ljs.63.2020.03.13.07.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 07:35:00 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <66dc369f-cd83-e39c-1310-32a9c003d114@iee.email>
Date:   Fri, 13 Mar 2020 15:34:55 +0100
In-Reply-To: <66dc369f-cd83-e39c-1310-32a9c003d114@iee.email> (Philip Oakley's
        message of "Fri, 13 Mar 2020 13:08:33 +0000")
Message-ID: <86ftec2ui8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Philip,

Philip Oakley <philipoakley@iee.email> writes:
> On 10/03/2020 14:50, Jakub Narebski wrote:
[...]
>> ### Graph labelling for speeding up git commands
>>
>>  - Language: C
>>  - Difficulty: hard / difficult
>>  - Possible mentors: Jakub Nar=C4=99bski
>>
>> Git uses various clever methods for making operations on very large
>> repositories faster, from bitmap indices for git-fetch[1], to generation
>> numbers (also known as topological levels) in the commit-graph file for
>> commit graph traversal operations like `git log --graph`[2].
>>
>> One possible improvement that can make Git even faster is using min-post
>> intervals labelling.  The basis of this labelling is post-visit order of
>> a depth-first search traversal tree of a commit graph, let's call it
>> 'post(v)'.
>>
> This, the post(v) number, may need a bit more explanation for those not
> familiar with graph theory terminology, so that they can get up to speed
> easily about the method, and it's (hopeful) simplicity.

All right, I see that it might be not clear for someone who is not
familiar with graph theory terminology.  The post(v) order is the order
you encounter commits, assuming that you mark commit 'v' as visited
after all its parents have been visited.

The positive-cut labeling works also for pre(v) order, where we number
commits from top, starting from heads, marking commit 'v' as visited
before any of its parents (you just need to switch from min-post to
pre-max interval).

> =C2=A0It isn't clear to me if it is a count along a single string-of-pear=
ls
> between two branch - merge points, or depth from origin, or whether it
> can span large chunks of the DAG? Ref 3. has the same problem of
> starting from an assumed level of knowledge and understanding that may
> put of non-academics (I'm thinking that the proposed method is this
> PReaCH [3]).

The basic method is something simpler, common to all those methods.
It is described as
- method from "3.3 Pruning Based on DFS Numbering" in PReaCH[3] paper
  (only one of full intervals from Figure 3 there), with modifications
- method from "Interval Indexing" paragraph in "I. Introduction"
  in FERRARI[4] paper, but using only a single interval (strict or
  approximate)
- Fig. 4 Min-Post Labeling, in "GRAIL: A Scalable Index for Reachability
  Queries in Very Large Graphs" (2012) paper
- "3.4.1 Positive-Cut Filter" subsubsection in "3.4 Optimizations"
  in FELINE paper i.e. "Reachability Queries in Very Large Graphs:
  A Fast Refined Online Search Approach" (2014)

> It's my understanding that 'v' is usually 1...n in the literature, but
> in reality it just means 'unique label' (and ultimately able to be
> indexed in a data table). In Git we use the object id as the unique
> label, so the 1..n is just an abstraction/convenience. The other problem
> that can happen is if the terminologies of Git doesn't quite match those
> of the descriptions, such as which end is 'root', or being 'mutually
> reachable' in a directed acyclic graph.

Yes, when reading various graph papers, I need to translate 'root',
'leaf', 'child' from graph-theory terminology to git terminology.

But 'v' being a node (a commit in a commit graph of revisions) is not
one of them.

>
> The Wikipedia article on contraction hierarchies [6] did give some
> useful clues for more lay readers.

Ooops.  Actually in my opinion Reachability Contraction Hierarchies
(RCH) reachability index from PReaCH[3] paper would not work for Git, as
it assumes bidirectional BFS search.

I have cited PReaCH[3] paper for its Pruning Based on DFS Numbering
ideas.

>> If for each commit 'v' we would compute and store in the commit-graph
>> file two numbers: 'post(v)' and the minimum of 'post(u)' for all commits
>> reachable from 'v', let's call the latter 'min_graph(v)', then the
>> following condition is true:
>>
>>   if 'v' can reach 'u', then min_graph(v) <=3D post(u) <=3D post(v)
>>
>> If for each commit 'v' we would compute and store in the commit-graph
>> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
>> that were visited during the part of depth-first search that started
>> from 'v' (which is the minimum of post-order number for subtree of a
>> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
>> Then the following condition is true:
>>
>>   if min_tree(v) <=3D post(u) <=3D post(v), then 'v' can reach 'u'
>>
>> The task would be to implement computing such labelling (or a more
>> involved variant of it[3][4]), storing it in commit-graph file, and
>> using it for speeding up git commands (starting from a single chosen
>> command) such as:
>>
>>  - git merge-base --is-ancestor A B
>>  - git branch --contains A
>>  - git tag --contains A
>>  - git branch --merged A
>>  - git tag --merged A
>>  - git merge-base --all A B
>>  - git log --topo-sort
>>
>> References:
>>
>> 1. <http://githubengineering.com/counting-objects/>
>> 2. <https://devblogs.microsoft.com/devops/supercharging-the-git-commit-g=
raph-iii-generations/>
>> 3. <https://arxiv.org/abs/1404.4465>
>> 4. <https://github.com/steps/Ferrari>
>>
>> See also discussion in:
>>
>> <https://public-inbox.org/git/86tvl0zhos.fsf@gmail.com/t/>  [5]
>
> [6] https://en.wikipedia.org/wiki/Contraction_hierarchies
>
> [I've been off-list for 2+ ,months, so still catching up]

Best,
--=20
Jakub Nar=C4=99bski
