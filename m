Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473C4C4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 08:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EBF610A2
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 08:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhHBIwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhHBIwa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 04:52:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBE6C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 01:52:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ec13so22915419edb.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=c0T1yF9BwHv6bWVB1iGzMwI+E2bz9Kc3Tn7AYMzYb/c=;
        b=uEtReQ++D8jZfxXXGKjWJH0sV/Pq4YjS0mjc9idL/cRMgtyM5fi7sO1xdIsU1i2rkI
         LXMcgHyNQ/1eOdxoKDL5mQkq3WPEzAG2Il3DseUkNQTY/Afff7dr/8IOWky5BLUJRyPf
         P9VOQZbbPsLA9oU90AhCIlcyslHC5ZHOBkk5oGI43wjgd7E7gymJ5e8MFtEfXZIDJz+J
         BDDJ1hQpdnwNm2PcWHgj7TT25KpPrQM1oSoKVfylXHBf3ZJcxOdtIur8/jbQYoabMsHR
         OndO3m2NqhGIwJSw7NfprdmJzeDI5v/7P/s6pgudAOCTXLUNLQZxBZyW8eV07XZF0g0p
         EOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=c0T1yF9BwHv6bWVB1iGzMwI+E2bz9Kc3Tn7AYMzYb/c=;
        b=drqp6Cm9KwwbLVLBycmS5z3XHYYMZ4MRAgaAV4VTKPypZPOPG/93sUBezDnB3ryl9l
         cWvZkRcKtZYAptZ9qx5qiN1z2LH6WNhFw/Rc6kIh83c9i6x/aBEJyNjNEZfOxANwMeim
         smP5/bJdYH3l3eH/hIuCIDQnvgt0qz2UOPbws2fJyFhqEenGDCU7iWUhkNY2nDqQFy53
         Uk1fVHblnXiOKwMnhZAGhTyU38ofvDTUuzBckqeMEOm0QOTcHbPuNvU+tho/D6Wp5Mpc
         1TmmoauqkciNHovaufVVvKmNzlQYjdPGjOljMxlLbb5Oxy1u9gF9siROUA9DCo9xZFOF
         ImEA==
X-Gm-Message-State: AOAM532Iu60Pi3KNUsW/jxAT8el6q5568AVFtI6raxm5+4s/oru4+EGW
        XXhSLVbkxU1d9Iw1OD4cUQk=
X-Google-Smtp-Source: ABdhPJxoK0MHMvEoVf29SRdpvvsuACNhMVdZRb7JpTdAV9oa/fmKJl+ZlkFWvmRijRktmcvxJ2az4A==
X-Received: by 2002:aa7:da02:: with SMTP id r2mr18071043eds.249.1627894338107;
        Mon, 02 Aug 2021 01:52:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o3sm5499088edt.61.2021.08.02.01.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:52:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     heapcrash heapcrash <heapcrash@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Enhancing --show-function and --function-context in default
 configurations
Date:   Mon, 02 Aug 2021 10:45:25 +0200
References: <CAM1Tk15N6uK3aU5bY6mWQVX5UdEOraysrRmO+v4TA+P-Wa9_hQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAM1Tk15N6uK3aU5bY6mWQVX5UdEOraysrRmO+v4TA+P-Wa9_hQ@mail.gmail.com>
Message-ID: <875ywoqldr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Aug 01 2021, heapcrash heapcrash wrote:

> Hello all!
>
> Thanks to all of the Git community for making such amazing tools.
>
> Some of my favorite features of Git are the --show-function and
> --function-context features of git {grep,log,diff}.
>
> However, the default configuration leaves a bit to be desired --
> setting some simple flags in ~/.gitattributes for e.g.
>
>     *.cpp diff=cpp
>     *.py diff=python
>
> Makes these features MUCH more accurate and usable.  However, one has
> to know about gitattributes, diff filters, xfuncname, etc. in order to
> turn these settings on.
>
> I'd like to contribute changes to Git that makes the "obvious"
> correlations be the default setting.  Before I start, I wanted to
> gauge whether these changes would be accepted or not.  As far as I can
> tell, these would not change the default behavior of plain git
> {grep,log,diff} unless the --show-function or --function-context flags
> are specified -- and if they are, the results would be improved.
>
> Should I work on a patch that does this?

As Junio hinted at in his reply this doesn't just change diff behavior
with the -W or --function-context flag, but changes the work we do (even
if the output is the same) on all unified diff output.

I.e. to generate the "@@" context line we by default use a C function in
xdiff/, this is replaced with a regex-in-a-loop invoking the
userdiff.[ch] code.

I would like to see us have a setting to turn these on by default, but
think it would be better to make that a diff.* config setting to put
into ~/.gitconfig, i.e. we'd extend git itself to know about a list of
extensions for the given userdiff drivers, and use them when rendering
diffs.

It makes emitting the diffs take more CPU, but the same is true of other
options like colorMoved etc, so that in itself is not a dealbreaker.
