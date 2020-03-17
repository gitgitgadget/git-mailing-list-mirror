Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2459C1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26B620735
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD55v10u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgCQSFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:05:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37672 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgCQSFn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 14:05:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so24057909ljd.4
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X3NS+LqD6d5RRsB2ib7AKpypW6PUDJ1DAshJWdgBBK0=;
        b=DD55v10upuFDI0QuRRO8DaPLBU5pqQvaTooC5h1S97O4RRDBNbwdGAb3ruErsx7uAR
         SIy8sNESqE2mWws/Ml5PsxI7J/7Wv0Xfn3+OvAN4BFUyIIcbhMTtTWs1KpfcWM8v8ZWE
         A5SMV+9qbbticjQbrzZTsS4BwHPAF79pb/ya4aIg+BzIsqiL8Az+CMZPnHyJqrbzJbgn
         6pHuGGmU6Vod/vID48s70HNW07Zq3+gfcv20MHScveShArWNMkkChwNHJin+tP2pNRba
         Jp3pJSi7Kti5eyyIWuhdqkDw8TrYZ/WZoctDxYxc2yUIVt592QInFlkQmmvbDEijEwS+
         zXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=X3NS+LqD6d5RRsB2ib7AKpypW6PUDJ1DAshJWdgBBK0=;
        b=seE5aljEpTwcXL8dsXTuIw9Xum+IZrdbcEjwJTvBEzc4cM1/jx+7QIE224Mzgdb2FB
         sshg1iY0Xmxo/PCN5GoGlhyR17vUmFXQSP8nb/xk/2zNj//viuaEseNGy5i2ZlQVuvFJ
         745BUCAC+qO6wf0KAcF+r0yQ4UtDqJsPmP5//cfCiaRLti7OOcYEsZAZWVORN6K0mekI
         1vKWj7Bk0aYl2Uqvrf4LvuMmCf4MSk2ukvU9E2dZQEou4Qmow4Iv3Pp6Vpw9+BoOi8HR
         kWX7vYcs6uGIdQbknej764htIW/7kplnjzzJxkZZwx4PHfS+Q8TFPKdmAVEfhxMT3HcV
         O4aw==
X-Gm-Message-State: ANhLgQ1tOcnlWOpiOc4FvACA9CwqO3AiOmlKLE1bO1Ka8zo6fLZOcr3g
        n7UWOMtgsi/GYT+gat5xO8I=
X-Google-Smtp-Source: ADFU+vviqumqc2Tfy0d0Dewo+KkRI5XJn5/oVSdlKZuUy8UII0pH1P1p3Ogv5N1x6P8+g2+AtPMuTg==
X-Received: by 2002:a2e:b4b1:: with SMTP id q17mr11195ljm.22.1584468341273;
        Tue, 17 Mar 2020 11:05:41 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id a10sm2922531ljb.23.2020.03.17.11.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 11:05:40 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <CAHk66ftx=XTSeVcPe09yA9KMDpHwiKFLKa62cCBFufjeenAbaQ@mail.gmail.com>
Date:   Tue, 17 Mar 2020 19:05:37 +0100
In-Reply-To: <CAHk66ftx=XTSeVcPe09yA9KMDpHwiKFLKa62cCBFufjeenAbaQ@mail.gmail.com>
        (Abhishek Kumar's message of "Tue, 17 Mar 2020 22:30:00 +0530")
Message-ID: <86sgi66emm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

>> Having such a complicated two-dimensional system would need to
>> justify itself by being measurably faster than that one-dimensional
>> system in these example commands.
>>
>> [...]
>>
>> My _prediction_ is that the two-dimensional system will be more
>> complicated to write and use, and will not have any measurable
>> difference. I'd be happy to be wrong, but I also would not send
>> anyone down this direction only to find out I'm right and that
>> effort was wasted.
>
> Agreed. I have been through the papers of the involved variants and on gr=
aphs
> comparable to some of the largest git repositories, the performance impro=
ves by
> fifty nanoseconds for a random query.

I would recommend extending results for other types of large graphs to
the commit graphs with care.  The characteristics of those graphs are
quite different from characteristics of commit graph: they usually are
scale-free graphs, with low maximum level, and low connectivity: the
probability of two random nodes being connected in order of 10^-3 or
10^-4; see e.g. https://speakerdeck.com/jnareb/graph-operations-in-git-and-=
how-to-make-them-faster?slide=3D99

The last one, called R-ratio, means that testing on random query
actually tests mainly negative-cut filters.  That is why some papers
provide either separate numbers for negative and for positive queries,
or separate numbers for random and for balanced queries.

> Additionally:
> 1. They require significantly more space per commit.

This depends on the type of the algorithm: is it Label-Only (answering
reachability queries without consulting graph), or Label+Graph
(augmented online search algorithms):
https://speakerdeck.com/jnareb/graph-operations-in-git-and-how-to-make-them=
-faster?slide=3D78

The CDAT chunk in current version of commit-graph format takes H+16
bytes per commit (where H is the size of object id hash).  From those
H+16 bytes 30 bits (slightly less that 4 bytes) are used for current
reachability label: the topological level aka generation number.
https://speakerdeck.com/jnareb/graph-operations-in-git-and-how-to-make-them=
-faster?slide=3D45

The proposed min-post interval label would take 8 bytes per commit, that
is 4 bytes per single number in interval.  That is not much, provided
that we get visible performance improvements for at least some often
used git commands.


> 2. They require significantly more preprocessing time.

This again depends on the type of algorithm: Label-Only or Label+G.

In the case of min-post interval labels, they can be computed together
with generation number, during the same commit-graph walk.  The amount
of calculations required to compute min-post interval is not much.
Therefore I think it would be not unreasonable cost.

>> My recommendation is that a GSoC student update the
>> generation number to "v2" based on the definition you made in [1].
>> That proposal is also more likely to be effective in Git because
>> it makes use of extra heuristic information (commit date) to
>> assist the types of algorithms we care about.
>
>> In that case, the "difficult" part is moving the "generation"
>> member of struct commit into a slab before making it a 64-bit
>> value. (This is likely necessary for your plan, anyway.) Updating
>> the generation number to v2 is relatively straight-forward after
>> that, as someone can follow all places that reference or compute
>> generation numbers and apply a diff
>
> Thanks for the recommendation. Reading about how this fits in more
> with REU on the other thread, I too agree that updating generation
> number to use corrected commit date would be more appropriate for a GSoC
> project.

You can read about monotonically offset corrected commit date for
example on my slides, from page 64 (the problem) to 75 (references):
https://speakerdeck.com/jnareb/graph-operations-in-git-and-how-to-make-them=
-faster?slide=3D64

I'll try to update the proposal on SoC 2020 Ideas page soon, perhaps
tomorrow when I will have more free time.

https://git.github.io/SoC-2020-Ideas/

In the meantime I will refer to what is written at the top of it:

> **Students:** Please consider these ideas as starting points for
> generating proposals. We are also more than happy to receive proposals
> for other ideas related to Git. Make sure you have read the =E2=80=9CNote
> about refactoring projects versus projects that implement new
> features=E2=80=9D in the general application information page though.

Best,
--=20
Jakub Nar=C4=99bski
