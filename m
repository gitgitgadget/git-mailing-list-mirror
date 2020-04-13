Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E515C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 13:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3551420692
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8o/tdTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgDMNQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDMNQH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 09:16:07 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CC9C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 06:16:07 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s202so4092680oih.3
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FidUyVaJVED0/VfxaURE66mVnb1tfZkJuJKOLd6KX48=;
        b=V8o/tdTXaNEDtDiCfWVZ0I1qi0hyD2osPAqRK2GP0BvjsLqOre9tttXlKnyl22zpgJ
         gRdKh44ZYLr4S38rJenHdxxat11MjoKWvLcLrlrlDrcRhZMFjqkyEQvMSckzgzke+J5E
         9h+VK2xMM+umNKeK0SCRYk0le8GGfBNXGIzpW2s2ulEaMdpPzTK3lgSOpdUhPlx6GD+8
         iZq7rAc84Umnu/NFfDTtZiJoc4tKq70XyGOfMqnCK7/AHAQjvmC8o+hnoxyGPvtCOTOP
         9+PkPa0GruBui9QmXOJTKBISR6b7+xzvRVJ7uakvepWFPFYMTLT49BUlHeimG5HIS6+M
         KGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FidUyVaJVED0/VfxaURE66mVnb1tfZkJuJKOLd6KX48=;
        b=M7yOL3dZEnJF2/g6fcLQ0pgVgqlb/JzyGpmX1mUJjArkwwtl4UB19rSJtNHpLT2/x2
         K6cDqkivQ0jVSH8VzVxEcgcooyopZmcsQMlBaHQsZw3AYvgEWPu0d3eZnAWmWus5MUYK
         t5zMGC1ZZKcd189G5ILQOEHrksqEos+/6J0BAR7Ko+72YQuvd7iiHq04gc0HQ+J6K41R
         y9FKP6SrfJSCcuPX7OVF/P/SpXWruinQ8Bg+u54ZRaXHxoTw5+z9wLNwTBiR2DdU9s30
         jw2mgX4CN4/r7k+ASNZ5xofW9mS4JsntZw/4IQU//AWfMqArqucxZppCyWiI2i4eIJiU
         7LtQ==
X-Gm-Message-State: AGi0PuY8Lo4J3cOPNV9Aq9U+u1GnpJ+DkS8J5pkFsH4uHmOYgd2ZR4Ka
        CeewVBLLaejKq+LW+zVO12nERfGlfvZh+vvbeNQ=
X-Google-Smtp-Source: APiQypKN9iGXzWdjdG6w9UeQ57bDeqJ4IU87oKLZjdSPzZ0NF7gVdZVcCU2FJbfMaW9fvrgOLUPf7ko6B2pP7HYnsPY=
X-Received: by 2002:aca:ddc5:: with SMTP id u188mr11076206oig.8.1586783766281;
 Mon, 13 Apr 2020 06:16:06 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Mon, 13 Apr 2020 15:15:54 +0200
Message-ID: <CAL3xRKew_RHbPbp0qSa7WcDbaMmMWWmBi_nvPbmKaSpVDJM08g@mail.gmail.com>
Subject: Re: [PATCH 03/15] run-job: implement fetch job
To:     gitgitgadget@gmail.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org, jrnieder@google.com,
        peff@peff.net, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

First of all, thanks a ton for upstreaming this.
Despite multiple complaints about re-implementing cron in git,
I see this as a huge improvement to git UX and it is very much welcome change.

> 3. By adding a new refspec "+refs/heads/*:refs/hidden/<remote>/*"
>    we can ensure that we actually load the new values somewhere in
>    our refspace while not updating refs/heads or refs/remotes. By
>    storing these refs here, the commit-graph job will update the
>    commit-graph with the commits from these hidden refs.
Ideally I think we want to let user configure which refs they want to
prefetch with the default behavior being prefecting all HEADS
available from remote.
Using Facebook's Mercurial extension
[RemoteFileLog](https://www.mercurial-scm.org/repo/hg/file/tip/hgext/remotefilelog/__init__.py#l31)
as a UX reference,
users should only prefetch the refs that they actually care about.

> 1. One downside of the refs/hidden pattern is that 'git log' will
>    decorate commits with twice as many refs if they appear at a
>    remote ref (<remote>/<ref> _and_ refs/hidden/<remote>/<ref>). Is
>    there an easy way to exclude a refspace from decorations? Should
>    we make refs/hidden/* a "special" refspace that is excluded from
>    decorations?
In git-log, there is
[--decorate-refs-exclude](https://git-scm.com/docs/git-log#Documentation/git-log.txt---decorate-refs-excludeltpatterngt)
which I think we can move into git-config as
`log.decorate-refs-exclude`?
If you let the `prefetch refs` be configurable as I suggested above, I
think it make sense to have the git-log exclusions being configurable
as well.

Cheers,
Son Luong.
