Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D97C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874F52080C
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcOvtdfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgDCTiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:38:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50907 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCTiu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:38:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id t128so8358199wma.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/9rRgjHPajPf4Ool5BXEUnW6ABKSQ8zMB1pnxGDIfCM=;
        b=CcOvtdfOCAqHX3a1ZKYOmTfXj2tYopQTAVuECJTe5swKFru0bgmOJBe9UIokHUReO4
         B/Dfr2KBsryfpdZH4XN7o8Os3x20OOWee0XYPNWNGKJA1E6hAfSW7uokgLXdVTO/nPwg
         HJVTZZ1yz+qQsaFhG92OKvheQ+fiTZdcQim7eOo4vMhH87ILSjKqJKFVMzgL6RQY1sN+
         hvMcqv5iV8j23P5/AI1qbciW0+Hlr1l1bMfw0DVMkGuQomPEnUMbn2EqaQqoUXv0f0Sm
         gsotm2zfVK7kx++MI6CkJzLOtXi8VAHlh6xY3iPi1Z6Kig22yt9f2vtLchN+UrbCbqlm
         m1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/9rRgjHPajPf4Ool5BXEUnW6ABKSQ8zMB1pnxGDIfCM=;
        b=L61X+MZcV0/C0gbc9HRz47wp44YxZd6oAjONuGvxWmQ6JWnG5nxbM45Hi/4yHNH74X
         +iwVykjpJ8lBV4xqFbFFTkt07A2htSvKRhD/4lvh826xT+T284bc/viv4OjL0FtJBMrV
         Zp0oBpppn97zbaOJcszuAuhqNgMe5RM7LoTFR1++6HwZtAFxARMgzJVlu0EqoDr5NJTT
         ipWoTWgNoonLC07+qgQV7emWnrQu21Mb44tB7uw5YWNaSEOjnrL+xfLH6sauUrUAr4MI
         VcBkQ8hCIcbo7+oIp0sGHuOd5oNeXJ3Z1jYhBA3uOJ4Ap3QsNRefz4P2QcXBJh324KzF
         UsLg==
X-Gm-Message-State: AGi0PuZqqaAyUtPizuSGFrDp9E4GQ3OPtO2n/My+qXfTS3gz95YSWcS/
        NlCddHMXewXueU5DYDqx+8s=
X-Google-Smtp-Source: APiQypJsAowhBb6LJceU6UAdB8GdtKlArUKWPtd4qjoqCNsfA5WTLVSFDHHqieTvTDFv520XYM+2ig==
X-Received: by 2002:a1c:9805:: with SMTP id a5mr10111730wme.119.1585942728256;
        Fri, 03 Apr 2020 12:38:48 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id v7sm13127439wrs.96.2020.04.03.12.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 12:38:47 -0700 (PDT)
Date:   Fri, 3 Apr 2020 21:38:42 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200403193842.GA7859@szeder.dev>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <20200403183057.GA659224@coredump.intra.peff.net>
 <20200403184933.GA57202@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403184933.GA57202@syl.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 12:49:33PM -0600, Taylor Blau wrote:
> On Fri, Apr 03, 2020 at 02:30:57PM -0400, Jeff King wrote:
> > On Mon, Aug 05, 2019 at 10:02:40AM +0200, SZEDER Gábor wrote:
> >
> > > While 'git commit-graph write --stdin-commits' expects commit object
> > > ids as input, it accepts and silently skips over any invalid commit
> > > object ids, and still exits with success:
> > >
> > >   # nonsense
> > >   $ echo not-a-commit-oid | git commit-graph write --stdin-commits
> > >   $ echo $?
> > >   0
> > >   # sometimes I forgot that refs are not good...
> > >   $ echo HEAD | git commit-graph write --stdin-commits
> > >   $ echo $?
> > >   0
> > >   # valid tree OID, but not a commit OID
> > >   $ git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits
> > >   $ echo $?
> > >   0
> > >   $ ls -l .git/objects/info/commit-graph
> > >   ls: cannot access '.git/objects/info/commit-graph': No such file or directory
> > >
> > > Check that all input records are indeed valid commit object ids and
> > > return with error otherwise, the same way '--stdin-packs' handles
> > > invalid input; see e103f7276f (commit-graph: return with errors during
> > > write, 2019-06-12).
> >
> > Can you explain more why the old behavior is a problem?

Because when I do:

   # sometimes I forgot that refs are not good...
   $ echo HEAD | git commit-graph write --stdin-commits

then I get _nothing_: neither an error, nor a commit-graph.

> > For reasons (see
> > below), we want to do something like:
> >
> >   git for-each-ref --format='%(objectname)' |
> >   git commit-graph write --stdin-commits
> >
> > In v2.23 and earlier, that worked exactly like --reachable, but now it
> > will blow up if there are any refs that point to a non-commit (e.g., a
> > tag of a blob).
> >
> > It can be worked around by asking for %(objecttype) and %(*objecttype)
> > and grepping the result, but that's awkward and much less efficient
> > (especially if you have a lot of annotated tags, as we may have to open
> > and parse each one).
> >
> > Now obviously you could just use --reachable for the code above. But
> > here are two plausible cases where you might not want to do that:
> >
> >  - you're limiting the graph to only a subset of refs (e.g., you want to
> >    graph refs/heads/ and refs/tags, but not refs/some-other-weird-area/).
> >
> >  - you're generating an incremental graph update. You know somehow that
> >    a few refs were updated, and you want to feed those tips to generate
> >    the incremental, but not the rest of the refs (not because it would
> >    be wrong to do so, but in the name of keeping it O(size of change)
> >    and not O(number of refs in the repo).
> >
> > The latter is the actual case that bit us. I suppose one could do
> > something like:
> >
> >   git rev-list --no-walk <maybe-commits |
> >   git commit-graph write --stdin-commits
> >
> > to use rev-list as a filter, but that feels kind of baroque.
> >
> > Normally I'm in favor of more error checking instead of less, but in
> > this case it feels like it's putting scripted use at a disadvantage
> > versus the internal code (e.g., the auto-write for git-fetch uses the
> > "--reachable" semantics for its internal invocation).
> 
> For what it's worth, (and in case it wasn't obvious) this came about
> because we feed '--stdin-commits' at GitHub, and observed exactly this
> error case. I wasn't sure what approach would be more palatable, so I
> prepared both in my fork at https://github.com/ttaylorr/git:
> 
>   - Branch 'tb/commit-graph-dont-check-oids' drops this checking
>     entirely.

Oh, no :)

>   - Branch 'tb/commit-graph-check-oids-option' adds a
>     '--[no-]check-oids', in case that this is generally desirable
>     behavior, by offering an opt-out of this OID checking.
> 
> Please let me know if you find either of these to be good options, and
> I'll happily send one of them to the list. Thanks.

Or introduce 'git commit-graph write --stdin-refs'?  Or teach
'--stdin-commits' to DWIM and accept and parse refs?  Though the
question still remains what to do with refs that can't be peeled back
to commits

> > -Peff
> >
> > PS As an aside, I think the internal git-fetch write could benefit from
> >    this same trick: feed the set of newly-stored ref tips to the
> >    commit-graph machinery, rather than using for_each_ref().
> 
> Thanks,
> Taylor
