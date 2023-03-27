Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35ACC6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjC0Wp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 18:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjC0Wp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 18:45:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7C1BEF
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 15:45:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so10593149pjl.4
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679957127;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67nkdggHhI/0qsKrD4mGTKb0ydx8ecaUmpsUUuamV2g=;
        b=gFW3WeHokxyUOh/tuuzMFBSwb96n8Do7nTcFQIkpxPNw32kMC73/jLyLWEYXjBNCtd
         6KAI7it1eptauTx1QfAVUVze2FLsKjiy5i8fBHLrVSRwP33ANefPUNNAOJKFmKOH/9pN
         znMzdTx2uZqMiMwcXInil0P9KxQAFAbXtdOyUqL94ce8Slm89BoZC2DAa+1oSjpbzSMV
         azkAI+7pQFH4QL1V1adF+mmmcpVlzXi9tzmFacjg58U6RFcbMGNYIA8+OeX4Wm1epKHs
         Vaf88Vx0V/ZzuV4M3IHrRvnqmh6y7K7PHzyCzMpn0XE4S+vu8jPKU1g5Kld16j1NN4B1
         7mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679957127;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67nkdggHhI/0qsKrD4mGTKb0ydx8ecaUmpsUUuamV2g=;
        b=UvXslWbH+cGkc667YYzc3L56F3QSKVfpNL6DxPWlRfyS6JQSqFavGOUZcY7m2lhnQ3
         JyKzeUMSUD8L8BGr6Mph46MTm7Z+SHc3IcEbqeT1pOrG59i21oYYFbB6l3Pptj1wgFxB
         002VQdSJ6KoN4YN7hpl5BBeBlJA2Pb3cl0pspXv68hwzD1zRpoRb6HZ/dTX6xLfUwLnt
         RuC8fp9mU0JzMgZX6zjszZKTyIQPYh3RjzbkJ2yDPnLbKd/jQFcGhM6ud3lb9+RnFLSU
         UBUQkr890opPa5o5zBuFlho5vGry+63JIaDE7xuK+awHRtNLEpsJpYLW2WrstgeI0yW5
         +LbQ==
X-Gm-Message-State: AAQBX9f414dHcQxIDWh7xnrwrSUPo2lQfIuOEkgm1SruWooXeTsxs1Hp
        H52fKcXZAj7LkCrtizobhXovWOEEhPs=
X-Google-Smtp-Source: AKy350ZsiZjc0+jy22lgyzpLrHFaOFPLhL5UaagDSIITj/++shATKKx33Y3Aq/xxUH2lEWbIEJuGtg==
X-Received: by 2002:a17:903:247:b0:1a2:17b1:71b with SMTP id j7-20020a170903024700b001a217b1071bmr15099309plh.66.1679957127309;
        Mon, 27 Mar 2023 15:45:27 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902b20a00b001a0403f6a97sm19701927plr.202.2023.03.27.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:45:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] t5000: use check_mtime()
References: <233edbbe-35c1-9b5b-7578-4c70c6d24449@web.de>
        <5e53c8be-92b7-82e0-e204-a0cbfdffc529@gmail.com>
        <a47f8172-a8d0-abe8-09a8-f31b9e19b1a1@web.de>
Date:   Mon, 27 Mar 2023 15:45:26 -0700
In-Reply-To: <a47f8172-a8d0-abe8-09a8-f31b9e19b1a1@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 27 Mar 2023 19:59:56 +0200")
Message-ID: <xmqq5yaln795.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Care to send a patch?
>
> There's more by the way:
> ...
> Personally I'd like to avoid wasting space and the second form looks odd
> to me, which turned me into a repeat offender out of negligence, I
> guess.  Anyway, since we have a documented rule (that came about by
> majority vote of code lines IIUC) we should follow it.

I used to appreciate that I can grep for "func (" to find shell
function definition while I can grep for "func(" for C, but that was
a long time ago.  "git grep <pattern> --" followed by "\*.c" vs "\*.sh"
is what I use to limit the hits these days anyway ;-)
