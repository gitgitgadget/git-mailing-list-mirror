Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4797C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47A52082F
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgBMXIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:08:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44862 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMXIM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 18:08:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so8757638wrx.11
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 15:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQEyGNFx9dyzRKHF/C1fUR1w+Bmvy0bpWYvL1DAxS4U=;
        b=QFufyNfa43p85sH0+/TETxRJck0qlK1nkEj7Ucyxx0/nRJzSjlh2Y+9UKP/oC4y7R2
         KdKratTa7T+Ko61fuSr0dEvmj0Tf20nkCsTv08v4HtlsnF8BibHgJJau4eif/oZU89a1
         PHZYcKfPWhksrvW5F1qHUWgKUbv4yYW2iyOHiGXyXiuffUIgWggdQp6hcPTrX8W0W3p1
         kj5jRM0+7kYCsjYRQLb3xFknf58cWjKPHhKNieu47amkUVejpQxAApiprKeDOxEBqVnC
         llvXMaNemGa0cIt91BDM44anuo0FyHTAG0QZmgYoUu8az8ZrCEsoRQ2OqiKAhmsD7nlY
         aRxA==
X-Gm-Message-State: APjAAAWaZSX4/hhzeuTzRaw+IMEFLgsgrE+qE/tYjsniWpYzxkDj9eAf
        kK/lITmFXmAaFvvudmAIJZhJbsv5qGfFq7bUKlE=
X-Google-Smtp-Source: APXvYqxKeNIBsGIQKI+oqGJm0sDZwL7rzbVALwsCa1IrvRZOkaQfw/OCK24e6YuaBFT1AY7AG49ec7mmB39p0YeUdLY=
X-Received: by 2002:a5d:5752:: with SMTP id q18mr25055448wrw.277.1581635290753;
 Thu, 13 Feb 2020 15:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-2-emilyshaffer@google.com> <20200206013533.GA3993@danh.dev>
 <20200213225834.GI190927@google.com>
In-Reply-To: <20200213225834.GI190927@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Feb 2020 18:07:59 -0500
Message-ID: <CAPig+cRDbOyDQm6wx7+fZoKDfehLjkPc3qenR5Mhc8OkeFJqbw@mail.gmail.com>
Subject: Re: [PATCH v6 01/15] help: move list_config_help to builtin/help
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Danh Doan <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 5:58 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> On Thu, Feb 06, 2020 at 08:35:33AM +0700, Danh Doan wrote:
> > -     while read line
> > -     do
> > -             echo "  \"$line\","
> > -     done
> > +     sed 's/^/       "/; s/$/",/'
>
> Thanks for the suggestion. You're right that I didn't look into the
> contents of this script much, because I was just moving it; I modified
> your sed expression slightly so it performs just one operation:
>
>   sed 's/^.*$/    "\0",/'

This isn't portable and won't work with 'sed' from BSD lineage,
including Mac OS. More portable would be:

    sed 's/^\(.*\)$/    "\1",/'
