Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4877C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 21:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbhLAVJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhLAVJO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 16:09:14 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75837C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 13:05:53 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id d10so34423171ybn.0
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 13:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQnwhXdEDPBFN/KsHyJOk2PjAi8gMj/RWGZA3oz7dZ8=;
        b=lCdThUg4ZrOk4I68jr6eUVQkAq6nD4dLl0tcmxwKvESIN94+K+lQP8plDSRQtvqe2y
         klQhW7p+4iI7Kgpn00D2u3wVE617UfVLFaQ34HLlBIpHOyCVPu7IhBCM65LNeUHDtsP+
         0rk4jlOngLj1Aw2W2dJuRDUBYrR7X1bSjp1xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQnwhXdEDPBFN/KsHyJOk2PjAi8gMj/RWGZA3oz7dZ8=;
        b=eBU/HqdkFEJMdiA7FbqNz5VHHfTxO+8YMcR6DtuXEOhO70OZmbMG+O6cMdv6/s9T3D
         2bEWviM7iZ8N8CK9DZDL39czfXdUbLJhrfE6UBgtSoe0SteFPt/tj0CITxgap6ol9Kt2
         YlrIlK4ZSn0GOg3F3H1lWtfhiOkWfA2djXIsUPox5yon/MHhGDaRhTJBhDxjl23a2V69
         pwrRvXGXZpGgovrRedzizRWIByy13j1WW/9MOMO4XX/D7XHVKiBSrTxtIAiP1O75ZcsA
         co0Eek+SAWLPsxPKxTNxlcz6fDJKZXtVvGd50irpb74bMGqmRUcAcjVhhCVNQJsJI6M1
         BHqQ==
X-Gm-Message-State: AOAM53123JtzrJaNbv8OnlcqUjduV1mHxzCWr0dq6iTaqgtSYuZBNp4X
        OrrCYGBgyAeh1C1Xtbxur473Dra/EZXW246JpTW40xmbD5xqwA==
X-Google-Smtp-Source: ABdhPJySQfe077nHajg3Yie1LX25GA1amnE8A+8Gcbp+PeEJR8jUXyJxLoql3X73EJpZ/a+Naz+ww4NkR/EJqQB/AUE=
X-Received: by 2002:a05:6902:1022:: with SMTP id x2mr10970030ybt.391.1638392752557;
 Wed, 01 Dec 2021 13:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20211120150401.254408-1-fs@gigacodes.de> <20211201085315.576865-1-fs@gigacodes.de>
In-Reply-To: <20211201085315.576865-1-fs@gigacodes.de>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Wed, 1 Dec 2021 21:05:26 +0000
Message-ID: <CA+kUOa=Yh0NdoKWEQbYP4YXv8JmMHkjrKREAj-5YAA_JBTqEbQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] test-lib: improve missing prereq handling
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Dec 2021 at 08:53, Fabian Stelzer <fs@gigacodes.de> wrote:
>
> The ssh signing feature was breaking tests when the broken openssh-8.7
> was used. We have now fixed that by checking for this exact case in the
> GPGSSH prereq and I will improve that check further in a future patch.
> However we are now in a situation where a broken openssh in the future
> will result in successfull tests but not a working git build afterwards

Nit, purely because I just spotted it: "successfull" should be "successful".

> (either not compiling in the expected feature or like in the ssh case
> runtime failures) resulting in a false sense of security in the tests.
> This patches try to improve this situation by showing which prereqs
> failed in the test summary and by adding an environment variable to
> enforce certain prereqs to succeed or abort the test otherwise.

I've not managed to keep up with the ongoing development of this
function, but I've just tested a recent version (specifically, from
Junio's tree, 1ade7d2334 (test-lib: make BAIL_OUT() work in tests and
prereq, 2021-11-20)). This looks like it would have been fantastically
useful when I was first taking over the maintainership of Git for
Cygwin, and I'm looking forward to having the extra confidence of my
builds and tests after I can add GIT_TEST_REQUIRE_PREREQ to my build
scripts.

Thank you!
