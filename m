Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD11EC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 19:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIGTqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIGTp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 15:45:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BA39F75B
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 12:45:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso10968071pjd.4
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 12:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=mAYDyxkd2dXYQ8GETTcWWngGkSag7yll75SCE+bHG98=;
        b=kgZYYh3OshDneTkM7YclTiHr6lF0fSFY3qMpsWzGmZmoPoit29gtHc4KYwcXfZwOwQ
         ujqaXrDkL5Cwe1FTIpcm6r2TeiQ/zROqdG+cTd1td8RFgoNuCsvKI8Dz7j6hXtOA+Rsr
         ydMcdr3mlDVhcO047hPVTZVwH0bhT9IBRxenosjWtLGSxxrynbAA68o7zc+QYa+02Y7S
         Pd21HdAWu4nJ93hPadCHl91rvXEBYYt6nVvQfqg6+9MgCx6xJTyT9F4KrZSp6zHiHg3Y
         UAarwYmQ8bfcdmAwNBGgcwOHApSWVxu+blDy/dBJjQ6wHaH+p8A6nTUUmrvxaxpHB27u
         EvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mAYDyxkd2dXYQ8GETTcWWngGkSag7yll75SCE+bHG98=;
        b=kcV7WoG7enMcySK/VjzVD3Tpd9HhDawr1CJE+KUNfhJPaOotIOWPwtAUBpjJQvvx82
         335ItSSmfV9gEAYE1sxHdXBSAB7mMfBbAd1daVHDC3y2z8bc7pjejkmqHhHMMkOW36ZO
         wYzY20tHFo0aK7OuZgnsPBJtUg/PKbTFfpMYIx6xRRbujPPBO+FNRocXIDYLyGsJHY/e
         oh3XE/sIAn928rotYjRGLGygMksdZmrDr7i1QV+gP3R40QHllUHwrKdpeYaWd2BD6nH3
         FpBOSGjH6CPw/ozpm2TtqZFpmt2Usaj7PaCmR1RQgFyX85SCGIL4L02yLSwe9HaZcbOd
         g5qQ==
X-Gm-Message-State: ACgBeo0zuK8fBBV0A9WlhP4Dsh0j0rquRCbgZXTwEltW3/gvpBhGBhSZ
        mGBzQ8x78y/mpr08S5gv3/Q=
X-Google-Smtp-Source: AA6agR5Hhk76RVammkxTKZRRqqli4pS3PCiWnfPI0uXVq1s+/RzG/vKfykrwitc+eEZNsFo+8tfwBQ==
X-Received: by 2002:a17:903:248:b0:172:7520:db07 with SMTP id j8-20020a170903024800b001727520db07mr5102852plh.76.1662579957412;
        Wed, 07 Sep 2022 12:45:57 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b0015e8d4eb26esm12822642plh.184.2022.09.07.12.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 12:45:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] tests: replace mingw_test_cmp with a helper in C
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
        <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
        <1f5366f137967cbec30041b40eedd86ce5f6e953.1662469859.git.gitgitgadget@gmail.com>
        <220907.86v8pzl6jz.gmgdl@evledraar.gmail.com>
        <220907.86r10nl63s.gmgdl@evledraar.gmail.com>
Date:   Wed, 07 Sep 2022 12:45:56 -0700
In-Reply-To: <220907.86r10nl63s.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 07 Sep 2022 14:24:26 +0200")
Message-ID: <xmqqillzt1cb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But I think that re-raises the point René had in:
> https://lore.kernel.org/git/b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de/

As the primary point of no-index mode was to expose fancy options
"git diff" has to comparisons of files outside version control,
without having to go through the trouble of upstreaming changes to
GNU diff, I do think "--ignore-cr-at-eol" should work fine with it,
and René's idea sounds like the best implementation for the
test-text-cmp helper command.

Thanks.
