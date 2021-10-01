Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B92AC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344566135E
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353742AbhJAOfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhJAOfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:35:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8487FC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:33:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x7so34370576edd.6
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jaiMG2cX3BZNm3hnHXe3jPcoCSFmtVwrjGOCOmAa0bY=;
        b=LMUeD4YVjASoURIdx6NPljqeZZddbZH2dYPYZPCwygXpYTR7dhfqrHE79VbbupbvNb
         r3edETmBCcg1i6dqhvVsyLTSNOTTRtMWXxOUGwyGQ19agflwgi+TCECm/thkMokeohso
         SwEeNchXae6WWyqdDehfCJU4Cmavy8H6KVVINahhy25EwipspPNSkVhVQrnPiygBWkTy
         edOSQYqDoMe271D9FyafWnMzY/PN+dzdss4RBEIo0Zi8tWe43LSJqI7KutXBX6psulWv
         /W2aT+d2EpIBDsEiuNLs8X2/rXK2PTr/cV8DaBaNBON9bAMEwCfdwf0k7NWuyZYRYqTM
         4gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jaiMG2cX3BZNm3hnHXe3jPcoCSFmtVwrjGOCOmAa0bY=;
        b=EeoMH0c/fUjm79Ls7RtLD4h+UgtgfSu+q2bMmRhnqNL2HuoLh1pV8FbGAeOcZfI8aT
         qmbULjLBkkh5Jm1uXdOEnQCq8aD2kXU9RK9b8l8BS0JnZ4+sOeybdXHP3AMmCnrHoIrp
         U23F0a9ed33vOZOCq9aqXDh4RybdLEJKYT2KiBgWp+zYYMu8nmlWPNRIy2LOyiOjZpM5
         5eWRfhUt8uvxLDUuDKh2jcVAm9092qqpWEPY5B7YeO2Ej7WPtDNXkae96/n0tHhjQ1mV
         9VtQLrHb7HCx4s/iK5+keBFT5MU22mg504GjLBRoWXoceBlsM8GA3lwInyO00ya25eNY
         kG5g==
X-Gm-Message-State: AOAM531VWTYw9Ukk3r9Mn5KndI5dPHjCPTaHoyBc06vNG1uZ4/UnOLN+
        0HY0CsjX1ipIkN2E0sJSL4wPyp5+ybJ/Pg==
X-Google-Smtp-Source: ABdhPJylZKEvhtSHQi1qXAlQ6EEv4hmBV9RuubLlmYvXuPd2+nmKK8uSJcL4a12qjRws+BHw/UP2Fg==
X-Received: by 2002:a17:906:9501:: with SMTP id u1mr6573623ejx.496.1633098826338;
        Fri, 01 Oct 2021 07:33:46 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k18sm3303709edv.41.2021.10.01.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:33:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/parse-options-cleanup
Date:   Fri, 01 Oct 2021 16:32:26 +0200
References: <xmqqh7e18soj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqh7e18soj.fsf@gitster.g>
Message-ID: <87mtnsrf06.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Junio C Hamano wrote:

> * ab/parse-options-cleanup (2021-09-28) 10 commits
>  - parse-options: change OPT_{SHORT,UNSET} to an enum
>  - parse-options tests: test optname() output
>  - parse-options.[ch]: make opt{bug,name}() "static"
>  - commit-graph: stop using optname()
>  - parse-options.c: move optname() earlier in the file
>  - parse-options.h: make the "flags" in "struct option" an enum
>  - parse-options.c: use exhaustive "case" arms for "enum parse_opt_type"
>  - parse-options.[ch]: consistently use "enum parse_opt_result"
>  - parse-options.[ch]: consistently use "enum parse_opt_flags"
>  - parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
>
>  Random changes to parse-options implementation.
>
>  What's the status of this one?  Meh?

Re-rolled just now at
https://lore.kernel.org/git/cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com/

I could rebase on it being ejected, but I've got some niceties in
parse_options() currently depending on it, and as notedi in the updated
02/11 I think that "enum bitfield" pattern is worth it under
debuggers. So it would be great if it could advance. Thanks!
