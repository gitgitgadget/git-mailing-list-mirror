Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE97BC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjDXQWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXQWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:22:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A4E69
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:22:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24b9e5a9a68so1171930a91.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682353357; x=1684945357;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESofe12vDoPPmgq7VmUED1arRgNvG1MGfRzWSNAB9oI=;
        b=Xxlfd6i0i9jof/N8A/8NzyO0Wj+/WbsCjWnoCHrk5e7xFRJM5RtrhIEQTyuvRc3tQx
         knT3ygzIjzr5OegTQKKu/vkbT8FSFhdjZqBe9F3cycdPSuJYMZndtDsCbhXf9PdXrXv1
         cT44Kq4BU/imDQQUD537qFeemY0ltV6clGGXhVE2IX7G1/SiDm5XdprofLOfQn05e96h
         Xw9cnBAv7LuTsPSPLBxZCyYjcyYmuNfodQ+sfuUR7eO2yHVDaMHVtcl0ex3jW56RbOxI
         m6WmUJy/cQz+V5Nvgf2XfTp6EwQFJgVAUDJChmPEQm6m+mPyHELP/cbYI7RSWtJxNvrX
         A8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353357; x=1684945357;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ESofe12vDoPPmgq7VmUED1arRgNvG1MGfRzWSNAB9oI=;
        b=aHOAYT+ZLUQD+e7u+r+hB0pyq4vq/TnTzUTlVKZqZPm8YxAQxpGQBxecsZo/iQXfCC
         vJKubmt5rsAhogxV5dPiImQOpVyNjxYUZqkwxMwxMolgn9f7j5tN3CH/FBbIo9XkEui0
         awYyTEjz5OL/ay0r1HBT9HE2swkeeaIEHYLzG5hhIHaq8QL9XK0S/MeVdLSlXt1frbfW
         Jp+/377l3CBdkRe1k7zfP3Xcd5q8VdIismJpSIxHMJ5YhDm6cea+mBk/GkclbsqAstlF
         b9vZAUGKrc1eInrgD0JVE01niP5GhraOCz1YUoVikMaj+J/4L473DI42dDk9KsnP/UW4
         Sr2w==
X-Gm-Message-State: AAQBX9cWeRVXKIFs/mHPjqEa3GSnBO3fr2W3KjFl0v4d+e0ZyHFRKR4v
        PdH0kij16ZKDPeQInHVD7s8JA/8pslY=
X-Google-Smtp-Source: AKy350YkAOHJgK4SbRlmwDKCB8t1G+0M0POfK6CvFZDrEbc8wIyU9RDi1kGIhGu1lSsoMNJsXtyRSQ==
X-Received: by 2002:a17:90a:8c85:b0:247:5e62:3288 with SMTP id b5-20020a17090a8c8500b002475e623288mr13984689pjo.33.1682353357456;
        Mon, 24 Apr 2023 09:22:37 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id kx18-20020a17090b229200b0023b3d80c76csm6634202pjb.4.2023.04.24.09.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:22:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rolf Eike Beer <eb@emlix.com>, git@vger.kernel.org,
        Jaydeep P Das <jaydeepjd.8914@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] gpg-interface: set trust level of missing key to
 "undefined"
References: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
        <20230418064846.GA1414@coredump.intra.peff.net>
        <xmqqy1mpduq3.fsf@gitster.g>
        <20230419012957.GA503941@coredump.intra.peff.net>
        <xmqqy1mnanz8.fsf@gitster.g>
        <20230422104758.GA2969939@coredump.intra.peff.net>
Date:   Mon, 24 Apr 2023 09:22:36 -0700
In-Reply-To: <20230422104758.GA2969939@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 22 Apr 2023 06:47:58 -0400")
Message-ID: <xmqq4jp5gshf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So before my patch the uninitialized state is (supposedly) less than the
> min level, and after they are the same. For the reasons I gave in the
> commit message, I think that less-than comparison was already broken.
> And likewise, for the reasons I gave, it hopefully never matters since
> the result would never be 'G' in that case.

Yes * 2.

> So I think it's fine, but I definitely had to stare at it for a while.
> This all comes from 54887b4689 (gpg-interface: add minTrustLevel as a
> configuration option, 2019-12-27), which does discuss some of the
> implications, but I think my patch is in line with the logic there.

Yes.

Thanks.
