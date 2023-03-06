Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59911C6FD19
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 17:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCFRnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCFRnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 12:43:06 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB006BC0E
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 09:42:26 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a7so6329320pfx.10
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678124498;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLjt0epniHP8D2CtPUKz4v0xY/5Lc2G1ysa/9KQREYQ=;
        b=EsPE2Wjf6huWlDTkjQ3Fwd9XoQdkj/VKCsA5ubFru3+lZg5y85g1gY6uoMI58j0elt
         mHrIc8kmRgjNyxlE0jZBIy1OQjUx2TMgBX8Z/PBYmBrWp2csoXISkd8XDGC9IS+OFoZY
         SHUARBzy4O2L7uegXoacsZKD8ictfwDwz4p3QrF8imeS/Z9XHNP3p0Pzp182fPd2EnNj
         L7z4Qp/MbkO+zWq9Sdwn8L5VSZZz6IVxt5WlVFoLEKQFaGW/e/cN77hpLNn770lwDL/T
         K3uuGqwJE5L1Wxtbq8+0wTbeiEA+RBq9o4m1Hyyl15LRE51xiH0GZ7C+o6jJ/Kt5j4Pb
         nCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124498;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zLjt0epniHP8D2CtPUKz4v0xY/5Lc2G1ysa/9KQREYQ=;
        b=pswtQDu/CZgFdIzJvaefQn2QCiVPEK1V5vGLQ+ZdiFhr8tW2tfRg/buWkO9ga67Z6Q
         NEBdAiT6lsbv4bYUHcDzqLeftAFo6jUu99gikHOhxkTlz0sKbFASCbmUdLd1DLl4F5TY
         Hzo/LqHOJtcd8bN1KnnkA3B+wQ4iuWDctbvqFhYiBu5lRlbN4pJWtiyz4ndzjPqi6Vpx
         xcyQwNXQbv92L4VaXBJbitt6R/38/wNnfNDN0KMiTcHFtVOrBnYWCGe/H9WMaQp935bD
         QZ3okEUVEeOgufF+vUnlYkSh/SV5Jd9gA09g+xPM5r3r68uEC8HRp4LgC0xD14E/fw5Y
         +XFw==
X-Gm-Message-State: AO0yUKXMOBjEzsUCeUV943c3FFKhXUzlxMRIrYmhI2hZuGf4pPeDpL4l
        E/ftxkrleAz4jO5AUjIXbxA=
X-Google-Smtp-Source: AK7set+DRKqu9KPIWxgKYnlenvEistt/j5iWE6Mjy2sTiZAkuU21EyaE8c8p3gFZRj4BCLB5Lwz5Cw==
X-Received: by 2002:a62:1bc3:0:b0:5a8:a751:d22 with SMTP id b186-20020a621bc3000000b005a8a7510d22mr11549346pfb.12.1678124498585;
        Mon, 06 Mar 2023 09:41:38 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78c03000000b0058d9058fe8asm6622106pfd.103.2023.03.06.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:41:38 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] bundle: turn on --all-progress-implied by default
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
        <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
        <xmqqv8jhcvrq.fsf@gitster.g>
        <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
        <xmqqpm9pcu6t.fsf@gitster.g>
        <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
        <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net>
        <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
        <ZAMjkffYmp+DNmr+@coredump.intra.peff.net>
Date:   Mon, 06 Mar 2023 09:41:37 -0800
In-Reply-To: <ZAMjkffYmp+DNmr+@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 4 Mar 2023 05:55:13 -0500")
Message-ID: <xmqqzg8paib2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm actually kind of confused about what happened with 79862b6b77c. If
> you go to the subthread linked above, you can see that I made similar
> arguments there, and Junio seemed to agree. Then the next thing I could
> find is the series appearing in What's cooking:
>
>   https://lore.kernel.org/git/xmqqftikxs4z.fsf@gitster-ct.c.googlers.com/
>
> marked as "will merge to master". Is there more discussion I couldn't
> find? Was it accidentally graduated?

I am stumped as well X-<.  It does look like it was merged down by
accident.  Sorry for the confusion.
