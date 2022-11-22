Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919BBC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiKVXuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiKVXuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:50:39 -0500
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495AA90394
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:50:38 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id q1so15355169pgl.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7x62AW3SyyGLJHOIIdWqCjwAzdROi/acZkycTfPTmgc=;
        b=5/nJ4GRbNuZNMC/Tofjd7DNa2YcX9f4o+6CYAphA4iYBYrcDWR9jjeqhYrwDJRfkJN
         i9wqjAiDtvBULkTPN/c52yZi+DX7BrhhPwqq+E87SfpAqHSGfWrz2vQ2oALRW7O12E5c
         cYgMoFwxrhpRFKko2hOUpQEMq1OTUTI7Q9Kqgsi62Mia3uIrk3H1alEQkBu01h7CEcZ9
         xImkGO9CTBRmPzLc1RJLFG1qzZwsNKms+kkpkquf7+sd3ddQ8R1dopj8tylPpnEf4fri
         qDjM0Sme1YLfNbeD6zGMX3xUt3wFf8ZQHrrj2QIzYgeabcU3N+UHPJgdvCSXOCYYnWXf
         BSDg==
X-Gm-Message-State: ANoB5plrRdl0B6d1OOM/juZOg2oejNwN9H/EHCNIqyelMfvkemlzpTNc
        GRY1fku7bRc+oRLmDlUdt+k3n672gvSIR20rKYk=
X-Google-Smtp-Source: AA0mqf7GIVYSVLCIzIhWP8lCskwaOJxz81MlkFC8+nY7dhK59mlI1lgQZT83YdWfObRouMR/tabqMZP6mRunMJ475HA=
X-Received: by 2002:a63:f048:0:b0:477:5e23:f9d1 with SMTP id
 s8-20020a63f048000000b004775e23f9d1mr5113101pgj.268.1669161037705; Tue, 22
 Nov 2022 15:50:37 -0800 (PST)
MIME-Version: 1.0
References: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
 <87v8n6o9du.fsf@igel.home>
In-Reply-To: <87v8n6o9du.fsf@igel.home>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 18:50:26 -0500
Message-ID: <CAPig+cRchF_6t-B-cZHLHAH_E6qNmapTezSfCj9AZ8cfWNzivw@mail.gmail.com>
Subject: Re: chainlink.pl /proc/cpuinfo regexp fails on s390x
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Andreas Hasenack <andreas@canonical.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 6:37 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Nov 22 2022, Andreas Hasenack wrote:
> > /^processor[\s\d]*:/
> > or something else.
>
> Something else.
>
> $ getconf _NPROCESSORS_ONLN

Yes, that works too and was (I'm pretty sure) considered during
development. The reason /proc/cpu was chosen over `getconf` was that
opening & reading /proc/cpu should be faster since it doesn't involve
spawning a process. If we did use `getconf`, we'd have to be careful
to degrade gracefully if `getconf` isn't available or if the
configuration parameter (i.e. "_NPROCESSORS_ONLN") isn't known on the
platform.

That said, the submitted patch[1] is probably good enough for now,
especially since there's talk about possibly removing this code
entirely.

[1]: https://lore.kernel.org/git/pull.1385.git.git.1669148861635.gitgitgadget@gmail.com/
