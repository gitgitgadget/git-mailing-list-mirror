Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F109C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 22:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiL1WME (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 17:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiL1WLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 17:11:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AE32AEA
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 14:10:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so17239766pjh.5
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 14:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1B5f/Hb1FIUXWrG5vgEVTWsOFnGKaWxFeLDHwZb7mQ=;
        b=DVmFdvZZ/hMB4rQekEfR4pCvDUOihWmZ1WUDfhzGon2aIJIstyovbDq8CktP229qxN
         rfHLc4DsUX36Qpw3KPGEL7icQ/rjiu/YYYjGGN/IvS52b/LxRNig99GxyUSgO0NBDt19
         ys3FmjGytrhxLfSOMUFYdQjhIwkkCXgffQ6w9l5KdMRmX7efbycOJMOuYRj0hmXD5+Kp
         0W40ckcx5QCm3UnjA57TV76Xi1eM24iwqUHnr34dcNCpbaKFXhJxnvKR/tSzYDEFtWsw
         fFhMuOi6zqSWLqiRXXyzQw2ujifzqDq0S9rrFzSCwMmBuos6DxH0AeMQUB83ZrBci2UF
         lbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1B5f/Hb1FIUXWrG5vgEVTWsOFnGKaWxFeLDHwZb7mQ=;
        b=MWlGv4H3jhtNRvRM0oLrtadkb5G3SuEmNDLTNX7le0d7PPPHEdP42nMRUY8Cc3bj6i
         9I218ueZYASEH5fySQxtw6Cjd8dp9LQsDKfWUc/gzRbMCag6tS7G6LsRYu/Ie9F2jdZl
         ekzHfILwFUN86D509NUs4/X3rKpp+BPQBb0Hyq8pQNiPwcWgVOz1STaY24Mln9D73s6f
         vVSG9kMSqBmsy1KxZMdchysI9xnLLt93gZTZlL1N8Xg9js8XEyWKxvdFX9uxQQgZTIqg
         SCTUX7NFx+2RSjsszbLwFLuBc/MyGxN3DRWpj8p/FR3nkxkKZC4MMYXxHpbz4vvma+DH
         eyMw==
X-Gm-Message-State: AFqh2kp8cWYn38jL5ej3vuq7ZRRFxAKTPboPQ3thlBc/Wp4ZUAju82p/
        Z/hb2dNT6X+leOmRvVaQnfE=
X-Google-Smtp-Source: AMrXdXsDhXLuWZMTxtA/PydrdLafHKmi9IBrE+QDwo0V0gnH06ypWaiSDWwuxuz5dBS1HsPFrlmMqw==
X-Received: by 2002:a17:902:c3c6:b0:192:8ec7:88cb with SMTP id j6-20020a170902c3c600b001928ec788cbmr6529689plj.12.1672265445963;
        Wed, 28 Dec 2022 14:10:45 -0800 (PST)
Received: from google.com ([2620:15c:2d3:202:c7c5:c73f:ef59:73b6])
        by smtp.gmail.com with ESMTPSA id s19-20020a170903201300b00187197c4999sm11472552pla.167.2022.12.28.14.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 14:10:44 -0800 (PST)
Date:   Wed, 28 Dec 2022 14:10:42 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Taylor Blau' <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [BUG] fatal: transport 'file' not allowed during submodule add
Message-ID: <Y6y+zkUsPhknTYH/@google.com>
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com>
 <xmqqilhwp5g4.fsf@gitster.g>
 <011201d91aca$a5db7800$f1926800$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011201d91aca$a5db7800$f1926800$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

rsbecker@nexbridge.com wrote:
> Junio C Hamano wrote:

>> This suspiciously sounds like what a1d4f67c (transport: make `protocol.file.allow`
>> be "user" by default, 2022-07-29) is doing deliberately.
>
> I have tried using 'git config --local protocol.file.allow always' and/or
> 'git config --local protocol.allow always' to get past this, without
> success.

Does `git config --global protocol.file.allow always` do the trick?

>>                                                           Taylor, does this look like a
>> corner case the 2.30.6 updates forgot to consider?

I think it's the intended effect (preventing file:// submodules), but
I wonder if this hints that we'd want that protection to be more
targeted.  A file:// submodule (as opposed to a bare path without URL
scheme) wouldn't trigger the "git clone --local" behavior that that
commit mentions wanting to protect against, so at first glance it
would appear to be no more or less dangerous than cloning from a
remote repository.

One thing I'd be curious about is whether --local happening
automatically is actually worth it nowadays.  "git worktree" does a
better job of sharing with an existing local repository, since the
sharing continues even after the worktree has been created, after any
"git gc" operations, and so on.  Meanwhile, the distinction between
file:// and bare paths is subtle enough that I regularly encounter
people not being aware of it (for example when wanting a way to test
protocol code locally and not understanding why a bare-path clone
doesn't do that).  Would it be more in the spirit of secure defaults
to require --local when someone wants to request the hardlinking trick
of local clone?

Thanks,
Jonathan
