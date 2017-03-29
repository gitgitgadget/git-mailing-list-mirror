Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B2620969
	for <e@80x24.org>; Wed, 29 Mar 2017 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbdC2WAp (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:00:45 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36818 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753717AbdC2WAo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 18:00:44 -0400
Received: by mail-pg0-f44.google.com with SMTP id g2so19227230pge.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fBVRG7QtUr9TEXi48kFJSdVGr3Z4+cTpL9uZrDTnkEE=;
        b=gH7FiSI65vtQnnzA3FxDf4GCxVTzBg8yp/nuKunZnY5mB4zbH5+6SujJ0aeaKUVk0d
         MP51/ENdGYV4S+V/BU5deLXDAuBtGvmC5hXkxHv40lGFOh/lwOAGY00wWW0C7OglrLDk
         jTPKbL5KlgOF9FA65PszpwfvSn6/jbW4GSftimX8KUyuwT/6fWDVS4/UVWA48NTPCDJN
         jY6TZZbV3T5YrlKkaHT/unA6BjYaA07+mkzglXAK0svZzx/Dwjeq93ZV/5mHInNm8VTl
         mM5MKQqkGX78QjRQ4mFsYdfTVl9B7+PqalXAbJ9BVwRcwinKvF05170aoemjFGxKji7F
         Cy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fBVRG7QtUr9TEXi48kFJSdVGr3Z4+cTpL9uZrDTnkEE=;
        b=traW5PpYh6JuORjqjTwzHyu0L1NIMna4BbXRWPttDX2/t07CrdzpNHSuIDHIWIoYxv
         /kiR9J45v2MitKkgtnqfykepFA3NvLGBj9iR18T5pv/LlF/sMe72QMJtNLmYjq+VG71f
         yVNc7JTF8iSAZ3mP8pihVHcnusOzageT0QJZUS9g05kq1Tsg9wIwn7N2e3JttCLm7mRB
         kFD2a5+dR96LMoRe8G8g1EJa3eQB9aKFmrrYEl2fwVg5KgAdc90WOJWyj0UauYZht3PL
         5JUVchm0UwhJ8aF+SxFdhWC22b9sM7CB9tmEZkFkAfqFDX5zta1tmSoHTBWSAL9WIPdG
         FzIQ==
X-Gm-Message-State: AFeK/H2AgzaK+OD3Bx4jlyHy1R4nV64qKbjitFeXC4RIlbEdofhh9MUJnDYhcXntnaGK6jarg8t1YtyfonatOhKo
X-Received: by 10.99.137.66 with SMTP id v63mr2736767pgd.183.1490824842701;
 Wed, 29 Mar 2017 15:00:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Wed, 29 Mar 2017 15:00:42 -0700 (PDT)
In-Reply-To: <20170328234217.GU31294@aiede.mtv.corp.google.com>
References: <20170325003610.15282-1-sbeller@google.com> <20170328230938.9887-1-sbeller@google.com>
 <20170328230938.9887-3-sbeller@google.com> <20170328234217.GU31294@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Mar 2017 15:00:42 -0700
Message-ID: <CAGZ79kbKgkHNjPXusAeoG112WEZZ801suxmcbei8hF7++5m-9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule.c: correctly handle nested submodules in is_submodule_modified
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> sanity check: What does this do for a "2" line indicating a sub-submodule
> that has been renamed that contains an untracked file?  Do we need to
> rely on some other indication to show this as a change?

Oh. :(

In case of 'u' and '2' we need to set DIRTY_SUBMODULE_MODIFIED
additionally. will fix in a reroll.

>
> Enumerating some more cases, since I keep finding myself getting lost:
>
>  - if the HEAD commit of "sub" changes, we show this as " M sub".
>    What should we show if the HEAD commit of "sub/subsub" changes?
>    I think this should be " m".
>
>  - if "sub" is renamed, we show this as "R  sub -> newname".
>    What should we show if "sub/subsub" is renamed?  It is tempting
>    to show this as " m".
>
>  - if "sub" is deleted, we show this as "D  sub". What should we
>    show if "sub/subsub" is deleted? I think this is " m".

All these cases are ' m', which I agree with, as it is a "modification
that cannot be git-add'ed in the superproject".

We might be inclined to later come up with  ' d' for a deleted nested
submodule, but I do not think it is worth the effort.

Thanks,
Stefan
