Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52009C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367E3613DF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhFKPwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhFKPwX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 11:52:23 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59718C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 08:50:25 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so3559972otr.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Uq2yiXCHZqHs7XJ6qZSdssS1aykciuUhubbAT9h00XU=;
        b=rSRGaRll8On0mupoi+Y/tRxDQmpX+h2Jexrm9adsPBKCsBJhOy7Pb9T7Z3wE5GrBBH
         KfLtXRBZUKgPI+4OvoZsOqNuVHbtM0ZKztEbbPoKOfAIGWyLtk8nfqCMjJ97A1DPnIvx
         roYAZQrIOlY1+Docujg9ZGZmeaRRWShxSopLHerhcYwNQWzwECwlYvDAOni8DyCPdLpm
         lYcjWOfF2qF36w9lE4HUe3nwqJ9VFxD7bM94TPMocm+A9D1LG/moQ7oON63pdS/GiG7t
         EpbexUj4gxLAUZIxoWSLVmO/0OUu3PFCRPm3dtPJOpw+0eBNe9MWNA0re/INIQ8rCBnI
         aUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Uq2yiXCHZqHs7XJ6qZSdssS1aykciuUhubbAT9h00XU=;
        b=mJohMEmViHkNgVghbiSjeVUTcrRrVbuZhSkfKxjDbSlXboX/O1qvhcyiGcp2q0jMPw
         gJ38lM3uKQctU+PfqBok7gNp6rj4WUa9v1LKmOj0QqTUufcdI5bVZb9eS+go8JoPI2BL
         /pBPJldUVFe5m6qr6ViO1OKN2NvWitzcGgmUPwFO8Se9FkTNGCgoxGmOFhzq6KfbEgPu
         58fem1SbFp5rPkwRBbE/6fRQVL2tigBkj41B8Ctfre3BPHVI9z0z8AOiVYGNKlefxTuR
         0L5v0xEFkB8leMe/3dFDa596NB4FwqUxMyCB02MrQsNwmGbiNDzuAg/rqjh7q6aB7Vy5
         kOGw==
X-Gm-Message-State: AOAM531k04JaZMzXI0bpNQB8tZWiHnDBRrz8Z0sg3xOlXedPG2W1x1XE
        n8+9A4SXW7nBH1+os1nDuLw=
X-Google-Smtp-Source: ABdhPJwLjcaHheZatyOUH/6xiHxHyyTOf9WDZ17/hY6ozZ+Nkz4eWNxMJB8vD/C5oVTDf00xIZ3AfA==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr3567563otl.70.1623426624726;
        Fri, 11 Jun 2021 08:50:24 -0700 (PDT)
Received: from localhost ([187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o24sm1326269otp.13.2021.06.11.08.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 08:50:24 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:50:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60c3863ad8971_85c8208e@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2106111224060.57@tvgsbejvaqbjf.bet>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
 <87a6nx6wtv.wl-lukeshu@lukeshu.com>
 <nycvar.QRO.7.76.6.2106111224060.57@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH 0/2] Fix git subtree on Windows
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Thu, 10 Jun 2021, Luke Shumaker wrote:
> =

> > On Thu, 10 Jun 2021 03:13:29 -0600,
> > Johannes Schindelin via GitGitGadget wrote:
> > > This particular condition, however, was never tested on Windows,
> >
> > I was going to say that I do have CI set up[0] to run the subtree
> > tests on Windows, and was going to ask for assistance in figuring out=

> > how to set up CI's Windows to match the behavior that you're seeing
> > with Cygwin.
> >
> > However, upon closer inspection: Because of how run-test-slice.sh
> > works, it wasn't actually running the subtree test on Windows.  Oops.=

> =

> Right, I am sorry about that, it did bite me recently, too.
> =

> > Now, that CI setup was just on my personal copies and hadn't been
> > submitted upstream, since I wasn't sure if it was welcome[1].  I neve=
r
> > really got a reply to that part, but but now that we've got buy-in
> > from =C3=86var for running the tests in contrib/,[2] I might spend so=
me
> > more time on it and try to get that submitted.
> =

> I am not so sure about running tests in contrib/ as part of the CI.

But we already do run contrib tests:

  t1021-rerere-in-workdir.sh
  t3000-ls-files-others.sh
  t9902-completion.sh
  t9903-bash-prompt.sh

> Those bits and pieces are in contrib/ to indicate that they should
> _not_ be considered as adding to Junio's maintenance burden, and
> adding them to CI would contradict that.

People rely on contrib and distributions build packages enabling what is
in contrib.

Part of a successful release is contrib not being broken, so Junio can't
just ignore the status of contrib.

I agree this is not goood, but that's the current situation we are in,
and that's because we have allowed perfectly widely used and stable
software on the same cohort as unmaintained waste nobody cares about.

-- =

Felipe Contreras=
