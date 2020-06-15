Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FD9C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 00:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A470F20768
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 00:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quZ5l7DT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgFOACy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgFOACy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 20:02:54 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EB9C05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 17:02:53 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id k22so11299667qtm.6
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HmLDwyGp9g2tXjiy93kN9s6vH+EteTPCnzuBppOMR7w=;
        b=quZ5l7DTkqQxu9ZAPyTfnTSYcWbudGuoxz22I1I66BQj03A+OQRftqJhCMQNrVB4aM
         NKNx9uzdqBjYtr1jPqSrhe9UBtiYWivEphCQkcoFOxumBu8EJVJyP9OJzzOwmetiYxWN
         iCmU40JsVjPxfnreJAYt2n1lMDsgEWBmIII7wT6q77bBJhu7T3qLDKlwTXZBglYL6QmI
         49gVpvjH4Snpx3gqKNnftVzX4KN6XWqVnBxBVreq7B3xnDW/sTAP8gu/3pTPNSaq0FCR
         baMskR4zjnG4IBen6Jron7OHTWZLKbEdv2yDOhItU5cQla/H8rfN8riPqhZh/xst1RMX
         mH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HmLDwyGp9g2tXjiy93kN9s6vH+EteTPCnzuBppOMR7w=;
        b=dnS3ef+RIvYolPb+GCcn2qS2PJlH6KYk87BAOGY3wijD7cJ3cw4pUSQzSdU1OM358r
         z3mQm0tNg2Fomf7WgQW0TEVhKP3yr54E7bSqdE/PW3JucRJf6+Kth/luoxK78iZcPlgD
         RDCzcg3c8bsIEjZwANTCyfv4/EWvbNe0EZ3ZG2l46qWHcOxwVGg+Rv74O1oAdg7gHUqR
         YJNWaYlXyt2m3ZviUZSQZC3p3NDd0aUtUoWjCku0tKxB87jhd6idvPEw80mqHrQo2Zvx
         BNK6+b/04LM1IhWMFB8Ol0HehxoTw/0kSHqlvjkkHo49Hy3hMU+b14s/dJok7o8LQAZM
         nLFA==
X-Gm-Message-State: AOAM533Iu+p7ePf2FDI2TGOBXHSi3xeAc7WhWPuMFWi95HSUXSDGYzIv
        rVdd2Oy7xR1lH58lJQESpkD5Jp98DWI=
X-Google-Smtp-Source: ABdhPJwvztZGYcS2c9AWtWNspi37/jiZyKqyJFoUScmDi/KJ0G0hd77YSs5uvQ7q5WLCZW/eUqd6UQ==
X-Received: by 2002:ac8:1ab9:: with SMTP id x54mr12926505qtj.371.1592179372728;
        Sun, 14 Jun 2020 17:02:52 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id v69sm9676506qkb.96.2020.06.14.17.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 17:02:52 -0700 (PDT)
To:     simon@bocoup.com
Cc:     git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <a34e4244-835e-976a-8fb4-7fc766d100bd@gmail.com>
Date:   Sun, 14 Jun 2020 21:02:50 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Someone sent me these points for me to use in this discussion. But to be 
fair, I'm kind of done so I will just paste what he sent me directly:

Don Goodman-Wilson said:

 > My feelings generally are: if you have to explain why it isn’t
 > racist, then there’s probably a better alternative.

Now this is already problematic as there is the idea of reversing the
burden of proof: he shouldn't point out that you have to explain why
it isn't racist, instead he should explain and prove himself that it's
racist and offensive, since he's the one making that claim and asking
for change in the first place.

All the sources I've seen linked in the thread are either Wikipedia,
that anyone can edit, or Twitter, where anyone can post anything, or
unspecified and unverifiable anecdotal evidence of the type "I've seen
people getting offended by it." This is not okay.

Perhaps the best argument you could make is that if and before changing
the name "master", there needs to be measurable proof of how many and
how much people are actually offended by the use of "master", and an
assessment of how many people would be offended by other proposed terms
or by the new chosen name, and a measurable assessment that changing the
name would actually reduce the amount of offended people, and have a
positive impact worth the effort.

In software development, people often say that if you can't measure that
your change in the code actually makes a difference and has an impact
going in the right direction, then you shouldn't bother writing that
code to begin with.

