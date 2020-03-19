Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636E2C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375B82072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 15:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgCSPWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:22:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35986 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgCSPWU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 11:22:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so2760215wme.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 08:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kWauxPW/VEdX8qGruqLPoTFSEu7KHrMsov+rLFlhzk=;
        b=pkHVowXJBu/Q/JwXSq5THOm6fHmkXPcSZB+cCgit0XrBL8oh+63RCqc9LtkrjnmUrD
         EZVytih1UzXDMOFg91Z7n0WbWvo08178UNf+Djd635+TfHZRLJL5Jmk8pKcnvAVXB1Ls
         HFHTs62ex0D85mmJOAzB8WtOkDxiUWCTZj1KzJcnE6PRkj4dMU3RpFru9HKQVfR6ZNn/
         F4fBi0fsR2eFlkxV3v77a5/dfx8JD4XGt1VaWkYybI6wYxogmwPlcr/XmEcN/7WDuIPE
         yM3rcjw/IGv8EV6oF9l3lEqVW179dT6XzKv9Zm2AfdJ2njkfb45d7zBjMFDHffAmBwkz
         UvwA==
X-Gm-Message-State: ANhLgQ2F2aMGYSPFBJJEkfj0bCovzW7DBYFvBHiL3glVTPw78KlkzErf
        qkobDYAx0rCZkyA6peR1mpX3/DWzfdev28iGmvESHW8V
X-Google-Smtp-Source: ADFU+vtoMuneILMjh8lNAxaSurR46xsuHUlr7tGEPNHkZUKYioUfl0Dwz5ThwYtf1Zabrnmx+ag3YFVwwwhNGZHvjWQ=
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr4389300wme.107.1584631336784;
 Thu, 19 Mar 2020 08:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200314224159.14174-1-me@yadavpratyush.com> <20200317132921.7222-1-me@yadavpratyush.com>
In-Reply-To: <20200317132921.7222-1-me@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Mar 2020 11:22:05 -0400
Message-ID: <CAPig+cQ0YJB25fFaKV2URz39zdS8BwMwwB-a6VJzekkQRLEHpw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] git-gui: reduce Tcl version requirement from 8.6
 to 8.5
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 9:29 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Some MacOS distributions ship with Tcl 8.5. This means we can't use
> TclOO. So, use our homegrown class.tcl instead.
>
> Changes in v2:
> - Add a note _after_ checking if the user agreed to the deletion.
>   Otherwise, if the user denies, two "zombie" notes are left lying
>   around which will never be activated. This means that the chord won't
>   complete and the index won't be unlocked, leading to git-gui becoming
>   frozen.

Thanks. I did some light testing on Mac OS. This re-roll seems to
address the reported problems[1] and allows the new "delete unstaged
file" feature to work on older Tcl. As a fix for the Git 2.25
regression which resulted in git-gui being unable to launch on Mac OS,
this path series seems "good to go".

[1]: https://github.com/prati0100/git-gui/issues/26
