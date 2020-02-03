Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68FAC33C9E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 04:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8496A20721
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 04:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EdzBmILw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBCEgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 23:36:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37783 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgBCEgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 23:36:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so147912pgl.4
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 20:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XiLSa2NpAMlOfmO59Dg3jaDRdmqwqt1SfGJqhsHfSMs=;
        b=EdzBmILwFkcXd8AL83UZpRGpPEGdY9MwP/UzuezJpC7OViiz2S2Z9bfrgBagWW7uwM
         p8X4Y6uoGG/CKrWVXfPcV7LmzZvS8VbEep9nasccF4Rjh1CzODkideG3i+pRTEL8+xom
         EHEdUFKiS7BN+j0yScC8WooFDcF0jhsIAmSBnGRQ+Zl7TyWE8BXWymmeteXAFlaacX1I
         sJCYo6vnA9aAx4HF6Y3Ms+TixYSToCaZqHGUUJnUME0auZe10olvmuoHK13yPK7kmjwB
         yzP7Y/GDEL49tYJEYaXhR5d8O55SUBb0xOSDbNrO12jZ5BCWgkvLh479EnTBCATjBldp
         YZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XiLSa2NpAMlOfmO59Dg3jaDRdmqwqt1SfGJqhsHfSMs=;
        b=Jw7c/Byi09mvrU0LF+tdc78ig0DrfmWB/snF1rhVEvWDE1Zfe1DVdeaPiws7LVbRr4
         hsR1bmPELO8ULcarkki1VeFRf8+1dEHPfAU1mojJKmxBXG/tW/kri1b3nvSwY1i3xFir
         YKf9o5YsZxxGGH3VN8vFd7XrrPA/UCUm5xNLaxbu6bJ4+Zd9eYRONbz3s/YjdJ+nZutn
         RphUP13UeBiPehuGrT/WCCrVaKTWu65e8puSl5te4eRy2kDFYxG59vz1c7bfkZshV09t
         cDKerwDPXt06GqzGQk0YqtrLNtQTGCR1UgYKgouG2IK6ANoC0UaruklnW2yz8KEtXC0Z
         j/hQ==
X-Gm-Message-State: APjAAAWvuu37KY3dD8hFKR5Ah2rNnbuDcFb1W2cvE7RQCj7ZLbWSU8Jb
        FNi2vZcp0GqTWj0Sa4DjGq97eA==
X-Google-Smtp-Source: APXvYqyFYujoDKNRWPl54VejTXBFFiASDp0mjTRP09nbP+zoJOCMZuOpDGmOoOekVrdVWqdLBO93XA==
X-Received: by 2002:a63:e80d:: with SMTP id s13mr23997376pgh.134.1580704607975;
        Sun, 02 Feb 2020 20:36:47 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:ac09:c6e5:fcdd:b79b])
        by smtp.gmail.com with ESMTPSA id m12sm18330846pjf.25.2020.02.02.20.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 20:36:47 -0800 (PST)
Date:   Sun, 2 Feb 2020 20:36:46 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] commit-graph.h: store object directory in 'struct
 commit_graph'
Message-ID: <20200203043646.GB23625@syl.local>
References: <cover.1580424766.git.me@ttaylorr.com>
 <890e0e7136204f5ca47f0703f32b4adb99ad8d7e.1580424766.git.me@ttaylorr.com>
 <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com>
 <20200131102049.GC2916051@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200131102049.GC2916051@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 05:20:49AM -0500, Jeff King wrote:
> On Fri, Jan 31, 2020 at 07:52:02AM +0100, Martin Ågren wrote:
>
> > > --- a/commit-graph.c
> > > +++ b/commit-graph.c
> >
> > > +struct object_directory *find_odb(struct repository *r, const char *obj_dir)
> >
> > This doesn't look commit-graph related -- could/should it go somewhere
> > else?
>
> I think the right place is actually as a static inside
> builtin/commit-graph.c, as this is really about handling its weird
> --object-dir options.
>
> But it can't go there in this patch, because there's a caller in
> commit-graph.c. In patch 4, we convert write_commit_graph() to take an
> odb, too, and that call goes away. At that point, we could move it into
> the builtin as a static.
>
> Ideally we could flip the order of this patch and patch 4, but that
> doesn't work either: by switching to an odb we lose our path
> normalization, but if the other side hasn't switched either, then we
> can't just compare odb pointers. It would be a temporary regression.
>
> So there's a circular dependency between the two patches. I think we
> ought to do done of:
>
>   - move find_odb() to a static as a cleanup on top
>
>   - squash those two patches together into a single
>
>   - swap the patch order, but have write_commit_graph_ctx store both the
>     "odb" _and_ the normalized copy of the path we do now. That leaves
>     it correct, and then it can be cleaned up in favor of an odb pointer
>     comparison in patch 5, along with the rest of the normalized bits.

Thanks for describing the problem, and for laying out a few options!

I went with this option, which was to swap patches 2/6 and 4/6, and then
squashing 3/6 into what _was_ 4/6 (but is now 2/5).

That all said, I am not sure that I follow the explanation that we need
to have 'write_commit_graph_ctx' store the normalized object_dir, since
we can use 'odb->path' for this instead. I double checked, and we
already do the same loose normalization in
'sha1-file.c:link_alt_odb_entry()', where we remove trailing slashes.

This isn't the exact same normalization strictly speaking. It differs
only in that we remove more than one trailing slash if it exists, but
this seems acceptable for the 2 patches that this behavior changes lives
on for.

I double checked that the 'odb->path' is normalized relative to the $PWD,
in which case I think that we can rely on it as a stand-in for
'object_dir', and don't have to store both.

> I'm OK with any of those. The second two have the added bonus that we
> could introduce the die() behavior into find_odb() immediately, and
> explain it (there's another temporary weirdness in this patch where
> specifying an --object-dir outside of the repository becomes a silent
> noop, and then the next patch turns it into an error, but that could all
> be done in a single step when we introduce find_odb()).
>
> > I think you could drop `cmp` and that final check, and write the loop
> > body as "if (!strcmp(...)) break". You could also have an empty loop
> > body, but I wouldn't go there -- I'd find that less readable. (Maybe
> > that's just me.)
>
> Yeah, I believe you are correct (and this is a nice simplification worth
> doing).
>
> -Peff

Thanks,
Taylor
