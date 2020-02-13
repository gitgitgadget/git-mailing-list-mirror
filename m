Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE1C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B0820848
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgBMX3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:29:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35478 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMX3x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 18:29:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so8833375wrt.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 15:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bRayr3SoeOyHtV387DTrfWY8pdUAqKoo8aXc6eDl5I=;
        b=K5jQjh/xmt9PwE6n2OmijWn6Q5j9L5Yrpvko4SerAC8VnsgVbeZ+POol0NoMmKQ8AG
         30doj6WBffNKqZvdeIQkb8bj7BHphVB2j7RTczxDSG+gtcf6Ym/UK402wLI9gKb4XLi2
         cRTVnuMkqrQj1nwvdy7wQk9+kk4xOJ6GK/3REkRSJo56FZvueBH/nPM5F/LAqRXRFQPY
         LfYa12QikCH9SRFMZ4wVRUHHY8YT+L8A+dQuT+PMurtDmvfvmh4ZqGvYJTFgMkdDJsG6
         G1Kwz/a+ZachNn7YFS6ogdOHtdjSavYJoL/NMVh6cEhpQboTQYjt2mxcO9+aKpu2kT25
         +S3Q==
X-Gm-Message-State: APjAAAWN632hfdl81s74CxiEnQqwdPU/N9EQ/z3O9E5WnxHr+b70FQWz
        PUbvxOjJACLVtic+KBmuC4/7/TiTZLh8qahxbx8=
X-Google-Smtp-Source: APXvYqw4W+sDIXAy1gMG2UDVtA8od1DK1mzTWc9fC8HqW0lVM5lUFoUz3vXV51N6W8oFWN6k9b1CbGBbHCFY0rmoXpU=
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr24181737wrq.415.1581636590919;
 Thu, 13 Feb 2020 15:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-2-emilyshaffer@google.com> <20200206013533.GA3993@danh.dev>
 <20200213225834.GI190927@google.com> <CAPig+cRDbOyDQm6wx7+fZoKDfehLjkPc3qenR5Mhc8OkeFJqbw@mail.gmail.com>
 <xmqq36beqdez.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36beqdez.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Feb 2020 18:29:39 -0500
Message-ID: <CAPig+cT3gSARiHFN=79Z_BBACDyOqW8nZ+7RwODAmLrDv1SHuA@mail.gmail.com>
Subject: Re: [PATCH v6 01/15] help: move list_config_help to builtin/help
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 6:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Thu, Feb 13, 2020 at 5:58 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >> Thanks for the suggestion. You're right that I didn't look into the
> >> contents of this script much, because I was just moving it; I modified
> >> your sed expression slightly so it performs just one operation:
> >>
> >>   sed 's/^.*$/    "\0",/'
> >
> > This isn't portable and won't work with 'sed' from BSD lineage,
> > including Mac OS. More portable would be:
> >
> >     sed 's/^\(.*\)$/    "\1",/'
>
> Or just replace Emily's \0 with &; that should be in POSIX.

Yes, that's nicer.
