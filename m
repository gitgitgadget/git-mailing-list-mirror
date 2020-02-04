Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94386C3524A
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 05:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410972084E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 05:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="R5EBWgBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgBDFBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:01:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53818 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgBDFBN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 00:01:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so800294pjc.3
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 21:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hf0TtrDBhPSDQ6qyHgajrcOLuHvknBiJUEA0awiGoeo=;
        b=R5EBWgBSLSLbUTaQQ36HHAgVpoV8o3BR/7DlpfeJ+S16fXGcgeryVsL2fIKqAm4d3W
         h+qYASBrk+nm3ysBa8IvFNXBApurpnzNFNAiZR+BmfZoA34w24lX6NYjuNqqF3WK6Gwq
         e0xRCHytfA8O+f+JXUi7mLQcwLjY1/5Ta614Z60Hvp4alklTjN3v1sR5vvaotsKkoPeI
         XDGMnAt6LD2VvV9ZaIxVqsiAIhkkUFgiNdxdlnZOWtcVMrnTq4xsreQBvVc3XHLWrLng
         s6ueNL63CgPZirWfadD9AVOyrw6HGv2FJat6+eMOFy9eu91Tn1ynut0Q4CX3vL+/Jq5z
         ElJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hf0TtrDBhPSDQ6qyHgajrcOLuHvknBiJUEA0awiGoeo=;
        b=FIMQpYQWeM5iDLolpLQ7cg7CU1keVRu+6IyPhmr6Bgtl74tGl736a7ahQxyK/hoKlv
         FRmVMXxIgItBRbScr5oPR9Z3GLxdFz/Sbbk8BNox8YcqqRB7ryTcpOOHOQLUx6MoNUgU
         bNJTh1gbJK/eYSbmhG6AVzDwt08KB0s+Qfa3TbQS7adcrYDxZpu+ajjlLUgnUykY1lVc
         D+QakBXZWdEV8902/zLyApjpgA3CZMVVjPZd6EOjMrJ/3NlFRh5rQnxTot8iCXHeMqTp
         wfKbiZllIwlnOs9nUGCuFR5Ft96e7H5ieunRXY9/e5Xa1VlouOSHeG+19XWMkUCFU52L
         ebMA==
X-Gm-Message-State: APjAAAXkdPGkHtjpPB2AZRHUsPkFLxNzhf8JRvJmsqeDxb2FwzfiS73Y
        Ec5ucCmo6ZW8LPgKYCoVTQDDWA==
X-Google-Smtp-Source: APXvYqxeHXsGlUj7yBoa7gfj5lbvSsoMr210xrseymdjUYgShRFilVp74bXAqJY5ytYtO2KMR3bzag==
X-Received: by 2002:a17:90a:cf11:: with SMTP id h17mr3779829pju.103.1580792472321;
        Mon, 03 Feb 2020 21:01:12 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:7c5e:a7ec:bd9e:cd59])
        by smtp.gmail.com with ESMTPSA id r28sm21460874pgk.39.2020.02.03.21.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 21:01:11 -0800 (PST)
Date:   Mon, 3 Feb 2020 21:01:10 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/commit-graph.c: support '--input=none'
Message-ID: <20200204050110.GH5790@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <c329a8ddc087c9b74f673005f8b1e8769816ab9a.1580430057.git.me@ttaylorr.com>
 <CAN0heSpfqMChHO=iNuUExrBsMPcpZ6K2zH68GkHO2ttEiSinSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpfqMChHO=iNuUExrBsMPcpZ6K2zH68GkHO2ttEiSinSA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 08:45:59PM +0100, Martin Ågren wrote:
> On Fri, 31 Jan 2020 at 01:30, Taylor Blau <me@ttaylorr.com> wrote:
> > In the previous commit, we introduced '--[no-]merge', and alluded to the
> > fact that '--merge' would be useful for callers who wish to always
> > trigger a merge of an incremental chain.
>
> Hmmm. So it looks like you've already had similar thoughts as I did
> about patch 1/3. At some point, you had a separate `--merge=...` option,
> then later made that `--split=...`. :-) Could you say something about why
> you changed your mind?

Heh :-). Left overs from an earlier version of this series. I think that
I already talked about why this was changed further up in the thread.

> > There is a problem with the above approach, which is that there is no
> > way to specify to the commit-graph builtin that a caller only wants to
> > include commits already in the graph. One can specify '--input=append'
> > to include all commits in the existing graphs, but the absence of
> > '--input=stdin-{commits,packs}' causes the builtin to call
> > 'fill_oids_from_all_packs()'.
>
> (Use one of those options with an empty stdin? Anyway, let's read on.)
>
> > Passing '--input=reachable' (as in 'git commit-graph write
> > --split=merge-all --input=reachable --input=append') works around this
> > issue by making '--input=reachable' effectively a no-op, but this can be
> > prohibitively expensive in large repositories, making it an undesirable
> > choice for some users.
> >
> > Teach '--input=none' as an option to behave as if '--input=append' were
> > given, but to consider no other sources in addition.
>
> `--input=none` almost makes me wonder if it should produce an empty
> commit-graph. But there wouldn't be much point in that... I guess
> another way of defining this would be that it "uses no input, and
> implies `--append`".

I suppose, although (like you) I can't imagine why anybody would want to
do that.

> > This, in conjunction with the option introduced in the previous patch
> > offers the convenient way to force the commit-graph machinery to
> > condense a chain of incrementals without requiring any new commits:
> >
> >   $ git commit-graph write --split=merge-all --input=none
>
> Right.
>
> > --- a/Documentation/git-commit-graph.txt
> > +++ b/Documentation/git-commit-graph.txt
> > @@ -39,24 +39,29 @@ COMMANDS
> >  --------
> >  'write'::
> >
> > -Write a commit-graph file based on the commits found in packfiles.
> > +Write a commit-graph file based on the commits specified:
> > +* With the `--input=stdin-packs` option, generate the new commit graph
> > +by walking objects only in the specified pack-indexes. (Cannot be
> > +combined with `--input=stdin-commits` or `--input=reachable`.)
> >  +
> > -With the `--input=stdin-packs` option, generate the new commit graph by
> > -walking objects only in the specified pack-indexes. (Cannot be combined
> > -with `--input=stdin-commits` or `--input=reachable`.)
> > -+
> > -With the `--input=stdin-commits` option, generate the new commit graph
> > +* With the `--input=stdin-commits` option, generate the new commit graph
> >  by walking commits starting at the commits specified in stdin as a list
> >  of OIDs in hex, one OID per line. (Cannot be combined with
> >  `--input=stdin-packs` or `--input=reachable`.)
> >  +
> > -With the `--input=reachable` option, generate the new commit graph by
> > +* With the `--input=reachable` option, generate the new commit graph by
> >  walking commits starting at all refs. (Cannot be combined with
> >  `--input=stdin-commits` or `--input=stdin-packs`.)
> >  +
> > -With the `--input=append` option, include all commits that are present
> > +* With the `--input=append` option, include all commits that are present
> >  in the existing commit-graph file.
>
> Do these changes above really belong in this commit?

I think so. My thought here was to leave this documentation as-is until
this patch, when adding '--input=none' would... somehow change this, but
trying to construct a reply, I can't seem to come up with why I thought
that this was a good idea in the first place ;-).

> > +* With the `--input=none` option, behave as if `input=append` were
> > +given, but do not walk other packs to find additional commits.
> > +
> > +If none of the above options are given, then commits found in
> > +packfiles are specified.
>
> "specified"? Plus, that also happens for `--input=append` right? (It
> really seems like "append" is an odd one among all the inputs.)

I reworded this slightly to not use "specified", which I agree is indeed
weird.

>
> >         N_("git commit-graph write [--object-dir <objdir>] [--append] "
> > -          "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
> > +          "[--split[=<strategy>]] "
> > +          "[--input=<reachable|stdin-packs|stdin-commits|none>] "
> >            "[--[no-]progress] <split options>"),
>
> Hmm, you've left "--append" the old way.

Fixed, and thanks for noticing.
>
> Martin

Thanks,
Taylor
