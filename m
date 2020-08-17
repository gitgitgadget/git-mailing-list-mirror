Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517A6C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1828B206FA
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De0csxyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbgHQRGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388690AbgHQRGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:06:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA651C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:06:12 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so8109813pjx.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CGPpoDEcfgW039A2PW3XSUoJcotXPWmMN6p/gYHFOYs=;
        b=De0csxybo5XFCMgx+1ywPxRVEgADipuUMb/i0xcDcMB4IDTc6UZDXoGvf1i5umwGjL
         XxCu696fRGv9ytRbAtVJkqo0iqwan/jKas9iMhAV92eDDAOAQiS+VLvmz6X10RfMk38J
         mowJRc2KOh8Zty9HVsqC66YpLtJ6Q18TQKYlWUWDRRifG/HFHr2otcC5dOe3d7nYsJ8v
         RMnHfOU04s8uknLcEYRlw0Mmx6i28Tr/b69Z6GCs2hv+WeUCP0Qn+Ocpx9hNutCKlhDX
         qxWm/2VeAETY+9gC0qa1HFGmBDVf+TndqDNT1dQxKHVX+ORRb8cVSXtuyVZwrLWtYQWT
         mbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CGPpoDEcfgW039A2PW3XSUoJcotXPWmMN6p/gYHFOYs=;
        b=oeY2zivIBNVcu+hmzmhEi1bJssp6wzM/XDkVwyvhO7YAnMadeC2W4SudL1KnPSAIkd
         glQZ4WGEGt78fLq8KmBapamO7Xtgi468eAtrY/uCVp3hPbW7ECj1g8/Rf6/m45c5z743
         PNJrvc39etUGfNmiiR7G0Bsu1eqvbiKREOucM1sXn8MgCJsRuECgLh4spnESql+MOzH3
         sl5Bm6R/8+2tan1uXaTkAhcBcLTiEkuyyp+LNDp89KPpex0EQVtYLF3O1j9ZQOiDaTve
         5coG+ytjqO5yzCVIZX0HJqtg0jC1eCHmh3Uq2AI7p8pGQbBPOG/IxAAOqXhbTwknwp8w
         wGew==
X-Gm-Message-State: AOAM530onB3gqPss6438wEFs0l7Pm3gt0KyQMPzHSjueR4ToSK2dENBi
        3q0XES4EzJCGQieQmh0biTQ=
X-Google-Smtp-Source: ABdhPJznjFeTcMPzxHUziI3dLhBvWPB4gq3PPShtTu9IMqMmTdOjhjqQw9JR+AgI9sbIJJ2rVdOltQ==
X-Received: by 2002:a17:90a:154e:: with SMTP id y14mr13753290pja.178.1597683970510;
        Mon, 17 Aug 2020 10:06:10 -0700 (PDT)
Received: from localhost ([2402:800:6374:3f71:3e6:8db2:d7ba:5d94])
        by smtp.gmail.com with ESMTPSA id t63sm17941216pgt.50.2020.08.17.10.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:06:09 -0700 (PDT)
Date:   Tue, 18 Aug 2020 00:06:07 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Alexander Ost <ost@ieee.org>, Git List <git@vger.kernel.org>
Subject: Re: [BUG] `make install' partly ignores `NO_INSTALL_HARDLINKS'
Message-ID: <20200817170607.GA16630@danh.dev>
References: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
 <CAPig+cQnGUyM2cwNjDm_zys15B9n82QT6-RD7Lgyz1-XSGp8yw@mail.gmail.com>
 <xmqqimdm1ae6.fsf@gitster.c.googlers.com>
 <20200814150214.GC9518@danh.dev>
 <xmqqo8ndxhof.fsf@gitster.c.googlers.com>
 <20200815011544.GB12363@danh.dev>
 <xmqq8sed445k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8sed445k.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-17 09:40:23-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > On 2020-08-14 10:26:24-0700, Junio C Hamano <gitster@pobox.com> wrote:
> >> > Since both git-citool and git-gui will be installed into same
> >> > directory "$(libexecdir)", I think it would make more sense to use:
> >> >
> >> > 	LN = ln -s
> >> >
> >> > here instead?
> >> 
> >> In the top-level Makefile, INSTALL_SYMLINKS make macro does exist,
> >> but it is not exported to submakes.  If it were, something like
> >> 
> >>     ifdef INSTALL_SYMLINKS
> >> 	LN = ln -s
> >>     else
> >>     ifdef NO_INSTALL_HARDLINKS
> >> 	LN = cp
> >>     else
> >> 	LN = ln
> >>     endif
> >>     endif
> >> 
> >> might become possible, but you'd need to audit what is fed to $(LN)
> >> at the locations the macro is used and make necessary adjustment
> >> accordingly.  "cp A ../B" or "ln A ../B" will make a usable copy of
> >> file A appear inside ../B directory, but "ln -s A ../B" will not,
> >> and I didn't see if all uses of $(LN) was to give synonyms to what
> >> is already installed, or some of them were truly installing from the
> >> build location when I gave the "something along this line" example.
> >
> > Yes, the top-level Makefile seems to have a special branch for
> > BUILT_INS, in which, we will create symlink for those builtin in
> > libexecdr if NO_INSTALL_HARDLINKS is defined.
> 
> Did you mean pieces like this?
> 
> 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
> 		$(RM) "$$bindir/$$p" && \
> 		test -n "$(INSTALL_SYMLINKS)" && \
> 		ln -s "git$X" "$$bindir/$$p" || \
> 		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> 		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
> 		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
> 		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \
> 	done && \

Yes, I meant this piece.

> The symlinks happen ONLY when INSTALL_SYMLINKS is asked for.

Not what I understand from that code.
When `INSTALL_SYMLINKS` is not asked, the shell will jump to this block:

 		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
 		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
 		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
 		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \

When NO_INSTALL_HARDLINKS is asked, the shell will jump to last
2 clauses:

 		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
 		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \

shell try to "ln -s" first, when it failed to symlink, cp will be used.

In fact, this's what we used for packaging in distro, we often ask for:

	NO_INSTALL_HARDLINKS

> Not all filesystems support symbolic links,

This is correct, but most sane package manager will do the right thing.

> hardlinks never suffer from
> dangling link problem, and often they are cheaper.

Part of the reason we don't ask for INSTALL_SYMLINKS,
because with INSTALL_SYMLINKS, symlink will be make from
$(libexecdir)/git to $(bindir)/git.

But, NO_INSTALL_HARDLINKS will only symlink inside $(libexecdir), e.g:

	$ ls -al $(/usr/bin/git --exec-path )/git
	-rwxr-xr-x 1 root root 3193704 2020-08-12 21:37 /usr/libexec/git-core/git
	$ ls -al $(/usr/bin/git --exec-path )/git-ls-files
	lrwxrwxrwx 1 root root 3 2020-08-12 21:37 /usr/libexec/git-core/git-ls-files -> git

And those symlinks are packaged and managed by package manager,
so, no, no dangling problem.


-- 
Danh
