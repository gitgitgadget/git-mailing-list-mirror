Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3003AC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130F2613C5
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhE0A5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbhE0A5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:57:06 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0592AC061763
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:55:32 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so2876877oto.0
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=arRXoGRnUNtJgduZhhv9TkbydaWFQNgEDi58LXFlypQ=;
        b=WkQrQ1Mi1ogFDgIao7ZHBg5YYRieoPsnmSnl1r9jmmusDCwv9K9NQNu2/RDeh/MBrC
         HWkywUwXBNMoq++bm/G56mF03AGTWQEgiQKjEmswPM4VqBoUHJNnGsER9vt8wDDYazoD
         Fk2PuMtTHzDWrs0E89UQ8gN4EhjGPMAe3B/fBY0O47VXRW1fJZCYyOHVbzkd++E3vOrw
         Gwxfe4+Qt2+emaUbN/vgxxebE4QUJ3QVSVHWLzbrXe+Sl+gsUei0uhJ2/XSTMDrVxGZg
         +QnNE2FfGceqKcEmV5opgyS/H2/W52nGLVv0emll3rllP2clytgQDt0t+viuHtDWV4Xg
         vTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=arRXoGRnUNtJgduZhhv9TkbydaWFQNgEDi58LXFlypQ=;
        b=dOieYjo+W2wPc9qpuT7fs+kWwCI7NqtfTiz363QmoYoKealgcNF+OdZpqnnzKRo8br
         0Q7vySPJHzOyxmZyE3zzvS1ktyko74C6p+2FyhhX9YaChQ3QnfDJ0paHn9PFxuXLYcyZ
         ogwVcfFCuYNUuq3NqrhaWjY0yjgZkmYEMFtujkupmX2mX3pBMrtGCmQtPv1vm1cFNZvT
         fD71WlbbehfE2n5+of2/wIT2yyym/HxH0clp+EA7RJq9D7Ld/7qP4rwQzTEsEaDDLmd4
         DSph2JrvSMlL9g8f1xqkLUTXH2lneq7RCDVFiAcvVeZsjfsxLlzmqqfccrgdDX/cZyiO
         wl9w==
X-Gm-Message-State: AOAM533YaO8BAe5ygXFcxI85CssXOlBGOgSUm52uqfdRhSy7Zjeg/LQe
        dD8NqnJ2ybu7BbZfGA+Pb892JDaRt7lxYg==
X-Google-Smtp-Source: ABdhPJx73QP7YfDHs9zF+DqLTupy2Xf905zb5HhKPJZ8NoDufk2WUQzQhgCcB14eR2KedY2zb1zhbw==
X-Received: by 2002:a9d:4584:: with SMTP id x4mr706499ote.85.1622076931969;
        Wed, 26 May 2021 17:55:31 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b8sm176282ots.6.2021.05.26.17.55.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 17:55:31 -0700 (PDT)
Date:   Wed, 26 May 2021 19:55:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <60aeee01f1e05_793420842@natae.notmuch>
Subject: [ANNOUNCE] git-related v1.0
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git-related is a tool to find out people that might be interested in
your patch series.

It works by running `git blame` on every chunk your patches modify, and
then presents a summary showing the roles of each person:

  % git related --roles master..fc/asciidoctor/clean
  Junio C Hamano <gitster@pobox.com> (signer: 93%, author: 7%)
  brian m. carlson <sandals@crustytoothpaste.net> (author: 20%, helper: 3=
%)
  Christian Couder <chriscool@tuxfamily.org> (author: 7%, mentor: 7%)
  Jeff King <peff@peff.net> (author: 10%)
  Johannes Schindelin <Johannes.Schindelin@gmx.de> (author: 7%, signer: 3=
%)
  Martin =C3=85gren <martin.agren@gmail.com> (author: 10%)

A lot of things have changed since v0.3, but the most important is the
addition of a completely new tool that does something similar: git-who.

Unlike git-related, git-who does not work on any particular patch
series, you can use any arguments `git log` accepts, and then presents a
similar output to git-related.

Therefore you can specify queries:

  % git who --roles -S'PERL_DEFINES' -- Makefile
  Junio C Hamano <gitster@pobox.com> (signer: 100%)
  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> (author: 75%,=
 helper: 25%)
  Johannes Schindelin <johannes.schindelin@gmx.de> (helper: 25%)
  Dan Jacques <dnj@google.com> (author: 25%)

We can find out a summary for the whole history of git.git:

  % git who --roles --since=3D2000 --threshold=3D1
  Junio C Hamano <gitster@pobox.com> (signer: 64%, author: 15%, helper: 1=
%)
  Junio C Hamano <junkio@cox.net> (signer: 14%)
  Jeff King <peff@peff.net> (author: 8%, signer: 1%, reviewer: 1%)
  Johannes Schindelin <johannes.schindelin@gmx.de> (author: 4%)
  Shawn Pearce <spearce@spearce.org> (author: 3%, signer: 1%)
  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> (author: =
4%)
  Jonathan Nieder <jrnieder@gmail.com> (author: 2%, reviewer: 1%, signer:=
 1%)
  Linus Torvalds <torvalds@linux-foundation.org> (author: 2%)
  Michael Haggerty <mhagger@alum.mit.edu> (author: 2%)
  Ren=C3=A9 Scharfe <l.s.r@web.de> (author: 2%)
  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> (author: 2%)
  brian m. carlson <sandals@crustytoothpaste.net> (author: 2%)
  Stefan Beller <sbeller@google.com> (signer: 1%)
  Eric Wong <normalperson@yhbt.net> (signer: 1%, acker: 1%)
  Elijah Newren <newren@gmail.com> (author: 2%)
  Christian Couder <chriscool@tuxfamily.org> (author: 1%)
  Linus Torvalds <torvalds@osdl.org> (signer: 1%)
  Derrick Stolee <dstolee@microsoft.com> (author: 1%)
  Jakub Nar=C4=99bski <jnareb@gmail.com> (author: 1%)
  Johannes Sixt <j6t@kdbg.org> (author: 1%)
  Eric Sunshine <sunshine@sunshineco.com> (author: 1%)
  Stefan Beller <stefanbeller@gmail.com> (author: 1%)
  Eric Wong <e@80x24.org> (author: 1%)
  SZEDER G=C3=A1bor <szeder.dev@gmail.com> (author: 1%)
  Paul Mackerras <paulus@samba.org> (author: 1%, signer: 1%)
  Felipe Contreras <felipe.contreras@gmail.com> (author: 1%)
  Matthieu Moy <Matthieu.Moy@imag.fr> (signer: 1%)

git-related is similar to contrib/contacts/git-contacts, except with
many many more features, and less bugs. In fact, git-contacts is a
rewrite of git-related and it never achieved parity.

The v1.0 release consists of 81 commits, and here are some of the
important changes:

 * Make roles optional with --roles
 * Add new --files mode (much faster)
 * Fixed bug with boundary commits (present in git-contacts too)
 * Fixed bug with certain mailmaps
 * Parse many more roles (top 10%)
 * Completely revamped documentation
 * Add color
 * Improved performance
 * Improved tests
 * Code considerably simplified
 * Split option parsing into a new gem

To install them just:

  gem install parseopt
  make install

It's written in Ruby, so you need Ruby.

Cheers.

https://github.com/felipec/git-related

-- =

Felipe Contreras=
