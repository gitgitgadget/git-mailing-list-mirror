Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6FFC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 08:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiCNILG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbiCNILF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 04:11:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9369F2BE6
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:09:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b15so14512031edn.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6UcGanwGzWhH5Dwz+aLI3+TFMCMByR05LwXNossPr4=;
        b=aR0i/KCOpYtRswOvpyXidEA23zQWdVLr0I8rJO5l3xRWSWsvnvhMU4UDwf5apTJxc4
         lPkxv1vjlRwJgYdrPCKI3g5cJxb2F8vBMToajz2jPhCsJDvHD+SlA+pDt/PbIPcjUalI
         8/W0Z5Hhua2B3BrPSgqSML8JgWdBjxUdllbAi2l2YTu2OUyb1Wa8GDuPOzY18Xh+a1Bw
         vJmlgSareqXW2eThdh0djRlXzY2y7nU5Zuzo693HCNe2IHfEv59X7klf7Wr+C/Y8xNqz
         MTRScb4IAYiL3zSGoA7DMT9pmn0hHNj9NoQejYIakVxNAcS6GN5ivDKIN2ihDQLcju5H
         z3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6UcGanwGzWhH5Dwz+aLI3+TFMCMByR05LwXNossPr4=;
        b=cz/3zdQLM5a3E5tW0cV+AXpqsPemDxfoBe0zK/8bektZw10drl9rZcP5D2EYbB9FBX
         gMmxzvR/a+pOaY9MC5HAqegU9f9Q0aaCj+YMULFEp2WRss+7yuHVFsZzH0dNLQLSVFA2
         Oacz1j5MsCMOG7g03nxCkP3GbXYBqrTDidnlVUfXNDPTfg/gNpcOEq6WVoadRmCO8UqJ
         yPLCCSCXSbXCaOwTJliMv9c0AWu9lVTApefCKFa5jRDIzGVXn3PLpkk+e3b6hHR9iFic
         e0/A2kggYZCFSnAm04bbur26aqK9uDrS1kO9ZRbjlmgX4e0cg8b8LwOdZ4Md1uD7orUT
         hfAw==
X-Gm-Message-State: AOAM533q8o1TG6hr4XYF19dWu7jHZDz1rF6CC2uUjGiR/ECMT0Lntuad
        VVndDo67zf9zGRgC6qhhEnotgc3/0qmuZ844wzkzXYkJwAE=
X-Google-Smtp-Source: ABdhPJw9GWkQQvmKtFiFVNA3Y7xJcpcdeqjzs70p7981odFmh2aBsejTTBqR8a1c15e5Q8D8HOzToIzTSQaVYP98TsU=
X-Received: by 2002:a05:6402:2750:b0:416:29dd:1d17 with SMTP id
 z16-20020a056402275000b0041629dd1d17mr19367928edd.387.1647245395114; Mon, 14
 Mar 2022 01:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
 <2aa11123-5456-b0f1-6c33-302924164e98@jeffhostetler.com>
In-Reply-To: <2aa11123-5456-b0f1-6c33-302924164e98@jeffhostetler.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 14 Mar 2022 09:09:39 +0100
Message-ID: <CAPMMpoiF_vH_wUNfH6QrhLJmq+5kVWe2h_W-QEcctfF=dMdFmg@mail.gmail.com>
Subject: Re: Keep reflogs for deleted (remote tracking) branches?
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 8, 2022 at 3:57 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 3/8/22 6:27 AM, Tao Klerks wrote:
> >
> > I have a practical question in case I missed something.
> >
>
> Have you considered having each team member have their own
> private fork of the repo?  Then their branches are theirs
> alone and no one else needs to see or collide with them.

Yes, this is a scheme that I've certainly considered - it is the
public norm after all, at least in open-source development.

In the case I'm describing, however, teams often prefer to work in
communal spaces, seeing work appear and disappear in their group
environment.

Of course most teams wish to be isolated from each other, and of
course individuals want and have the option to work in isolation from
their team for any given period of time - and by "isolation" I don't
necessarily mean secret, but rather "not pushing refs into a space
that others will automatically fetch".

The case I am describing is a specific subset of an ecosystem - the
case where a team normally works in a communal central refspace.

Anyway, thanks - it looks like no-one considers git's behavior very
surprising here, I guess I'll just implement a server-hook-based
workaround.
