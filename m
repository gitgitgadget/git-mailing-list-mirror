Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AD6C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 13:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiCWNCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiCWNCP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 09:02:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6913B6B0BA
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:00:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h7so2597207lfl.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5npaBl8fHbAR+8l1K36tfqD87ce7jXi8jt6I/zDUD30=;
        b=hnKFMdA3i7nsLGHkzVMLsce8LkJWLJ4vKMFPJEF9WsL8/yOOl+m2id0g7AwM2SCRwL
         GWL+ZF9VVhoM3uF7hczp2sU9SIoVRKV18yydnEto+jY9dRvSb2oljF7mM4EfhV/rrbjB
         w+SugCjEk4quwkkVl43vVRTTstxvmKS7giVK0EqKaeVXg1cl1bQ8xDnDp//pt3bPXQyp
         UIA4WcP6BeFF1QCCMYsGx1NQsp0DQG2X/ICG69vwvtPZY/75xV8VuqWU+MgjsgtxAdWv
         eMAapzp0mVHfSUP+wG+gFroGaqeoGUT97dOKdoyXn2nMi8Wv++dUmNAzx47wXDd54kqB
         H8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5npaBl8fHbAR+8l1K36tfqD87ce7jXi8jt6I/zDUD30=;
        b=e/6BDbt6eQvNFjxdJHQehaamVr+IfK7datRzxeTWE+NB5qrAh/dDYa0Hb+pi+cF0cf
         iXcOSLyGfdI5X2vhXkGwVcqF3Zehw/c7zNjAcmZkB0C9XOE2i935jS+zmAQWQOXIXjQk
         s+Wktb9qyH1E37hLOew2W0kmoDrRjguI+pl2LWTn3FvOHY20UJG8MQ0/Pv8BszqIFNyM
         JGd/j3cwsU4mOJeQ+FD3CfXUW3Lbqj4N0FlCf+5XYLU6gC5/6WVdTv3GZuRqIl508Twl
         S9+p9QkO1N2onMvv7jWCW7wy/5TTqUnoAHJE05TsGR9Po+7el0ne3CatB/YWRSD/i4Qe
         gtKg==
X-Gm-Message-State: AOAM531RyhNlmwBgxOpFFMXaqLTZLsynoy0SVv6H05GPtsbT3PcC08yJ
        Du+OM8AbO23H+lLmDGh9PPhd7ViFMeRRiUjLxoCypZGgnwA=
X-Google-Smtp-Source: ABdhPJxvsb9G9MGUZhpVrn256LAVW8VIa/f+sXO2KfJ3oD9isTtWzOdjOa0cQfQvwpRH6HPOjKB1ewejQo+gY2tJ0Mc=
X-Received: by 2002:a05:6512:3b0a:b0:44a:2e21:ef25 with SMTP id
 f10-20020a0565123b0a00b0044a2e21ef25mr9771765lfv.333.1648040443414; Wed, 23
 Mar 2022 06:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHGBnuPavzr_gq0ake6bOQETmHBnU2XOWdDz-UtkBP_+rRdYfA@mail.gmail.com>
 <220323.86o81wonlf.gmgdl@evledraar.gmail.com>
In-Reply-To: <220323.86o81wonlf.gmgdl@evledraar.gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 23 Mar 2022 14:00:31 +0100
Message-ID: <CAHGBnuMRKhsF-xCL944KD5GFPWYe-9cSp6FBZfaZ7bdVTkgjng@mail.gmail.com>
Subject: Re: How to determine the number of unique recent committers on a branch?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 1:33 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> I think --since to "rev-list" combined with e.g. "shortlog" is what you
> want here, e.g. on git.git:
>
>         $ git -P shortlog --since=3D2.weeks.ago -sn origin/master

But that still interprets "2.weeks.ago" relative to today, right? So,
for a repo to which no one committed to in the last 2 weeks, it would
show nothing. But what I'd like to get is the number of committers
since 2 weeks before the latest commit. Any idea how to get that
easily?

--=20
Sebastian Schuberth
