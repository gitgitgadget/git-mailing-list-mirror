Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8FFC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjDXU5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDXU5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 16:57:37 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13174187
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:57:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b73203e0aso30919143b3a.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682369855; x=1684961855;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qdNiSGOvt4tSbKGv6QFZrxQ9KJZiGrE06ROohK+afpQ=;
        b=sUJYsOjWi0xZtNAs1dz1bBFBMFbOCw0zzy7uS97Oj1FBengtcRll70HcP0EolJioC8
         na7UqROOk/k1GckZESVeDQU9k5688bO3dnat0OAuJ4wNyyJwnEyT0+ANnjapS6/3km3P
         70sigCnnTfCbbs5jDJ1/W4VKJBSc8YQ5znQOlZN7HhAXw45fnyhiDnUNsO+Q0i1k+6AI
         E5vXiALX/VYZvwkacosm+NSZ31TPTxg6b6moqYaZ9ZX9ghKxqFzDQsm7wqNiJ1jaPeQF
         a8BVqrXqVLUfIGbsdN2FmMs7stfA5ealCxInzRoWyESJ+64FLQrFZIuCkyaQmmaAUmz3
         OW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682369855; x=1684961855;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdNiSGOvt4tSbKGv6QFZrxQ9KJZiGrE06ROohK+afpQ=;
        b=BVsmpZADY8IGjrOEKXowDxxzzlIeKpPCj6f4jdWpBBem9n2ggUqCoVgUlY5tFsAJRq
         oTYKb6SaWpcyvXsUN0d9na7J+hY6rBK7ylmJ9JAZZEysQNTcrBJ4mTXj5syPfhAe73MH
         0rHcl3RKT2DLWQKIt1tbZttvIDQbLwlQwadY3SyaMd8tUnar3kFQFWe+I1PFozCfkxRP
         H5H1hYzyC7yx/+n4aTjlR+2RZTqE5WNHVFYP6IUNWBwIiMJNKtWDy8/CSFQtWWFX4HgP
         JdBOoqEDFWeKOmKln8nRM5fA46BTUz1gQEq6Jy4Gl/Q32N8az2o3c0DvwqmmFhD4P04+
         OV6g==
X-Gm-Message-State: AAQBX9d4+Si9s2L1rWx0bRBwfzyf0X8RTRRrq4JTQ7j0uxXeB7YQPnjI
        Gcv/9gMX8t/kLGDsjZ/fj9g=
X-Google-Smtp-Source: AKy350YradCNWEMy8UHw8VhzNMX3E1WrTIDndeu/DwN4SwdJF5qrsaHcdJjV0AGWAFpKkc3/tL9zIA==
X-Received: by 2002:a17:903:25d1:b0:1a6:3e45:8df with SMTP id jc17-20020a17090325d100b001a63e4508dfmr18752780plb.33.1682369855531;
        Mon, 24 Apr 2023 13:57:35 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902d70200b001a1ccb37847sm6927883ply.146.2023.04.24.13.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:57:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>, Michael J Gruber <git@grubix.eu>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
        <20230416054735.3386065-1-newren@gmail.com>
        <xmqq5y9uo4kj.fsf@gitster.g>
        <CABPp-BEmzofRAmgoz7Wam-6btCYCTy4CiVnTOtr9aQdjS6TB7w@mail.gmail.com>
        <xmqqwn28c3dh.fsf@gitster.g>
        <CAPig+cTTTNO9e3X5u8irHjGHmY5t3GA1_zrvYmfhETn312XJcQ@mail.gmail.com>
Date:   Mon, 24 Apr 2023 13:57:34 -0700
Message-ID: <xmqqa5yxathd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> A link to Michael's email might be useful for future readers of this
> commit message.
>
>     Michale J Gruber noticed[1] that connection...

I don't think so.  At least, I tried to write the proposed log
message in such a way that it is not needed.

I encourage people not to add URLs just so that they can be lazy and
omit summarizing the discussion for readers so that they do not have
to refer to external material in order to understand "git log"
output.  And I was trying to show by example.

Was there anything you couldn't read out of what I wrote that is
necessary to understand the issue the commit tried to address
without reading the original discussion?
