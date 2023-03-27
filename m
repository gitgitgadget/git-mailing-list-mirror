Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E3EC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 22:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC0W0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 18:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjC0WZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 18:25:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422B3A82
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 15:25:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o2so9880083plg.4
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679955953;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t+BGlfRExkXM7FDQmmRERF/pngXd/pVZ2Qnf5I8QfVI=;
        b=VndRQNHJ5mV9RRENWHeAx8u1NZWOSV3DBBWUQ2dxdqU+/OKOlO6CwGGUgvVF4NjpB2
         Y2qvPNICS8sJ55c8yCQnWvA+fDKc/hDK2DH8o3x3WTiK2hRsV9mskOQXNoFQPUwSK/dt
         cbpnamjIHechni5et6m2K1FzgO5BAjg7zdegSbdqVcRhO8BEmSmRYpr9Yo3Vkd/PbxPf
         geOXaWgAH1f000NMqdv/FDTKnkK5noeG6JGXALDFQIuFYRw2nt9DEowlxRSSbFcPC3SX
         eM6vSiKYqHnQBtlR4KJZw6+Cdcsxc/v9kTzVZ8KUH6fhu0S0Yf673UfofXNHal7+/AjI
         8M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679955953;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+BGlfRExkXM7FDQmmRERF/pngXd/pVZ2Qnf5I8QfVI=;
        b=krb0Zf6Q/VJiNrW//MYxjUEBBKZg/NOhN2D4sVydpuXnPp/NjHelwB4eKQ86312J9A
         OGXI/l05iVcg8lpF4dUsBqwwA2g0u0GNq5WSdGmnh44iOOuQhsgvou7E83rur0f68C63
         x3JeF+q9D/6SWE5KIo2RQX23b/Vjj11dS0zB8v4r+Ely0yPQfuvNHNW1MyOZ/vDhbrCH
         4MFYZbFpZZSXlmS22QCK99vEBIXTg3Na8+J7iyEapF+rMH8EdANG2uwIoVb4lulyYQcC
         lTpS1Jtu/9NRdC7kXPX/IbcET/uUKi93UaavthlbV0rIZockdiyyBSSCl6dQ4/Gbnv2s
         ZJRw==
X-Gm-Message-State: AAQBX9dtmqdwr8RVhGg5Rw/BrsfjrDwUSC0JLfADqEyL1RsCWSRvOLPf
        IldRUNqcm2WwiQZ+dWQDUgmm1vcx55E=
X-Google-Smtp-Source: AKy350bAzjmSgpyLbDoWJqYCiQMSbW3oX0HzyghHRuS2n2OYC8UNZufM6uQ7WYGCIeBojTQSERy+Ew==
X-Received: by 2002:a17:902:ced0:b0:19e:7a2c:78a7 with SMTP id d16-20020a170902ced000b0019e7a2c78a7mr15126280plg.57.1679955953194;
        Mon, 27 Mar 2023 15:25:53 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902a3c300b0019ef86c2574sm19651873plb.270.2023.03.27.15.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:25:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] sequencer: beautify subject of reverts of reverts
References: <20230323162234.995465-1-oswald.buddenhagen@gmx.de>
        <210376fb-f830-4883-b576-2936dabc09cc@app.fastmail.com>
Date:   Mon, 27 Mar 2023 15:25:52 -0700
Message-ID: <xmqqa5zxn85r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Thu, Mar 23, 2023, at 17:22, Oswald Buddenhagen wrote:
>> Instead of generating a silly-looking `Revert "Revert "foo""`, make it
>> `Reapply "foo"`.
>
> Nice addition.
>
>     $ echo change >> README.md
>     $ ./bin-wrappers/git add README.md
>     $ ./bin-wrappers/git commit -m 'A change'
>     $ ./bin-wrappers/git revert --no-edit @
>     $ ./bin-wrappers/git revert --no-edit @
>     $ ./bin-wrappers/git log --oneline master..
>     adfce56c6a (HEAD -> reapply) Reapply "A change"
>     395894c2ce Revert "A change"
>     a01e3d6b3d A change
>     058643b69f sequencer: beautify subject of reverts of reverts

I think Oswald saw the end of a thread a few years ago that
discussed a similar idea and the patch is a continuation of that
thread, but what should happen when the re-application turns out to
be bad?

The significance of the act of reverting such a reapplication to the
project would be different from the initial revert (where "yikes,
the change introduces a regression---let's revert to the state
before the change, regroup, and see what we should do" was the
motivation).  Somebody thought that it now was OK to reintroduce the
change, presumably because the code paths around it now have become
ready for it and the phrase "Reapply" makes a perfect sense to
describe it ("Revert an earlier revert" is not too bad, either,
though).  But then it turns out it still was a bad idea.  Should we
say

    Revert Reapply "A change"

Next time somebody thinks the code paths around there are finally
ready, do they do

    Reapply Reapply "A change"

or something else?  That may be shorter, but even more cryptic than
'Revert Revert Revert Revert "A change"'---"Revert^4 "A change"" the
other thread proposed start to look less horrible.  So, I dunno.
