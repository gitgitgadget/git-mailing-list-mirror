Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38159C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 22:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiCUWsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 18:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiCUWsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 18:48:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A12986DC
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:28:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so19578603edu.10
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2L1btps0yapyu2X34+Vakeghim/oZbwyqeS3Wym7wTk=;
        b=MiMiTT5NGHIpITNkrQS9cXTSEfdAocuZ2ZwBORpzU7/XZx3JTeYPCs1R2qeGPDXw80
         ux9bf8kof1myPu6cH0CdUAC7pQU4qD8gtJyxNCHJjAqhEJaiPpu0K1QOtPbtICspVuKL
         5J3eGWSmf5djy5qBeebIpS2eljIC781ghaDnNJEvjxNQqjUtsPXRarPfK2P87w8W2/xv
         +g605lTJpom2UQGH+Hga7IL7uGj/IEKVbVtkVtEbxcgFHhgrGn5BDfsHt4KZ+gSAb64m
         24EGF3N27UH/PNCtVVlts/EKyQ1668nHpK1Jtk4Hfff1LoV6XP46bbQiO0PfuVufoRmO
         hjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2L1btps0yapyu2X34+Vakeghim/oZbwyqeS3Wym7wTk=;
        b=CNQDiKHVf+IqMHd3vrX5IiciTX6AeQ5jBxzfRM2G1hfZGYXDRMHeLKST0+obQKTPVf
         qYpUUxNCfNzk5la0SAt9LDkUVTuVxPzu31nUOt/pHpjywXzstpDBsar9MGhkpS++rqul
         150cu4THsZATpZYclyJcrNde5TfpIxukuOSRefRqefuUsYKKhJUjDnozXZNeBZOaplIa
         t47YHt37gP3rAPxOhpQS8P8UttESlGmfe6nsDCyqL9pmSG0I6ePWeV6F7cS3HW4FPNUj
         eFYPoQWsUco8Viqad18qrv9ACMrF6Vo2s8VUUCqHzJM97GIUnYPagPIBH0W7k4SNAa9l
         EVLA==
X-Gm-Message-State: AOAM530/A36mdBtUe3z4EvFi4xdkXbpwMZKnyQm+2EWcFc0Cu7ZuJMEP
        pZ41/mITRroCy+47vV2Eff/E2JhCB913l7wJWcPtdKaP/3o=
X-Google-Smtp-Source: ABdhPJzTLlTzR+FXGaI+ZC4/xoB0K6mQ+KA9HfH6rV3A7FLdmTMAC0xnjqyRl4fag7acDJjwluGMhFY9m663ZRMpy9w=
X-Received: by 2002:a05:651c:158e:b0:248:1ce:a2a with SMTP id
 h14-20020a05651c158e00b0024801ce0a2amr16626564ljq.172.1647901102066; Mon, 21
 Mar 2022 15:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <54797dbc52060b7fa913642cd5266f7e159a5bc9.1647760561.git.gitgitgadget@gmail.com>
 <xmqqzgljyz34.fsf@gitster.g>
In-Reply-To: <xmqqzgljyz34.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 21 Mar 2022 15:18:10 -0700
Message-ID: <CANQDOdfa3SOee929pHmUBjQTgFa9hMHtX5kMZ45NaL+Xd6w+Rg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] update-index: use the bulk-checkin infrastructure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 10:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/builtin/update-index.c b/builtin/update-index.c
> > index 75d646377cc..38e9d7e88cb 100644
> > --- a/builtin/update-index.c
> > +++ b/builtin/update-index.c
> > @@ -5,6 +5,7 @@
> >   */
> >  #define USE_THE_INDEX_COMPATIBILITY_MACROS
> >  #include "cache.h"
> > +#include "bulk-checkin.h"
> >  #include "config.h"
> >  #include "lockfile.h"
> >  #include "quote.h"
> > @@ -1110,6 +1111,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >
> >       the_index.updated_skipworktree = 1;
> >
> > +     /* we might be adding many objects to the object database */
> > +     plug_bulk_checkin();
> > +
> >       /*
> >        * Custom copy of parse_options() because we want to handle
> >        * filename arguments as they come.
> > @@ -1190,6 +1194,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >               strbuf_release(&buf);
> >       }
> >
> > +     /* by now we must have added all of the new objects */
> > +     unplug_bulk_checkin();
>
> I understand read-from-stdin code path would be worth plugging, but
> the list of paths on the command line?  How many of them would one
> fit?
>

do_reupdate could touch all the files in the index.  Also one can pass a
directory, and re-add all files under the directory.

> Of course, the feeder may be expecting for the objects to appear in
> the object store as it feeds the paths and will be utterly broken by
> this change, as you mentioned in the proposed log message.  The
> existing plug/unplug will change the behaviour by making the objects
> sent to the packfile available only after getting unplugged.  This
> series makes it even worse by making loose objects also unavailable
> until unplug is called.
>
> So, it probably is safer and more sensible approach to introduce a
> new command line option to allow the bulk checkin, and those who do
> not care about the intermediate state to opt into the new feature.
>

I don't believe this usage is likely today. How would the feeder know when
it can expect to find an object in the object directory after passing something
on stdin?  When fed via stdin, git-update-index will asynchronously add that
object to the object database, leaving no indication to the feeder of when it
actually happens, aside from it happening before the git-update-index process
terminates.  I used to have a comment here about the feeder being able to
parse the --verbose output to get feedback from git-update-index, which
would be quite tricky. I thought it was unnecessarily detailed.

Thanks,
Neeraj
