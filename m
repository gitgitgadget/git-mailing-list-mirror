Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8ADC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 04:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCXEpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 00:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXEpj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 00:45:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F792887A
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 21:45:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l14so505815pfc.11
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 21:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679633139;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FC1hS9MJTk4N+IT8tAYkQBrt3lYsQg+JAGhfUiAiJc=;
        b=oYVewoH2e52rk6VaEEWoQ17Wv5X4vgM9M0Vo/PkxKdxrDJ/PakadnoMqysQFhB2fS+
         bwoW2jVZEAeIOgxBB+LtJTQgXM+L7j1ff9xgWPtMwKMrXXuk0vTZX+tEqypmU0Bmz8fk
         W34GXJwkTn7Z801UlhPm5XO/EUTIDPdGG7VjpGbAz+rwAa3vwq1ErbOz+vRCYGqrqF9m
         1ylaetEI67MrXjcyTxumtc6N7vD/Z/umBVYW3K1fWqGUH7fUlOt6upAUQcltJE9sikZt
         1qrNH0lZkaRrpBB9XR9ebFR9qy5HPr530ilpyJe/APY2JKIOLTpn3Z4XvKvSrCpes1Id
         gpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679633139;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FC1hS9MJTk4N+IT8tAYkQBrt3lYsQg+JAGhfUiAiJc=;
        b=b7foK8r2he4dMEONw5LSdqs22TmEFOQBbG8jSE/p075V1sEhH38/BR40bhZ65H5diM
         NyXxhi3R5EgwiL00/+vzXelNG1BsVAiqmVyqraR56VWxY1i/s9jbUkqjh+v5B52wkXPp
         Ae3dFLfmbwB7nkliZ0VC94lPW8JosRT9Gd20f8YTrZw4eDgHLcTEp0IXID+g7rKUvMKJ
         kDyCZ8XHc9a5m7qw+d08jjjiCWkE9VKJcnS9eZofJiovQs52L6kZ9dEmacKjvY2URzcx
         jQVgxZVwtR2qgZ49Fz1nOJ3A0uDokt3x2IOkbNyWmAcjaBV6ileWe9QKHvZGnIJvKmsN
         Vx5Q==
X-Gm-Message-State: AAQBX9cUkm6axVlNbUJisQPgm+3uUSui8iFQ/IpVofLo6xP+gQJdVT6Z
        C7NlS66/4lXLQtwcfRRK380=
X-Google-Smtp-Source: AKy350ZtHCp5Wr50/9Xdaeb+E7Fqd3gfay123oDsLv3rW/ICL/tZfCASGXr+6/I8xnjKQjRvsRSLaQ==
X-Received: by 2002:a62:5245:0:b0:627:ff1d:db6d with SMTP id g66-20020a625245000000b00627ff1ddb6dmr1605650pfb.21.1679633138601;
        Thu, 23 Mar 2023 21:45:38 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d13-20020aa78e4d000000b00622e01989cbsm13197718pfr.176.2023.03.23.21.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 21:45:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Sjur Moshagen <sjurnm@mac.com>, git@vger.kernel.org
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
        <20230323053110.z64tcce5dy3q7yew@tb-raspi4>
Date:   Thu, 23 Mar 2023 21:45:37 -0700
Message-ID: <xmqqr0te69la.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> The general rule and recommendation would be to start the text attributes
> definition by using a "catch all" rule, followed by files that need
> special treatment.
> The very first text/binary line would be
> * text=auto
> which will tell Git to auto-detect all files (and file types),
> see below,
> This basically prevents corruption of binary files.
> which are not mentioned later.
> Like README.md, LICENCE and so on.
> Then there is a list of file extension, that are known to be binary,
> you can add them as shown below.

Thanks for writing this down clearly.

If I would add one thing to the general advice, it is that it
applies o those who are using Git primarily as their source code,
not binary asset, control system, which roughly translates to "for
most of the paths in the project, 'git diff' without using any
external diff driver is useful".  In such an environment,
"everything by default is text, and only selected few are not" would
work very well.  If on the other hand there are myriad of binary
asset of different types, it can become cumbersome to mark them "do
not try normalizing the eol, which is done to help cross platform
development" individually.
