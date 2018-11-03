Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3F81F453
	for <e@80x24.org>; Sat,  3 Nov 2018 00:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeKCJtG (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 05:49:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34704 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeKCJtF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 05:49:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so2217457wmg.1
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 17:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5h25pqTUx+q7YITpxojGxzgYB++pBjYFjzHJWpzb7Ww=;
        b=urGuao+hmt3pCuBlQAgnevSqEBNqQAIQYXCNy41hUcEIZYLfF9CP4OZ9ZDwRtkg6I+
         sioS0VFkO62vKt6m0E8eifirpYPAY0VmaQgFK4+I1aI7imx9hckI111rW5o/2XSncxcX
         4liuz9mK182t0fQ1EhKCi2jOdIgsidK+HHZZ6JQtPsA8UlXELhfyE3WNnAMIJAiF3EPU
         aGqcWx5FRaDYmh0hZ544sxVn19LFTZkyN4ur02Mq0ypa88O/gM9QWTReBRyQs9iEwij2
         RFOkaFfmZVrSYmazX6GjVPzqAIMGp60BFXs96hDZQrNuUAP/BeVBN6WTlFHKjtFdYEem
         RYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5h25pqTUx+q7YITpxojGxzgYB++pBjYFjzHJWpzb7Ww=;
        b=fCXJ6p71SLjlr1dmnCr/fZ1BvIul17gs7x+aMkxQjGfSbdadnv/oHd1jOoAQx23API
         ary/QmrnOyy/g1AmO8gkGJPXiS1y1JKMsAgFSPWA7MsTcJeZEcEPXpFnbEKpOeNNAh7o
         sRPPd6pZ6MbFuTlwKS3COawB2W9GEYJTq+f9zzd5vWPKcknLSExEm3u44vMmrqcYP3bG
         OWsIUvpxq1A8AIL0SjP69CXR0ikKzLlEmVUE3Cw3nyVf44saBy2TW6yMjB4Lou5M4Y/x
         S/sOETNMMUJZtURHofshpScg4xKvRCJCSSOmIpurJB9G92FfRoXBimMVKlPHYUG4Y5ze
         QYUw==
X-Gm-Message-State: AGRZ1gJibMBbWHH83LjWwCePHttMzDhDxM81CsRurlkJKY4pZD36/0bT
        rQ7gMDzH26W2DDYxwsenfP8=
X-Google-Smtp-Source: AJdET5dlCcsGi8V+rp4P4D8n0rJ3SrhCZm5OJ2qRI9XjaKuxxWhDDOg0HFpgQG+jKReFyWLO1H36FQ==
X-Received: by 2002:a1c:27c5:: with SMTP id n188-v6mr108799wmn.88.1541205580044;
        Fri, 02 Nov 2018 17:39:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x8-v6sm85875091wrd.54.2018.11.02.17.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 17:39:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Steve Hoelzer <shoelzer@gmail.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
References: <pull.64.git.gitgitgadget@gmail.com>
        <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
        <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
        <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
        <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
Date:   Sat, 03 Nov 2018 09:39:38 +0900
In-Reply-To: <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org> (Johannes Sixt's
        message of "Fri, 2 Nov 2018 17:43:43 +0100")
Message-ID: <xmqqin1fngdx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> Yep, correct on all counts. I'm in favor of changing the commit message to
>> only say that this patch removes Warning C28159.
>
> How about this fixup instead?

Isn't that already in 'next'?  I didn't check, though.

