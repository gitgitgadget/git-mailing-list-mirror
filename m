Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C906DC636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjBUUA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 15:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBUUAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 15:00:25 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A565E27492
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:00:24 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id fb30so3114896pfb.13
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UTyO9B/LDlMAzNX8HrG16veZDgCtab9Px3IxyRv1FE=;
        b=OKFvL9762M3/98mHGNKWXLHsLWDK9u+lp5kzNNbWHQfqaYPKJAohZyFDujyJUJ2WoG
         fdO0i4201dxAiGj6k0xPuDzNBTQVMw1ppIlU19YcwQyO38zlzyqKOVGyoqqaoqgh4trf
         +CGRCyMoa7AWCnt8aHL7KXXl/jNM8mtIldMZwZYqvyQIgFkhF579DdtZsCqJaiOh21y6
         tagTsmmGW6AoCfhNo3ytQ9zDvH4483zXEEIZ6NQykJRVYDgUVQDhzOeYb6iNHJ7m9+Nu
         jb1mSUpq7iYbatgHWLo3ovaBj8XLX/oVax45O3gIOrRKa6KctYx4J36jMyaHGw392wR1
         u/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0UTyO9B/LDlMAzNX8HrG16veZDgCtab9Px3IxyRv1FE=;
        b=QQjiubIHjcf2+L7Fd+87ldCaw6ln+Lhld6OVVdZmhkPeAZ3XvZQVoRRyIR1LE/2B2J
         3cPRYedTqMj5i9ePjnlJ1XLWKEeVB4N1Uptpx2iYSEoFwyH8bB2sDn7Lnxvp8JibPd1v
         Sv5bWtKIrtlnvnP0bsqBpVfOHY8O6SADR074cOIhCwzuTF491r5GrD1SJGX9qSgGQt2j
         Z1v6esHCnSgrPqHbPjuHppgxyoQobLIHa0P4CX3tXlutmV5TNb+aOSK3tKB2K4Gkp2XM
         g7+KrGieJ4gr6auNFFLgl2cWD6ObkjSuq3KiEaIalRUH+QjjsyeZwK/gvp+9/knaTkni
         vt8w==
X-Gm-Message-State: AO0yUKU26uAY70uKGf/9oVtY/SI53jp/IxD4bPWoxDDMYccXT638qf/K
        km1llDI1ULirpvUAqxNaTx5GJZGWLtA=
X-Google-Smtp-Source: AK7set/u4CX5mnqJBupRX9MlsJoD8HF4AXG8/z66WoJyJolq9cZFgSMJTrjfyEzDHjPiNIwa0ByWlQ==
X-Received: by 2002:a05:6a00:1817:b0:5a8:445d:d352 with SMTP id y23-20020a056a00181700b005a8445dd352mr4639979pfa.11.1677009623990;
        Tue, 21 Feb 2023 12:00:23 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t17-20020a62ea11000000b005ac8a51d591sm6602421pfh.21.2023.02.21.12.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:00:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Idriss Fekir <mcsm224@gmail.com>
Cc:     git@vger.kernel.org, cheskaqiqi@gmail.com,
        christian.couder@gmail.com
Subject: Re: [PATCH v3 1/1] trace.c, git.c: remove unnecessary parameter to
 trace_repo_setup()
References: <20230215104246.8919-1-mcsm224@gmail.com>
        <20230219002527.84315-1-mcsm224@gmail.com>
Date:   Tue, 21 Feb 2023 12:00:23 -0800
In-Reply-To: <20230219002527.84315-1-mcsm224@gmail.com> (Idriss Fekir's
        message of "Sun, 19 Feb 2023 01:25:27 +0100")
Message-ID: <xmqqttzeeqlk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Idriss Fekir <mcsm224@gmail.com> writes:

> From: idriss fekir <mcsm224@gmail.com>
>
> trace_repo_setup() of trace.c is called with the argument 'prefix' from
> only one location, run_builtin of git.c, which sets 'prefix' to the return
> value of setup_git_directory() or setup_git_directory_gently() (a wrapper
> of the former).

The former is the wrapper of the latter, though ;-)

> Now that "prefix" is in startup_info there is no need for the parameter
> of trace_repo_setup() because setup_git_directory() sets "startup_info->prefix"
> to the same value it returns. It would be less confusing to use "prefix"
> from startup_info instead of passing it as an argument.

... but for commands with neither RUN_SETUP|RUN_SETUP_GENTLY bits
requested, the prefix is set it to NULL by run_builtin(), and
setup_git_directory.  What value does startup_info->prefix get in
that case?  If we know it will always NULL (and I suspect that is
the case, but I haven't followed the codepaths myself to find it out
lately, so you should without taking my word blindly), saying that
at the same place you mentioned the return value of setup_git_*()
functions in the first paragraph would make the reasoning perfect.

Otherwise, very nicely done.

Thanks.

