Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07D6C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 09:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbjELJci (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbjELJcf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 05:32:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D24911B4E
        for <git@vger.kernel.org>; Fri, 12 May 2023 02:32:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4effb818c37so11029790e87.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683883940; x=1686475940;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rSeTYxLScbA1aATHEH7w2LVd3CJEBOSsj4ESq27P7Ag=;
        b=kQyg/nXbPXZHJZEpR8VJOkPaM5RCP2baqqFK/E7D3He+UVkDKgAi7aTnQAjayRPNAH
         oOxT/Ww4TIAz9KSc0PHOyJlaXgZcyq8Gl6SSNEf8oN/dlYEsg/1Yre1elBXqSPyPHgIG
         l/J5PMUbDcXJDy3bn6CjQMHmSzBh/HNoLEW7JLK30ZWwF2ELe2qihgAe3aQHgnggCyQX
         Akh9PvlNd1TSdQvD68irCDx+Bi0SlIRQqHkGuv+5ne87tBLR4cltiUY5cfa++/z4zACd
         a9ejndyFpLzUMuwFvUPpcWV2MfcTi8bWEkByl2MHryBNokdJkU+zgbqCAUD1sN0uaOx0
         hV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883940; x=1686475940;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSeTYxLScbA1aATHEH7w2LVd3CJEBOSsj4ESq27P7Ag=;
        b=AWc8vlNP52ZZI5sHAQeARUwkn6dbuVcY9hVd/Dk8w9Blv8BqYSVRrEZTe6bHmdczlY
         TWC8wWNzpT0n49Hfrv2vhisw58nDQYH7VtFQVeudxruBz+q91iXGgRsopbvJUugwE56X
         Z1Hvw4/trJLXh9y5DYe0hObL+IbUMZa9vfy4e1E4UZM28kAmvweLi1Tb7SzJztF2sVC5
         c4XbQDqZOw0/GR5U2CfIHzw/Fg+TCL33BY+zwjf2beCU6I0U9aFeYg+OxMOlRb+Ad8MY
         RoddB1YMghR9SSmprf9NWVD4inufg0KkVbteO/i0yQmqnufKc5nji4ppv4p1ujv35sT8
         BU1A==
X-Gm-Message-State: AC+VfDyDIhzEvDJGuMQY5b3lD7F2Bwa6cqYJuQIZDYEAeQajzMa8dpuP
        zxAp901wrUk5XNNIIALOZnarhaGrhNCelw==
X-Google-Smtp-Source: ACHHUZ7RD4rxgJznzElaDPoaukZGw1gCWgCAoOZJpSO2B25XHWXrVAjc0UyyAyw5XHZrYxfZI+ZlOw==
X-Received: by 2002:ac2:4c1b:0:b0:4ef:eeaa:e9b9 with SMTP id t27-20020ac24c1b000000b004efeeaae9b9mr3064905lfq.35.1683883939654;
        Fri, 12 May 2023 02:32:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q5-20020ac25fc5000000b004f1477cf8a7sm1417062lfg.115.2023.05.12.02.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:32:19 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 0/7] diff: fix -s and --no-patch
References: <20230512080339.2186324-1-felipe.contreras@gmail.com>
        <645df6e614f00_215cec29462@chronos.notmuch>
Date:   Fri, 12 May 2023 12:32:18 +0300
In-Reply-To: <645df6e614f00_215cec29462@chronos.notmuch> (Felipe Contreras's
        message of "Fri, 12 May 2023 02:20:54 -0600")
Message-ID: <87r0rlj3od.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Felipe Contreras wrote:
>> This fixes an issue Sergey Organov reported.
>
> Sergey, as you can see this series fixes the issue you reported.
>
> First, I think these should remain working the same, simply for convenience:
>
>  * git diff         # default output
>  * git diff --patch # patch output
>  * git diff --raw   # raw output
>  * git diff --stat  # stat output
>
> I don't think there's a way I can be convinced otherwise.

Fine with me.

>
> But there's many changes:
>
>  1. git diff -s --raw                 # before: nil, after: raw
>  2. git diff --no-patch --raw         # before: nil, after: raw
>  3. git diff --patch --no-patch --raw # before: nil, after: raw
>  4. git diff --raw --patch --no-patch # before: nil, after: raw

Fine as well.

>
> I don't think there's any way you can say my 174 changes make the code work
> "exactly the same".

I said that in the context where we discussed entirely separate issue
"handling of defaults by Git commands". Irrelevant to these series as
they don't touch this aspect as visible from outside, even though you
do change the implementation for better.

>
> And this is better than Junio's solution, because #4 outputs a raw format,
> while in Junio's solution it doesn't output anything.

Yes, and that's where I agreed from the very beginning.

> Even if you don't agree with everything, this solution is better than the
> status quo, and it's better than Junio's solution as it fixes --no-patch
> immediately.

Yep, it fixes "--no-patch" semantics indeed, and as I already said, I do
vote in favor of this change, for what it's worth.

Thanks,
-- Sergey Organov
