Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B827BC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 17:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7584420738
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 17:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd3ZTWAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgIHReK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgIHQPT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:15:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A5C061795
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 04:48:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so20934599ejb.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 04:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ozag8svG/ocSDzUrXw+pFrjye1Q9dL4czJ+tH1lJbqM=;
        b=Yd3ZTWAvfZZBJ/4oohfN9zz4Np+4Of1bG7qw/5S11AbG51+39reqqaSEuTOX38gfpz
         jzG9k+dDb30aigIJcUgA+yj1sdx37AqIVtxpOC9FoZe4KF1FLAIWEVtKOVU4rJ43NBzN
         GIQLy4oFMyP1t4kL58ij/YavlQM6pXyLAaPFp0DLf3suzGCaLpvGI1zhWmWxOx8TIfxJ
         1MtUnX/EC/UKxPWR6l+RqswoKQtwdLlikGki98OJEFOqHI6rd12AhqmQOuKdTqX/BJqE
         S5GQLtSJatLj/D9qOA7nEyvc4dUUR79YViaaQy5XCUT1na6g1+gK0DxGwVyM2WZIHL4n
         nh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ozag8svG/ocSDzUrXw+pFrjye1Q9dL4czJ+tH1lJbqM=;
        b=RaFHMByGekL+Lt9MMr2lvGbpBUhxoNIno9pL4zHUQhWfezPdKTF4g34/MSSUsvrISv
         Y2WmiW3UHTU2OlAvTD/5fBJIlxZhJm6iIqc8t99d24Wuae2Rjk/rMUIPFG0QbUA0r6pL
         PO+YymulEuxd6d/+SJwpcyc3SiZkjell/aQJVqej7zeEGeFaY4d+DBovB0IvBbgpQ9+h
         YR4fDiMFpo6w/sknL0gcK1T+muGCY042m+vshZ55HIwpMqHa0a/4zbBgoo4eAlyHnemq
         4gXJJKpzBuNqciX6ogy80cQk1NS2Ny7Xi8uTEGar/uvNxNciL7IgBsZh+txRm+0qnUib
         ww/w==
X-Gm-Message-State: AOAM530Ge4Yehkz3aJTMuLkHYR38jmDzjWqKgE23MXWIrvkdfwkIdzZI
        ayaIq6PQPJGD2W+mOuvVZiA=
X-Google-Smtp-Source: ABdhPJxi+tQfx1uusFRA/Lsza5UfmmKGpbPWJToJCRwL+FVE+KT/5lPgoh0Qm9+dyQI4AWT9qcH1+Q==
X-Received: by 2002:a17:906:a1d8:: with SMTP id bx24mr24598374ejb.161.1599565695242;
        Tue, 08 Sep 2020 04:48:15 -0700 (PDT)
Received: from szeder.dev (84-236-109-131.pool.digikabel.hu. [84.236.109.131])
        by smtp.gmail.com with ESMTPSA id u26sm17456687ejj.11.2020.09.08.04.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 04:48:14 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:48:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ci: stop linking built-ins to the dashed versions
Message-ID: <20200908114812.GD6209@szeder.dev>
References: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
 <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
 <99a53284925315995e30d417cb58dfb176b036ed.1598443012.git.gitgitgadget@gmail.com>
 <20200903104537.GA27325@szeder.dev>
 <nycvar.QRO.7.76.6.2009081332020.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2009081332020.54@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 01:32:56PM +0200, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Thu, 3 Sep 2020, SZEDER Gábor wrote:
> 
> > On Wed, Aug 26, 2020 at 11:56:52AM +0000, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > Originally, all of Git's subcommands were implemented in their own
> > > executable/script, using the naming scheme `git-<command-name>`. When
> > > more and more functionality was turned into built-in commands (i.e. the
> > > `git` executable could run them without spawning a separate process),
> > > for backwards-compatibility, we hard-link the `git` executable to
> > > `git-<built-in>` for every built-in.
> > >
> > > This backwards-compatibility was needed to support scripts that called
> > > the dashed form, even if we deprecated that a _long_ time ago.
> > >
> > > For that reason, we just introduced a Makefile knob to skip linking
> > > them. To make sure that this keeps working, teach the CI
> > > (and PR) builds to skip generating those hard-links.
> > >
> > > This is actually not such a big change: e4597aae6590 (run test suite
> > > without dashed git-commands in PATH, 2009-12-02) made sure that our test
> > > suite does not require dashed commands. With this Makefile knob, the
> > > commitment is just a little stronger (running tests with `--with-dashes`
> > > would _still_ not see the dashed form of the built-ins).
> > >
> > > There is a subtle change in behavior with this patch, though: as we no
> > > longer even _build_ the dashed executables, running the test suite would
> > > fail if any of Git's scripted commands (e.g. `git-request-pull`) still
> > > This would have succeeded previously (and would have been unintentional,
> > > of course) because `bin-wrappers/git` sets `GIT_EXEC_PATH` to the
> > > top-level directory (which would still have contained, say,
> > > `git-rev-parse`).
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  ci/run-build-and-tests.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > > index 6c27b886b8..1df9402c3b 100755
> > > --- a/ci/run-build-and-tests.sh
> > > +++ b/ci/run-build-and-tests.sh
> > > @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
> > >  *) ln -s "$cache_dir/.prove" t/.prove;;
> > >  esac
> > >
> > > -make
> > > +make SKIP_DASHED_BUILT_INS=YesPlease
> >
> > Please make sure that this Makefile knob is set in all jobs building
> > and testing Git, or justify in the commit message why it isn't.
> 
> The intention was to set it in all jobs (but the jury, AKA Junio, is still
> out on that). Did I not do that?

No; as mentioned earlier, the CI jobs using Docker containers don't
use 'ci/run-build-and-tests.sh', but 'ci/run-docker-build.sh' instead.

