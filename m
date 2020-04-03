Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6247C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC3F2076E
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xOJPCRqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgDCSti (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:49:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45747 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgDCSti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 14:49:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id o26so3919430pgc.12
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YnF7PKIokfr9rFeUyb7ge7QRTQhtYgITzXLW9LGegrM=;
        b=xOJPCRqfuo8ZoHo0beXprHSUob3VXurB/+VebuaueGuhS1vG9CSbOLHjzxMUrrzkRg
         1b5p618VLY/+LbOes5jktRyOZwYdYQraZIiqJinO4xNM5OvYU6knfnMyXJBYUseuQ4N6
         l6yYtEDuU5HUWDPOZ4I2f0KewzMa0LcsUKHI91/XPHORwxIH+Eqit656lUzszfw5zaeL
         PnjkoC//KHNCElbLEyVEgeEbaskcizqyoCfZUUbdhcyJ2VuWnLeFRc0W7LjKEoNjr2he
         GAA/m86jFoLqLBmWNSeVcvMlYbE+SWUz/pkYue/55I1AcOuEtb2nb0+Jkm4CJxxycwM0
         6ZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YnF7PKIokfr9rFeUyb7ge7QRTQhtYgITzXLW9LGegrM=;
        b=Kad8/lHpE6IArnQ43u+pw4OkaodQ1oYRNEPOoXTpw/yW/wNmypbZQ10wVXwZhZtij6
         Ai6ony9s0CDQUskzpr4V1TdN+z1FGNaYQ4Otr5KTI1gZa81yias2x50i6hjbrOEIsxGO
         5aAmMfRkUYdJu0zbuJ8yY2Aqd/5DoQ8bawnmQWWnhdyrRQdN3a8Z6KG2kQKI04zgdwlk
         Bg5AYeNsvJw1dAp2+k/adzNswWJ7+bnz44lXR5+pJ5LJQ8Dr8RuUSKj8cSGKzlMexVqA
         SmAqoOy3OrKnfZYGMW7hhH+/wEIjL7jH3TEMrrL9NyDHUoyoQaqygLy/XV02XVsUbW95
         1JBg==
X-Gm-Message-State: AGi0Pubbt2gGDiFEcoAp6zUHABRmC8nAiJmhYPgndMIevlScgw2bJLX6
        WMN09zlmWUIDKRxYJHEXvG+NiQ==
X-Google-Smtp-Source: APiQypLLTSHNRL5V4L+UGBKvnFe4dVcyHQGTu0JHsHp1UVbG09WASm1WccvBPd29WHOi0cQtql8cVQ==
X-Received: by 2002:a62:cf84:: with SMTP id b126mr9721964pfg.316.1585939775046;
        Fri, 03 Apr 2020 11:49:35 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g9sm5662803pgc.46.2020.04.03.11.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:49:34 -0700 (PDT)
Date:   Fri, 3 Apr 2020 12:49:33 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200403184933.GA57202@syl.local>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <20200403183057.GA659224@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403183057.GA659224@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 02:30:57PM -0400, Jeff King wrote:
> On Mon, Aug 05, 2019 at 10:02:40AM +0200, SZEDER Gábor wrote:
>
> > While 'git commit-graph write --stdin-commits' expects commit object
> > ids as input, it accepts and silently skips over any invalid commit
> > object ids, and still exits with success:
> >
> >   # nonsense
> >   $ echo not-a-commit-oid | git commit-graph write --stdin-commits
> >   $ echo $?
> >   0
> >   # sometimes I forgot that refs are not good...
> >   $ echo HEAD | git commit-graph write --stdin-commits
> >   $ echo $?
> >   0
> >   # valid tree OID, but not a commit OID
> >   $ git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits
> >   $ echo $?
> >   0
> >   $ ls -l .git/objects/info/commit-graph
> >   ls: cannot access '.git/objects/info/commit-graph': No such file or directory
> >
> > Check that all input records are indeed valid commit object ids and
> > return with error otherwise, the same way '--stdin-packs' handles
> > invalid input; see e103f7276f (commit-graph: return with errors during
> > write, 2019-06-12).
>
> Can you explain more why the old behavior is a problem? For reasons (see
> below), we want to do something like:
>
>   git for-each-ref --format='%(objectname)' |
>   git commit-graph write --stdin-commits
>
> In v2.23 and earlier, that worked exactly like --reachable, but now it
> will blow up if there are any refs that point to a non-commit (e.g., a
> tag of a blob).
>
> It can be worked around by asking for %(objecttype) and %(*objecttype)
> and grepping the result, but that's awkward and much less efficient
> (especially if you have a lot of annotated tags, as we may have to open
> and parse each one).
>
> Now obviously you could just use --reachable for the code above. But
> here are two plausible cases where you might not want to do that:
>
>  - you're limiting the graph to only a subset of refs (e.g., you want to
>    graph refs/heads/ and refs/tags, but not refs/some-other-weird-area/).
>
>  - you're generating an incremental graph update. You know somehow that
>    a few refs were updated, and you want to feed those tips to generate
>    the incremental, but not the rest of the refs (not because it would
>    be wrong to do so, but in the name of keeping it O(size of change)
>    and not O(number of refs in the repo).
>
> The latter is the actual case that bit us. I suppose one could do
> something like:
>
>   git rev-list --no-walk <maybe-commits |
>   git commit-graph write --stdin-commits
>
> to use rev-list as a filter, but that feels kind of baroque.
>
> Normally I'm in favor of more error checking instead of less, but in
> this case it feels like it's putting scripted use at a disadvantage
> versus the internal code (e.g., the auto-write for git-fetch uses the
> "--reachable" semantics for its internal invocation).

For what it's worth, (and in case it wasn't obvious) this came about
because we feed '--stdin-commits' at GitHub, and observed exactly this
error case. I wasn't sure what approach would be more palatable, so I
prepared both in my fork at https://github.com/ttaylorr/git:

  - Branch 'tb/commit-graph-dont-check-oids' drops this checking
    entirely.

  - Branch 'tb/commit-graph-check-oids-option' adds a
    '--[no-]check-oids', in case that this is generally desirable
    behavior, by offering an opt-out of this OID checking.

Please let me know if you find either of these to be good options, and
I'll happily send one of them to the list. Thanks.

> -Peff
>
> PS As an aside, I think the internal git-fetch write could benefit from
>    this same trick: feed the set of newly-stored ref tips to the
>    commit-graph machinery, rather than using for_each_ref().

Thanks,
Taylor
