Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7625C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 16:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBNQlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 11:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjBNQlG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 11:41:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C34B2D157
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 08:40:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m2so17613387plg.4
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 08:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6szKLal+TTEAGpfTz69KywZtSblOiB+aLCqNmIGT18=;
        b=Yl3Fcv6aBJ8wIUyQizDj1LMIf71O+XimnPuj6LnjcwEKoRQID1Ur+GccoBSGKxTT+O
         Vf9vBJmlvdD36bp463/96WMO/mHaMZHc4U2lpMEK3A8vDr59qhdMyDe7pFyqqZDJRSHg
         ax3hQ1H8+KfefUbkAElIDUbuQSP0GIbbUGrv6dLU3PnbB0VTv0o9nVUuXMTW7FR6+YKg
         2upvI6JolI+c4jV6sEi8j2viMLY69SMxdI/wCcFPwduJiPjfEyVXlvNmiR8NvsBgS4yC
         kGJRHtRnMLZDSqBP5io61zsTYB3D8iejK2yIajKta3sbDAReRqYUMy1FvBqnX3NAysXS
         6/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L6szKLal+TTEAGpfTz69KywZtSblOiB+aLCqNmIGT18=;
        b=1mt2Aqtmi9Pm05wW7LsI2dikgEmllIlOarM/m4GI7BRa5pFPB/a+LxQ0gGTTnkqoVp
         7RneFK3KXzELBq3WEja8yRagZLlVcp/qqkPkEu+d1kS52t5IGUXhnlGYI2IjPj7jKSZt
         pWqLMRqYOxfhnHDcYbPwrrx9CGLhbgvtjxm63HHxf/tjO5RhV8CL9ylUxrmjV+WQgb6q
         7C/rBgW3DYF290rx5KcZG/bJB2viRKqUDzzoTT0+3dFRrvJO+s54sD079NXBiJ3ujun8
         0tUJZXnPWXS9GfIKt4XpHXMnlzsARPzikrWEVGe56jtDLyUem9HOEcl3PDj9b5aOHBEX
         sDTg==
X-Gm-Message-State: AO0yUKVPI6tpXa1fSn1tjAE2oIyy2cczs+bavvStMl8AC1rDZtUdtFvF
        Th/3RsjRg7oUhIKn1Wp7uAU=
X-Google-Smtp-Source: AK7set9457MBZMy/qEbMiiMm20i5GBpDE1bxhEI1u7WTpmRfLMtJKg3q4F0/tQWERVnIaFi0HQlPrw==
X-Received: by 2002:a17:903:234a:b0:19a:a9f0:a019 with SMTP id c10-20020a170903234a00b0019aa9f0a019mr3839904plh.21.1676392824823;
        Tue, 14 Feb 2023 08:40:24 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902e8c500b0019a8283f272sm6744068plg.81.2023.02.14.08.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:40:24 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
        <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
        <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
        <Y+rmNvfjIA/u81em@coredump.intra.peff.net>
        <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
        <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
        <xmqq7cwk955b.fsf@gitster.g>
        <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
        <xmqq3578924s.fsf@gitster.g>
        <CAPig+cQLRDJY_9zjEu2DdZug8h9QNSUVCzDC7W65Cm=eQ-3MiQ@mail.gmail.com>
        <Y+uwW0I0k7urZ3do@coredump.intra.peff.net>
Date:   Tue, 14 Feb 2023 08:40:23 -0800
In-Reply-To: <Y+uwW0I0k7urZ3do@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Feb 2023 11:01:31 -0500")
Message-ID: <xmqqk00k6w08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Oof. So it is some weird locale thing that scanf is doing. I don't even
> want to think about what the details could be. ;)
>
> Since scanf is such a bad and error-prone interface in the first place
> (and I'd actually like to put it on the banned list), what about just
> parsing manually here?

Me likee.

This will eradicate the only use of sscanf() from the tree;
unfortunately there is a topic that adds a new one or two back in
flight X-<.
