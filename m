Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2541DECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 19:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiIBT2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIBT2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 15:28:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965261037EE
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 12:28:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so3489233wrq.10
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=K58GPc+WwlbkntU3YRuZvFdEsnpL1IMw1ni+aT97O3o=;
        b=MhvuQvzCoOW5KMlKj6sLokE20e0FhWxzernlZWQon+bXg9NhsVflpE1LOF5BLRHhgi
         5Cwshe6m14rZbLkzXc9ygNaNFiiBKVvGs42Ds7Qm1aqIvXJ150psJd3RkXjDuZavrMsp
         zuFXfVq6AqNmHwnGaq2ylf3zrc3TXtV2oKE3XCWe3yuO9AClmun1SDM769+m9eBmP7fx
         UUy5Iz84bkGcqU2+WiVoHJB30gZQ1zK6GR2lI5/C2p4keCw/E0TCG7Mo6+RSrwRM6P/n
         zKhxvbQEaDW2NO2RjaWAYyaVQD1sW+7nYcgyUlRz5e017EcqAxqixUCUCUc1+bdGjrI3
         3hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=K58GPc+WwlbkntU3YRuZvFdEsnpL1IMw1ni+aT97O3o=;
        b=A385pMC8yA6SbxSLtpICs3SwSHdYDF75Yy345+2cEq9SOzr64nJznXcra7TWMerIof
         /jGz9PMY3abrm4f+uBXgGO+BAZYw23kyul2PT+2sL7ZD04LaO4/AVfcYB5DZ9BbpvGTI
         8hEcel5tBGyCCwF3lEU7nXB3Fk0xdIXWn2WMeCRJWaAB1NTUMCTM3fxGoBzGPGAeeioP
         BHDEOTZMWp8hREJLhN6hYmZoxwYec9udy6xD7v6SjCz6+UoXwHQcazCD2sV+B0Q1APfX
         JydZyNVwRt0kPz7MwpttjXbw7W8+gllnLsx+FnJGuTTRQ8T5y/Uv78I+S4rTXyo0JGjg
         3yZQ==
X-Gm-Message-State: ACgBeo3BRxDaViyW5Kr/vcltT4mows8IdSQBFKLINj+82ZcLEdPbot6V
        guGPIPzq8Uz6ztGco6miQ5N7YwpGgFdKkBRWcTGqdXo5HcA=
X-Google-Smtp-Source: AA6agR7anqeIBigOtguXmPixb5Ry91pz878bKGTQoD05Y0P9xzMCxiKEIUmmMx+kw9LWodEbqpJ/i85qvUK7FGXbhUE=
X-Received: by 2002:a5d:5848:0:b0:228:47af:caf3 with SMTP id
 i8-20020a5d5848000000b0022847afcaf3mr1900660wrf.336.1662146911041; Fri, 02
 Sep 2022 12:28:31 -0700 (PDT)
MIME-Version: 1.0
From:   Lana Deere <lana.deere@gmail.com>
Date:   Fri, 2 Sep 2022 15:27:55 -0400
Message-ID: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
Subject: 2.37.2 can't "git pull" but 2.18.0 can
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm testing an upgrade to git 2.37.2 from the current version we're
using of 2.18.0.  When I try to pull in my development tree, 2.37.2
gives me an error but 2.18.0 things all is fine:

$ /tools/linux-x86_64/git/2.37.2/bin/git pull
Your configuration specifies to merge with the ref
'refs/heads/feature/switch-to-qt5'
from the remote, but no such ref was fetched.

$ /tools/linux-x86_64/git/2.18.0/bin/git pull
From http://githost:7990/scm/dp/sw
 * branch                  feature/switch-to-qt5 -> FETCH_HEAD
Already up to date.

Anyone have any ideas about this?  All I could find on google was a
suggestion that the "no such ref" message indicates the remote branch
was deleted, but that's not the case here.


.. Lana (lana.deere@gmail.com)
