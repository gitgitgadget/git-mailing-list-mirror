Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C3EC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE09207D3
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQRTQvZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgETO2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgETO2N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:28:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C026C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:28:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d7so4045462eja.7
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=80FobgK6xgZ/sNnG2Ifk+oNQEv/gW8VUyp7vnqQ/JUc=;
        b=cQRTQvZmeemIyPxGZ+5aoMBLShyRNxqyGOQM7wFj+PhIHGqOYgbWYV9QB4cXxg4nbg
         rAJGHtNvIzKDOj0NeuYwFozGR3kNa+88eKile5zL38Ir5IV8fVQD6eRXzO4jn0DvhNys
         P3LDHwPdH95C21P1pGhuqjPKYYJJxHCERZXN6WixJYLM9RKjgXxOXd+WfMGOObLVwVXT
         8EkhCDq2ctw94C2/00L5pW/9H33DNsGZIT2tAIE+vuR3GcOOGSMZ1vhE9LC9xQNoleqf
         Kye0UDHNwaXdEGjK5j9hQGTBFPwv0QQd8d5JXFMy2fe8DLgAV4U8UOJPkyiKhzT3ICfl
         A9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=80FobgK6xgZ/sNnG2Ifk+oNQEv/gW8VUyp7vnqQ/JUc=;
        b=mMg9CghSchmVblex7pTH9DqWKk4qAipDrz/1gZe43WGpuQ07sthySLTKquBGIFHW4M
         Jk0EbuGCAIX6dpwPeSnMNSK3cq34FjOPM6KPBOaJoSYCAR92H5joYjvEphJuplCLStCj
         On0aFBR60JQ3jXt5oMcsrQzwQEuozGqYGJk9tWFdS+mWul14BJWaJUHnNLs5FwOP5Vb5
         dpf+6rnxzH/C1RNLciCqb/Y7+vQr2FXwSJIk05cB14Hru1oNyzGZ9AHkGgVMJKUECEVW
         3AApbocfJSR6k5mhBMa5PXNsrZzmnvnLjsFNr7x94cDQFN4jcc8C8wvranbl6CntIqSr
         ydpg==
X-Gm-Message-State: AOAM533lVrF3KOsct3maq7akrvuhOTnIWah44wwdXWEJY3mlJ6zKf79V
        Qh0GxXyDAjKHqm24QLEUHWSXuRMJ
X-Google-Smtp-Source: ABdhPJw8sO1aFaqRhSNBaCDTk00UbygUlN59si7SxmKEjdymgGqZjWHqJvPVqdw7niRNn6JmlVW6Ow==
X-Received: by 2002:a17:906:41a:: with SMTP id d26mr4090271eja.217.1589984891459;
        Wed, 20 May 2020 07:28:11 -0700 (PDT)
Received: from ?IPv6:2a00:6020:22ff:ae00:d228:1423:c030:9e9? ([2a00:6020:22ff:ae00:d228:1423:c030:9e9])
        by smtp.gmail.com with ESMTPSA id h18sm2102998eji.86.2020.05.20.07.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 07:28:10 -0700 (PDT)
Subject: Re: Bug: git worktree remove and overwritten directory
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <89526b3a-297d-591d-6e12-48580d697ed5@gmail.com>
 <CAPig+cTU8+N6Chimpoa2_T-TcXxw-3B9-9pjCLz7WeOh472P_A@mail.gmail.com>
From:   =?UTF-8?Q?Jonathan_M=c3=bcller?= <jonathanmueller.dev@gmail.com>
Message-ID: <dd7c3a11-6537-74ec-053c-0c9c946c5f19@gmail.com>
Date:   Wed, 20 May 2020 16:28:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTU8+N6Chimpoa2_T-TcXxw-3B9-9pjCLz7WeOh472P_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.05.20 16:22, Eric Sunshine wrote:
> Git tries hard to prevent the same directory from being registered to
> multiple worktrees, however, there is not much it can do to prevent a
> person from shooting himself in the foot by making changes like this
> outside of Git's control. Thus, this seems like a case of "if it
> hurts, don't do it".
> 

I agree and didn't expect git to "work".

> However, "git worktree" could possibly do a better job of helping you
> recover from such a situation. In particular, I think it should be
> reasonably easy to enhance "git worktree prune" to detect this
> situation and automatically prune the non-main now-bogus worktree
> entry.

At the very least, the somewhat confusing error message could be 
replaced by a "you messed up the worktrees, please delete the 
corresponding entry in .git/worktree" or something like that. But 
enhancing `git worktree prune` would be better. It was, in fact, the 
first command I ran to try and fix the problem.

> It may be possible to special-case "git worktree remove" to detect
> this situation and automatically prune the bogus entry too, but I'm
> quite hesitant to suggest that sort of special case both because the
> implementation would likely be ugly, and it could lead to a plethora
> of additional ugly special-cases as people discover even more ways to
> shoot themselves in the feet.

As said above, I think git worktree remove could issue a better error if 
it detects multiple worktrees with an identical path.
