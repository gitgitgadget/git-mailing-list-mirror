Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDBBB1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 19:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965624AbeBMT5T (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 14:57:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37143 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965589AbeBMT5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 14:57:18 -0500
Received: by mail-wm0-f67.google.com with SMTP id v71so18127035wmv.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 11:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HOoxUhAq7M5DFUKYQEKIF+EhUWcwAUZ1/PO0XChGLb8=;
        b=dcal3QluPA565CIS5Em0nnHKuFdj2C8Itej0So/qoeL2FsczAovxZ0J8F/JFVFqZ8j
         95mR0M5KpX/9MpZwVFk96q6FfJmZgu/8XaRHw8nWom3g8c3nlswMWd80qTTyU2Badv2c
         hUUAmedLZCwPbTumS+yNc2RA4V/AnlFlLdwEQEt4f0NnHYVw4KKn15F9aUlg9//tpVY/
         GQ8rSKpxwpxToRuhhICykI9XWJyPusYmkX4NWFpmjflBZ7+QvVFjUL12svkBzjkb4447
         3PtzfDtDaC5HnV1WBjPLEOHFQdylCVSXubE5SVnDhNlq8UBG0RyAT/AGzUpzdY/xYAxH
         cLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HOoxUhAq7M5DFUKYQEKIF+EhUWcwAUZ1/PO0XChGLb8=;
        b=dSGmKbvfD4g4M5w2zayOzUdMwQ24yghZ628FIR8NKivsVsTsZdxIQUaH2jxA6nwr6G
         iMIl/5THPJmc/2UnIp+PMZmHe0ViBVUYqLsuz2mYa8Z2oChsJZfvWq1KsaBi9gKKEdtf
         tQl4Mo5yQvEb+vVaXx8ms0DXESn8ad1lMF/5tBICE/Q2OE8IzpBi29UqofJIrkda+zgl
         EbigRE7pQ/K8aAsnzMtTwEzi5NxeUis61XHsSoMQd+YSegWhOX/1kImE+rT4cNS7z1E/
         Wij4Vpv3zNuMSooMFW3557R7gchtj+0KXk7HYMX6pUAQd23Ky5VlO6SLaEuMBptVndCg
         Y88Q==
X-Gm-Message-State: APf1xPCNqp5WX8TKW3uJd/HzULxmCkYzIJGMX0lUMoRQ0u7P1/j2QOwa
        e6oFZyQ1ok/6Gen6lssTmJA=
X-Google-Smtp-Source: AH8x227IbWyVusKYxiHz4mjtY9WSfoHWsDC5HDFrUcLi8w5H4i/00EgNQS6XtHDnoB+/GyBgfpqAdQ==
X-Received: by 10.28.156.67 with SMTP id f64mr2377020wme.11.1518551837371;
        Tue, 13 Feb 2018 11:57:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u20sm5974943wrg.13.2018.02.13.11.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 11:57:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, l.s.r@web.de, stolee@gmail.com
Subject: Re: [PATCH v2 0/2] Refactor hash search with fanout table
References: <cover.1517609773.git.jonathantanmy@google.com>
        <cover.1518546891.git.jonathantanmy@google.com>
Date:   Tue, 13 Feb 2018 11:57:16 -0800
In-Reply-To: <cover.1518546891.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 13 Feb 2018 10:39:37 -0800")
Message-ID: <xmqqvaf0psrn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Updates from v1:
>  - use uint32_t so that we can operate on packfiles of up to 4G objects
>    (this also means that I had to change the signature of the function)
>  - don't hide types
>
> Derrick: you'll need to slightly change your patch to use the new API.
> As for find_abbrev_len_for_pack(), that's a good idea - I didn't do it
> in this set but it definitely should be done.
>
> Jonathan Tan (2):
>   packfile: remove GIT_DEBUG_LOOKUP log statements
>   packfile: refactor hash search with fanout table

Hmm, is this meant to replace the topic that was merged to 'next'
last week?

>
>  packfile.c    | 29 ++++-------------------------
>  sha1-lookup.c | 28 ++++++++++++++++++++++++++++
>  sha1-lookup.h | 22 ++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 25 deletions(-)
