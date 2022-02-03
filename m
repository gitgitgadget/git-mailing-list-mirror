Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325CCC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiBCS1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiBCS1p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:27:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E09FC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:27:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so10816122pjt.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/C4riX1ENdqKbH6Hz+zRWkAx+fitv+RuxL0+2OqBj6w=;
        b=n0/vy2vIM5NBm/X9141eYF27AhbCmtK5Qsgk37y6jIy/ofXhTX4JdDHi2lDUeCGEcp
         nr6N6V6u1GlZKCNbE03/Z10F3PIBEFLygUk37lq6PKWakteeBFivbbOwhvrdlLBCTzBS
         YEH+Bdfvr01u+VRFyj3msj7Tvl6o6qTODmjnDssLD1jfX5XZmH9RAT/1Ujqy98sx2QCI
         klS6Y63yPIrqL+co//d/OmCscKE2pZethRNGlWroTPYpQo1h1y11cHAQkiieTi/8RQfw
         wDyHgCNMyk58NQOLCwDldHrbZjRwai6/HSZmqaqnOVv6qj9ExToFpaHVnSgz/b2vkVN4
         dhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/C4riX1ENdqKbH6Hz+zRWkAx+fitv+RuxL0+2OqBj6w=;
        b=qxXPfTKyhdzRr2Wrn0s1G9SXU+0spZSiX+eVl3ytqZ/WB+SHDZmsGnGN4c96UnBMYK
         0uryaJykkL7acRgufiM7Vhz3HN/uRCAoF3D1oHctjgIpkc46S4FChrAn5GlHqJJ7FR5v
         5phwOTR4tMI7mPcalxK2QESTIX6p/YlUlUruTyFmWVpRh90AB4MrMWLfJr97cfBby5Vt
         5QGbEXW09Xi02U47AvLkHWLTQfdoIoC3bWz93BNvWMLARVaj52Nmt+3t3dtIARYms8px
         LUKT64dFhNkXU78R5cp6iEkMI59RqB9086QDWGHJn2HatIoxe5xZ0fhBmD0MpbVEaf6X
         SUUg==
X-Gm-Message-State: AOAM530SyG2gsOsOEhCROwJc/FxbT8CJXAz1JXRUtOU759y3/vD3Lexi
        MbRUuSepAr1BnGCwJQKLTe8=
X-Google-Smtp-Source: ABdhPJx6lazudpx8eeUd6yA3gwXITmCAIYn7evwS74A+m4TB5//qgMzUxq2r4kuIGOQ7ccFZe8fFxQ==
X-Received: by 2002:a17:902:edca:: with SMTP id q10mr36758690plk.21.1643912864614;
        Thu, 03 Feb 2022 10:27:44 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id t15sm10398604pjy.17.2022.02.03.10.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:27:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2] refs.h: make all flags arguments unsigned
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
        <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
        <220201.86ilty9vq2.gmgdl@evledraar.gmail.com>
        <xmqq8ruub35i.fsf@gitster.g>
        <CAFQ2z_Oxq67XO20oG7Tokk48wm5ZzHRR3GDi4PG5wg7FMJ89aA@mail.gmail.com>
        <220203.8635kz6d2o.gmgdl@evledraar.gmail.com>
Date:   Thu, 03 Feb 2022 10:27:43 -0800
In-Reply-To: <220203.8635kz6d2o.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 03 Feb 2022 18:53:55 +0100")
Message-ID: <xmqqo83nvm8w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Yes, enums or not, what I was also pointing out in
> https://lore.kernel.org/git/220201.86ilty9vq2.gmgdl@evledraar.gmail.com/
> is that changing just one logical set of flags at a time would make this
> much easier to review.

Another thing to consider is how to make this play better with other
topics in flight.  Basing a huge single patch on top of 'seen' is a
way to ensure that the patch will never be useful.  There won't be a
good time when such a topic can graduate.  The topic will also have
a hard time keeping up with what new topics add while waiting for
what happen to be in 'seen' today (some of which may even go away
without graduating) all graduate.

Limiting the scope to small and more stable subset of flags that are
in 'master' and does not conflict (e.g. no new bit defined to the
set of flags, no existing bit gets removed, no new callers that use
the bitset introduced) with other topics would incrementally improve
the code base, and makes progress in the sense that it reduces the
remaining work.

> It doesn't matter for the end result as long as we end up with "unsigned
> int" everywhere, but would with enums.

As it won't be an error to assign to what has converted to enum a
value that is in int or unsigned that comes from the part of the
code base that is not yet converted, so it may be OK either way.

Assigning between converted "unsigned" and unconverted "int" may add
unnecessary warnings during transitory period, but I think the story
would be the same for a flag bitset that is conveted into an "enum",
which the compiler happens to make it "unsigned", which was originally
a signed "int".

Thanks.



