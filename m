Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5613DC433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 22:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD2E2073E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 22:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6qbtFUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgFVWDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgFVWDo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 18:03:44 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A41C061573
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 15:03:43 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id o15so10528799vsp.12
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bshHMxPNhi0eaKBsfaiPUwGdKfGZrrSXe7hU/0d+8PA=;
        b=T6qbtFUFI6GAy1NBGyBypROga8+wV4d8plqRpuWIXwmgDT+SRy4V9Hi/azpfZrAlz/
         gxMAHhQMJtMOr3I94lUBPI5tgUeX59r1JmKleMFgrlTMZHUjSIGu+ILMdEqWTwVLsd8O
         cISC4VysmYswuAXKk3Sycp/JI1u2LM0iuDBNkCDU0nPB7U1JMZ9SBTlTJ7wt9g0u7jZz
         C1BBCgeGU9IEAUH1p0ePnql2ckzkLkPGhb0DB+3xTlWhuWPzBSbLEpAvL1PFNTV41+iV
         37jl2YZuJEkqvTA74fiPRI/rlnXcjXa1a4OEVoJTkn2fu3vXvhwxWWMAgbeQOVYnh8vs
         0i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bshHMxPNhi0eaKBsfaiPUwGdKfGZrrSXe7hU/0d+8PA=;
        b=rA1fEGNcWi4zi3tvf9OIJ2yIl+4r1+exx436uC0+40MrDXp4DFahdWtUQvJlS4/F68
         NuGQf9mYFk/lDRoRMOeswPEnYtXn6k4AipcrnqkpXujB7q1vmOe1SCUVJHQFUTYm11PS
         /FCKnWcxFq7SvA+wjfxrzWPxHJsbqqEeg58he8ZJp0pHgGzjk/qSFhFrPDbijQ31Kc45
         l2E/XOt5YlKumNRXE83ots9mClcu8NynpVeMt4uX/uO95SKDLK8bEPw9SkdDnFIYVYYV
         Atmpp0ZD8xwEm24buxR29UmwyBdkHfROHw664o4bZdDEgIDfY00COf+6Vz+fui497o0D
         kMiA==
X-Gm-Message-State: AOAM532wFXf4kaJqpIMgHvT1GoG3Jyvlr8XBZ5hgqTZxFWrAe1y25Zmj
        fa8tYE+IAAIgmcBtvB3bkJbhYPFdMl7CSTOoeYQ5JQ7fB0I=
X-Google-Smtp-Source: ABdhPJzW+yO61u6nvyaZVwZWCIcInoKtA+dsLlqM3A4evn6BWhV+w/oYDT+k3/o/1D86alPlyyiG2aYt0RFJK8Pdbws=
X-Received: by 2002:a67:3211:: with SMTP id y17mr18782196vsy.56.1592863421765;
 Mon, 22 Jun 2020 15:03:41 -0700 (PDT)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 23 Jun 2020 00:03:30 +0200
Message-ID: <CAFQ2z_NZbg4YoTo1vPaikfwYLMRZrx59bDMaeuczuJW2OG86DQ@mail.gmail.com>
Subject: Reftable progress
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I wanted to give a few updates on reftable. I'm posting a new version
of the patch series separately.  It has a number of interesting
improvements

* The source in the git tree now uses the strbuf library, which was
the largest stumbling block for integration.

*  The code is still completely self-contained (the
REFTABLE_STANDALONE #define includes 100 lines worth of strbuf
compatible code; enough to run the unittests.)

*  The number of test failures has dipped below 1000.

I would like to post the next version on top of Phillip's patches that
make ref_xxx functions take a struct repository* argument. Is there a
branch that I can target for rebasing?

The bottom 2 commits should be OK to merge as is into next.
("checkout: add '\n' to reflog message", "lib-t6000.sh: write tag
using git-update-ref")

The major open question is how to handle per-worktree refs.  My idea
is that, on creation, the reftable backend can figure out if it is
running in a worktree or in the main repository. If it is running in
worktree X, we could read/write pseudorefs as ~X/PSEUDO_REF.

Could we discuss next steps for merging at least the library? I think
that would solve one of the major complaints, which is that history is
kept in a separate repository.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
