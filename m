Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66564C61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbjALSUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 13:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbjALSTA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 13:19:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A8DA440
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 09:53:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 18so27889343edw.7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=351brHAb4+WrhzBjoIXWf6jMX/ZYo5+1Exwf0qHhIoU=;
        b=N1dAJFaYk/oJSuT3InLJrnRHUNEqJDcGQNkj4icI4FWYtZ6N6C8un2ylAF6uejiYb5
         +FnNFMoL95oAcnPuzXM1Mb/Gub9QT0V2a6sYCDfFplWKDe8dAZ1Rep+nQNuIN+VRlpMD
         Il7B19srag53p5/37DzT0h2muvDlBZhuqzL8Wt3zWGjG935X0hEizEm5hZrMWmHRY/OO
         jR412eUuNVwU9ZUvtbQDqa0z4lCrA3XvqZqCfbnGCOhYKh7Qg9mHW5bDbKITwbFyQqau
         2ps79QlBnQC9LfAzBNSk2LpSELr3uCrv+UKhLxRh45bF9eEyTOL+mvmAcFTCeYbTCA+O
         64bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=351brHAb4+WrhzBjoIXWf6jMX/ZYo5+1Exwf0qHhIoU=;
        b=h7CfE870clvRrL7B9NCPIZWGGjTaU8E9+vWxHXMd4WhrD1Ye5MftuXz0ZesIRu/hW8
         AATUC2sQ/wCdk/JaI8g6NC++uXiqY/vwrB5FF0A6KVBipb618sTv/iAR6NLXn1Su5Y2k
         oJ5/IvssU2ycIQ9fIgElWUmQDJrNjAgLEPi653KTeSo5h4sO3oJscrwcHZmjsxa6RCJk
         0xMcrnzDqa8g09f/jp/BRGgfcgRUXlnUi1suF+uA3YVUUocVTWLOOqO15S/ktHId/IUI
         x/QVBkvhXFy2F7TPYwaXaGMcEv40skrrdkmgpuKkJSFY8r0yuCiwXjV2wVY74z2wycbg
         Vcyw==
X-Gm-Message-State: AFqh2kp/tJLZrIOlnID7zQu3jpUv1BEZcPR1vydPzDKJ2szTv8lUEGkP
        gPzOpnA8XDbfqAtRJG1fEQ0=
X-Google-Smtp-Source: AMrXdXvc/xt/LPsWSVjIPN76b6bf1l6redFH5TRUxStj/5SW+mccsmDVBKqjY+hwrKiuf1SxcifLXw==
X-Received: by 2002:a05:6402:450c:b0:47c:445b:b4f with SMTP id ez12-20020a056402450c00b0047c445b0b4fmr67050031edb.32.1673546011802;
        Thu, 12 Jan 2023 09:53:31 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b6-20020aa7d486000000b0048447efe3fcsm7421722edr.84.2023.01.12.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 09:53:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pG1la-000Ngz-1u;
        Thu, 12 Jan 2023 18:53:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: git grep behave oddly with alternatives
Date:   Thu, 12 Jan 2023 18:52:22 +0100
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
 <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
 <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
 <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
 <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
Message-ID: <230112.86mt6nzlk5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Ren=C3=A9 Scharfe wrote:

> Am 11.01.23 um 19:56 schrieb Jeff King:
>> On Sun, Jan 08, 2023 at 01:42:04AM +0100, Ren=C3=A9 Scharfe wrote:
> [...]
>>> Which begs the question: Isn't that a problem for the platforms that
>>> still have to use NO_REGEX?  Shouldn't we fix compat/regex?
>>
>> I'm not sure. I always assumed our fallback was similar-ish to what was
>> in glibc and was thus pretty featureful, but that may not be true (it
>> actually comes from gawk). It looks like we just didn't pull over the
>> multi-byte parts in a997bf423d (compat/regex: get the gawk regex engine
>> to compile within git, 2010-08-17).
>
> GAWK removed NO_MBSUPPORT, NO_MBSUPPORT and mbsupport.h in the meantime.
> I guess that means they support multi-byte characters everywhere now.
>
> Ren=C3=A9

Note that GAWK doesn't really have its own regex engine, their is mostly
glibc.git's, which they've ported over to their codebase with some
difficulty over the years (it not being in gnulib, like most such shared
GNU libraries).

Ours is then an old copy of gawk.git's, which I attempted to update a
few years back, but that patch series ran into some issues I can't
remember, so we still have that very old version.
