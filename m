Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15274C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhK2W7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhK2W71 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:59:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A4C111CC2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:33:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z5so9988809edd.3
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnL7qExY4vDaiYZ7v9uCptUZ4xonmpADfQjS/wjwVyU=;
        b=M4HXecg8Fxty2liqU50qH7t48BUchM9843c1MlA+qihUJUcOqC+C3cXTv7sFRZRBQI
         NCT/lV155e6caZSlPTRt9iw//aWlLDSEsZ3sbkXSGaRnAG6EbufVapAmJq9Nf7IARHQO
         KIq8Od4WUDjHksFwMjfsFEwOvVzpnAo3G9mLZUJsP4xXVcO7tNFHnHMHOwdUOxDEGeZC
         fCDJJCY9DEMJxT/zB+uHG4bPqDCIoj9RCmLGl4UIrRzWiEgKUdPAP4+MfA5FA84w+W9b
         O4HXPp8EkyW6tjHB31hA5rh29ypLEvCXKexniIv4Sb2v2rdAnJeD5OFg4Sk7zoCTK6f5
         eluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnL7qExY4vDaiYZ7v9uCptUZ4xonmpADfQjS/wjwVyU=;
        b=eKdcD3nJ+GgUBpDAHyY0giPdPERGmbhbk+MATg/S2p2/7BIiXQMr7vB4tSqUhJ+Odk
         ilwBjQuseqZJnCY7KRzjN3M2NG3n5lcWui9OrSuSWgHIdL4Xq99C71frjZOf6v0lkSDd
         Ehp36nqNcOvD65QloY5MGJuTjZ+Ccyj6UVk8euwjMm8ruxvIBttEWnXS1aMhNMXFc8Xa
         hPNiGSx/xplNnHIyWFVOG+uJPVnfHzMD/RPlrrg4P6Rlxg51QE+Fh0yikRyl0ir+J68O
         dZNNGhamn+5eq7+8htnwruwVFz2X1DkJ3F1wTWxPADibK48+J7NVvsc4bltResBMQ6PM
         IIbA==
X-Gm-Message-State: AOAM53148k58UCRUV/5UsEKbCM0kkXXbzAK10cdLFHjQa4vDW7VxKY1o
        RZdMOwI+EOnajgp6ENlc0kAM6AOzOIbur/0QyOI=
X-Google-Smtp-Source: ABdhPJwi0kru/SKDSxlpkagi38Ecjvsb/fUtVR7w7xmjsBss2WGNI3DD+sEFud1igFUmP2n0+vl4CihYTf3BPBBsQSQ=
X-Received: by 2002:a50:c38c:: with SMTP id h12mr76552780edf.72.1638207225240;
 Mon, 29 Nov 2021 09:33:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com> <e06806e3a3266fa6fdc973fcd7b479bd395c3023.1637829556.git.gitgitgadget@gmail.com>
 <f65473df-4cb0-afdb-70e3-ee7685e6d817@gmail.com>
In-Reply-To: <f65473df-4cb0-afdb-70e3-ee7685e6d817@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 09:33:33 -0800
Message-ID: <CABPp-BGSNh0Ai6nT0B+kW=37w=ho6SRNoTEGFXE9uaqxmfwmAQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] unpack-trees: add special cwd handling
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 6:14 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/25/2021 3:39 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When running commands such as `git reset --hard` from a subdirectory, if
> > that subdirectory is in the way of adding needed files, bail with an
> > error message.
> ...
> > -test_expect_failure 'reset --hard fails if cwd needs to be removed' '
> > +test_expect_success 'reset --hard fails if cwd needs to be removed' '
> >       git checkout foo/bar/baz &&
> >       test_when_finished "git clean -fdx" &&
>
> This test doesn't include any condition on the final state of
> the worktree. I could imagine that an implementation could be
> writing to the worktree incrementally and then bail halfway
> through. A clean "git status" would give us some confidence that
> the worktree and index are in a good state after the command
> fails.

Makes sense; I can add a
   git diff --exit-code HEAD &&
to the test.

> > +     if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED) {
> > +             /* Avoid nuking startup_info->original_cwd... */
> > +             if (startup_info->original_cwd &&
> > +                 !strcmp(startup_info->original_cwd, ce->name))
> > +                     return add_rejected_path(o, ERROR_CWD_IN_THE_WAY,
> > +                                              ce->name);
> > +             /* ...but nuke anything else. */
> > +             return 0;
> > +     }
> > +
>
> This implementation appears to do the right thing in the case
> I'm describing: we check which entries would need to change and
> we reject them before doing any real work.

Thanks for taking a look.
