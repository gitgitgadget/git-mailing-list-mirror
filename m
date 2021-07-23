Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0EEC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC96C60E93
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhGWH7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbhGWH7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 03:59:36 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A558FC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 01:40:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u25so1084585oiv.5
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxfvRtT0FZ3EkNrFZQgcjcd0iUxQju8oarS2PSvKxm4=;
        b=TWrNNaK3uTfr6HC9qzlB1KJejkmifjOzhhnvECryzTpkv0JAt+AUHBRfy5CUJOl4KW
         I3aqPIcMUCmU7/Hcg9o2RRkMpoKwj/XjPKiSUDaPVxYzFtDayaozL9hSTSOFdQzw3VS2
         re6TVlNfaxQ4r1UUV2uGH/9yAfhigPaHLkZnKgUoGfivwWt4GNmfwqdxhUDsQ4TkmCr0
         qdzJZujQG5q+weB5n40zCTAxcZ26ke5j2euUNC914pfg4InfA1atgOs6A/+Bf0TDuOR1
         NNd2cJclP6okZpWlQMmTiB3fZ0wFY0hGbATqeuAUUjIC8P6bJ5bjhjww16krLLiL4AQF
         kclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxfvRtT0FZ3EkNrFZQgcjcd0iUxQju8oarS2PSvKxm4=;
        b=DsTolHx3ssGMz1MTMpPsr+bmY5Qc+vukkjP9MKYcabpluWQgkDWT3DzEIIFfTWx/rw
         1EuJxSSBkLktKUnlxOi3mwjAaJlnbGxvB5ooPoPhP01b58UOyyL2QgDP28n5do/VzdMz
         nPklbvCpAb1vQvGYLMRJI27ogfJjCzGP6XqTibHCqz2znVZbGZFUdsVLFxJwLpq/X72C
         5JFgPHg+adNukGXxH3eW7ggtnqFDrKRd1TWv2OgLS+epA3JX9xe6i89Y2lU7w0Y+vud3
         Wwztg8fMPNCLP35+oroXRiFfdN1+01Uef9rlYGvO50obKSpgcfBNj2tKDoNntEUZY8ub
         kVfw==
X-Gm-Message-State: AOAM5317qclfIzAWa/W1tEIh27mFBS6DhWBPqlVcvlPPfsMuR8NvAVeZ
        Gtaz0HbcWXZyC+7JBkEwIPwrlQklCzmx+zsBfhA=
X-Google-Smtp-Source: ABdhPJzsgv9eOdlZVuiOJD6NcEL0xn/KWmC57ZXvPTfSW8AAM9MYxVO/g1BIoPq2U1dY5v87WWPvxZsvnI8bWaWA8ko=
X-Received: by 2002:a54:488f:: with SMTP id r15mr2418566oic.130.1627029609106;
 Fri, 23 Jul 2021 01:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
 <YPimnEtNgKD32r2o@camp.crustytoothpaste.net> <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
 <3D8703D8-54E6-4CF0-9E9F-CCAFFAA8914C@gmail.com>
In-Reply-To: <3D8703D8-54E6-4CF0-9E9F-CCAFFAA8914C@gmail.com>
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Fri, 23 Jul 2021 09:39:58 +0100
Message-ID: <CAFSh4UySxQLS10M4XJHyNQ313wuLu1rg2Jnahf-Dk2uxJkw17w@mail.gmail.com>
Subject: Re: Bug: All git operations fail when .git contains a non-existent gitdir
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 9:23 AM Atharva Raykar <raykar.ath@gmail.com> wrote:
> I am not too familiar with this area, and I don't know how feasible it is to
> delay setting up the environment until after looking at the 'ls-remote'
> arguments. At a cursory glance, it looks difficult to do without large
> structural changes to the code.

Understood.  This happened to bite us particularly hard, because the
context where we found it is during a `go mod download` and `go`
swallows the error, attempts something else and then reports that the
something else failed with no indication what the underlying error is.
It took us a while to track down what was going on (see
https://github.com/golang/go/issues/47311).
