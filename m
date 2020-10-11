Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C6EC433E7
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 05:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF161207E8
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 05:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgJKFI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 01:08:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36769 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJKFI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 01:08:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id l16so13521732eds.3
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 22:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxhB/K2X+ZRKyvfu+XhnQQYUWo9cyVu4EwWkyrGKS3o=;
        b=kBs9BlRBk0fIashyfqCoP82jbMTOMLGoUsORVRn22NUaugzHBElJSMMMfvLmzILTWZ
         ATkuPG2eXiNnCaYl8v4Hs9g5eRSR/voIkeScPR/vTiqVWTSUJM1YVRuOJY55vkgEAw55
         yfPyr3455lDKUOakj9zNwGcPEuWeDLjT0vhDrOYuHglYA3vXgWuFnVzPqUcHPc2AlYVB
         5wUNDy3wypNGdEzA/ctuHjATm2L5ftbu6TRHxuelwAKK7UQf8PblgrpbbZybSoWnbxx6
         BrSoLxprjG4eweL5xwulnCVZbx/qFd4o/32fYg0XDklvBfSiOPsZEUR9hTP9ehAw0lHs
         Tmsw==
X-Gm-Message-State: AOAM530oZtYJKmAsi561zjWJneT7c9KEPthTE7eG1M7CCZpa3NtcLrhs
        aptBNAyG529wiKpgWKzpZqH+4Zwtw3TgpiwVtmI=
X-Google-Smtp-Source: ABdhPJyv9QoDK7fVq/Vdj8Ojubr8GW6oDeDOTS99XpSvrL45SLU4Rb38qQZ1DMxAyC2ztoPbuSYqgvfxAZjOjUK4zHY=
X-Received: by 2002:aa7:c746:: with SMTP id c6mr7468095eds.221.1602392936141;
 Sat, 10 Oct 2020 22:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
 <20200123163151.GC6837@szeder.dev> <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
 <xmqqpnfa3sj1.fsf@gitster-ct.c.googlers.com> <xmqqk15i3rp7.fsf_-_@gitster-ct.c.googlers.com>
 <20200123192707.GA110440@coredump.intra.peff.net> <8be28321-3108-4846-ac6a-d5c7977774dc@onlinehome.de>
In-Reply-To: <8be28321-3108-4846-ac6a-d5c7977774dc@onlinehome.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 11 Oct 2020 01:08:45 -0400
Message-ID: <CAPig+cT1drHWic4bm=NPMd4RnGuLe-WwUJ-82nHkze_ZOoYerg@mail.gmail.com>
Subject: Re: [PATCH] gitk: to run in a bare repository (was: gitk can't be run
 from non-worktree folders)
To:     ch <cr@onlinehome.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 30, 2020 at 11:21 AM ch <cr@onlinehome.de> wrote:
> On Thu, Jan 23, 2020 at 11:20:36AM -0800, Junio C Hamano wrote:
>  > Subject: [PATCH] gitk: be prepared to be run in a bare repository
>
> Sorry for bumping this thread but what's the integration status of the patch?
> The issue still seems to be present in v2.26.0.windows.1.

Junio just recently pulled commits into git.git from Paul's gitk
repository which contain this fix, and it looks like it will make it
into the Git 2.29.0 release.
