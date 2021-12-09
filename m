Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4001C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 00:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhLIAMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 19:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbhLIAMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 19:12:21 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC666C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 16:08:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c6-20020aa781c6000000b004a4fcdf1d6dso2497120pfn.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 16:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/hfAWkLT9CdwpDkSWeranMLVQzaknKE9oG9s4SDJ1d4=;
        b=VpPsTEKAPo8oDDCB/BKBLIkc8OnrD9ms5sh4UA6jyrdopDwYPZCRojjGWmHMIQpmeP
         pWAP8M93eGvaLUYcAVBk1XB7WVbf2k7C9VIptRwZn8WLRW6ffhk0iPDEpg0ECPufDc5V
         m6VcsZvJWrH6s1a52V3qoSnPsn1ySw0h/8x+/v2EGxJQ7oJSMfBhxhYYVMXOvO7TqDkS
         VzW+jN7Ti1dr+IIa6JOeX5fK0AFKzUQvPTkUwauCScPRbeVGPge4wtGXjO7COaGnEs5v
         QRqJM45d/MvFHP40iiPtI6PzRz8vqXBYkxSYIykzioeU97OfgtJ1j26bcUt57xko144Q
         XsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/hfAWkLT9CdwpDkSWeranMLVQzaknKE9oG9s4SDJ1d4=;
        b=bF6w3gXo/MgMfAdNtfrhGrNH/56gwEwYPVqDRnU6W+b4ZhJJB2bI03VaEQRCXWNCFp
         r5c+9myED/jv9Kd8qn/Iua/M9jjhN9GztWlP1CntZDaVUJOccyeKFYnNyKew/0gFX1T8
         BDZ25Bng7cFJ5URTsc/xgLXlaZMZsiGX/nyTGJrmin9f/zUnncpjFhrqepY49PgzB457
         PcN+KrljEi9QlgPOnt6JWvKHd5Z8oe1joVdVNy8XNYt3iyL/BQ5StTqScIHxKSRjas4d
         69dra5wbwNksdQpYBMgjhFZgWjw+VKr1TS+kXqa3OPkT5wm1BgV+53wfQEJOUEJnWtsB
         +4yw==
X-Gm-Message-State: AOAM531NmVX2QB4rFlJZra4IhI7z+RJtL4SNa6BHmxVGnof+9K1i09VT
        ZOzXots6wYc+CM6/HzuYIey84vkVk6LCnw==
X-Google-Smtp-Source: ABdhPJyLWZ14onecNe/LqobhpEDVeeXyCjy4e3ngUcniLcALtHVKEjX+pUue059viH8nWO6Pqf9O64wyc2b0hw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c947:b0:142:13f9:3444 with SMTP
 id i7-20020a170902c94700b0014213f93444mr63664196pla.82.1639008528034; Wed, 08
 Dec 2021 16:08:48 -0800 (PST)
Date:   Wed, 08 Dec 2021 16:08:46 -0800
In-Reply-To: <kl6lr1amac23.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lo85qabch.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <kl6lr1amac23.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, emilyshaffer@google.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> We print ref_string, which is a strbuf. This causes t/t3200-branch.sh to
> segfault on my mac + clang, but inconsistently! With -O2, it doesn't
> always segfault, but the wrong memory is read:
>
>   Branch 'my3' set up to track remote branch local from 'Branch '%s' set up to track remote branch %s from '%s'.'.

I forgot to mention this earlier but in this example, the test *passes*
even though the stderr message is obviously wrong. I don't see any
coverage of the help message in t3200, which is a bit worrying to me.

After this series is done, is it worth adding test coverage of the help
message?
