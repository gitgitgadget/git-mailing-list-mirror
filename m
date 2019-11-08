Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2291F454
	for <e@80x24.org>; Fri,  8 Nov 2019 21:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfKHV6x (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 16:58:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36128 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKHV6x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 16:58:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so8687666wrx.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 13:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjD2GTzExAHwY/IRvwkA03TJAwDdwsXVeQGVMnWXAg8=;
        b=d03bn7snAxpmmd5AF1pG0d00X0O3C0Do3Jd5WPXAypV8jcMwehTllyzLX8tLlkTdpN
         fpxnJnwgI1ZXqXaMxusg60bGHe80O8Sqa/TNXBbaPaMvZgWnDY1YaauyRJHY2sIk5/A1
         Fh4JEpxX7HeL/QWsOAp2XFvinBWIp6KiTqXr8c2CYqwyaZTBc6Cxbc7LqhWXINUtoO7T
         IMsF3EkgfzHUR6DgA1kx1Kf8mGazs9s58HGETwxTV1X8HUd1blJOTusOW7F3Lq7MyUZz
         1UueFdt6fxvYxpRWjUbBlE9OTTJvWY4Bnp4aQkH6+v9Q1XyL0hwTu176GN42rgJLz0jc
         izzA==
X-Gm-Message-State: APjAAAWqDFfNmWCJ2KEqrJ2cc7jOOCm6oPO8gIKvrDJGTYm/8GfG4k4n
        7ok+zlpIE+jJrH5ANV8P3+VgcCAat2wr9AJbLzU=
X-Google-Smtp-Source: APXvYqzG76zTnH14cJa3YLiufVeCfTQC3gsoAkHs6mimsU8yzM23sIHKT7AySZpNQdb2GKszBDjZHAy1lOIo0m2VNa8=
X-Received: by 2002:adf:d18b:: with SMTP id v11mr11078307wrc.308.1573250331124;
 Fri, 08 Nov 2019 13:58:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572897736.git.liu.denton@gmail.com> <cover.1573241590.git.liu.denton@gmail.com>
 <b5950823ce90dd2476f002ed0370b7e0099a4d85.1573241590.git.liu.denton@gmail.com>
 <CAPig+cQDMSwP5-D-=LgjBPH2kJK16Fv4c619Pg6OTU95CQ9sgw@mail.gmail.com> <20191108214711.GA27310@generichostname>
In-Reply-To: <20191108214711.GA27310@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Nov 2019 16:58:40 -0500
Message-ID: <CAPig+cQ3FrxUGiFXooaiZ+po0qK6tBOda5apCs4=H0mdWxAKOg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] t4205: cover `git log --reflog -z` blindspot
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 8, 2019 at 4:47 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Fri, Nov 08, 2019 at 03:36:25PM -0500, Eric Sunshine wrote:
> > For completeness, the above example also drops the unnecessary 'revs'
> > variable, uses double quotes rather than single when interpolating $p,
> > and makes the loop early-exit a bit more idiomatic.
>
> The reason why I pulled out `revs` was because putting the rev-list
> within the for-loop would cause its exit code to be lost if it ever
> failed. Since I've been cleaning up test scripts to not lose exit codes
> from git commands, I figured it'd be a bad idea to introduce an instance
> here ;)

Make sense. Ignore that suggestion of mine.

> > > +       git log -z --pretty=oneline --reflog >actual &&
> > > +       # no trailing NUL
> >
> > To what is this comment referring?
>
> I wanted to point out how in the oneline case, the trailing NUL is
> already included, unlike in the multiple cases, so we don't need to
> output another one.
>
> I'll rewrite this as
>
>         # the trailing NUL is already produced so we don't need to
>         # output another one

That will be clearer. It might be even clearer if that comment comes
before the "git log -z" invocation rather than after (though that's
subjective). Thanks.
