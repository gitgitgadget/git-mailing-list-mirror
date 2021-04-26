Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AE5C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3915261090
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbhDZUMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:12:52 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:45874 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbhDZUMw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 16:12:52 -0400
Received: by mail-ed1-f45.google.com with SMTP id d14so3418120edc.12
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 13:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUGLLxJyBH84XDSEkO15BXNhzRXfqDWw6c3W80oLQ74=;
        b=iL7atfIjEoXmuzanAqt9w8O84uaujpeXDDArJv8DIj8QwAu0Iob2zb5hlrEvGfuyH4
         qFAmRwVw4x01dVKRCujbCCogQwwBDn0HDjRKWqBMaeJr4OZAK1Idf7c4IfZ3yFJJx3Pi
         m6tilac55aemCOL4Vfq+/7pkgyxMe5rzup0/gPBMUL8MR5PcUZDViW1mcv8fckORqeop
         MXAtixOI7oG8nooaAXvday0YVIeCJ97lE1wzo/EdIetpAJQOyIWcnJGjjJvWBQMR0j1E
         Ee9iM1vGNBxxyTTJVfw2mztDTivEy2A7IHRXvLDEdMDK2I9SnGL+gGoJKYs1QUZPKVxS
         z5Cw==
X-Gm-Message-State: AOAM533ElQrGmb4w/oqHZqLTgq1kUos/Iw0ti3NoCnqY/KoOQq0dgM8n
        N/MSfvnP33PVZ0ZMQJekU5Y8xoQ+JBa6fZk0YlE=
X-Google-Smtp-Source: ABdhPJwnJz7l8WFgQVQIBlixW0eR4ikG1YLAQvwXTwcPbn/y0chkAQ1SrZHXHUjUigCcDsoMqqy2lBQv2n+vGFNBWEA=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr431540eds.291.1619467929385;
 Mon, 26 Apr 2021 13:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <451563314d84f9d6dee29a4899b5d18033aa227d.1617291666.git.gitgitgadget@gmail.com>
 <aca24c96-33ab-3b90-bf21-0da19283a3d7@gmail.com>
In-Reply-To: <aca24c96-33ab-3b90-bf21-0da19283a3d7@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Apr 2021 16:11:58 -0400
Message-ID: <CAPig+cT1yz-M1MYTx1_HQRYe+Ryy=vzwtRgkhkX7bTYDB5rnkA@mail.gmail.com>
Subject: Re: [PATCH 10/23] fsmonitor--daemon: add pathname classification
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 26, 2021 at 3:17 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> > +#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
> > +
> > +     if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
> > +                     strlen(FSMONITOR_COOKIE_PREFIX)))
>
> Seems like this strlen() could be abstracted out. Is it
> something the compiler can compute and set for us? Or,
> should we create a macro for this constant?

If you're asking whether the compiler will resolve strlen("literal
string") to an integer constant at compile time rather than computing
the length at runtime, then the answer is that on this project we
presume that the compiler is smart enough to do that.

Or are you asking for a function something like this?

    fspathhasprefix(rel, FSMONITOR_COOKIE_PREFIX)
