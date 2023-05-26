Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292EBC77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 04:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbjEZEwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 00:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjEZEwa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 00:52:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1981D183
        for <git@vger.kernel.org>; Thu, 25 May 2023 21:52:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso386751b3a.2
        for <git@vger.kernel.org>; Thu, 25 May 2023 21:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685076748; x=1687668748;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGOVNXTFGEd6VU7YHC8QRlMqv2yhnC9R/AfXSHuN94Q=;
        b=aBCufpJ8H4e6+8vVl7sobB0lE+GdyXFP8T9mnV+EQSAfQAMHn4T4xOTS4PPRB1dQEB
         XV4KjJA8JM9KiOperbsri84v/GT7OS2NtTb7ORwZy/luRN50W4BQWCh1XeztKK5Vr9vu
         CZXF9qkExeSSuPLOIlG/At/0bBUUaoGA8Sd45sRWIAPR+ZY00c/BSfplqoQVAQ/alkUp
         STY8CivoUA2RS8GRqob0JRi4cl6BQRkemsiNzingT5rhPcSDyFY/0LoKIDw3+6l6zgss
         a179IsNXgZRFyE+sMU0RGYvoGpC4YQ+EdxS0EocamD0XLPCKoLcjADrt8Yx3qPlZ58gR
         ln/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685076748; x=1687668748;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PGOVNXTFGEd6VU7YHC8QRlMqv2yhnC9R/AfXSHuN94Q=;
        b=A3EbuNIC43iAzoERIZAxu9pRvrE4mpmomteZ0PkWnv5ZiBfb6koIIUvYPdXkhxAHEV
         Ei3hgfmKycAXRAX8GyMk5gkqmz0E+UxY2APgNYWSqL1SgqsKIrcrvZTqRCj4U9/ftesJ
         1CjeDse+yebuD1pSodoAS1sOytvmoKN6ZTsXb4tXXdS/80AJrZKnH8sDlmW5KbyMY2hD
         /Hvczpvw5wKln7/C2lmjKwH6oYgPLMp5ZKmf/Y2eUt8cz38pz7VT/2hgNxtPeDaVkVoV
         dkbhK4Me3rCe+cLmlI00QwRyA+BY9pQ8OdG7EKdBM2SLP2bbGjN5LNUprXNy7wZsIuOl
         28HQ==
X-Gm-Message-State: AC+VfDynAV6Zj9i39NvAz6WzftcIHqg3GS0IBZFgYro98MBhd9ITYFkZ
        lkYkx81TyH7HROVzQsM4m5xD0N1axZVHrA==
X-Google-Smtp-Source: ACHHUZ5F4Rii5vgYNMgqQtuDbmXgJQ8mAbGQfexMgj7Hs5OwQame0nW8/A299z6f0hZ5ne3gKzh6Vg==
X-Received: by 2002:a05:6a20:43a0:b0:101:3112:c839 with SMTP id i32-20020a056a2043a000b001013112c839mr688706pzl.15.1685076748368;
        Thu, 25 May 2023 21:52:28 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id l14-20020a62be0e000000b006460751222asm1921029pff.38.2023.05.25.21.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 21:52:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-gpg: fix ssh-keygen -Y check-novalidate with
 openssh-9.0
References: <20230525031026.3554406-1-tmz@pobox.com>
Date:   Fri, 26 May 2023 13:52:27 +0900
In-Reply-To: <20230525031026.3554406-1-tmz@pobox.com> (Todd Zullinger's
        message of "Wed, 24 May 2023 23:10:24 -0400")
Message-ID: <xmqqsfbjeltg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> OpenSSH-9.0 requires a namespace option with `-Y check-novalidate`.
> This was added in openssh-portable commit a0b5816f8 (upstream:
> ssh-keygen -Y check-novalidate requires namespace or SEGV, 2022-03-18).
>
> The -n option was documented as a required option since check-novalidate
> was added in openssh-portable 8aa2aa3cd (upstream: Allow testing
> signature syntax and validity without verifying, 2019-09-16).
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> Hi,
>
> I only recently noticed the GPGSSH_VERIFYTIME prereq had
> been failing in the Fedora builds.  This began when openssh
> was updated to 9.0 in the distribution, which means I've
> been slack on checking missing prereqs since last August. :/

Better late than never.  Thanks.

While I was trying to see if the symptom reproduces in my
environment roughly based on Debian testing, I had this trivial test
script

    #!/bin/sh

    test_description='heh???'

    . ./test-lib.sh
    . "$TEST_DIRECTORY/lib-gpg.sh"

    test_expect_success setup '
            : test_have_prereq GPG &&
            test_have_prereq GPGSSH_VERIFYTIME
    '

    test_done

and noticed that GPGSSH_VERIFYTIME prerequisite does not pass
regardless of the version of ssh-keygen installed, without first
triggering GPG prereq to cause "$GNUPGHOME" to get created.
Otherwise, this part

	# Set up keys with key lifetimes
	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_TIMEBOXEDVALID}" >/dev/null &&

because GPGSSH_KEY_TIMEBOXEDVALID is defined to be created under
GNUPGHOME, would not work.

I notice that GPGSM lazy prereq forces GPG prereq to be triggered
by starting it like so:

    test_lazy_prereq GPGSM '
            test_have_prereq GPG &&

and I think we should do the same for GPGSSH_VERIFYTIME for
completeness in the longer term.  The current users of the
prerequisite all seem to trigger GPG prerequisite check so
this is not all that urgent, though.
