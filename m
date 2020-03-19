Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7010C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 12:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E8820732
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 12:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdkA8PUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgCSMuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:50:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34141 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgCSMuF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 08:50:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id s13so2345570ljm.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 05:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tYa1WJQsLupgLh1P6fnw8DFpr5RPLljvm5LP3A83tPs=;
        b=VdkA8PUGmaZdcYzTpeUD4ClT25LfSF56D7Nr0FWMuJR70zctqRW2YP+dpQNikYtLcc
         LLS5eQ4HbxoF4UH0Vw9jyVQ2wnhPMqV4qYi+EY6/kqLGipLKX1U1FXcmKzLnSEY9xlWn
         82ou25As7xr/tHPjjoY0k/Xp9Oc063Mme3hWXubo1svdh779Y0VYOVwZkbhYaW/gQBI3
         9xuqY2dS7qI0KZNgD9JkaqlxuVJNsO1YDMT9EQyC7Z7tPGIEOSqajVuq7X9NlfZOd9U2
         viH8V7XSRN1ZqPjTyg7WEo5rvKz+t0dQCc/n0cAQCEpv6aYUeE/bq7u6QXE8pX4zDbaF
         vNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=tYa1WJQsLupgLh1P6fnw8DFpr5RPLljvm5LP3A83tPs=;
        b=KyP2PaMKbT5qfJQ498MXOChzBqK2C3o43ZTctPYpWx5diuUnrrCbHU5/rTH3OpcP72
         4AthYPCGdMruXgf6V4EwTuI5JLcpgVCnDHeUmlp4E7BGP2Bpx9XkXRHTGU0axlGDAzLp
         Lc5gN2pYFxpv1hT/NwTJiB4NUOJsF9+u+65ab4Cj50vz/BCo0Plkst4EvQEyby0ouXpg
         Fh+oAZufh0+KkpBo/UYQfD0mJ90Wqfvn8FfLCpbWVXsV/lns0s+WmQUqjBivS1HYTVfH
         GX6IxJU3XLmnUh9sF4xr8QSia2yLGtDqZ55hLQYDfwGQq901ixWCWQVR7fqIFyNJwl6E
         LR9A==
X-Gm-Message-State: ANhLgQ2B1usVpGkLW930rChvrMzqywLlg4nyM6Pofyd0gVp33rdbLb27
        6bFL9630Iy9Rb8GITzOdBV8=
X-Google-Smtp-Source: ADFU+vs9hQEhxL493HjDP9Vf/IangvStE3wRnKxSq5KTQwwNwwxlnHcaDohBPdrwYSHPOyNGV0ZHUQ==
X-Received: by 2002:a2e:3a01:: with SMTP id h1mr2006729lja.161.1584622202546;
        Thu, 19 Mar 2020 05:50:02 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id y23sm1404212ljc.28.2020.03.19.05.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 05:50:01 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <CAHk66fv-fRZdUFC978sKUT_b7VYi6S2f2vdTQ6iB-wcCznnBHg@mail.gmail.com>
Date:   Thu, 19 Mar 2020 13:50:00 +0100
In-Reply-To: <CAHk66fv-fRZdUFC978sKUT_b7VYi6S2f2vdTQ6iB-wcCznnBHg@mail.gmail.com>
        (Abhishek Kumar's message of "Tue, 17 Mar 2020 23:30:00 +0530")
Message-ID: <86eeto5x1j.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Greetings Jakub
>
>> So perhaps we should expand "Commit graph labeling for speeding up git
>> commands" idea, splitting it into two possible ways of working in this
>> project: the more technical 'Generation number v2', and 'Interval labels
>> for commit graph' which is more of research project?  Which should be
>> put first, then?
>
> I would suggest working on generation number v2 first because:
> - We ship improved performance *sooner*.
> - I find it easier to shift from simpler to more complex systems.

It would be also more of an engineering project, than research one.

> On a personal note, I would be able to do a better job at working on gene=
ration
> number v2 than on interval labels. While reading through the papers menti=
oned
> was fun and full of a-ha moments, I find building things more
> fulfilling. I would be glad if either you or Derrick opt for mentoring it.

All right.  I have added 'Generation number v2' as possible way of
working on the "Commit graph labeling for speeding up git commands"
idea.

https://git.github.io/SoC-2020-Ideas/#commit-graph-labeling-for-speeding-up=
-git-commands


> You could read my proposal at the link below. It is very rough and I have=
n't
> proofread it yet. I will send out a more formal proposal once the directi=
on
> of this project is decided.
>
> https://github.com/abhishekkumar2718/GSoC20/blob/master/graph_labelling.md
>
> **Too long, didn't read**

I will comment only on the TLDR version below.

> - Commit graphs are small to medium-sized (compared to problem sizes obse=
rved in
> graph-theory literature) sparse graphs. They have unusual properties comp=
ared
> to more conventional graphs that can be exploited for better performance.

Right.

> - Most of git's reachability queries are negative and using a negative-cut
> filter improves performance more than a positive-cut filter.

Not exactly.  Most time consuming git graph queries are those that
return a subgraph or otherwise need to walk the commit graph (like
topological sorting, or ahead/behind numbers).  Here in most cases
negative-cut filters, that reduce the number of commits walked, improve
performance more (with rare exceptions, like --ancestry-path query).

That is what I think, but it is not something I have proven...

> - Implementing and maintaining a two-dimensional reachability index is ha=
rd
> and does not offer justifiable performance gains.

I think it would be better to not mention graph reachability algorithms
at all, and just talk about generation number v2 as straight performance
improvement over generation number v1.

> - We plan to use corrected commit date as the generation number v2 becaus=
e it is
> locally computable, immutable and can be incrementally updated.

Unfortunately because of an oopsie with respect to commit-graph file
format versioning, at least for the time being generation number v2
needs to be also backward compatibile with generation number v1.  See
for example:
  https://git.github.io/rev_news/2019/06/28/edition-52/#reviews
  https://speakerdeck.com/jnareb/graph-operations-in-git-and-how-to-make-th=
em-faster?slide=3D74

>
> - If git ever considers a two-dimensional reachability index, either post=
 order
> DFS, GRAIL or an index based on commit date would be good starting
> places to explore.
>
> I go in more details about GRAIL, FERRARI and PReaCH, explaining
> briefly how they work, their advantages, and disadvantages.

Again, I don't think that is necessary.

Best,
--=20
Jakub Nar=C4=99bski
