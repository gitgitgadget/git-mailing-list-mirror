Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B1BC433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D70A20836
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 17:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvwxI/8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgFLRGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLRGK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 13:06:10 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD4FC03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:06:09 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 190so5684384vsr.9
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xFtFmZyc96/iqpsT4guoT/b65CNErVkDWfjDKpZAwr4=;
        b=UvwxI/8JSvGTxfC+DiRj9fa1cWixM9ZXw0c009mbQT8g/L3d9J/J4o49AFEkEz9EFG
         E4cywr973/1H4SmCqsWTT594+jM8v7yD4au18H8CRFCkJpWqx+vBvNrLQp9M3rlfwQvA
         LGuFN+1QLfdQa6StgDOM8kiwSAn/f/MfCkNAadyQFtRAHQJwN8I9UdfviUjREgsgjjMk
         940JSOGVL88jx72R2DRV1XV8JCIvuB1F/M6IiiWouu2RyW4+UzJ7lrjrwmEekyZhzMrr
         E3oPtk3PR9r8d0Caqa+d9I23Y8qlmNlfQyAK3fxCqsabniJmD/y5OvOSgiSfAMXhQZer
         cueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xFtFmZyc96/iqpsT4guoT/b65CNErVkDWfjDKpZAwr4=;
        b=adpDkluBPKI0GwAJ69cArzSk+90B5xwrKVL5Xjln3jybZLg+erOqnYfONvJzAUGV2K
         Ic6pQqcS3uoTebok3BnBw1O7UwQrTwVB96oRC7OqFe5QC6Zj8jI5wjm/iGIpK1OBKtma
         i0YWOqetFHSEPW94XOqutKUPrwDh91NUNz5gQe9ZoO5DSL6zjhv8YJmIcnNELXofdQRc
         0BiGE6C4X7PifjwzdTDpzus9Ro7+mO3Pfkt2tO9d9H+Wi3zMF7p7l1rZQV5lKm3hYpOw
         MGfRn3xB8tcznrO3wf3CcdWiKAS0yS7hYJxxNHCSO+u13mR7teZFJ/uoEFyI7i2veCf6
         0Atw==
X-Gm-Message-State: AOAM531wSEs4DveZWclaeUGNRj8SyrsmNpoOCD/hv2PT5q1wwU3VgzqA
        ShPBkttIWx3LxpXuKdEXjHenYzFE
X-Google-Smtp-Source: ABdhPJz18/L+s5uoQJegG3jFu8XjyOE2xpY9LOn1+C2J5OcHLi1GlD74I4f5wFyCy5V0nls982tFKg==
X-Received: by 2002:a67:f981:: with SMTP id b1mr10834332vsq.224.1591981568729;
        Fri, 12 Jun 2020 10:06:08 -0700 (PDT)
Received: from localhost (69.104.231.35.bc.googleusercontent.com. [35.231.104.69])
        by smtp.gmail.com with ESMTPSA id r134sm1034968vkd.52.2020.06.12.10.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:06:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Chris Torek via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH 2/3] git diff: improve A...B merge-base handling
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
        <f7c8f094e02406a7d0cb0c61f880e5b01fa413c4.1591661021.git.gitgitgadget@gmail.com>
        <6eadaa89-fde7-4224-dcb9-ceef315942f2@iee.email>
Date:   Fri, 12 Jun 2020 10:06:07 -0700
In-Reply-To: <6eadaa89-fde7-4224-dcb9-ceef315942f2@iee.email> (Philip Oakley's
        message of "Fri, 12 Jun 2020 14:38:43 +0100")
Message-ID: <xmqq8sgs2ozk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 09/06/2020 01:03, Chris Torek via GitGitGadget wrote:
> [snip]
>> +test_description='behavior of diff with symmetric-diff setups'
>> +
>> +. ./test-lib.sh
>> +
>> +# build these situations:
>> +#  - normal merge with one merge base (b1...b2);
>> +#  - criss-cross merge ie 2 merge bases (b1...master);
>> +#  - disjoint subgraph (orphan branch, b3...master).
>
> nit:
> Use of b1, b2, b3 here, but br1, br2, br3 below
>> +#
>> +#     B---E   <-- master
>> +#    / \ /
>> +#   A   X
>> +#    \ / \
>> +#     C---D--G   <-- br1
>> +#      \    /
>> +#       ---F   <-- br2
>> +#
>> +#  H  <-- br3
>> +#


True.  Which one is to be recommended?  The shorter and sweeter b1,
b2 and b3?

In any case, that must match the topology used by the tests.

Thanks.
