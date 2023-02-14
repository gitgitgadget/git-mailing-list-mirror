Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1970C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 05:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjBNFdg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Feb 2023 00:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBNFde (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 00:33:34 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820C511EBC
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 21:33:32 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id z3so3265630pfw.7
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 21:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRvKgqVxCtu+nfU25ySZOk327QUDaJH+SMOq8vE/JFU=;
        b=7P6ofipaBZTwBNpgFSBXwy0i/RHLY0hAOjUD2vbfb2Lt/V9TBlmjPJLJCe99DgDmsf
         OHlpp1/QYzf1DxjP7seFqvIRyw/DeBRd7mjBYPszxgU2SksQWD5QAkn2ka/OgxTKCJLv
         ALi5MdDCQzoP8C5m5tVu4r5ZJ2YzmfkME2CAQZhkysXjdl7y2dkhPcZ7YsnH2fmtjjw7
         e5DeL1DT8PE+f3un/5ejSqpuPrHjzHPQ3fyMo2msvckcjxDOLyWCLejaqf8H94HXEVOB
         Out8wyVXxEpIFocsW8xZNxspQUqkVODllDBA70escWVyNKudQrxVgnu0J3Yd4JkItZhd
         JEyA==
X-Gm-Message-State: AO0yUKUVEns50rOluHrG+z3wuq1AM3S4/Y90BxsNcxwid4z8ZCaFL7hj
        JaPUAPKbF2tI3XQUFYlCXrzuAqL/IE3yBMPUzTAQqBVA2BI=
X-Google-Smtp-Source: AK7set/3+5J2r4lARg6TVD/Mp+EbOqqGsF7n1uowqCBt6+HBw5HetgVICMfLJW43LC4R7SUxO3mg2d3KlIOw6ua48RU=
X-Received: by 2002:a63:3809:0:b0:4eb:ee7f:baa2 with SMTP id
 f9-20020a633809000000b004ebee7fbaa2mr93877pga.65.1676352811889; Mon, 13 Feb
 2023 21:33:31 -0800 (PST)
MIME-Version: 1.0
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net> <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
 <Y+rmNvfjIA/u81em@coredump.intra.peff.net> <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
In-Reply-To: <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 00:33:21 -0500
Message-ID: <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 12:15 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 13, 2023 at 8:39 PM Jeff King <peff@peff.net> wrote:
> > If you do something like the patch below:
> >
> > -       short_name = xstrdup(refname);
> > +       warning("strlen(refname) = %d", (int)strlen(refname));
> > +       short_name = xcalloc(1, 2*strlen(refname));
> >
> >                 short_name_len = strlen(short_name);
> > +               warning("strlen(short_name) = %d", (int)short_name_len);
> >
> > Does it help at all? And if so, is short_name_len longer than we might
> > expect it to be (I get 39 for the full refname and 28 for the scanf'd
> > name).  I'm having trouble coming up with a reason that the scanf value
> > _would_ be unexpectedly long, but just trying to rule things out.
>
> I get results different from yours:
>
>   warning: strlen(refname) = 39
>   warning: strlen(short_name) = 9

sscanf() seems to be the culprit. If I set LANG, then I get the same
result as you get:

  $ LANG=zh-CN.UTF-8 git symbolic-ref --short HEAD
  warning: strlen(refname) = 39
  warning: strlen(short_name) = 28
  测试-加-增加-加-增加
