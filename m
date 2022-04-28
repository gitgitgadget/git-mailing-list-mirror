Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78987C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 20:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351775AbiD1U0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiD1U0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 16:26:10 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99692A7770
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:22:54 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id l6so286691uar.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yapTIGMDmtpK/oY9BmEcshLu1zMsJSL3c6NVNq3SLq4=;
        b=S5OJO0u6MJBCmwS6JlLgEpChDY1Ue4rUuVaAo2mtqUYVVT1gRhMi+FhnTOnZrCOEi5
         suuMs1cTbIAy1IRrgD+yRYf1TyUGXb1LiG3p2uKnr6HcsLHMYEyNuptg4buIdYZiIS8m
         1QxPleNgzMijCHZf89nxo8QbKdgE41K/nhVsPkDo1m0LzEqPyNoB04Af0/zoYmtl+M0e
         /vDU2DFGaiSMgognmKoaWZpCGlCQLVWzdVOpLhRNC40QcA3nTiOPGOxiamXZ6OXQY+w+
         gbiCDaixlf4Xh9EMvvlUMOLWh977rfbHDRv7jF95coiAor+T6KPrwgcdtc+OYoR/5tsS
         bs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yapTIGMDmtpK/oY9BmEcshLu1zMsJSL3c6NVNq3SLq4=;
        b=3AecHHcl1SUrxsbxsE3tRcrZxJciWjL/QRIPhFckzohUSCXyyI07HzEX08xTs3dK50
         KtzIdkp12TSZBhmfnJHEDdRUYwdUU9trh2tmZVpfvMD6U/b9BGYhzuF+yvh7eH7T3y0G
         1jyCT6LjW7JkE+XTx/UPVkFjc7vxg2oOp1lwmCOXbJaXzYoBVmpYvEKxFbKc+xaKXlIE
         E5iR2AVBDRmnRVJwFbwe23nqUJoX71UR8VPsf0BL28yYc7p+ooXkyMdRKkxjYsZdKNSI
         f6oySY7/MJZnXHIvlKNT/aktasSMnof2dypc+uXIonkYmHdrHEG6jM1iZIlwFtNPTkcu
         RukA==
X-Gm-Message-State: AOAM533sFuPw/CQlpNRZbHBh982lRuQFt5k1rySDlHZU62hnmNBVcomZ
        +pOM2DwuhmvCXgHXz7OhCcj+vpjYmnJBXza4S85g75ilXHY=
X-Google-Smtp-Source: ABdhPJwlk1HymsolWAhSzlieJj8EWsKfUY4SkTa55VY8xVm15ojbSt6cw9e8gVNKStz7Kyh0V0FhZGRY5WLC8NXWYME=
X-Received: by 2002:ab0:654e:0:b0:360:303f:46c7 with SMTP id
 x14-20020ab0654e000000b00360303f46c7mr11387022uap.6.1651177373666; Thu, 28
 Apr 2022 13:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220428033544.68188-1-carenas@gmail.com> <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g> <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com>
In-Reply-To: <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 28 Apr 2022 13:22:42 -0700
Message-ID: <CAPUEsph+p-fD8vMOMU4Djkc8cFUmm=9JVFdgaxkQ4-CpKZgnCA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
To:     rsbecker@nexbridge.com
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2022 at 12:53 PM <rsbecker@nexbridge.com> wrote:
> /etc/sudoers is not standard although usual. This path should come from a knob somewhere. We can't run this test on our x86 system anyway - no access to root or sudo even though it is installed.

correct and note that the test would succeed if the file doesn't exist
because what we are really interested on, is to make sure that sudo
won't mess with our path when invoking git, and if there is a chance
it would (because that setting is enabled in a different file for
example) then we will just skip these tests.

Obviously the target I had in mind when I built this test was my own
workstation and our public CI, but feel free to provide a fixup that
would also make it work for your private runs if you are interested in
also running this test.

> Also, /etc/sudoers is typically secured 0600 so the grep will fail even if is_root passes

It won't, because it is running with sudo ;).  note that as stated in
the commit message, this requires a fairly open sudo setup (like the
one github provides with their actions).

> - and I'm worried about the portability of is_root, which is mostly Linux.

I actually made sure that is_root was posix shell compatible, but got
a little carried away when refactoring it to accomodate for reuse;
eitherway it is gone in v3.

Carlo
