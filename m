Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7733EC38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 16:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiIHQlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIHQlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 12:41:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21288F4136
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 09:41:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so17305061pgb.4
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Lhjdq8pBzYZREODAf4ZQrZwXoSuN7KSj6tCvYviFINc=;
        b=HU8AmxGRLy6xGd1wlNu0TGvhfWv8fCWjyffzq+jrCUFRLOgtFhNENFbxnmdRTnOoxw
         1NDVJQ8ripT+XnBujjfc7yvfRMyHBIucjMjmqJ6FtfwuKCuLq30/fdMyJHDnV6V464Sl
         hUC3aCDgka/Ys+RAGRbuguLOm/B7gU+VTKGg2ysWqyJs50ojGptBju5TWVSIgNCaRdvm
         SiqIHT8LQearAGFyh1s9M9NymItCP0tCY26USKzdjsziEaBjh69M2BzbhSyZWkhCDLHv
         ufmnWJv2ulel8d2grlWvzPOBpGddElbHv1PEEdhGy7XEVFDOO5IYoVKW+V6OMcibCfmb
         NzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=Lhjdq8pBzYZREODAf4ZQrZwXoSuN7KSj6tCvYviFINc=;
        b=zNvSNpBIeLew8HBFd3MtTxygXRRS9VDxsrt/FXKMf7pvgnBsdw26OnToqbAPoNw3X+
         QztstPmN3zLKKfDVOXCzOhSCBqqBNNc/4yGE3+mMRjjcF93dwNGjormU3Vy2DxxjOLaK
         iz1PBU10khLvqnlEEwpr40RG0V1HowKYOo0O6w795f9od4EZfVKLM01AyGxSrTeEXJPe
         fT+lHBt3ZYDwS++wzf+e+umY/SrzZX7dytxR210ZUjUg0Q4pnq39At06MSVlx+oax0Wp
         j1wzISjbUTrZfeD6KvbOOoYvK5FxYbkivZmyHUhPEWL5b2W1QL+UHQjJfDy+PTKAhtjQ
         whEA==
X-Gm-Message-State: ACgBeo2DomvHwa7NH7ULC7C04W5DnikJICOawNdyXnhh4GZK0DkthrbR
        Di8OS5vJWa8ub17uwiaUnV8=
X-Google-Smtp-Source: AA6agR6hu1f8eOTI1it+Wlsr9hwUDGzyxRyJgSWxhSbSxaduO8RYe+KdZhN21YFHuIr2xbxy1ONKbA==
X-Received: by 2002:a05:6a00:24c2:b0:52e:7181:a8a0 with SMTP id d2-20020a056a0024c200b0052e7181a8a0mr10116163pfv.57.1662655304558;
        Thu, 08 Sep 2022 09:41:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 67-20020a621646000000b0053e2be5605dsm6719749pfw.214.2022.09.08.09.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:41:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ?= =?utf-8?B?5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [PATCH 2/3] upload-pack: skip parse-object re-hashing of "want"
 objects
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
        <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
        <xmqq1qsnugsu.fsf@gitster.g>
        <YxkAxutS+B8//0WF@coredump.intra.peff.net>
        <YxkG3A30vNfu55Sx@coredump.intra.peff.net>
        <xmqq8rmususl.fsf@gitster.g>
        <Yxl37LhGgCC+6J1K@coredump.intra.peff.net>
Date:   Thu, 08 Sep 2022 09:41:43 -0700
In-Reply-To: <Yxl37LhGgCC+6J1K@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 8 Sep 2022 01:04:44 -0400")
Message-ID: <xmqqv8pxrf7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 07, 2022 at 03:07:22PM -0700, Junio C Hamano wrote:
>
>> > Subject: [PATCH] t1060: check partial clone of misnamed blob
>> [...]
>> Thanks.  Let's queue it on top.
>
> <sigh> This fails the leak-check CI job because of existing leaks in
> "clone --filter". I think I found the (or perhaps "a") bottom of that
> rabbit hole, though:
>
>   https://lore.kernel.org/git/Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net/

Thanks.

