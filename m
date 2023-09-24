Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D6CE7A8A
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 10:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjIXKZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 06:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIXKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 06:25:28 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9C1E7
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:25:21 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57bb6b1f764so604885eaf.2
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695551121; x=1696155921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWehYribpM0tzRNTwfTq3DCX9BI6DtsImnBSf1iBakk=;
        b=VA78zNA8Dst4fnICFhUtamrhDTZbRv1jTHV1LcO4efEcr/8sne80ML+Jds8SOYD/HF
         x3L6zTwsaf1fDUVLht4UtiELxbivzU2fGI+hLrsJo8QTkpYOTcFn89fsqrHF91S75YyV
         /NXX4BWsxtyVbJS6Lzqn1QnISVsId/zB96O6xk1gDAALa3//o9oCxFq8jL98yH+H3fTp
         lPl+33SyoRstbbQBIe8e75cwfxRmS2Xp/pHTKTYly+M1l1vtYStsTSY/nAkUNqyWHqTn
         hecrEYP5l7bAnq33aNU3p2gdB5WJae5Elf0z/lHBSQItptqtB403Higm5yY8tGVJSINP
         mh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695551121; x=1696155921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWehYribpM0tzRNTwfTq3DCX9BI6DtsImnBSf1iBakk=;
        b=hzYzE/o1mAS5ij9UKazeDEbyDbVhPvgLPFdyjNlsnxUoot9itzS+QSdTTmNysac6QX
         lmNcbwjVKg9iKPDe+1Wm5/YOVvrvZA/HhU+E/2ib6OR8A55eEPpr/1y2VJeRzly4XaGL
         /sSbKkMziw4FzkbxNgXNen8vqGxlT+/4FtBUhDuL+JgljrR+TWpOWW+SF/CA1EUA31gY
         JAAD0y+XCvgaqdM5+hWlx/0/c2S5ewc9WG8dAhT8Ap1oEdgiqitVmLopxDf8mbkBJGMV
         EozMjPdX3eQcuZ31mEb+AAYuu0j8xiIyW1biwYm1fo015OXqCBFalwZhzML4vYqgOkiD
         P4wA==
X-Gm-Message-State: AOJu0Yxwh/YbNGV97lVZwezuoWNTu9ihCV8BaldpTg6XeAWO6mmIOx/Z
        Un3B43E0NIGpuXPMlrt4jKk+OW0izmNGWuKB0gY=
X-Google-Smtp-Source: AGHT+IHNqK/fLDL7o+eVXeSIhV07DaLUSloi5Dtw0q094V7RIOchkpWy/kahfckNgJ7JsKCK9GMYo+aZYQaOqrYYMGk=
X-Received: by 2002:a05:6358:291f:b0:142:d678:f708 with SMTP id
 y31-20020a056358291f00b00142d678f708mr6364063rwb.19.1695551121079; Sun, 24
 Sep 2023 03:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
 <ZP2DaQMA_aFvjQiR@debian.me> <CAN47KsUe=qicr4wZWd33EV+cciUr8ztP2veoOkcw0JBtvsBGjw@mail.gmail.com>
 <ZP4PO+HkbsbuKact@nand.local> <CAN47KsX5cpo5oD7PAwAQzjR4oocST6uSkJe2SzAYPxxqy7dGtg@mail.gmail.com>
 <20230912T004049Z.jiWw7xuK7fiT@pug.qqx.org> <20230912043345.GA1623696@coredump.intra.peff.net>
In-Reply-To: <20230912043345.GA1623696@coredump.intra.peff.net>
From:   Max Amelchenko <maxamel2002@gmail.com>
Date:   Sun, 24 Sep 2023 13:25:08 +0300
Message-ID: <CAN47KsUDS0om6r6WwRZHLHdETHE+Lu=bj1skG1cAwvzEUaF81Q@mail.gmail.com>
Subject: Re: [bug] git clone command leaves orphaned ssh process
To:     Jeff King <peff@peff.net>
Cc:     Aaron Schrab <aaron@schrab.com>, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks,
Just wanted to clarify something. This will not be handled by AWS (we
had a support ticket re. that case), since they do not interfere with
the running processes on its infrastructure, and if there is a
problematic process causing this overflowing in orphaned processes, it
needs to be handled by that process.
The question is, doesn't Git want to ensure a clean exit in all cases?
This is a clear example of a non-clean exit.

On Tue, Sep 12, 2023 at 7:33=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Sep 11, 2023 at 08:40:49PM -0400, Aaron Schrab wrote:
>
> > At 13:11 +0300 11 Sep 2023, Max Amelchenko <maxamel2002@gmail.com> wrot=
e:
> > > Maybe it's connected also to the underlying infrastructure? We are
> > > getting this in AWS lambda jobs and we're hitting a system limit of
> > > max processes because of it.
> >
> > Running as a lambda, or in a container, could definitely be why you're
> > seeing a difference. Normally when a process is orphaned it gets adopte=
d by
> > `init` (PID 1), and that will take care of cleaning up after orphaned z=
ombie
> > processes.
> >
> > But most of the time containers just run the configured process directl=
y,
> > without an init process. That leaves nothing to clean orphan processes.
>
> Yeah, that seems like the culprit. If the clone finishes successfully,
> we do end up in finish_connect(), where we wait() for the process. But
> if we exit early (in this case, ssh bails and we get EOF on the pipe
> reading from it), then we may call die() and exit immediately.
>
> We _could_ take special care to add every spawned process to a global
> list, set up handlers via atexit() and signal(), and then reap the
> processes. But traditionally it's not a big deal to exit with un-reaped
> children, and this is the responsibility of init. I'm not sure it makes
> sense for Git to basically reimplement that catch-all (and of course we
> cannot even do it reliably if we are killed by certain signals).
>
> > Although for that to really be a problem, would require hitting that ma=
x
> > process limit inside a single container invocation. Of course since
> > containers usually aren't meant to be spawning a lot of processes, that
> > limit might be a lot lower than on a normal system.
> >
> > I know that Docker provides a way to include an init process in the sta=
rted
> > container (`docker run --init`), but I don't think that AWS Lambda does=
.
>
> I don't know anything about Lambda, but if you are running arbitrary
> commands, then it seems like you could insert something like this:
>
>   https://github.com/krallin/tini
>
> into the mix. I much prefer that to teaching Git to try to do the same
> thing in-process.
>
> -Peff
