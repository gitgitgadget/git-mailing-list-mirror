Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9381F453
	for <e@80x24.org>; Tue, 22 Jan 2019 22:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfAVWni (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 17:43:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34549 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfAVWni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 17:43:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id f7so236739wrp.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 14:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q0H7efHDHoUyZFBGN8HIaTKVqEf0iOX1ZLKXP/+PwI0=;
        b=rEeStWKUZw8K4IeXpVGsRKs8vit672cbohGpfCW6To7ygd9hFQCBDdfl/zzyiWL2nx
         /7YLN4OvrvWD9FbKkebrLkoxsaPfTd2MpV4ggzIOGC5wcZhVI+iGsQ3klLNIJUKJXR+/
         8D1oFP7xV+b5/irCkuzi5aWf5HVReMBWaIbH0lvup5vkWqm/WnnaP+ywnjUZNZK/qFSP
         pfiWCe/2OfMNxawc4KP5IE7rB8p5yQr4GCw7mCMj2EafqnN3RJeE9P9LCZ30p/PTv2LX
         S9IMK9/kg9E8e4mLKMFsu6JQcst4k4Y4ZVUkLX4yKcIg5jgBfJ4RwwQ22JE9RX5+45BF
         jwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q0H7efHDHoUyZFBGN8HIaTKVqEf0iOX1ZLKXP/+PwI0=;
        b=bk02z554Yqw4pDCejvEHaVEqtnlbAyOXl4bA8Or9NE5Z7+j8iD3qpQTudwIXhNme+j
         BzBndXATpUM8SfX1wSnRKlXaZTOB5sOCbJjPQDcpglwI0hQyGz086Ymdzu6xvQMtemr0
         jsL8y9dFSluiLoREtTY7M92cJd+XiDDPzUssmvYNJ3/CVWUmoMgnQPi4TTshTjn4jP6M
         jf3ogKWAQt1fwPcwrDZ6a4enMjCkHGyqcfKg9O7MKthJ4q1mQoFoDOK1PpYfF/1bGXM7
         vcxgGrOMGMgTV/Mkc4uC4/0rbIPx9oDEXJaRJRjP/Zz0Pl084ev+baPVWbbLJ///3npK
         p0jg==
X-Gm-Message-State: AJcUukdusEqiaBZVPLGP7HWp7WoUbvlTBChGNAJc+0tjeDB3Lx8SB0OG
        bmcjjuCza59VohJfOwozL+M=
X-Google-Smtp-Source: ALg8bN6wubP/Xp3RcXl7TBPnJgj/tOo8wMCHD414lBG0LKMlOhGdwPK9+CnBjZ9mGYEoH9Dj5i5KpA==
X-Received: by 2002:adf:f149:: with SMTP id y9mr37551921wro.284.1548197015940;
        Tue, 22 Jan 2019 14:43:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j8sm142361898wmd.0.2019.01.22.14.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 14:43:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Hogg <phogg@novamoon.net>
Cc:     git@vger.kernel.org, pclouds@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] pack-objects: Use packing_data lock instead of read_mutex
References: <20190119154337.6556-1-phogg@novamoon.net>
Date:   Tue, 22 Jan 2019 14:43:33 -0800
In-Reply-To: <20190119154337.6556-1-phogg@novamoon.net> (Patrick Hogg's
        message of "Sat, 19 Jan 2019 10:43:38 -0500")
Message-ID: <xmqq1s54e2ju.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Hogg <phogg@novamoon.net> writes:

> As I mentioned in the prior thread I think that it will be simpler
> to simply use the existing lock in packing_data instead of moving
> read_mutex. I can go back to simply moving read_mutex to the
> packing_data struct if that that is preferable, though.

I'll let others comment on this to show preference between the two
approaches.

> I also removed the #ifndef NO_PTHREADS in prepare_packing_data around
> the initialization of &pdata->lock since I had to upgrade the lock to
> a recursive mutex. As far as I can tell init_recursive_mutex (and
> pthread_mutex_init for that matter) have that protection already so it
> appears to be redundant.

If you can defer "I also" to a separate patch, please do so.
Keeping the fix alone as small as possible and not tangled with
other changes would make it easier for people to cherry-pick the fix
to older maintenance tracks if they choose to.
