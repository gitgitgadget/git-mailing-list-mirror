Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C394CECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 05:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJ1Fcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 01:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJ1Fcc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 01:32:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D2A1AC1F5
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 22:32:31 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r18so3896221pgr.12
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 22:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htVoqhbVh1wEGLaflyFEOfskf9CGAI4Oqt3DMPZ1SM4=;
        b=FUOfbWQy62+PYtBLjZQLFZ7GngbGkL3Aqo7UC0PoERqiTGz2kC1zm6nj0Hq/q45ZN7
         7jKkdrAU6mrfGyEDdojAKMKLdzP6x9JQSEEc9vWnjLeMy/SXokk3aKnSW2B9L0ZO/eNm
         xq61DE29A7ExDPLMbDWp/7YC0zDoLWhm9jEyvzhCOyIyEIrGSz3/GeLvY8hEx4/TS3k2
         UZ2mLCz6eD9nTAuF/Ddrb2bHNR0Ci8Glm3/+En6A7AlLKZvuln7Ifo6dnWBB7Jt8Dn5F
         sTpMqj4WVFq++8lx0cVaDSkLWWBZzjSE62cjG6tQjbQl7yC9Fs5jMxmAx7j8gODONtlw
         amiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htVoqhbVh1wEGLaflyFEOfskf9CGAI4Oqt3DMPZ1SM4=;
        b=r/tko5+3Y/GynPmBbuvo2N/jmxYwDxIhSGHOdtQuuzZUnlRpVf7X+BESKGzP182nEM
         7eOpFj/UJGfSAXrY7GC7wd1it7I4Xmjpp8STVc8Y3Wx8sH3qQT29R71seAB5uY1hRYxp
         NqGgOtP0Y3ghbSHbAgWiLhjJ5u1J8hTlFDJTuXtjWbAP5ZqneU0w6ZcPno0kZWvnZa+W
         fiVIRFVfRwNkrfklBEjP38cP9t23oaZF0vcJL17RPw1G+3cmdM5W/T6Ze9a8rAMvxPQ5
         Yt6uBzAWeKtvYkVKZGM+lMca+u2PaNT/hpaiCNC5ttcYcruE1PMNQrO/lfsYOZvXICSE
         GcGw==
X-Gm-Message-State: ACrzQf3ydoI9OG8vETrKupTCF4fYoj4FbNuT5qjTK5uvmpZetVpTm04Y
        TinC5umDuUZ8fHLN5GPScLo=
X-Google-Smtp-Source: AMsMyM5d4Tqt7CTQbAseDJ8Fwqf+x/tcJwcyEUCR1wuF2N4Ciman+Btjq80jcp2T8w8r5Z0dg5jLPw==
X-Received: by 2002:a63:1a4c:0:b0:43b:e648:a7a4 with SMTP id a12-20020a631a4c000000b0043be648a7a4mr45608620pgm.7.1666935150752;
        Thu, 27 Oct 2022 22:32:30 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b00172973d3cd9sm2102933plb.55.2022.10.27.22.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 22:32:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai <johncai86@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
        <20221025224224.2352979-1-gitster@pobox.com>
        <20221025224224.2352979-5-gitster@pobox.com>
        <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
        <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
        <221026.8635badbz5.gmgdl@evledraar.gmail.com>
        <08A5BC44-24D9-4C8F-A61A-41983A13553A@gmail.com>
        <221028.86k04k8wbk.gmgdl@evledraar.gmail.com>
Date:   Thu, 27 Oct 2022 22:32:30 -0700
In-Reply-To: <221028.86k04k8wbk.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 28 Oct 2022 05:11:07 +0200")
Message-ID: <xmqqk04kjyxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> First, for the purposes of this thread I think Jeff and I are far off
> into the weeds here :)

It is good to clearly separate where we would want to draw the line
for this round, to get the already-worked-on-and-immediately-available
improvement going, while we envision a future direction for the longer
term.

> But if we go for that: I think in this case & most I can think of
> generating the code from the docs is better (as that rough POC I had
> showed), because:
>
>  - You just need a shellscript to scrape the docs to make a *.c or *.h,
>    whereas you'd need a C compiler to make the docs if it's the other
>    way around. But more importantly:
>
>  - The docs are way easier to scrape with some sed/awk/grep/whatever
>    few-liner than to scrape C code for generating docs. E.g. see
>    config-list.h.

Scraping docs is easier because we do not have to choose from
multiple choices that are all reasonable ;-).  Either way, the
source material needs some discipline to keep it scrapable (e.g. to
keep the doc scrapable, you'd probably keep each entry a single
line, or a fixed format like "<token>::" followed by "^I(<token>) "
followed by description.  Nothing forbids us from giving developers
a similar rule to keep each entry in FOR_EACH_MSG_ID() macro easier
to scrape, so it is about the same difficulty going either way.

But if you choose to make the code the source of truth, you'd have
to see if it makes more sense to "compile and run" instead of
scraping.  That's another thing to consider and choose from, which
makes it harder ;-)

> But mainly it helps to have a use-case, replacing the linter script with
> e.g. the *.sh I demo'd might be a marginal improvement. But e.g. "git
> help -c" uses one of those generated files (config-list.h), and actually
> does something useful ...

Yes, I've shown how N_("explanation of the error") may fit into the
existing scheme in a separate message upthread.  If we go from code
to doc, it would be a reasonable starting point.

Whichever way the aout-generation goes, we'd complicate the build
dependency graph, which is a downside.  Another is that third-party
consumers of docs now need to generate some docs from the source,
which may be additional burden for them.

> Is there a good use-case for the fsck data like that? I'd think that
> we'd want to make sure the docs are in sync with the code, as in we're
> not adding new warnings/errors etc. without documenting them. But beyond
> that maybe not much, and people would just run "git help fsck" to get
> the list of variables..

"git help fsck-error-codes" that does not have a pre-generated
documentation (instead we'd just dump the N_("explanation") to the
output) is certainly tempting.  I am not sure if it would fly well.
When was the last time you saw a manpage that says "run this command
and view its output for the most up-to-date list" ;-)?

