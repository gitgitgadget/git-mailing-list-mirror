Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020C2C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9912A23138
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgLRGYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 01:24:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:37514 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgLRGYf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 01:24:35 -0500
Received: (qmail 10545 invoked by uid 109); 18 Dec 2020 06:23:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Dec 2020 06:23:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11923 invoked by uid 111); 18 Dec 2020 06:23:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Dec 2020 01:23:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Dec 2020 01:23:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stuart MacDonald <stuartm.coding@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug report] includeIf config is not displayed in normal
 directories
Message-ID: <X9xK+rn8vZGtBuuo@coredump.intra.peff.net>
References: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
 <xmqqczza7lpm.fsf@gitster.c.googlers.com>
 <X9pe119edtL5KQTU@coredump.intra.peff.net>
 <CAPQE4+rhWT9kgusNXOw5cnJ-oFq++4G1FMaXvQ3wppQ0GE0hSA@mail.gmail.com>
 <xmqq5z512v2r.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5z512v2r.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 03:24:28PM -0800, Junio C Hamano wrote:

> Stuart MacDonald <stuartm.coding@gmail.com> writes:
> 
> > My old understanding of git clone:
> > - create sub-directory
> > - create subdir/.git and whatever initial states are needed
> > - clone the repo from origin into the directory
> > - all never having left $CWD
> >
> > It's actually:
> > - create sub-directory
> > - cd subdir
> > - create ./.git and initial states
> > - clone the repo _while inside_ a gitdir
> > - cd ..
> 
> I am not sure how the above two should make any difference with the
> [includeif "gitdir:<pattern>"] matching.  Regardless of where your
> $CWD is, the inclusion is decided on the location of the .git/
> directory we are dealing with, so as long as "subdir/.git" matches
> the pattern given to "gitdir:<pattern>" the inclusion should work
> the same way even if the internal implementation of "git clone"
> changes between the above two.

I think the question is just "are we in a repository as part of clone or
not". Stuart's original world-view was that we were not, as we were
creating a clone but not "entering" it. But that is not how it is
implemented (nor the conceptual model I think we would want to give the
user).

> IIRC "includeif" is a Peff's brainchild, so I'd ask him to correct
> any mistakes in the above paragraph,

The notion of conditional includes was my thing, but gitdir: was Duy's.
That said...

> but I am a bit puzzled as to
> what the true misunderstanding is, where the misunderstanding came
> from, and which documentation if any we should look into improving.

I think it might just be a case of mistaken assumptions. But I am
certainly open to hearing from Stuart if there are places in the
documentation that misled him (or could have led him better).

-Peff
