Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C890C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335DF2087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oberbrunner-com.20150623.gappssmtp.com header.i=@oberbrunner-com.20150623.gappssmtp.com header.b="dAsQNgKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBDWdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:33:55 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:39409 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgBDWdy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 17:33:54 -0500
Received: by mail-io1-f51.google.com with SMTP id c16so22876653ioh.6
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 14:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oberbrunner-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=auNbGellmQVFWVDMjt5W6C6Vxut2EEUuCQ3EwVEFnYM=;
        b=dAsQNgKheejuv4krGARo8SGeOvmOcJd+uD637DPxIe6dpUVVM21iKKy4p0h7EG5lMd
         PdziH96SlijttRFtotrbwMG6LETywnvC8018Da02x7pfql6OnDYXOjMgzaC8IrKq1xuK
         A426iq8HFzolF475PXh2vBhsbNfSxQqj0n2iQb1FyPv47sJYdF5gyCneDcG68mvTjjhz
         rqysFXVjaMdYK8YXNyb/+N21caUiMtvCGq/Bj4aUksE7KCELzZZD8+eXttaXAVDLITQN
         xOSx5a9S8lTe8Gidjh7LYFw5mktO1J7IyHLWHg/znZs602EJeCQf7gwRo6DbybAWpLdA
         mNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auNbGellmQVFWVDMjt5W6C6Vxut2EEUuCQ3EwVEFnYM=;
        b=H1SyI+tHOTcd7u4xo506w8+1WGxSnmaOvUtHkVYRjdbebT4JJhNFDrPHDbvQArQCxU
         Gg0Oo58yFQ5GEf2bWHVmo6cSiEoeSkjEOzuiTQA77JSneUK3s+13e1hgxOigf8V75I3d
         WMr5qfu5W7roXM8Sm2oaM7NAWuPVdFUXEyRvWhoJWrBK4/AQLdG/poYyulvebF++shCd
         kuqlGDoMt5cN9VFMfRLG8pKNe9ZI+9YZIrkZeViF/HvuzBcURgu2zwkVINHsaC5XYaOH
         +UxlWvFfHSqQhsFs/fxiagIY5o5zuHjup4no7FFL3NXZkrFdakD3iXoVr0FPBNGfSNR1
         vqeQ==
X-Gm-Message-State: APjAAAWId+9mr+zRRNHXzoutR33CYU/qQf4AfEbfIPUTEt3nuBaccre1
        DLyytBSxH23Ben67oXEEDKmkrnw/8KBdR13RKJRcZQ==
X-Google-Smtp-Source: APXvYqyEWSG+qXYidKgnfgnasnFamcXZsMu9ANq1gjgjKZIT9dyGu0R4Wr2z+ys/6NBdmKgHRChLK/OIsy3Uksu+4k8=
X-Received: by 2002:a5d:9cc7:: with SMTP id w7mr23553077iow.159.1580855633439;
 Tue, 04 Feb 2020 14:33:53 -0800 (PST)
MIME-Version: 1.0
References: <CAFChFygiaMsUJC5Kfpnk26DLWbY0gPdNJpZ_gLMf4utZ6_oZxA@mail.gmail.com>
 <CAFChFyi5J-mb+rshtF7U2m=MtPzEPUa+V1_qbEXC=-LdQ218yA@mail.gmail.com> <d4313777-ce8c-0b64-997e-17cb719c9ab8@gmail.com>
In-Reply-To: <d4313777-ce8c-0b64-997e-17cb719c9ab8@gmail.com>
From:   Gary Oberbrunner <garyo@oberbrunner.com>
Date:   Tue, 4 Feb 2020 17:33:42 -0500
Message-ID: <CAFChFyhZYm88cCo6X_XikT=HRQG9Pp0vyveXmAuComFUJYjRcA@mail.gmail.com>
Subject: Re: Fwd: Possible git bug in commit-graph: "invalid commit position"
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the long reply delay; the bug went away and only just showed
up again. Here's the info you requested.
I'm now running git 2.25.0.

Showing the bug:
% git show --patch df2f
fatal: invalid commit position. commit-graph is likely corrupt
commit df2f311c78b87d16509f352c66d7309957740711 (origin/feature/renderer)
Author: [redacted]
Date: Mon Jan 20 12:37:01 2020 -0500

WIP: add outline of back-end render web service

Submodule packages/ngl f713ed5..7de8821:
%

Run "git commit-graph verify": doesn't detect any problem.
% git commit-graph verify
Verifying commits in commit graph: 100% (1/1), done.
Verifying commits in commit graph: 100% (2/2), done.
Verifying commits in commit graph: 100% (10/10), done.
Verifying commits in commit graph: 100% (14/14), done.
Verifying commits in commit graph: 100% (71/71), done.
Verifying commits in commit graph: 100% (478/478), done

You asked me to delete .git/objects/info/commit-graph -- I don't have
such a file, but  I do have a subdir "commit-graphs":
% ls .git/objects/info/commit-graphs/
commit-graph-chain graph-e96da2872d5c5fc1c4e399f99b7800d08fcdd273.graph
graph-4f5807bbdcba22f8fdc081c91205c40d40e99d38.graph
graph-e9f543a1389f8f5d6e91c09caa6658a1905d00fe.graph
graph-79f0f3bff07f7e7dda9d2438a30ef6483a2b531f.graph tmp_graph_GHI48b
graph-83ce268fda98e26938ce702bb261e1719ff816ba.graph tmp_graph_Ypgl2f
graph-93a966dc8be3040189367f047f5111e9f29c2d6c.graph

After removing that subdir and running "git commit-graph write", I
*do* have a .git/objects/info/commit-graph file.

The bug is still present though! However, I do have a git submodule
with its own .git/objects/info/commit-graphs; let's look into that.
In the git submodule dir, "git commit-graph verify" succeeds with no
errors (just like the parent).
Deleted the .git/objects/info/commit-graphs subdir, regenerated with
"git commit-graph write".
Retest original problem:
- Now the problem is fixed!

So long story short: the corrupted git commit-graph was in a
submodule. It does appear that "git commit-graph verify" failed to
detect the corruption. Removing and regenerating fixes it.

I do have the old git submodule's commit-graphs data in case it's
useful. Let me know and I can send it along.


On Mon, Jan 20, 2020 at 7:37 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/20/2020 12:32 PM, Gary Oberbrunner wrote:
> > I'm running git 2.24.1 on Linux/WSL, and sometimes git fails with this error:
> > ```
> > % git diff --cached
> > fatal: invalid commit position. commit-graph is likely corrupt
> > ```
> > Usually that error goes away after I do a few more git operations, but
> > I haven't been able to discern a pattern yet. It's not always with
> > "diff", can be any git command as far as I can tell.
> > Perhaps it started after I enabled the commit-graph stuff:
> > ```
> > [core]
> >         editor = emacsclient -c -a \"\"
> >         preloadindex = true
> >         fscache = true
> >         autocrlf = false
> >         commitGraph = true
> >         writeCommitGraph = true
> > ```
> > In fact, when I turn off `commitGraph`, the error goes away. But as I
> > say, sometimes it goes away of its own accord.
>
> Disabling the featuere will definitely remove the error. Some commands may
> also just not "visit" the corrupt commit.
>
> > Googling turns up almost nothing on this error. I have no idea if I've
> > done something wrong to corrupt the commit graph, or if it's a git
> > bug. If there's anything I can do to help debug it, I'd be happy to --
> > just let me know.
>
> Please run "git commit-graph verify" to see if that catches the
> corruption. If not, then the verify feature is broken.
>
> Then, you can delete your .git/objects/info/commit-graph file
> and rebuild it with "git commit-graph write". (If you have
> fetch.writeCommitGraph enabled, then you may need to instead
> delete the .git/objects/info/commit-graphs directory.) If that
> process does not fix the problem, then there is definitely a bug
> in the feature. At the moment, it may just be a flipped bit in
> the file.
>
> Thanks,
> -Stolee



-- 
Gary
