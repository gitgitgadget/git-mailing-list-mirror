Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5646C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C02121734
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NamdIA69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIRRjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRRjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:39:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E967C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 10:39:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w11so7024912lfn.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ij7xD3tMG+lw4J6MQBnLY1mtFCCxOKzfCvkffC1vq0=;
        b=NamdIA69i2MWNacNrV9c68FXJpOgE6Dkas+QV7mc0bo00EKWUpLJc6A/DxuJ0bC5Bw
         fF5h3MMJiLunUTPSrnzK4r1Cr6CRP9iBYr3wjIsUZMvGI09s8eLPvr8Mc7u8S0awRGq+
         R46InFBq9ooaTyCMUIeDsY2kIv5NilcJ92EitXVj4pC3E+S81+wzt0VqFspfCgA7KYUg
         dNRmENWEyFGnLlU7zhlRBnbALCXy3lAFkzNC2wkEh1StcwdOZkv2DpyW0rCmOH6pSMl/
         Md0kyIgRDNO61Mi9jgd8YJ2MeU4WGT0e8RDx1MNZYcRINIhNWrvGa5ZekSmIjco/skPr
         IC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ij7xD3tMG+lw4J6MQBnLY1mtFCCxOKzfCvkffC1vq0=;
        b=l5Sd9aIB5p5NIuvfbdTNEZJO2mH82qASRfvRHJIvZc9gBoS4sSSp8S2llqjXnT4PNx
         /Jih38X5PkbxAqWff8rq6llPwTNWtXGO4iunQ6Oqxq1UAu+d0CZfqk5I1xoM0NTvox7+
         1Za9YLenAUswVX/8BXg3J6EzCJUAPCPMQzdkH0Cu70Oud1h4AfYIJVhNb6raSJONwgtv
         PryPRiTO6l0jsVC6mihyOv/eN4BRIZp6fZoN2j/ugMxC8qsOQ9lIewUPBuvveF4ZndrR
         Aon05rWY7X+1QUMrNWpJLtfKfqniyHIm1sb3jjrt8RdbuOA/9BYxzRCnAyAPMA/cZTAi
         viPg==
X-Gm-Message-State: AOAM530wo/A02aUmwf7nagi1CZoqG/rJk9A4gA8iCiexEy3eFdkQ9z/V
        Faj31kt/Fl0FQjTV/GuQOgL6nOAjKSPgb4IEUoU=
X-Google-Smtp-Source: ABdhPJwtRQ4k6BfYzasLufLEAops1Fh7giIy4jbNif7/RNRUXpsEMi3ouBo6Sx+0tc1v8FgACLlhWgQ2jaxN7jyv38c=
X-Received: by 2002:a19:e041:: with SMTP id g1mr10467089lfj.337.1600450775463;
 Fri, 18 Sep 2020 10:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200918113256.8699-1-tguyot@gmail.com> <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local> <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
 <20200918171950.GA183026@coredump.intra.peff.net>
In-Reply-To: <20200918171950.GA183026@coredump.intra.peff.net>
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
Date:   Fri, 18 Sep 2020 13:39:23 -0400
Message-ID: <CALqVoheztgciT1PBGmWu-M-Y_Lt13fhbSyXrMfoqmAotVCthNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff --no-index
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 18 Sep 2020 at 13:19, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 18, 2020 at 12:34:48PM -0400, Thomas Guyot-Sionnest wrote:
> But we do have to account for this in the test suite, which must be able
> to run under a vanilla POSIX shell. So you'd probably want to set up a
> prerequisite that lets us skip these tests on other shells, like:

Indeed, the bash test library that was suggested earlier may be better
as it exec() bash rather than skipping tests. Testing as a prereq
works, another approach which may be harder to swallow but allow
testing when default shell is /bin/sh is to run each git command
through bash - could be coupled with a dep if bash isn't installed at
all.

> Though it is a little sad that people running the suite with a vanilla
> /bin/sh like dash wouldn't ever run the tests. I wonder if there's a
> more portable way to formulate it.

Debian defaults to dash, a minimalistic and afaik POSIX-compliant shell.

> Getting back to the overall feature, this is definitely something that
> has come up before. The last I know of is:
>
>   https://lore.kernel.org/git/20181220002610.43832-1-sandals@crustytoothpaste.net/
>
> which everybody seemed to like the direction of; I suspect the original
> author (cc'd) just never got around to it again. Compared to this
> approach, it uses a command-line option to avoid dereferencing symlinks.
> That puts an extra burden on the caller to pass the option, but it's way
> less magical; you could drop all of the "does this look like a symlink
> to a pipe" heuristics. It would also be much easier to test. ;)

Thanks for the info. Another consideration is how other commands -
diff, vim, sed, curl, etc can take input the same way, so being able
to swap-in git is a plus imho,and one less switch to learn (or even
learn about, I never looked for one for this issue).

Regards,

Thomas
