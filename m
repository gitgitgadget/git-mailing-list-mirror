Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F98CC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 08:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjAII6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 03:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbjAII5V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 03:57:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AED1B1DF
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 00:50:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so12035463pjg.5
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 00:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylthqK0wGjTZE1z0PPTAuVy9Im/xoViLJzlA0T5Mzoc=;
        b=oKEqKWZRarLLEsTqwCbWnxB3vxXzb1c7NHmkl1xR1WxIk3DlYuqNMsn/KNBgzQeL2E
         AwRUgxcdLyfYC4FjVn7r6egqxfvu/exyyq2LXTyyrUtMSbxuVzIaqCSKA4JNyA069r3M
         yNN1soNKB8/LK5++NbDhGbcOkZ13lUXePAg0dzqzperGUojE7S9fF1wi42CQefp7vQL/
         eUOElKtTcocnuQGlExsH/GzGHpsFUE5hB96TXv+40mEJGKaqt2o1jHp279e0N0kcffdj
         PsxwQ1+EH/dd5A0+OxAUIoBDGtK9hdK8hXeHo6+JZhx+jc4W8paz82pzqsZ5/yA7I886
         u2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ylthqK0wGjTZE1z0PPTAuVy9Im/xoViLJzlA0T5Mzoc=;
        b=LCFW9Y1opjdqogAN2wBmXQQ1h/+8LNQGJpFMBWEAxQxnDXlzFFDYMVnDOS4/BIJwMD
         s5Ksoo+2DX/jXuzAHcY1XcMXISW4nxV7arloNw3/BkbsjR6EWepC3nNpDR/5n6GjKMpo
         2xg4zwUAmOp26Fi2vIBcG62EULJ2LqDYlfZZPK+w+UhxhKVXqmwEC1ZSq9f3zG/LG6pP
         ixcJuAPJjniqLJDUFIXm89HprPiEhDCivXLCQJvtlZXQnkbFONwfAfUPzW4BSbPp2yMW
         yMQMNRa1j2v68TORhqXyHMFpD0BXeqmKck+WwrFN65a8LgfUvhOcrhCc3Ny57raTdiCx
         +iGg==
X-Gm-Message-State: AFqh2kpW38MinSp9/+X0WnXZGhvHDYgz/uLKU4psq63wYujIbm7pj+hU
        4DUEjvJjSJeX5UfXOt71jkw=
X-Google-Smtp-Source: AMrXdXuoY5ncUb2+Ra9HR1YjZv8gmUuV+NivTRZM57ChmeKCBT9H7BGkQS7ffwBiV2UlbGXEVhA1Nw==
X-Received: by 2002:a17:903:2652:b0:192:8e0a:16b with SMTP id je18-20020a170903265200b001928e0a016bmr43103361plb.14.1673254197993;
        Mon, 09 Jan 2023 00:49:57 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l17-20020a170903245100b001890cbd1ff1sm5540688pls.149.2023.01.09.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:49:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Harshil Jani via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>
Subject: Re: [PATCH 0/2] Remove MSys Support
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
        <xmqqmt7lxxr6.fsf@gitster.g>
        <9933d992-ffd3-b43c-559e-0de819408cda@gmx.de>
Date:   Mon, 09 Jan 2023 17:49:57 +0900
In-Reply-To: <9933d992-ffd3-b43c-559e-0de819408cda@gmx.de> (Johannes
        Schindelin's message of "Mon, 9 Jan 2023 08:36:40 +0100 (CET)")
Message-ID: <xmqq7cxwum6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I need to note that Harshil and I have been communicating about this
> patch before it was submitted. So here is my explicit ACK.

Excellent.  Thanks.
