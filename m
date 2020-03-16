Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30847C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 12:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058D220658
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 12:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHprdK9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgCPMLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:11:02 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:46204 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730911AbgCPMLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 08:11:01 -0400
Received: by mail-qt1-f169.google.com with SMTP id t13so13809898qtn.13
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Un8V5RkFltyQXspZ4DMm5HFQD407vFk+LTleU/XafnM=;
        b=CHprdK9aAutprVYQxvWZGNNeJq5Wvg4HQBE3Ts1FB7k+XYgsE6vcbpUHMP+isUkfxg
         Th71Lv05mFQfZDIzb+FeOs6K04ftI1b0zHjXXBkyD9DvgZORBvDMUX82uANcAiLwnEcY
         FxJuTWq/EVFggyc7hDeB/0gX8ElIbrobgnUkHCnH+Z3afXFf7oxK0r4GVF4434cygVvB
         Wf1cwYp0gb2vtVRpERt+3T7S/prs7YQtxjypVqX1+ECLZXkTHZ2ZI87j6UeR++OzFoOt
         jNlsq4QTkGTar8H/uQ1kZNMQyvbo1+SAf8QkrNIDPDLrEJO8dSMT6WwtLGxJIzuBblce
         iMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Un8V5RkFltyQXspZ4DMm5HFQD407vFk+LTleU/XafnM=;
        b=WwmXd9HAGBNJj1utrKkr2YyWHCB0LvG2C3urQQ0hpy89XU0+nArU6aApKExmvKL6p4
         wBVr9Q2oY+gq9IEfvbrADFsihEd78s+Hbfwkduxvqh2IggwZmywHM3197gwy8xaOald5
         H7sbcLm1JYu0cRSIJVuHNCliL+e7xYYcxOX5ohleTSw1BVomLI2vwRj3RYfEA2RHTVnz
         ZHstDmDUpgupKOYDAIy+HdxIbXftyeoEZ+bI9U2xTxJc3lgGUwjPV+E2EcSOtNUwtZwC
         CDotL2mxaMARxhZGLcyC6omaJ5dlyuNU0uzoBStoJOLMX2xntzBr8yENGLtXUv+r3M7U
         nidw==
X-Gm-Message-State: ANhLgQ2b0UjZUv7VX/AjFl/RpM/BOqiov+9k7TJ8RPYr7qVQKedNUoYS
        my7JQw3BHlixorOjWixNQnE=
X-Google-Smtp-Source: ADFU+vtM/EDqBlYvAMaKpTl990a6jOiAuCsSqKKBh/Y5wV89UOC54/XfGgwzYFMwe/TxOFJYU4Im1Q==
X-Received: by 2002:ac8:4906:: with SMTP id e6mr24909887qtq.178.1584360659115;
        Mon, 16 Mar 2020 05:10:59 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u13sm34906063qtg.64.2020.03.16.05.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 05:10:58 -0700 (PDT)
Subject: Re: Avoid race condition between fetch and repack/gc?
To:     Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org,
        "peff@peff.net" <peff@peff.net>
References: <20200316082348.GA26581@inner.h.apk.li>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <759f4b3b-28a7-c002-ae51-5991bf9ad211@gmail.com>
Date:   Mon, 16 Mar 2020 08:10:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <20200316082348.GA26581@inner.h.apk.li>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2020 4:23 AM, Andreas Krey wrote:
> Hi all,
> 
> we occasionally seeing things like this:
> 
> | DEBUG: 11:25:20: git -c advice.fetchShowForcedUpdates=false fetch --no-show-forced-updates -q --prune

I'm happy to see these options. I hope they are helping you!

> | Warning: Permanently added '[socgit.$company.com]:7999' (RSA) to the list of known hosts.
> | remote: fatal: packfile ./objects/pack/pack-20256f2be3bd51b57e519a9f2a4d3df09f231952.pack cannot be accessed        
This _could_ mean a lot of things, but....

> | error: git upload-pack: git-pack-objects died with error.
> | fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
> | remote: aborting due to possible repository corruption on the remote side.
> | fatal: protocol error: bad pack header
> 
> and when you look in the server repository there is a new packfile dated just around
> that time. It looks like the fetch tries to access a packfile that it assumes to exist,
> but the GC on the server throws it away just in that moment, and thus upload-pack fails.

...your intuition about repacking seems accurate. The important part of the
race condition is likely that the server process read and holds a read handle
on the .idx file, but when looking for the object contents it tries to open
the .pack file which was deleted.

This error is emitted by use_pack() in packfile.c. I'm surprised there is no
fallback here, and we simply die().

The race condition seems to be related to the loop in do_oid_object_info_extended()
in sha1-file.c looping through packs until finding the object in question: it does
not verify that the .pack file is open with a valid handle before terminating the
loop and calling packed_object_info().

Perhaps the fix is to update do_oid_object_info_extended() to "accept" a pack as
the home of the object only after verifying the pack is either open or can be
opened. That seems like the least-invasive fix to me.

The more-invasive fix is to modify the stack from packed_object_info() to
use_pack() to use error messages and return codes instead of die(). This would
still need to affect the loop in do_oid_object_info_extended(), but may be a
better way to handle this situation in general.

Of course, this is a very critical code path, and maybe other community members
have more context as to why we are not already doing this?

> Is there a way to avoid this?
> 
> Should there be, like git repack waiting a bit before deleting old packfiles?

This all depends on how you are managing your server. It is likely that you
could create your own maintenance that handles this for you.

The "git multi-pack-index (expire|repack)" cycle is built to prevent this sort
of issue, but is not yet integrated well with reachability bitmaps. You likely
require the bitmaps to keep your server performance, so that may not be a way
forward for you.

Thanks,
-Stolee
