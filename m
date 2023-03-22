Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07903C6FD20
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 03:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCVDIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 23:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVDIG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 23:08:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FA449DC
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 20:08:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j11so21629338lfg.13
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 20:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679454483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krt6u4NTZRQ1rJFBPpzjbVXuzZXpaKtgCHoGI33wlY0=;
        b=mDmzQZfuDQ9TV0nLMK7NCUxRZJTY+3ddA/1bc6A/JA8PYr8Xu2gPVQRjDFAmB+/Epv
         1ZqHttu67Y5ni6lUDtBhghq6FX/CQDKlaIRM+BhOOaVEU3KkrdtR3g8DFJfvvhjO65Ar
         T9YZ6CeXtRoe40MpKkBEXV7LS2K6OqQortsshW/3wSXxJX5lrEJv8Y4UuEDCH1AQlUc6
         S/QzzULiLEQWuFTsTxDf7YzGwJagif94N/yO/YMIwvl4mT1xXmrQBoh7HqKs8gncRJeS
         Te78WG/Hl5kzc6CGvvlcWCFtmfYCpxsyrUbhPTHkyYW7WtfugrkDQq5Jzge3wS4QHqF8
         Hb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679454483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krt6u4NTZRQ1rJFBPpzjbVXuzZXpaKtgCHoGI33wlY0=;
        b=thxk5CPPaoGqukTiv+yNg+il/9drn+AzClY2aT09g4H1i7ZVTMeCrormm/cD5teN9k
         U/maGJC3QhAX/i5uxgyzH0CftfPcnoiKtanFG8O6tkwRNSghlEBsD5a8LXyrJWeALPVN
         FehJAmCaQoGENkJgzvkI7WqV7d9XoLg/R+nppBYSzPHkmiGwP/aq/Cy0JTdpBeYrIg18
         XSiDldkWIh6LHVkpo60HPcba77LnzAzDWotxrhYFlTDOb5hy9X1MQSApvgWEGZTMq7Iw
         zCVJXSUfIrFV+L1zj2AtaRp4WDEzciky4P98WLfNwGK89CHkjBttuJ8Gv4pPsXWC7Jtu
         ll2A==
X-Gm-Message-State: AO0yUKUnwJyWheXk293rTIzu3bwvOgiyRo05R2nmAkaadpfUiFoiEEof
        RKkRZEdh+MzRNB98lUDYckb7D0d6NfbQ6HQ86UQ=
X-Google-Smtp-Source: AK7set98qCCcFcOg2hxmfkXHsYAOA1/KhFIrDM0EUgHd+ZPBDQwvul1E9nL8YqeaGvusL5TEjehFZDZsW64cMp4D9b4=
X-Received: by 2002:a05:6512:b8a:b0:4e8:4409:bb76 with SMTP id
 b10-20020a0565120b8a00b004e84409bb76mr414089lfv.2.1679454482904; Tue, 21 Mar
 2023 20:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <BBB169A5-0665-47C9-819B-6409A22AB699@lanl.gov>
 <CABPp-BEG+vp-UcpVfcZecPBnfcuTjO6JYCo7wEU5ZrDUHBUd9g@mail.gmail.com> <20230321183138.GL3119834@coredump.intra.peff.net>
In-Reply-To: <20230321183138.GL3119834@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Mar 2023 20:07:50 -0700
Message-ID: <CABPp-BGvC9wGwUYPGLXkPZH-stg9KxwFFJSCk2dXhDitOFCWoA@mail.gmail.com>
Subject: Re: bug? round-trip through fast-import/fast-export loses files
To:     Jeff King <peff@peff.net>
Cc:     Miguel Torroja <miguel.torroja@gmail.com>,
        "Priedhorsky, Reid" <reidpr@lanl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 11:31=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Mar 20, 2023 at 06:57:21PM -0700, Elijah Newren wrote:
>
> > Honestly, looking back at those two patches of mine, I think both were
> > rather suboptimal.  A better solution that would handle both F->D and
> > D->F would be having fast-export sort the diff_filepairs such that it
> > processes the deletes before the modifies.  Another improved solution
> > would be having fast-import sort the files given to it and handling
> > deletes first.  Either should fix this.
> >
> > Might be a good task for a new contributor.  Any takers?  (Tagging as
> > #leftoverbits.)
>
> There was a patch a while ago, but it didn't get applied:
>
>   https://lore.kernel.org/git/1493079137-1838-1-git-send-email-miguel.tor=
roja@gmail.com/
>
> It got hung up on the fact that fast-export can also generate renames,
> and ordering there is tricky. I stand by the sentiment from back then
> that it is still worth it to order things to make the no-rename case
> work, even if there are still corner cases with renames (since you can
> have a cycle of renames, you should not use them if you want to be
> robust against this kind of ordering dependency).

Ah, thanks for the heads up.  Stinkin' renames.  ;-)  I tend to forget
those in the fast-export/fast-import context since fast-export doesn't
detect renames by default (and e.g. filter-repo would turn them off if
they were on by default).

So, I think we probably need to have the fix in fast-import.
Currently, parse_new_commit() calls the various file_change_*()
functions immediately, which in turn immediately call the various
tree_content_*() functions (e.g. file_change_cr() for a rename will
call both tree_content_remove() and tree_content_set()).  Instead of
immediately handling all these, I think that queueing all the
file_change_*() calls up, splitting the renames into delete + modify,
and sorting all the deletes first should fix things for both F->D and
D->F, even when cycles of renames are present as per your example in
that thread.
