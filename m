Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D32CC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 03:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiA0DrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 22:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiA0DrI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 22:47:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0269BC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 19:47:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ka4so2766296ejc.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 19:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hb0bXLpKyZTdmZ4PqJNQYORQSk4Y8QNCl77y0VsHZh4=;
        b=WybKiwTdLSOwDYinEZzruFHPqBTe7PTQnkIyPvUUvVTmZSF8EK4nIM6OZqpvK4H7A5
         SodoIRCA/RgPaxmUYLIoUSI0vKjZspOsmblMg4bvbSwpE41EwrBHa78POXdkUlDJ0Pqy
         5wfWYpE3XXrHYr/G67NVKYY+hVDG5ieixjAZZC4tMAjTfsWWqD5ohOYAAEoZsJTO4QJx
         o2WWxPWjMCmuRsjlHo3yTDhJmEdvu0R0x04DBdhyp5+GwFxNmcdxO7lu8ZadxOlHV9Py
         cc4ag9vAnbdISNxMlgQ/Sv/Ukh+ZVBpgoYXbiKd+WSUkjogrVwCDk2GK2aMq9Dgh1WJp
         48oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hb0bXLpKyZTdmZ4PqJNQYORQSk4Y8QNCl77y0VsHZh4=;
        b=gfrfHcWLfwH+i3jey0rAUfMHmPjfZgTZEqjKMZZHmOe5gmUesgdrQnT9ElTfJqWn1H
         uE4I4+GEJk6oxlw4oUlJ2wXdE3aGkxewDxrsD9U69BiS0nFJNEGhhbXqjQplMO0fhKbI
         AtbuWdTLHx1Inc41UqcEaaXF75+BjJgVonrgzig3h0HNVRMxcRpags0SrQlX97Oqx/LN
         UJEsOF0lbSckp3diSnc1SB5jrVmWurPCc4F9hD2wCXCVGWlwjf+V6FAGzAfJ3D83+wvl
         J130ksSn82usFlVKgr/CxGepOpT3D6wDjlW4rfzpCnenNvNXQv2w3sKPp0nTsp9PRsNi
         2sCw==
X-Gm-Message-State: AOAM533+iRkLZBTPHjVKGgrtfkck0XasoYTrasg0hG6qJ3HONPm6EUkV
        6LKT16n42uHx1+fySvotzUkTqQkPYWVcFw==
X-Google-Smtp-Source: ABdhPJyhPeL1OptR41SZCQfVY9QFaGQEpfj+iWzIdVEm3mtHsubGx2/UOHc9fq0KegO5tOsn6p5I7Q==
X-Received: by 2002:a17:907:97c3:: with SMTP id js3mr1580617ejc.232.1643255226444;
        Wed, 26 Jan 2022 19:47:06 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v10sm10666219edx.36.2022.01.26.19.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 19:47:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCvkX-003HSK-Cn;
        Thu, 27 Jan 2022 04:47:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http API: fix dangling pointer issue noted by GCC 12.0
Date:   Thu, 27 Jan 2022 04:45:19 +0100
References: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
 <xmqqczkengsg.fsf@gitster.g> <xmqq8rv2nggn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq8rv2nggn.fsf@gitster.g>
Message-ID: <220127.86mtjhdeme.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 26 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I am puzzled by this error.  The assignment is the only one that
>> assigns a real pointer to the .finished member, and until
>> finish_active_slot() is called on the slot, the loop would not
>> leave.  I would understand the error if slot->finished is used after
>> the function returns to the caller, but I do not think it is the
>> case.
>
> IOW, I am wondering if this is a mistaken compiler that needs to be
> told not to raise a false warning.
>
> If the motivation behind the original "do not get fooled by a reused
> slot still working on somebody else's request---instead return when
> our request is done" was indeed what I speculated, then the pointer
> slot->finished when we leave this function should not matter to
> anybody.  Would the following patch make the compiler realize that
> we never smuggle a local variable's address out of this function via
> a pointer in the structure?
>
>  http.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git c/http.c w/http.c
> index 229da4d148..85437b1980 100644
> --- c/http.c
> +++ w/http.c
> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *slot)
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
> +
> +	if (slot->finished == &finished)
> +		slot->finished = NULL;
>  }
>  
>  static void release_active_slot(struct active_request_slot *slot)

Yes, that does quiet it. The GCC warning is specifically about pointers
that survive the exit of the function. From the commit that added it to
gcc.git:
    
    +      /* The use is one of a dangling pointer if a clobber of the variable
    +        [the pointer points to] has not been found before the function exit
    +        point.  */
    
