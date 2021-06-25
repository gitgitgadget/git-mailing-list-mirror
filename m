Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00973C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D143061963
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFYQGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhFYQGU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:06:20 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B70C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:03:58 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so9720660ota.13
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TYx24gJn0D0uYLEvdbzlj0xDVaaxrEWAc9Rja/nHbOs=;
        b=qqgsLP2cZWApDFoPBV0qh05W8aBQcWwoo+R7GxlMz0wCFJ4kDC4x75e5U9pAzpPZVN
         qXId38usBhGWOwuXREaUdxQdvBnv9Fuls2xvpu/0DqHeQLkXfHusfrkSl/i16pmDs6sS
         oFRQlHQKoKLdaF9WNHnt113V2YFt6I1IqXfl5OJpdqjQxWdjpt0DNxJfCWey1tQkFkCF
         hTQHNhrv83PcpOnFa3EWAFrIUXd3yCYh14ZiL9ld81oczRsA8uv+ZvmXr/F2Srx7o8fn
         XNhL8NA8ct/epLk2tueFzzVyW9CeoDKgDBdYvhmJ+Ny/k0Lc5LbbrQvxFiIVvfufM3Td
         gB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TYx24gJn0D0uYLEvdbzlj0xDVaaxrEWAc9Rja/nHbOs=;
        b=U2hazMqF++h13FUVMV6m8ljCQxO4aIuVspoJKTZGeahndipI+jWhtbRsMhtLUgEsOd
         Nn02amWlpl5Xe9YYFM+l+Xnezwlg2WESnLQ2gNdJPBPGoMUAuaeVyca8q+A8voFMrclp
         FyynGQT1ThjgmaGJsAwiVMpQqWf/saHkAGt9XkcPjla3U8JO/6cVqlCIc10WRhK2o5o4
         wRe43LV5obTRxoJGJBlHQReh8LHxgxZDylKEp5YkNJ8Jf4Tu+aYz/sXhVnbMZXdaH3h9
         Z/wIqNg5512f1pYn/SQkDX10IpjSsrdTM/PJeGIcJIiy821NVbr8MdRccXiCEIOkA+Zz
         tuiw==
X-Gm-Message-State: AOAM532EQlebAysQnFX2vihfbwmtESpOFyL5Pj0pb5wEWvGFjfZVzjHs
        Yb26yMd/+og1CX1xJtsknx8=
X-Google-Smtp-Source: ABdhPJwBwqvAK9x0W8saS0Q4T02eFXgsd5D3XcGs5HM4EHkFzB5rqS4V7zG1YBqaHgoU0dLnWgWr6g==
X-Received: by 2002:a9d:4501:: with SMTP id w1mr10314857ote.305.1624637038253;
        Fri, 25 Jun 2021 09:03:58 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l3sm1401279oif.49.2021.06.25.09.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:03:57 -0700 (PDT)
Date:   Fri, 25 Jun 2021 11:03:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60d5fe6c5be64_c237208ae@natae.notmuch>
In-Reply-To: <AS8PR02MB7302119463FF6E69A58E82799C069@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
 <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
 <60bf1997b1a72_1a2ac520865@natae.notmuch>
 <AS8PR02MB7302DF058D13CAE11A1086FD9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <60bf36f24d2e2_1a848720836@natae.notmuch>
 <AS8PR02MB7302955796AAEF8B9063505E9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <60c18651e2e78_af4cf2086a@natae.notmuch>
 <AS8PR02MB7302119463FF6E69A58E82799C069@AS8PR02MB7302.eurprd02.prod.outlook.com>
Subject: RE: [PATCH] branch: make -v useful
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kerry, Richard wrote:
> 
> > From: Felipe Contreras <felipe.contreras@gmail.com>
> > Sent: 10 June 2021 04:26
> > 
> > Kerry, Richard wrote:
> > > > Do you always push to the same remote branch you pull from?
> > 
> > > [RK] Yes.  There are two people doing most of the work , me and one
> > other.  We each mostly:
> > > [RK]  1.  Are not working on the same things.  Ie we don't generate
> > > many conflicts [RK]  2.  Pull and push to the same branch.  Ie each of
> > > us has a branch that we work on.  He uses "master", I have my own (It
> > > is a single very long-lived branch - I know that isn't a recommended
> > > workflow but that's where we are for the moment)
> > 
> > I call this a two-way workflow.
>  
> Ok, I'm  not sure I've heard of that.

You probably haven't, because I invented it.

Just like in a two-way street cars can go on both directions, in a
two-way branch you push and pull from the same destination.

> > > [RK] Merges are infrequent, but because we are working in different areas,
> > we merge to "our own" branch (few conflicts, usually) and push to its
> > remote.
> > 
> > This is crucial. 
> 
> Is it ?
> 
> > Is the local and remote branch always the same?
> 
> Yes.
> 
> > In other words: do you always pull from "origin/topic", and push to "topic"?
> 
> Yes.

Then that's a two-way branch.

> > > [RK] I have never yet done a rebase, but need to do so soon as there is
> > work in an area that we have both worked on.  Then it will be pushed to the
> > usual place - ie the two branches mentioned above.
> > 
> > When you involve another branch is sounds like you will be in a triangular
> > workflow.
> > 
> > You would be fetching from remote branch B, merging to local branch A, and
> > pushing to a remote branch A.
> > 
> > > [RK] So basically, no, not triangular at all, if I understand the meaning of
> > triangular (pull and push to different remotes).
> > 
> > No, once again: triangular workflow doesn't necessarily involve a different
> > remote (although it usually does).
> > 
> > You can pull from branch B from a central repository, and push to branch A
> > from the same repository, and that would be triangular, not two-way.
> > 
> > 
> > It's understandable that users are confused about this--since in fact many
> > developers are confused too. It would be nice if git had some documentation
> > about the different workflows, alas it doesn't at the moment.
> > 
> > Basically in my view there are four workflows:
> > 
> >   1. Central - two-way: push and pull the same branches from the same
> >      repo.
> >   2. Distributed - two-way: push and pull the same branches, but from
> >      different repositories (master <-> origin/master,
> >      topic <-> github/topic)
> >   3. Central - triangular: push and pull different branches from the
> >      same repo.
> >   4. Distributed - triangular: push and pull different branches from
> >      different repositories.
> > 
> > It sounds to me you are mostly in #1, but soon dabbling into #3.
>  
> I think we are just doing #1.
> We moved a few years ago from Subversion to Git.  Before that we were on CVS (actually CVSNT).  Those are centralized, with merging and branches allowed, but not different repos.
> Originally all the work produced a single final product installer.  Since my work and his turned out to be on different release cycles it was changed so now there are two separate products.
> My part has some dependencies on his, so I need occasionally to incorporate his changes into my branch.
> I occasionally changes files that will go into his final product, so there is then the occasional merge from my branch to his.
> 
> Actually maybe there is some #3.
> After merging his to mine, then mine back to his, I will push both.  Does that make it #3?

Yes, you sometimes use a triangular workflow: pull from your branch,
push to his branch. Even though it's on the same repository.

Either way, you probably always configure the upstream branch to be your
branch, so you always know what your local "topic" points to on the
remote.

-- 
Felipe Contreras
