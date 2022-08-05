Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5C1C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 08:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiHEIFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 04:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiHEIFO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 04:05:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E0320
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 01:05:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j8so3625549ejx.9
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=NHbSZknlgVNwAWmbYWeom0kX0WW5OUpj+umAFHN0FiY=;
        b=Bd/Uj4Gu95g80DKZrCZG9iAnXMFaNN640nOis5Z2g1DRU/anb9e5Lssg9A0C9BKqc2
         2ZdrD9Z95szfQuGjmSNGBcXuHG48zlCTPOGBCeGdoZ9idgMB4yd+Z7f0XTo/KufPS7tW
         JHVsiTwqkB1fxemzQjVte8fc1hmAQ423g4kntysppUziLdBJ7WReoLLzBgEsKL+cCU8z
         GqustcScVSo4D+375+X3lC/UQRQD7BKQZwDkVhilarSrkQKggbl7/ooUCfs0szBObVfq
         HVgWCpLkUd/UCOaFnKHoF51cZkXaif61JX8zOpYGBOo253pb7fahuIxjwVdhakgTgMUP
         oQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=NHbSZknlgVNwAWmbYWeom0kX0WW5OUpj+umAFHN0FiY=;
        b=e+BdocgUfzBClEcMOsLmlFdrwvE6LWON406tQwD1NET2eHyVnY3WmPWThxBxIgsezU
         wXiyWPXTPfezgeCOSqNybYxMZwyvv9iD+DOrU9xN6NbQhghbLljS85KFNgX53vh2nZFr
         GbiAIbR289YUpNEqArXisdduF+VX7xrBihxDwDUQYcmEJOxYsXhyM6BZLN6HXAkTDKhX
         CH0d+cis0DXU21UdFnoetw4EakeTIC0bMvY5h/ZiRGp5pABq4MbVQWPtyowfe5Ioml+2
         lZwhsEbPLWIcQk30RSKGap+IoOHR9bpyuOBzsLgGmvXksLq29JynEBjBuLEHDbCEzcyM
         KC/Q==
X-Gm-Message-State: ACgBeo21TJ3p0TxshMQjS+2dzVIFzWUXJ8zjmzI3ZsSMrHRNRjG78FP5
        eQhJFykXlUZx8R08srA84/oXPJJtP03dmw==
X-Google-Smtp-Source: AA6agR7pu8vGLyqkMKQ1OWcO3JiujcYnCTlPdiSDwa7+mCENvk/HRqeq6EQYRnKg75nlhau39rHqQw==
X-Received: by 2002:a17:907:724b:b0:72f:32af:e9cc with SMTP id ds11-20020a170907724b00b0072f32afe9ccmr4367587ejc.308.1659686710724;
        Fri, 05 Aug 2022 01:05:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b00726abf9a32bsm1269903ejc.138.2022.08.05.01.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 01:05:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJsKT-000R0Y-1d;
        Fri, 05 Aug 2022 10:05:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Ilya K <me@0upti.me>, git@vger.kernel.org
Subject: Re: [bug] Segfault in git commit when a hook has a broken shebang
Date:   Fri, 05 Aug 2022 10:04:46 +0200
References: <30015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
 <YuzML2lVGDBIK1uF@danh.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YuzML2lVGDBIK1uF@danh.dev>
Message-ID: <220805.86pmhfru8a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 05 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2022-08-05 08:45:02+0300, Ilya K <me@0upti.me> wrote:
>> Hello! I ran into a weird bug just now that is probably easier to show t=
han
>> explain:
>> =E2=9D=AF git init
>> Initialized empty Git repository in /home/k900/test/.git/
>> =E2=9D=AF echo '#!/usr/bin/oops' > .git/hooks/pre-commit
>> =E2=9D=AF chmod +x .git/hooks/pre-commit
>> =E2=9D=AF touch oops
>> =E2=9D=AF git add oops
>> =E2=9D=AF git commit -a
>> fatal: cannot run .git/hooks/pre-commit: No such file or directory
>> [1] =C2=A0=C2=A0=C2=A024580 segmentation fault (core dumped) =C2=A0git c=
ommit -a
>> This happens consistently with git 2.37.x, and I don't think it happened
>> with git 2.36 or earlier.
>
> This seems to be a side-effect of a082345372, (hook API: fix v2.36.0
> regression: hooks should be connected to a TTY, 2022-06-07)
>
> Since it makes hooks run in "ungroup" manner, hence run-command will
> pass NULL as first argument to notify_start_failure.
>
> This patch seems to fix the crash, however, I think we should remove
> that clause entirely.

Yes, thanks. I'm already working on a patch for this with a test, will
send it in shortly...

