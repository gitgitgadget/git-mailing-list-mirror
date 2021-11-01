Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A540BC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8319160E98
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhKATdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhKATdX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:33:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB4DC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:30:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w1so13951027edd.10
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Gm39cLaZQAw8XOsFsW6iinMDMjF2FDc/7HR3FKW6awQ=;
        b=i/WOhr79/DpCQj3u7sj3VG2InUzkXQiAWbE5VncjvxkTc7HlwmWJm8Z4mfJnZU6UwP
         Q8WAkTb3zxeMe27dRdbs8PSjH4gpe3gEKLq6M9J+LYVs8pWDHg+YbCu9/hTG310Wpo6K
         K/hBQ4xCjyDljJVc4j7jCpmyGIdlI6zv9/nc9+/UdROtov8n4PnKoKe7o1qRCVfejGps
         0CIktbR24N6Ype+y29XKO7+oOrHb9muGImeLRTcTUcww4QKHu6CTSRZoim+s9+qKAWTW
         +nVnU/JjE9dtM6cFK/BasR93DM+jjFjuPa/Sfwga7lMBosN0cDuSrH5OBQjTHcr9+Vdd
         2S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Gm39cLaZQAw8XOsFsW6iinMDMjF2FDc/7HR3FKW6awQ=;
        b=EqZslbjQpkSMWrKxTSwzmFuM6nS7UzREz7DYxIMEaW+0wAwzw13miLjftn3pvMaKVM
         CPeZCsfz9xTh8OWIaDcWBZxBxT2uAy8QAwaj+LnaN0FN9stuqa70ouziQAmZRCZl6PRx
         7H2fKvfVpE7HEV08t7dUWIBrjP1+TD6Z2DifsJ8lbvlN3i/32BFZTAZ7pwiXCwBhMtlv
         eMTTchffOiOTrvnEonJlymKLs9zT0tizcx+1nUtWlodqV1WpsTyK1wSTNCJHTzVp02uM
         7v90Ej+22AMstb8e5/sCrA0UJxFpzlMsLnjvVBmKfkovVMOn74kuUZ+zqRm6uYQRglhP
         JWmg==
X-Gm-Message-State: AOAM532Y17qghV6OhOPpuTsJHsHl10LVvpHZPgSfypX9ei1eaOcLieCL
        o8X7nTO4qNllNl0PHNS0rzHOuO7klMFtJlg0
X-Google-Smtp-Source: ABdhPJyEu+sqmPv776Xqj9TNlm9aNXNrfaWsqiQyiGd1iSulxOBKf5/HH9oadvI15rK+zfdchGh0ww==
X-Received: by 2002:a17:906:6b1a:: with SMTP id q26mr37450909ejr.185.1635795048201;
        Mon, 01 Nov 2021 12:30:48 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cr18sm7318895ejc.25.2021.11.01.12.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:30:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhd15-002BgB-FH;
        Mon, 01 Nov 2021 20:30:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: tb/plug-pack-bitmap-leaks (was: What's cooking in git.git (Oct
 2021, #07; Fri, 29))
Date:   Mon, 01 Nov 2021 20:30:04 +0100
References: <xmqqr1c3e57a.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqr1c3e57a.fsf@gitster.g>
Message-ID: <211101.86sfwf3c7s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Junio C Hamano wrote:

> * tb/plug-pack-bitmap-leaks (2021-10-28) 9 commits
>  - pack-bitmap.c: more aggressively free in free_bitmap_index()
>  - pack-bitmap.c: don't leak type-level bitmaps
>  - midx.c: write MIDX filenames to strbuf
>  - builtin/multi-pack-index.c: don't leak concatenated options
>  - builtin/repack.c: avoid leaking child arguments
>  - builtin/pack-objects.c: don't leak memory via arguments
>  - t/helper/test-read-midx.c: free MIDX within read_midx_file()
>  - midx.c: don't leak MIDX from verify_midx_file
>  - midx.c: clean up chunkfile after reading the MIDX
>
>  Leakfix.
>
>  Will merge to 'next'?

I think these leak fixes look good & that this should be ready to go.
