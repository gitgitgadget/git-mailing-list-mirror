Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597DBC43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 22:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiGEWyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 18:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGEWyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 18:54:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9A10CF
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 15:54:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id li14so2185986ejb.2
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 15:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TNHbzHPvvqJRlkWQhEyVr7LrjhKmiA1jtHPiybmyUxQ=;
        b=D2Z3uafSk3pygUYxETAUwJbFTr9bS3AP+Ane+gxCjAUzFMuygFIRD+2zlM4JkgfFQ4
         4JdJMbtYsF8jGzDHnTK1/oPjA2nApxlnlhArK+w9maKdgCN5kMfN34L3olU7rmRZ1snD
         KUYzwd/rJ9l4fbmw22FmfKIGix1s6J7j5Ep5EiLJQocPEIpauOOGkmX5gRa8QzdqHhVm
         ayXh+GGcoYxVu83wVK36+v+pzXDTHa5KbVieFoUtX0g7T5U6sPo3am+0kJDKTSeXRRDM
         aYMtjS9tx52Z5nfGE/bbuDWK9hp4B67OTPBkrY2vGHhyaGUvJQs+sKd0hAtEgZiMsXXm
         jB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TNHbzHPvvqJRlkWQhEyVr7LrjhKmiA1jtHPiybmyUxQ=;
        b=1defEIL2TZQRmzl2e45/fYSIavVbbesab+p46vbQJBxPC0FwYx3ZHs27JbgTJnu+C/
         iKi4b6PCkRILf9rzrf4NgS16trWw/tjOXL+UokuMq5yah4+aADt5XcDswOIkXDuxJqKa
         /k/yeLjYxqm42s+dB9Z6VMirsc/M+7XWPmMo7ahyX0tR9IekPKdemcyY4o8Wh8OoYviI
         83W60mnnYeIviahhw+DsJbMlkkiaDjuaW3hGWImCWiQX6D3vUKHx45d7u6upcreEq3cS
         nlWXY34TODjjmpKxK9NmVAyebvq9H8BMuVCzZqDy2v001HWQJkkWcpPAV5E3DQs3T5yY
         q3lQ==
X-Gm-Message-State: AJIora8kN1xYjn3QQn5TwTtliXCsgkSkzaq3rkzFeiAdE54zE7aVCWPy
        Cqj/o/rdjANS+diERGMXBLUIUeMgoM2o2w==
X-Google-Smtp-Source: AGRyM1vDugJNnE9a8QlNScgdLB1vuH2yB0qG2t+bglWctKL7lTS95JOz8nL2InhvTXEf8pXGIpiRXw==
X-Received: by 2002:a17:907:7ba1:b0:72a:eba6:12ba with SMTP id ne33-20020a1709077ba100b0072aeba612bamr4075836ejc.652.1657061669673;
        Tue, 05 Jul 2022 15:54:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z8-20020aa7d408000000b0043a37e1d8easm6586224edq.32.2022.07.05.15.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:54:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o8rR6-004Bn3-9b;
        Wed, 06 Jul 2022 00:54:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>
Subject: Re: [External Mail]Re: Git fork process infinitely and never stop
Date:   Wed, 06 Jul 2022 00:50:37 +0200
References: <9d3b79239a314f72a099040a26ef9ad8@xiaomi.com>
 <8e1d019e-6456-ed05-7d3e-a0c4beeb35fa@gmail.com>
 <8ccd27ef3a344596b6237e98e1a5f204@xiaomi.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8ccd27ef3a344596b6237e98e1a5f204@xiaomi.com>
Message-ID: <220706.86k08r9nmj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 05 2022, =E7=A8=8B=E6=B4=8B wrote:

> - git version:
> 2.36.1
> - steps to reproduce the bug
> : We have no idea actually. We're maintainer of our internal
> git/gerrit. We found sometimes some user will invoke 100+ threads to
> clone the same repository. And when we ask those guy, they say they
> only executed the "git fetch" once. And just like the youtube videio,
> you will find git fork a child git, and then grandson child git, and
> loop like this forever until the server down.
> If we copy their local repository to our own PC, and then execute `git fe=
tch`, we can also reproduce it. It seems that some broken local git files c=
ause this bug
> - what you expect and actual behavior, as well as the differences
> Mentioned above
> - system info
>              Ubuntu  18.04
> - miscellaneous

I assume you can't share the repo, but perhaps try if you can reproduce
it with a "git fast-export --anonymize" version of it, and if so whether
you'd be willing to share that. It will publish the "shape of the
history" of the repo, but not any meaningful data (all commits, trees,
blobs etc. are replaced).

Alternatively myself & probably some other regular contributors to git
would be willing to look at that repo + reproduction recipe off the
public ML, to see if we could reproduce the issue, if that sounds good
to you contact me off-list.

Or perhaps we can still figure out a reproduction for this...

The YouTube video shows that you're using various options to git-fetch,
including filters, refspecs etc. Does a plain "git fetch" reproduce
this, and if not what's the option (try adding them one at a time &
experiment) that needs to be added to trigger this?

I somewhat suspect some --filter funny business, but that's just a
hunch...

