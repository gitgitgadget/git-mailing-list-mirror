Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660CF1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbdKMWDq (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:03:46 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:46364 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbdKMWDp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:03:45 -0500
Received: by mail-oi0-f51.google.com with SMTP id n16so3281055oig.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 14:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zEt2dZbK3BMtBVikCTqXAusy8Rq0RjCdWg0SNc24u1c=;
        b=h559pptmHR6ukNMLjaosoMvbkaZCBLn2RvIn2ainE+zvUsXafarNeHk2HEbFCUkEZX
         DoUmwdarM4IMAWXHZ2p5KqoOowOPcmIbis77aB8ufqHyvljYx6FO3v0hZOBBEWVw430O
         CirvRiSnULsjuZwWqHORaRTvWt8/qDusB/lL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zEt2dZbK3BMtBVikCTqXAusy8Rq0RjCdWg0SNc24u1c=;
        b=k7J8zeeNFzLf/oV3zV929HHj89F/bN0ihrf8JYkPmmhg0cntpMuGZ0kqkL44+NkgZe
         1lJe+UX8lbJEfwiSmj4v83S3Eo20wGa1OCzG4FgnFDkzX/8pFkXCNjCyT011oyFS8eln
         gJgMLEWrDlLESF9cD0AfO60mzDo9qZB/2F249RWTguHvk8fg3jckCC5obASodTvPRu5S
         p7BZfdCjB/gZ3Mzo8GkFshi7e2V89PrqI4t79+IlA6NDBCj9bJcKVAyYtGft47Y3NhZz
         ifPuZOFwGPa6mQI/n1JsE0oQyhfUGPWh9S3E+lweGObx74YfTfUkc7bjVlBG4GdhxqaZ
         ifhw==
X-Gm-Message-State: AJaThX7na1VMGxrrN4fqKgaSyIJ8qw/ys5i6KhBQzELGPyJjUd4Qn0+T
        KDPgCCJiN3I7MOr0zQbGS/y830VfpQy+419Rrtpvfg==
X-Google-Smtp-Source: AGs4zMZCbl5DMzFAhZm1cl/4IVcSmv8fWf6nzYLZSGxCUrKxRJWigrTp48rUPCqqQFlbIuj/GgjE/wPhiNcxde37i34=
X-Received: by 10.202.75.147 with SMTP id y141mr3436087oia.206.1510610625028;
 Mon, 13 Nov 2017 14:03:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.12.236 with HTTP; Mon, 13 Nov 2017 14:03:44 -0800 (PST)
In-Reply-To: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com>
References: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 13 Nov 2017 22:03:44 +0000
Message-ID: <CAE5ih7_uuVVrze9gNr3JMg5HNH8eAcH_wM4wrc2kH6u=Hw0JOg@mail.gmail.com>
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
To:     Git Users <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 November 2017 at 19:51, Luke Diamand <luke@diamand.org> wrote:
> Hi!
>
> I think there may be a regression caused by this change which means
> that "git fetch origin" doesn't work:
>
> commit d0c39a49ccb5dfe7feba4325c3374d99ab123c59 (refs/bisect/bad)
> Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Date:   Wed Aug 23 19:36:59 2017 +0700
>
>     revision.c: --all adds HEAD from all worktrees
>
> $ git fetch origin
> fatal: bad object HEAD
> error: ssh://my_remote_host/reponame did not send all necessary objects
>
> I used git bisect to find the problem, and it seems pretty consistent.
> "git fetch" with the previous revision works fine.
>
> FWIW, I've got a lot of git worktrees associated with this repo, so
> that may be why it's failing. The remote repo is actually a git-p4
> clone, so HEAD there actually ends up pointing at
> refs/remote/p4/master.
>
> Thanks,
> Luke

Quite a few of the worktrees have expired - their head revision has
been GC'd and no longer points to anything sensible
(gc.worktreePruneExpire). The function other_head_refs() in worktree.c
bails out if there's an error, which I think is the problem. I wonder
if it should instead just report something and then keep going.
