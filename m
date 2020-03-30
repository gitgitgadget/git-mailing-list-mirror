Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428CAC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 20:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172842072E
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 20:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7eiguAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgC3UD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:03:58 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:42159 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgC3UD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 16:03:58 -0400
Received: by mail-qt1-f169.google.com with SMTP id t9so16284504qto.9
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:mime-version
         :content-transfer-encoding:content-language;
        bh=LSah7NDevXLEh/S9H8azelrEaAOI52QKXKOXry+UV20=;
        b=L7eiguAZDIM9X7OrDyD/EGpQxrJT/bfGBCrw8YMOXrqK5ZHJQw6E4Mz7kfUPSURrtf
         bHoL1R8GF7kXqI4szcZShkG/yIIfrBhajgV5g1n3GdINEe8FmZyvA8oDI5YbLLabFSyl
         U+CnPxFrggXe5/1gamTbkj7P0XRPlgQIvqY8/4TOo5r6uyzj7V9Jzrbq7tbRl1fKJmsy
         nXU7IIt5T7MmFHISNuqN2ALHTfV6KxZ89O6umOUwtegNcgsCXe31k0Ey+vm8XpH1pZIw
         J2S/896Rn8NhJs+VIqK6wKLNyBfHwUf+Ew4+jMYLO9lRfCyYFhxfqCvqlzHe2Y7cJGGH
         aAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :mime-version:content-transfer-encoding:content-language;
        bh=LSah7NDevXLEh/S9H8azelrEaAOI52QKXKOXry+UV20=;
        b=CpH+F0qP9L1zFL80dwe46RyKevObrMffo/73SKuGN1uCBCNZXddFaJh0P0ZmTDUBO9
         wR3CkBsrQgff2q9iWWpcEogmSEpgpiWkZzlDyBmFQLBLoe44ZZFHzJatQXi9/yG6Pq4r
         R6xYtS+jB0K7sc5yp/fSCtB1YRgqW4n8sLPD5HCcyvRWw8MNy15q1+O/+I9SmD1kXPkD
         63DdX1+afqaN/oZ7psGjn/7/Os7AAGm4SuSm2zJkt6QpN/QZU/Y3W3qnayLeOJCofuq1
         HFL7qNwst6OA1dmI8W5D9pq9j5OXDrjRf6B9tz83iwAWODUYRlWscGGhdzB0gikcmrxE
         eh/w==
X-Gm-Message-State: ANhLgQ362tR9KCKPeDARCI4ZRCORDST6J9qXrH0zjPmbw8xHumPgKoDk
        RYbg027MJx6dD5yekFFbAwCApqGH/EU=
X-Google-Smtp-Source: ADFU+vuolcOfy7AGJGmlEB901UeOLLcSem65Iua/MpKdCfG5zLkBAAtG1FTQqZNu2YlfI4yFTgomzw==
X-Received: by 2002:ac8:3f3a:: with SMTP id c55mr1770659qtk.281.1585598636554;
        Mon, 30 Mar 2020 13:03:56 -0700 (PDT)
Received: from [192.168.102.5] (pool-71-182-232-12.pitbpa.fios.verizon.net. [71.182.232.12])
        by smtp.googlemail.com with ESMTPSA id x65sm11175523qkd.65.2020.03.30.13.03.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 13:03:55 -0700 (PDT)
To:     git@vger.kernel.org
From:   Dominic Chen <d.c.ddcc@gmail.com>
Subject: Support for `--no-gpg-sign` in git rebase, cherry-pick, etc
Autocrypt: addr=d.c.ddcc@gmail.com; prefer-encrypt=mutual; keydata=
 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
 SP1d4L0/7aR4qw==
Message-ID: <81aea443-6978-93d7-c5d3-98dd731a1fd8@gmail.com>
Date:   Mon, 30 Mar 2020 16:03:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

The subcommand `git commit` supports a `--no-gpg-sign` argument, which I
find useful for cases where e.g. a GPG key is specified in `.gitconfig`,
but is located on a hardware key that may not currently be attached to
the system. However, other commands like `git rebase`, `git
cherry-pick`, etc, which internally invoke `git commit`, don't support
this argument at all, making things more cumbersome. It'd be great if
these other commands could also support this argument, and propagate it
internally when calling `git commit`.

Thanks,

Dominic

