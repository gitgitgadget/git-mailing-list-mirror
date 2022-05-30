Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22178C433F5
	for <git@archiver.kernel.org>; Mon, 30 May 2022 16:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiE3QJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiE3QJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 12:09:49 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9116A413
        for <git@vger.kernel.org>; Mon, 30 May 2022 09:09:48 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id v19so6823225edd.4
        for <git@vger.kernel.org>; Mon, 30 May 2022 09:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IC4kxt5T/kxsRdA8mKPLAsDtN9CofqrucGmm6ctLDsk=;
        b=oSAljiRYsSD8tWwEr28DyN3b2U0fMqXOw2bfc7BQ3zJkvzstlbHgYByDlSn8BMxPbS
         zCFGki7aqbVEU1hUh+aHl4vRQrdu79aCyjSSx38tV6kPUiCCDSHEHnAViD6bqkInuVUE
         lej+Utz92erbqbafeeO5JAv2jDTaHPwRQLdh+CEeWet4uOQkbXGawzRM+2cj9qI9LUmS
         uj/hTuZXkHGDwbuduiDWM+cu+wDit/zmexX+ZZ4nwclHUkiIKxfrw96I28zGstdL84mc
         juesqCSWCLP4doHzJ9ROrCQULoEQpemfbpAO7qEdMBbV0g5GlH0d8ZMBph48Lz/rK5xE
         QvcQ==
X-Gm-Message-State: AOAM531iVgfQFnIn59kmFAOLuPyzuFMMZIQwJ5d+eHr/5qJunoly+epi
        sRF8HBjTmiOXanU4NhFOneqyZxkzFvhqNmGyIKE=
X-Google-Smtp-Source: ABdhPJzbOeRfsc5SfjnXlCDK0zv5KQIeZoawWcmcjmpZxjsuJJqwnBe9FNEw9M3cHUNjD+qcxHCLX91hfWDhi0w2ns4=
X-Received: by 2002:a05:6402:40d4:b0:42b:3203:aafe with SMTP id
 z20-20020a05640240d400b0042b3203aafemr50639044edb.376.1653926987437; Mon, 30
 May 2022 09:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com>
In-Reply-To: <9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Mon, 30 May 2022 12:09:35 -0400
Message-ID: <CAPyFy2AETzTCJUtbxS+RmygajrUS5XUkZvF-1FVbJ67t61bJtg@mail.gmail.com>
Subject: Re: Investigating Cirrus CI FreeBSD failures
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Carlo Arenas <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 May 2022 at 20:38, Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi,
>
> I spent a bit of time investigating the Git Cirrus-CI failures on FreeBSD.
> It seems something goes wrong with the Perl installation, as most failures
> are in t9001-send-email.sh, and the error messages are:
>
> ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"

Ah, what happened here is that this is picking up the perl package
built on 12.3 (i.e., the earliest supported FreeBSD 12.x) which added
strerror_l.
https://cgit.freebsd.org/src/commit/?id=d3912bec58d0b82509a0973cae02f156986d88fa

> I know next to nothing about Perl or FreeBSD, but simply changing our image
> to FreeBSD 13.0 makes all failures in t9001 disappear [2]:
>
> ...
> Is this something that we should do ? Or should we stick to FreeBSD 12
> and try to debug this installation problem ?

I expect this could have been addressed also by updating to 12.3.
Cirrus also supports "matrix" so both could be tested.
