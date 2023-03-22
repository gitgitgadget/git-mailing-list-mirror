Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471E7C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 13:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCVN7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCVN7s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 09:59:48 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE397F8
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 06:59:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id bl9so2021555iob.8
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679493587; x=1682085587;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqkv+4wqH0qE0ggWdzyD23j16Psl0zce3il+mCUvSOY=;
        b=SZ0P45lJh+UwGhmOwy0M26Ql0kOn94CpMGoLwxFJw2tVsoe60sH4/XFscWE8jOZ4Zm
         rqWxpG8+XpuoF/hG9qOFpDN8hqdvjDsBDMccdGHv1oj8MxmTGR3CEiF4Tg9vyL7PJx3p
         jZIzXofix0/lEwfItL/Y+V6miRbeSJlpoeENdym51ScnMIKIgJbyYIBZn47pa8ue87E6
         208AZEzlj1dyl+vWl1Gf3hrvuAwhgj4TxelxeBSOVJykBBZcqXBiFP9Itftxz4ncCkRX
         rXlI/lmKJIxpnRRhnWST0REog6PJCLFfSjZEGHnJfZmkKjlHJZ9iEpizSKBOYg4Zlz2w
         C2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493587; x=1682085587;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vqkv+4wqH0qE0ggWdzyD23j16Psl0zce3il+mCUvSOY=;
        b=snrB0pR+tb3pGsSWYVJz4V45iKJdZyZF12/Xdp45D77LD6ntefe3ceedS6dXGNBJpd
         RuLyIkXFsi8pYdbgViEGUrsZXRPykHGW9qmiXPMXBeRdgxmX0cvIHQPYeKYIbacADW5+
         WQft03ApByRTgkugS1LF6ruRvhDpjhvlLdstyi57GSFVL4VSbRJFhod+ENAXcvpxzP/q
         aN976K07LKTu1+l9v38gzwC0YOB3awIbXiZjx9kBVNDQvbHjDzZJTckEk0skPQb6DTVi
         Mw64tJ+gqKwel9N0bC8HLxfs6ljsWL0emI7imiAeIYBfKF2Pk0zevpa9I5oLtBgTWGzg
         9Zug==
X-Gm-Message-State: AO0yUKWlKTzMcNnsehlI/80xqMZm1h70wsFgl3DuuouJk9ijUU+T8fvi
        e+gA3deaU53a/uOBN+RyXeq+dkxwYjY=
X-Google-Smtp-Source: AK7set84qiOGUQnSqjuFPgWiXAvz7vljw/He/RK2si19UgAb12kjm/5npCt+Id9GmKaUO6OrNL77WA==
X-Received: by 2002:a05:6602:168a:b0:758:6517:c621 with SMTP id s10-20020a056602168a00b007586517c621mr3338073iow.2.1679493586752;
        Wed, 22 Mar 2023 06:59:46 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-f.epic.com. [199.204.56.212])
        by smtp.gmail.com with ESMTPSA id e41-20020a02862c000000b0039df8e7af39sm5220152jai.41.2023.03.22.06.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:59:46 -0700 (PDT)
References: <94EFF553-E498-46D9-B14A-3500FEDEBB47@nearearth.aero>
 <m0o7ol6ta7.fsf@epic96565.epic.com>
 <ACA3ECE1-689A-4BFD-A8EE-9CFF30128C1C@nearearth.aero>
User-agent: mu4e 1.9.22; emacs 30.0.50
From:   Sean Allred <allred.sean@gmail.com>
To:     Ward Hopeman <ward.hopeman@nearearth.aero>
Cc:     Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: Feature Request: Ignore Tracked IDE files
Date:   Wed, 22 Mar 2023 08:55:12 -0500
In-reply-to: <ACA3ECE1-689A-4BFD-A8EE-9CFF30128C1C@nearearth.aero>
Message-ID: <m0fs9w7upa.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Ward Hopeman <ward.hopeman@nearearth.aero> writes:
> [...] but I agree there appears to be an alternative available. I will
> pursue those configurations with the team.

Best of luck! Managing settings across a team is always an 'interesting'
experience :-)

> I am curious if you think there is a class of files, under the
> paradigm I outlined; that need to be tracked initially but then
> ignored for regular workflows? Just curious at this point if this was
> discussed / considered previously.

It comes up every now and again, but in lieu of specific examples, it
always 'seems' to be the wrong approach. The Notes section of
git-update-index(1) talks about this a bit:

> Users often try to use the assume-unchanged and skip-worktree bits to
> tell Git to ignore changes to files that are tracked. This does not
> work as expected, since Git may still check working tree files against
> the index when performing certain operations. In general, Git does not
> provide a way to ignore changes to tracked files, so alternate
> solutions are recommended.
>
> For example, if the file you want to change is some sort of config
> file, the repository can include a sample config file that can then be
> copied into the ignored name and modified. The repository can even
> include a script to treat the sample file as a template, modifying and
> copying it automatically.

--
Sean Allred
