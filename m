Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E823C61D97
	for <git@archiver.kernel.org>; Sun, 29 Jan 2023 17:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjA2R0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 12:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2R0n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 12:26:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7EF1CACE
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 09:26:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m11so9158957pji.0
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INQGLHigzjCyng/9hQPEVR9QuCvUkcW0ST7+wRpwkPA=;
        b=CXKV3VZeoI+t9d8Vl7dWbP+zXmE8zDbcBn6SAd6QewWQ2fOfOZrY1OsktDNmged+Gf
         xaT2zXeYzgVDD8TnA8dNROoSW8ZJe7KXwn3FSo3riq4eu858CR9jA0dDZAHonwdwm5QD
         4Yhosu19MYjEVjsCdH2YFfMVV6aLvggkm3/rwGN0z6/APUCA6zAwxvFbD1kRP697xU7d
         D45bJc0W0VMlRrLDLF06s0zWlOoGz5F1RAX8qKZI7dP9pofLwFbOpnckvuOvYc410K9l
         blbnIfW4ieJs9ip1dWA4Fu4+zho3I1IK4ZZPlaxYu9XZlMAGLDNu5bq2sI8mndg8H4CI
         rPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INQGLHigzjCyng/9hQPEVR9QuCvUkcW0ST7+wRpwkPA=;
        b=48sYJ5xXc8iMRSvUuBlGhUJ6UqLlVfX2qaGnmrtogGD49ZrqsIhrIT0kv2DNkU41u9
         BkpTjgDBpu0HjilkB2nIcfGDseziGKDHqliLJ/Rsf2SMU8G3UcWlMRWKgfcP4prYCxcF
         L3KQkblIzf+O2Rzo1gSHJFUi04gL7YaJDFjzkjuNtA9WjNw8LxRsBOkuAaVW2g6druPW
         8nly72DYqu/U+bbwkVc7pKma2m5VqHH6JLJvmyOe6l6X7V/r5MTRqIEL9oIjKGnxL41B
         Cg+8FIWV0BFxfVPvNVcXDKUTuHyyNBnaOrcIRtlpftP5kI9lCH8xPhEdC3+NwaFGEuh0
         JJaw==
X-Gm-Message-State: AO0yUKVHHqfm4I1sfmxsYFjBwCkQPLwng2HBT1yD1UFcLgLwBScNqZea
        jq9E3VFyQnreA9/8w44nI5c=
X-Google-Smtp-Source: AK7set80fifur6dXZ9/1iiI6mDDZcyM89H1PN431HvWhrQOCEd/Z2n21eznrBu1ftGsCVqbjMfPbvA==
X-Received: by 2002:a17:90b:33c6:b0:22c:aaaf:8de7 with SMTP id lk6-20020a17090b33c600b0022caaaf8de7mr289642pjb.5.1675013202009;
        Sun, 29 Jan 2023 09:26:42 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id h132-20020a636c8a000000b004e613cc1f58sm1558129pgc.57.2023.01.29.09.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 09:26:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v3] Documentation: clarify that cache forgets
 credentials if the system restarts
References: <pull.1447.v2.git.1674936563549.gitgitgadget@gmail.com>
        <pull.1447.v3.git.1674936815117.gitgitgadget@gmail.com>
        <Y9YWruI4CdbJ9Rjn@coredump.intra.peff.net>
Date:   Sun, 29 Jan 2023 09:26:41 -0800
In-Reply-To: <Y9YWruI4CdbJ9Rjn@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 29 Jan 2023 01:48:14 -0500")
Message-ID: <xmqqfsbt6ylq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jan 28, 2023 at 08:13:34PM +0000, M Hickford via GitGitGadget wrote:
>
>> diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
>> index 432e159d952..f473994a864 100644
>> --- a/Documentation/git-credential-cache.txt
>> +++ b/Documentation/git-credential-cache.txt
>> @@ -14,10 +14,13 @@ git config credential.helper 'cache [<options>]'
>>  DESCRIPTION
>>  -----------
>>  
>> -This command caches credentials in memory for use by future Git
>> -programs. The stored credentials never touch the disk, and are forgotten
>> -after a configurable timeout.  The cache is accessible over a Unix
>> -domain socket, restricted to the current user by filesystem permissions.
>> +This command caches credentials for use by future Git programs.
>> +The stored credentials are kept in memory of the cache-daemon
>> +process (instead of written to a file) and are forgotten after a
>> +configurable timeout. Credentials are forgotten sooner if the
>> +cache-daemon dies, for example if the system restarts. The cache
>> +is accessible over a Unix domain socket, restricted to the current
>> +user by filesystem permissions.
>
> This version looks good to me.

Yup, it looks good to me, too.  Thanks, all.
