Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF95C4332F
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 16:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLKQ1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 11:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLKQ1X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 11:27:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAD1DF18
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 08:27:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 794B01FD66;
        Sun, 11 Dec 2022 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670776040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRIQpLthuFyVsYhoc7bBJ0mYNRDEd4kDTZJUxmcVCVc=;
        b=z+0GFvziVRWee4QWzQWxOSvixTclYA4vuLsm9Rf0fNfAbn5yJDC5RTcm6sEiZlm5wkskVT
        5ZLyK9yUmM2dZDnWGqGF1wrRlV3DF8wmgCv7Nrz8Kwt1I0/w6EAj/D/GRqIfTP+2HmGhdR
        2QFBY994oj/++x49LQB8f8Dedvrmy48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670776040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRIQpLthuFyVsYhoc7bBJ0mYNRDEd4kDTZJUxmcVCVc=;
        b=TTHCkF4lLq2ytXNRVBUNwepslQrOWPM4607ggMw6FkqrydxHqjty7jCv+WERZ7U5kXFUYC
        vr23yPN4azpUqfCg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2021B2C141;
        Sun, 11 Dec 2022 16:27:20 +0000 (UTC)
Date:   Sun, 11 Dec 2022 17:27:18 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
Message-ID: <20221211162718.GO28810@kitsune.suse.cz>
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com>
 <20221208011631.GH28810@kitsune.suse.cz>
 <Y5GLsZgmrxbBtLqo@coredump.intra.peff.net>
 <20221209004918.GI28810@kitsune.suse.cz>
 <Y5KRQMcUlepwNlor@coredump.intra.peff.net>
 <CAOLTT8SR6JWX6mRLbyq4keb4JCfJP6Vq07LzHpb_f+e1jMnsZQ@mail.gmail.com>
 <221209.86bkoc7kgi.gmgdl@evledraar.gmail.com>
 <CAOLTT8SqFJFk2sO6quL_O8gm4FL-w+mbvjH+cg2L7OF3G_-mLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8SqFJFk2sO6quL_O8gm4FL-w+mbvjH+cg2L7OF3G_-mLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 12:01:51AM +0800, ZheNing Hu wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> 于2022年12月9日周五 21:52写道：
>
> >
> >
> > On Fri, Dec 09 2022, ZheNing Hu wrote:
> >
> > > Jeff King <peff@peff.net> 于2022年12月9日周五 09:37写道：
> > >>
> > >> On Fri, Dec 09, 2022 at 01:49:18AM +0100, Michal Suchánek wrote:
> > >>
> > >> > > In this case it's the mtime on the object file (or the pack containing
> > >> > > it). But yes, it is far from a complete race-free solution.
> > >> >
> > >> > So if you are pushing a branch that happens to reuse commits or other
> > >> > objects from an earlier branh that might have been collected ín the
> > >> > meantime you are basically doomed.
> > >>
> > >> Basically yes. We do "freshen" the mtimes on object files when we omit
> > >> an object write (e.g., your index state ends up at the same tree as an
> > >> old one). But for a push, there is no freshening. We check the graph at
> > >> the time of the push and decide if we have everything we need (either
> > >> newly pushed, or from what we already had in the repo). And that is
> > >> what's racy; somebody might be deleting as that check is happening.
> > >>
> > >> > People deleting a branch and then pushing another variant in which many
> > >> > objects are the same is a risk.
> > >> >
> > >> > People exporting files from somewhere and adding them to the repo which
> > >> > are bit-identical when independently exported by multiple people and
> > >> > sometimes deleting branches is a risk.
> > >>
> > >> Yes, both of those are risky (along with many other variants).
> > >>
> > >
> > > I'm wondering if there's an easy and poor performance way to do
> > > gc safely? For example, add a file lock to the repository during
> > > git push and git gc?
> >
> > We don't have any "easy" way to do it, but we probably should. The root
> > cause of the race is tricky to fix, and we don't have any "global ref
> > lock".
> >
> > But in the context of a client<->server and wanting to do gc on the
> > server a good enough and easy solution would be e.g.:
> >
> >  1. Have a {pre,post}-receive hook logging attempted/finished pushes
> >  2. Have the pre-receive hook able to reject (or better yet, hang with
> >     sleep()) incoming deletions
> >  3. Do a gc with a small wrapper script, which:
> >     - Flips the "no deletion ops now" (or "delay deletion ops") switch
> >     - Polls until it's sure there's no relevant in-progress operations
> >     - Do a full gc
> >     - Unlock
> >
>
> Well, I understand that after the branch is deleted, some objects may be
> unreachable, and then these objects are deleted by concurrent git gc,
> which leads to data corruption in concurrent git push if these objects need
> to be referenced, but what I don't understand that is it enough to just block
> the operation of deleting branches? Once gc happens to be deleting an
> unreachable object, and git push new branch (git receive-pack) happens to
> need it, won't it still go wrong?

As I understand the problem:

 - push figures out which objects are missing on the remote end
 - push starts sending the missing objects
 - remote gc deletes objects that are not reachable but push assumes remote has them
   - these might be part of a branch deleted long before gc started
 - push finishes and branch is advanced to point to an object that
   references objects that were deleted by gc

-> repository is corrupted

The only way to prevent this is to not delete anything ever, or to make
sure that objects that are part of any ongoing operation are always
referenced.

Which would probably mean in practice that any operation adding objects
needs to add temporary references to any objects it creates or aims to
reference, and/or check reachability of referenced objects once the
final object is created.

Thanks

Michal
