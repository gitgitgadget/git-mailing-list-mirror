Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8942EC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF81206E9
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="U641O+NW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgDCTzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:55:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44406 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgDCTzt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:55:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id 142so4019900pgf.11
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cMEQNQ/25SODFvp2U4jA+93bQKALsDt/cKkuknSr+94=;
        b=U641O+NWWPTcvGrJ8ZhDTto1RwrzLbiRrVFQyBwijJVY0LbO4F4bZ5v9R4bOV6sgjg
         tDZ1sBm7+qX2sHJYUH0zn7Ttpse53vFIcRo+AdQ/rb49x7F6rrDZltTYE569LonymYU9
         qVkqH9SDkrcO6y8CrxZ1z1WozvrXXsP9cQYVRFGUgPXzZ8sDQbhHGE+dwWTt5oiR47eu
         yG9WJJ++8MQOZrzhxG/uy6ZW+6GrWXcVFvYNWYUEu5yFHHM2FQ17L66dnZbc7fi+3ifn
         PN8UN3PHVo2xBq0elmpg0yvwgW+8dJm/NtabaQs5kOzm5b69a/dQLj2OuCgPnQiESDsB
         Z3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cMEQNQ/25SODFvp2U4jA+93bQKALsDt/cKkuknSr+94=;
        b=ui/Q4eS6PKZe8HhAP/90FEPoXCLJ8qQp6YcGKa43rAs/HGDCVM9PpNCyzdZ/RvhOMR
         xhxiRn4/NNCp1vOBTb9OLwo1wqjyyUYBE8+8gLE5pZK4rpkmnycw8O258NzQ50VqVBNa
         xhiNswTVz7yiuPYUWR1fYA6WL4YJy2viF7ppG1FI/9cltSOvEhAk36G6VR77md2IG8Ea
         H7ZMzCEoIT1ep1FeDtQ6r+mTMUJ1PTpTjwwCapc0YbLKHFfEtDEDPGwLDv9w+PaTtDgG
         dRh9CsEKODq8BROIM6MXIweAQZTkUxVWf35WbKuAODwfEF6iBJovfpn1emyxDIFJICPF
         G4uw==
X-Gm-Message-State: AGi0PubySWMhqVhjGgCCKA4M58bgwLGHY6YkbUMplhG3wZTFl0I00idB
        kUq7c1NVou0nHgdd/crueTg7OA==
X-Google-Smtp-Source: APiQypKKc9AsdwPhkj01rS8sjCT7NJJJt+BNjXr1JCi9CBvPZe/0ZH1tG5z5u1TsbRm0JwQi0bZ8Ew==
X-Received: by 2002:a65:498c:: with SMTP id r12mr9829910pgs.14.1585943746940;
        Fri, 03 Apr 2020 12:55:46 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r186sm6487236pfc.181.2020.04.03.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 12:55:46 -0700 (PDT)
Date:   Fri, 3 Apr 2020 13:55:45 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200403195545.GA58262@syl.local>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <20200403183057.GA659224@coredump.intra.peff.net>
 <20200403184933.GA57202@syl.local>
 <20200403193842.GA7859@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403193842.GA7859@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 09:38:42PM +0200, SZEDER Gábor wrote:
> On Fri, Apr 03, 2020 at 12:49:33PM -0600, Taylor Blau wrote:
> > On Fri, Apr 03, 2020 at 02:30:57PM -0400, Jeff King wrote:
> > > On Mon, Aug 05, 2019 at 10:02:40AM +0200, SZEDER Gábor wrote:
> > >
> > > > While 'git commit-graph write --stdin-commits' expects commit object
> > > > ids as input, it accepts and silently skips over any invalid commit
> > > > object ids, and still exits with success:
> > > >
> > > >   # nonsense
> > > >   $ echo not-a-commit-oid | git commit-graph write --stdin-commits
> > > >   $ echo $?
> > > >   0
> > > >   # sometimes I forgot that refs are not good...
> > > >   $ echo HEAD | git commit-graph write --stdin-commits
> > > >   $ echo $?
> > > >   0
> > > >   # valid tree OID, but not a commit OID
> > > >   $ git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits
> > > >   $ echo $?
> > > >   0
> > > >   $ ls -l .git/objects/info/commit-graph
> > > >   ls: cannot access '.git/objects/info/commit-graph': No such file or directory
> > > >
> > > > Check that all input records are indeed valid commit object ids and
> > > > return with error otherwise, the same way '--stdin-packs' handles
> > > > invalid input; see e103f7276f (commit-graph: return with errors during
> > > > write, 2019-06-12).
> > >
> > > Can you explain more why the old behavior is a problem?
>
> Because when I do:
>
>    # sometimes I forgot that refs are not good...
>    $ echo HEAD | git commit-graph write --stdin-commits
>
> then I get _nothing_: neither an error, nor a commit-graph.
>
> > > For reasons (see
> > > below), we want to do something like:
> > >
> > >   git for-each-ref --format='%(objectname)' |
> > >   git commit-graph write --stdin-commits
> > >
> > > In v2.23 and earlier, that worked exactly like --reachable, but now it
> > > will blow up if there are any refs that point to a non-commit (e.g., a
> > > tag of a blob).
> > >
> > > It can be worked around by asking for %(objecttype) and %(*objecttype)
> > > and grepping the result, but that's awkward and much less efficient
> > > (especially if you have a lot of annotated tags, as we may have to open
> > > and parse each one).
> > >
> > > Now obviously you could just use --reachable for the code above. But
> > > here are two plausible cases where you might not want to do that:
> > >
> > >  - you're limiting the graph to only a subset of refs (e.g., you want to
> > >    graph refs/heads/ and refs/tags, but not refs/some-other-weird-area/).
> > >
> > >  - you're generating an incremental graph update. You know somehow that
> > >    a few refs were updated, and you want to feed those tips to generate
> > >    the incremental, but not the rest of the refs (not because it would
> > >    be wrong to do so, but in the name of keeping it O(size of change)
> > >    and not O(number of refs in the repo).
> > >
> > > The latter is the actual case that bit us. I suppose one could do
> > > something like:
> > >
> > >   git rev-list --no-walk <maybe-commits |
> > >   git commit-graph write --stdin-commits
> > >
> > > to use rev-list as a filter, but that feels kind of baroque.
> > >
> > > Normally I'm in favor of more error checking instead of less, but in
> > > this case it feels like it's putting scripted use at a disadvantage
> > > versus the internal code (e.g., the auto-write for git-fetch uses the
> > > "--reachable" semantics for its internal invocation).
> >
> > For what it's worth, (and in case it wasn't obvious) this came about
> > because we feed '--stdin-commits' at GitHub, and observed exactly this
> > error case. I wasn't sure what approach would be more palatable, so I
> > prepared both in my fork at https://github.com/ttaylorr/git:
> >
> >   - Branch 'tb/commit-graph-dont-check-oids' drops this checking
> >     entirely.
>
> Oh, no :)

Heh, I figured as much when Peff pointed me towards this thread ;-).

> >   - Branch 'tb/commit-graph-check-oids-option' adds a
> >     '--[no-]check-oids', in case that this is generally desirable
> >     behavior, by offering an opt-out of this OID checking.
> >
> > Please let me know if you find either of these to be good options, and
> > I'll happily send one of them to the list. Thanks.
>
> Or introduce 'git commit-graph write --stdin-refs'?  Or teach
> '--stdin-commits' to DWIM and accept and parse refs?  Though the
> question still remains what to do with refs that can't be peeled back
> to commits

How would '--stdin-refs' behave differently? I assume that it'd handle
going from 'refs/heads/blah' to an OID, but I think that's only kicking
the problem a little further down the road. Of course, you note the same
problem which is: what do we do when we can't resolve down to a commit
object.

I think that it seems the '--[no-]check-oids' may be the best of both
worlds, which allows for (mostly ;)) easy scripting around 'git
for-each-ref'.

> > > -Peff
> > >
> > > PS As an aside, I think the internal git-fetch write could benefit from
> > >    this same trick: feed the set of newly-stored ref tips to the
> > >    commit-graph machinery, rather than using for_each_ref().
> >
> > Thanks,
> > Taylor
Thanks,
Taylor
