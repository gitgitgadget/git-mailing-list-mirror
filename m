Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2028BC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351252AbiCXScF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239091AbiCXScD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:32:03 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B03A1A7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:30:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so9525840lfg.7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EiiclJ83EIXJXTLe2lRsSttpLkIPfDoG+9bfS6odEdg=;
        b=ng/IMyXX2XrnDSik8hgYDCaxoL3eT8Of1lS/9G+GC6jxHraEvCLEeHiC+9B2QR+exZ
         i9J65xGs13HGL755vn8ee6hBb97Zaa4ttKzXV0wHJsqxy4ea8UTrnhdO/IW/8VC8cOGX
         mS6pwXd2pVSoSeV49G6SOy5DXgx61uvFrh8mS8HbwUNbHSvc/2Ch9kdVzLgWl8LlOb8b
         yKZ4Al+Npive/yKHoI/gPB8LajVNJHifgS/mqheP3F0Tur8FhmTmv9tSIz6ku4VQBYqy
         RKyCuuAKjzvvTV40pXamd2idqT5SVvfHIUuAQGiglNgl/VlFiuqSbH2vorj1cFcpE8hA
         +FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EiiclJ83EIXJXTLe2lRsSttpLkIPfDoG+9bfS6odEdg=;
        b=MBl11Lj0qc6ZNuhaKiWGzy4GrJPghmmSYDUQ1k5jwocBVDam+T7Of4BVURL1fWs8f9
         8Ru3++2zwEZAuF9xds0diba/bnJu0EBBaP7Dn61OUbpW2ZY7w5rxDsziXYRdpnetGGVz
         vWdHgoObL2cJwKOVUm/2RyEk05+5byxv9VfY+67vhD7VlXiSPF0Rc3J6kdcmbMWQdjMY
         yciL8vwvtfgiN5gN5KKnxeGa2hxaibmBQIQp4gzMVvZoGbq/b/bs4xJUpfnrN9njupCP
         uCJuUNRFXGNgxxVfjJIOVqLSpR3x859zOa1tem6bxGgBtVPWUtjMHYcIsF2Acoj1+QIQ
         YU3g==
X-Gm-Message-State: AOAM531lMIoqk4v45uHyOyLqfWEkS2ilwYpJ2kU5q5/wb1ay8azFI24f
        ixt9UFgo/BXbSRLOQP0HdkUsVBmR/bOTpzfQtaFZ9assu8+eaw==
X-Google-Smtp-Source: ABdhPJytVr/RpKk3AMu6Os2sAUucPlQolJZkur85xS5FdA/x2+74TLV/5o5YbHC3g7GWQrU/tTO6w+ZSUhFZPdMScdM=
X-Received: by 2002:a05:6512:3ca9:b0:44a:2ae0:51d3 with SMTP id
 h41-20020a0565123ca900b0044a2ae051d3mr4757748lfv.361.1648146627493; Thu, 24
 Mar 2022 11:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ZGDOUKrNRdf-7+SBoVhPkAmyHEtt==AJ=jBDWGkOUcz=n4BA@mail.gmail.com>
In-Reply-To: <CA+ZGDOUKrNRdf-7+SBoVhPkAmyHEtt==AJ=jBDWGkOUcz=n4BA@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 24 Mar 2022 11:30:16 -0700
Message-ID: <CAJoAoZmo4bJgGdYQeM4XtRJHOpm4z7Gvg=qpUc4xa7Ap=v++UA@mail.gmail.com>
Subject: Re: bug report: pre-push hook
To:     =?UTF-8?Q?Honza_Proke=C5=A1?= <proke.j@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 9:45 AM Honza Proke=C5=A1 <proke.j@gmail.com> wrote=
:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> I did setup pre-push hook to run unit tests.
>
> What did you expect to happen? (Expected behavior)
> Pre-push executes tests, I can see output, and if tests fail, push
> does not happen.
>
> What happened instead? (Actual behavior)
> Tests seem to execute on the background, but I do not see output

I wonder - are you printing your test output to stdout, or stderr?
stderr of the hook is printed to stdout of the Git process, so that
may be why.

> and
> push happens when tests fail.

This part I am a little less sure about, especially without seeing
your hook script - but perhaps getting the output thing figured out
first will help figure out this part?

>
> What's different between what you expected and what actually happened?
> As above, so:
> Tests seem to execute on the background, but I do not see output and
> push happens when tests fail.
>
> Anything else you want to add:
> When I run pre-push script directly from terminal, it executes tests,
> I see output and if I ask for last command exit-code, it is non-zero
> if tests fail, so my script is functional. It was working until
> recently, noticed today, but this behavior happened at least two days
> ago.

Oh, interesting! There has been a bit of hook-handling backend work
going on lately (ccing =C3=86var who has been more actively working on it
than me) so it's possible it's a regression, although we do have tests
covering pre-push hook in t/t5571-pre-push-hook.sh; I see that those
tests cover nonzero exit, but it doesn't look like they cover output
capturing (the test hooks are cat-ing to a file, rather than trying to
print their own output).

Any chance that you can provide a minified version of your pre-push
hook that reliably tries to fail and doesn't prevent push from
happening? That would help a lot to track down the issue.

> It was working well in past. My fella has the same issue with
> similar script on up-to-date Arch Linux.
>
> [System Info]
> git version:
> git version 2.35.1

Would also be nice to know, if you happen to know, what version you
used before when it worked nicely. But if you don't happen to have
that handy then don't worry about it.

 - Emily
