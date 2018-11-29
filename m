Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE926211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 10:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeK2VVK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 16:21:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46248 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeK2VVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 16:21:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so687649qkf.13
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 02:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1gvu8zKdborYWUL83/tQRRf+kTli9I4LW+YO3oL+X8=;
        b=mwNQcW/43VTFK1Mx9vUCtwisv1wFUxc2qsNdxRGn90bVqtKyfqWBOzt/ix6xv3Hgb9
         HC9SXWCYt0tjmpe/Bw+N7ydMm6tJNBdRgoxpi3plgVk89UhljYVTnF1bt53E0pgpzwrT
         g5OqnGH3x1scWGlR+IeBtwT/qtT/hH7wJTvqwyV57VKGoFpWD7860iq8XMkcW6NMGtCn
         33K87XQrARVezRPi05AAqpln0hyHaBVsbG8+PlJNvVKnhL6irx7KDdlGTlk+RY84VDZJ
         u65bM/L6rkXUa3vUr2ZRgdtYsWuWIzZCNPxNuNIFazDPsBa9K0dirIiOUKmAWtgsZBan
         Tmnw==
X-Gm-Message-State: AA+aEWbXQwsZPwr4WQdPExCwgirNkDHnIGtYLdo3TbQkbpgYHhFhOI/S
        2BW4jZI/cyBXyo6AXROIOD+Fokrhx6FNqwUtXcWwFUso
X-Google-Smtp-Source: AFSGD/X7u3fYqDuHeWlMEsPHt+cBjI7nA5PlL9HlcvwU4+TWrTYPFqtR09XV0JTsAQQ1V0J+9a0ZGbCXynLqt5sNHM8=
X-Received: by 2002:a37:a315:: with SMTP id m21mr688953qke.152.1543486579327;
 Thu, 29 Nov 2018 02:16:19 -0800 (PST)
MIME-Version: 1.0
References: <CAABTFJPpmThrrwP6pb5gZ82fb8yKteLpDcXTCQS8p_7WZ0Ne5Q@mail.gmail.com>
 <CAGZ79kZtrj-Gg8P-xJmn8TYjgXuUmj8pJUXU+Vf89F0tKHuYBg@mail.gmail.com>
In-Reply-To: <CAGZ79kZtrj-Gg8P-xJmn8TYjgXuUmj8pJUXU+Vf89F0tKHuYBg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Nov 2018 05:16:08 -0500
Message-ID: <CAPig+cRU5pxZr50UpDwA2044dbX_jKZP1rhm4JQPB_yjgSTmgA@mail.gmail.com>
Subject: Re: [bug report] git-gui child windows are blank
To:     Stefan Beller <sbeller@google.com>
Cc:     kenn@eissq.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 2:29 PM Stefan Beller <sbeller@google.com> wrote:
> On Wed, Nov 28, 2018 at 6:13 AM Kenn Sebesta <kenn@eissq.com> wrote:
> > v2.19.2, installed from brew on macOS Mojave 14.2.1.
> >
> > `git-gui` is my much beloved go-to tool for everything git.
> > Unfortunately, on my new Macbook Air it seems to have a bug. When I
> > first load the program, the parent window populates normally with the
> > stage/unstaged and diff panes. However, when I click Push, the child
> > window is completely blank. The frame is there, but there is no
> > content.
>
> Looking through the mailing list archive, this
> seemed to be one of the last relevant messges
> https://public-inbox.org/git/20180724065120.7664-1-sunshine@sunshineco.com/

I was hoping that Junio would patch-monkey that one since that
crash-at-launch makes gitk unusable for Mojave users, but apparently
it never got picked up.

Anyhow, the issue fixed by that patch has to do with 'osascript' on
Apple, and it's the only such invocation in the source code of
gitk/git-gui. The 'osascript' invocation merely attempts to foreground
the application at launch, so is almost certainly unrelated to the
above reported behavior. Somebody running Mojave will likely need to
spend some time debugging it. (Unfortunately, I'm a couple major
releases behind and don't plan on upgrading.)
