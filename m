Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05071C18E5B
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F5720663
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea+TW6N6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgCQOSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:18:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42611 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgCQOSq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 10:18:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so22991558ljp.9
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ytHFdKsokBUdr3gWyf70bC592y59e5sOi2gUNGw7wkk=;
        b=Ea+TW6N6xEBSEbsW5/RGaCX6SJuhzivCJP4kkSSdJ5HujQNepoJmA8jXM/K1kEwZm4
         O2xdxqeE5V2LNre4iPAlrdOnpUZNjseqYK3NABWLoMG2HPiYZz4yGLLB31NRaUmWFpSe
         6d14630yDqq0zVfu13e/bCIoH/h5fenHu1dC3J/T378/qPpgVCbXSS3zNLyvA8iVX6Wo
         UlehmH5Lt3fFFBcigesR2SVN3Nzge3gT7h8yf562JVzlB9eyODMGpb4Ydyy6zLgGz6zd
         NUqpG2QeXIdb8MaALN7QpiNuP9uvsKXmu4lZfbjjS49qxbX1TwO/4rvJ8wc+xi2RIn2H
         FYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ytHFdKsokBUdr3gWyf70bC592y59e5sOi2gUNGw7wkk=;
        b=KhXhSPBbwlrQCWoIkYxJeHG6K0iu9khimXIGQ82pvo9qS00+isb1VQ78OonxMswIau
         GT/qt8NspyQIk+fmQb1Xa2nxcjYluDQL2AXpa+t2DAgIe0I4lduMbQAdcFKX12UZtNuo
         dg0N0oTnw87MNYIKRhksNvZbZX1saS8pVwbwvtMvASzB7skO/HScTQC2St55Ffj3ztdc
         Vw97qp7/K4JKBZR2qh9KIz6/veuGl66AUrvspMRjrsJOwl8S10AsMrdxtGuO0BWLVvMQ
         azlGJoTKg2E5zN0eMJj4P+/Dgdt0COgVVa7/OjIBtlMJcZVMbecV/PKpMZ4QrhVe2ir6
         99YQ==
X-Gm-Message-State: ANhLgQ206UbVtV/lkzEtUTHs8Isi+MXxpf6rGXHZ1P0sAod5hjUiidwr
        cS9GUMnQXqderMGpyZEhoiw=
X-Google-Smtp-Source: ADFU+vtd0/6MYV9i7Bv1+ajYOLe54MOtgh98/5/6u+hQdyiv99/i6fjG+AKFJEelmsnky+EHgHaa8g==
X-Received: by 2002:a2e:97cf:: with SMTP id m15mr2806356ljj.30.1584454721865;
        Tue, 17 Mar 2020 07:18:41 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id w10sm2430894ljo.92.2020.03.17.07.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 07:18:40 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com>
        <86d09b7jx6.fsf@gmail.com>
        <CAP8UFD3BeS8bj8OGKJmVyKeDTCvqhCpBxLhTwuQ3zffejQkj7g@mail.gmail.com>
Date:   Tue, 17 Mar 2020 15:18:37 +0100
In-Reply-To: <CAP8UFD3BeS8bj8OGKJmVyKeDTCvqhCpBxLhTwuQ3zffejQkj7g@mail.gmail.com>
        (Christian Couder's message of "Tue, 17 Mar 2020 08:24:22 +0100")
Message-ID: <867dzj6p4y.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:
> On Tue, Mar 17, 2020 at 4:13 AM Jakub Narebski <jnareb@gmail.com> wrote:
>
> [...]
>
>>>> ### Graph labelling for speeding up git commands
>
> [...]
>
>>> We already have the second inequality (f(u) <=3D f(v)) where the functi=
on
>>> 'f' is the generation of v. The success of this approach over generation
>>> numbers relies entirely on how often the inequality min_graph(v) <=3D p=
ost(u)
>>> fails when gen(u) <=3D gen(v) holds.
>>
>> True.  It may turn out that additional negative-cut filters do not bring
>> enough performance improvements over topological levels or corrected
>> commit date (or monotonically increasing corrected commit date) to be
>> worth it.
>>
>> I think they can help in wide commit graphs (many concurrently developed
>> branches with many commits and few merges), and when there is orphan
>> branch (like 'todo' in the git.git, or 'gh-pages' for storing
>> per-project GitHub Pages) that is somehow entangled in query.
>>
>>>> If for each commit 'v' we would compute and store in the commit-graph
>>>> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
>>>> that were visited during the part of depth-first search that started
>>>> from 'v' (which is the minimum of post-order number for subtree of a
>>>> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
>>>> Then the following condition is true:
>>>>
>>>>   if min_tree(v) <=3D post(u) <=3D post(v), then 'v' can reach 'u'
>>>
>>> How many places in Git do we ask "can v reach u?" and how many would
>>> return immediately without needing a walk in this new approach? My
>>> guess is that we will have a very narrow window where this query
>>> returns a positive result.
>>
>> As I wrote below, such positive-cut filter would be directly helpful in
>> performing the following commands:
>>
>>  - `git merge-base --is-ancestor`
>>  - `git branch --contains`
>>  - `git tag --contains`
>>  - `git branch --merged`
>>  - `git tag --merged`
>>
>> It would be also useful for tag autofollow in git-fetch; is is N-to-M
>> equivalent to 1-to-N / N-to-1 `--contains` queries.
>>
>> I am quite sure that positive-cut filter would make `--ancestry-path`
>> walk faster.
>>
>> I think, but I am not sure, that positive-cut filter can make parts of
>> topological sort and merge base algorithms at least a tiny bit faster.
>
> Is there an easy way to check that it would provide significant
> performance improvements at least in some cases? Can we ask the
> student to do that at the beginning of the GSoC?

The "Reachability labels for version control graphs.ipynb" Jupyter
Notebook on Google Colaboratory was created to answer this question
(originally for the FELINE reachability index).  Among others it can
min-post interval labels and topological levels (generation numbers),
use them for reachability queries, and load Linux kernel
commit-graph. The exploration didn't get finished, but it would be not
that difficult, I think, to at least find the amount of false negatives
for min-post interval labeling for git.git or Linux kernel repo.

  https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg

As Jupyter Notebook, it is run in the web browser.  It can either use
local runtime, or run on Google Cloud runtime.  On the other hand it
requires at least some knowledge of Python...

>>> I believe we discussed this concept briefly when planning "generation
>>> number v2" and the main concern I have with this plan is that the
>>> values are not stable. The value of post(v) and min_tree(v) depend
>>> on the entire graph as a whole, not just what is reachable from v
>>> (and preferably only the parents of v).
>>>
>>> Before starting to implement this, I would consider how such labels
>>> could be computed across incremental commit-graph boundaries. That is,
>>> if I'm only adding a layer of commits to the commit-graph without
>>> modifying the existing layers of the commit-graph chain, can I still
>>> compute values with these properties? How expensive is it? Do I need
>>> to walk the entire reachable set of commits?
>>
>> I think it would be possible to compute post(v) and min_tree(v) using
>> incremental updates, and to make it compatibile with incremental
>> commit-graph format (with the commit-graph chain).  But I have not
>> proven it.
>
> Would it be difficult to prove? What would be required? And again can
> we ask the student to do that at the beginning of the GSoC?

Formal mathematical proof by induction would be not that difficult.  The
problem is, I think, in finding all possible classes of initial spanning
forest arrangements, and all possible classes of commit-graph growth by
one commit -- and examining how this affect the spanning forest.

> [...]
>
>>> The point of generation number v2 [1] was to allow moving to "exact"
>>> algorithms for things like merge-base where we still use commit time
>>> as a heuristic, and could be wrong because of special data shapes.
>>> We don't use generation number in these examples because using only
>>> generation number can lead to a large increase in number of commits
>>> walked. The example we saw in the Linux kernel repository was a bug
>>> fix created on top of a very old commit, so there was a commit of
>>> low generation with very high commit-date that caused extra walking.
>>> (See [2] for a detailed description of the data shape.)
>>>
>>> My _prediction_ is that the two-dimensional system will be more
>>> complicated to write and use, and will not have any measurable
>>> difference. I'd be happy to be wrong, but I also would not send
>>> anyone down this direction only to find out I'm right and that
>>> effort was wasted.
>>
>> That might be a problem.
>>
>> This is a bit of a "moonshot" / research project, moreso than others.
>> Though it would be still valuable, in my opionion, even if the code
>> wouldn't ultimately get merged and added into Git.
>
> I agree that it feels like a "moonshot" / research project.
>
>>> My recommendation is that a GSoC student update the
>>> generation number to "v2" based on the definition you made in [1].
>>> That proposal is also more likely to be effective in Git because
>>> it makes use of extra heuristic information (commit date) to
>>> assist the types of algorithms we care about.
>>>
>>> In that case, the "difficult" part is moving the "generation"
>>> member of struct commit into a slab before making it a 64-bit
>>> value. (This is likely necessary for your plan, anyway.) Updating
>>> the generation number to v2 is relatively straight-forward after
>>> that, as someone can follow all places that reference or compute
>>> generation numbers and apply a diff
>>
>> Good idea!  Though I am not sure if it is not too late to add it to the
>> https://git.github.io/SoC-2020-Ideas/ as the self imposed deadline of
>> March 16 (where students can start submitting proposals to GSoC) has
>> just passed.  Christian, what do you think?
>
> Would that be a different project idea or part of your "Graph labeling
> for speeding up git commands" project idea?
>
> I am very reluctant to add new project ideas at that time. I don't
> think student will have time to properly research it and get it
> reviewed.
>
> It could be part of your research project though, to check if that
> approach is better or good enough compared to what you suggest in the
> current version of your project.
>
>> Would you agree, Stolee, to be a _possible_ mentor or co-mentor for
>> "Generation number v2" project?
>
> At this point I think it might be best if you are both willing to
> co-mentor a "moonshot" / research project to find what is the best way
> forward by bench-marking the different approaches that you both
> suggest for different commands/use cases.

So perhaps we should expand "Commit graph labeling for speeding up git
commands" idea, splitting it into two possible ways of working in this
project: the more technical 'Generation number v2', and 'Interval labels
for commit graph' which is more of research project?  Which should be
put first, then?

Note that for example "Convert scripts to builtins" idea is in similar
situation: it is also many projects in one.

Regards,
--=20
Jakub Nar=C4=99bski
