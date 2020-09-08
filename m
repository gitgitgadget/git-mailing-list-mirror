Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E6C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544E720768
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=klerks-biz.20150623.gappssmtp.com header.i=@klerks-biz.20150623.gappssmtp.com header.b="ewCBiuru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgIHT7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbgIHT7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:59:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E28C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:59:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z22so148142ejl.7
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=sPWvBWl0rPpNs/h4bMg4hZDheQD8TnKF1Vd5oiUBk3o=;
        b=ewCBiuruwHNIf6F/IqkrD4MqWIKtsyrW7sg07OxLJaZiUb2dVjyiw+/xxL5rrDLLER
         693Ki13CzoXuv8dcKGwDzG/+aZR6b/ne4MNkgJqmnS9d+KQA8QMd0qt12UhC0viFkJeE
         87FLSA6tnUuVBkH9vdrwhpaZZxb+Y0WXQfAQ5iubBX+U7Rg6PsBwXu4KsDf72iQThctJ
         ntRop8ZQ/LZO/8Zwe4sWugM6NO2o0VAthIJx0ui0bnXDz40GW0VybAdEw+XGGvrlmmZv
         AnKzU/yy1Uz5L+l0UbVuH9hWkrml2HWzj2HhwDGqau2r8ARxMlQXjNnP5tG1a58TZsBn
         HCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sPWvBWl0rPpNs/h4bMg4hZDheQD8TnKF1Vd5oiUBk3o=;
        b=dxvLyb2m/KSfFAY70TXggxRkIL2NRasJMLr6G0l5H6aO52hckd4bpCsJUegINV/MON
         GQOtbE3W5+MdEzxYxAmlV7qGfnV9dnd0SqI/15b7c0ZGpf2MVMQDrmRJzaoy3VWjkl4r
         w2IuuB+EzocIocO7evNr1BKeKAm+ypVvY1P75wm4rVxhSaX6hC7CyEiRPUqtz0xMCTHg
         NwgbDaQ0VR/Ox+H8Xc3/V4p/w5q732hcxMtepAO5WcgaGptEArNMgJzxr9EGZPj724Cx
         YXSaH0wHWcYHHTAAWDtiE4N2eajp7W0B1MVYNMlHtVH+vY1ZEW35Zom387mqQyLrAAVD
         z8xw==
X-Gm-Message-State: AOAM530EndxA2jgzNPjLO9FbrCIna14pwkpVxPRA/eikLYBJgWCYDvHo
        rOT5V77WA6MDTwHz1E/h0H2tkIxHkkT0HSO5xILJoVzSf1ZB2o6+
X-Google-Smtp-Source: ABdhPJySB1jC7RxMohXm0+tg85tTVR3n5ni7XkhscA5iOlhuMo9Quy90jZcxgM6BBlmFrZzFph8cV73BX4ncaJZGj14=
X-Received: by 2002:a17:906:49cd:: with SMTP id w13mr86154ejv.151.1599595137466;
 Tue, 08 Sep 2020 12:58:57 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 8 Sep 2020 21:58:46 +0200
Message-ID: <CAPMMpoicRnoBshbSNaF4Ns91b4WTE95EJJGzt1=cx9s_iYDOmA@mail.gmail.com>
Subject: Possible bug: --shallow-since and old branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I've encountered very strange behavior when fetching a repo with
--shallow-since, where I get many more commits than I expect in the
repo, and specifically when I count commits by branch I see old
branches where *every* commit is beyond the specified date threshold.

I found a thread from 2018 in which something like this is discussed
(https://public-inbox.org/git/20180522194854.GA29564@inner.h.apk.li/),
but I haven't completely understood the thread. It seems to address
the specific "repo would be empty" concern, but not necessarily the
more general "I'm getting branches I shouldn't be getting"
concern/case...?

I can confirm that if I move my --shallow-since date to one that
"intersects" the lifetime of a branch I am unexpectedly getting, then
all of a sudden I only get those commits I expected on that branch.

I can also confirm that in a recent version of git (since 2.16 I
think), if I set my refspec so *only* a "too old" branch matches, then
I get the "fatal: no commits selected for shallow requests" error
that's expected. But if my refspec *also* matches a branch that *does*
have commits newer than the threshold, then I get the correct (newer)
commits of that recently-active branch, and *all* commits of the
too-old branch that otherwise correctly refuses to fetch on its own.

I *thought* I would be able get what I would have expected from a
"--shallow-since" clone by:
 * Initializing a new repo
 * Adding the remote
 * Removing the default fetch refspec
 * Iterating remote heads, checking their commit dates, and adding
those valid/recent heads explicitly to the fetch refspec
 * Doing a fetch with  "--shallow-since"

... however, I seem to have assumed some magic there: getting the
"most recent commit date" for a remote ref apparently requires
fetching it (to a depth of 1 at least) first??

Is the behavior I'm seeing "as designed" for branches with no recent
commits, or is there a problem somewhere?

Best regards,
Tao
