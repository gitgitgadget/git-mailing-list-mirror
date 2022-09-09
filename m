Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C0ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 05:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIIFXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 01:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIIFXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 01:23:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173510F8F5
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 22:23:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b21so769612plz.7
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 22:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=yy5T3MDf0W/75zhRH2CwDWtAOLnBWYAEm/qwphXD6Go=;
        b=brP6Mg6Nx63lvK31CsFIJuvqj3J4TS87NBP1VpCVbW4AgJtRhjGDL85K2IMcjmxbz5
         C4UHiQ2X8JSzeHzc0UN4u90saE0zWb5p8bsYWHpy6YB2KouG3EH86ltYnWQlY4OKbKB7
         BpuTo/S3dO7IcJjqecpGV8Cr8PosCwnRgouaZHRAcmkJSAL4E3+MpH3R0bwLwSlp2vKt
         y52pJFLkmM/JiOsrXOVmDuJX/mTDkyA/bXXnemUcgAAw29QNQo+13FSihE95xS/sum5n
         dHE6ri0X1TUnH8KxqnShB3+xD4N233Ip/ESmre6COM1UKCtB0AJnwoE6PtalFjraXHuG
         7eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=yy5T3MDf0W/75zhRH2CwDWtAOLnBWYAEm/qwphXD6Go=;
        b=evQsVxUshZPoWg/n0WjlcI4xJPHgivboOxEg+w9+RFryOu3b3Lc1RPBOvMyvaON2bx
         h/5dXEyjb1Hfri6cCws8EqwPAPKHb5UCen0M6ge5iOBTVo2A55SpN3NcimUE2DRvBOWU
         D39I8R7haQhb20bLRngv8CJor31uh7WMcqQtoZQ/2rGPplMDkmMTAWysVwr345Szp/Ig
         x50eA8b9x1KE2aQjhcLSOOYI5Im79oQQ+QfkK80gqn5feXN9j3NWXEdu/XUXHIq9WUyT
         lxXK2nimuunAvzuqT4oxRPJrtD9aaFgiwaXDT9hX3T+ezgqS168yTt0FQ97LnfsRftFn
         9OuA==
X-Gm-Message-State: ACgBeo2CLo2PGCS139+oU7tspWFErxEOCpzd3DNZhOxVNjinftJQMV+W
        Grvexo4RIUtgsWaV5NXDSonxIyC6W5A=
X-Google-Smtp-Source: AA6agR45f2Taz+R/6f8MKdmnazNDX5dOODjzl1jugiL5vnvLmaRx1juCcHANb/mFbt9LQzSAZxT0Sw==
X-Received: by 2002:a17:90b:35cf:b0:202:6f3d:53a7 with SMTP id nb15-20020a17090b35cf00b002026f3d53a7mr5926586pjb.63.1662701024053;
        Thu, 08 Sep 2022 22:23:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u64-20020a626043000000b005366696b735sm610457pfb.77.2022.09.08.22.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 22:23:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lana Deere <lana.deere@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: add branch.*.merge to default ref-prefix
 extension
References: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
        <YxpB0dbFTKp5L94k@coredump.intra.peff.net>
        <xmqq1qslpprv.fsf@gitster.g> <xmqqtu5hoamx.fsf@gitster.g>
        <YxqiJW4cSp4cBR22@coredump.intra.peff.net>
Date:   Thu, 08 Sep 2022 22:23:43 -0700
In-Reply-To: <YxqiJW4cSp4cBR22@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 8 Sep 2022 22:17:09 -0400")
Message-ID: <xmqqv8pxm880.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The code in fetch's add_merge_config() that does branch_merge_matches()
> comes from 85682c1903 (Correct handling of branch.$name.merge in
> builtin-fetch, 2007-09-18), but I don't see any indication there that
> non-qualified refs were intended.
>
> So I could either way: non-qualified refs in branch.*.merge has always
> worked, and we should continue to support it. Or it was never intended
> to work, and we are not obligated to continue supporting random things.

Yeah, it looks like it was working by accident.  I do not care too
deeply about folks who edit their configuration files to futz with
branch.<name>.merge, and "checkout -t -b" and "branch -t" commands
have been recording only full refs, so it is tempting to tighten
branch_merge_matches() to only allow full refname.  The only thing
that makes me hesitate to start writing code to do so is that some
third-party tools might have taken advantage of the fact that using
a branch-name was "working" by accident.

> I do think "continue supporting" would probably just mean using
> expand_ref_prefix() here as you suggest. It does increase the size of
> our request, and the work the server has to do when it matches the
> prefixes (which is inherently linear on the number of prefixes we give
> it).

Giving extra garbage to the set of prefixes does not hurt the
correctness, but we didn't add the extra prefix for
branch.<name>.merge before this fix, so not using
expand_ref_prefix() is not breaking anybody who weren't broken
before.  So I think it may be OK to support only the full refs at
first.  It's just that folks who didn't have full refname as the
value is not helped by our fix.

If enough folks complain that they have handcrafted (or prepared by
third-party tools) branch.<name>.merge that is not a full refname,
we could switch to expand_ref_prefix() and as long as the refnames
on the remote side is not ambiguous, things will still work
correctly, but I'd prefer to keep it tight until we actually hear
complaints.

Thanks.
