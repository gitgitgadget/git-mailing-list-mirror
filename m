Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9ADC35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 21:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504620658
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 21:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvU4K+Yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBBVxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:53:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33426 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBVxX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 16:53:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id h4so1489594qkm.0
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 13:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bqaz1ZjwCBrayTJjiU3fzduiNgWrekd+3LOWx0wwAjY=;
        b=MvU4K+YiREjvNKm3XfTuowZpyJ7kIR1w6prDxDtVNbx7K6Vz7QiG/Z5kV0VXIKRq0A
         LFBrKUkZLBJmpHqvUnGlUn3UWlWbCISUHtMUt+2Ws/ywgh2QI4egqEZ4ihzHht/9wcGb
         hBfT4YB1QeLSVeUk0iqNPnTi5uKkQ+Avz7yieGXToHREzkDEZP236BCf78oZyvzz6ziZ
         cRDB6DCbWW7Z/3sZdpuvVIMqES2sUia7b+7NL/CEfoo6LleRL+csvUSZtZCfAQ8XTaN0
         cRWN+uYLXF0pPTd+SCrLbiNNyZQq4pfbmhk5VEguvSGoPgqfsiFzkX350FD72mlf59/M
         Au9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bqaz1ZjwCBrayTJjiU3fzduiNgWrekd+3LOWx0wwAjY=;
        b=CuQOI2v5p0Gr9LFMMkB1qSFxvPCtBPar5n29EdHXHRoVjXm3cfFxwGIH5epiFU2kl0
         7SpR2MJTZArto5BUCG+JtAlMMsFsyky4Mh/n2bc5KFzK412vTejkEU8izBRqZngGBRcn
         aNln9aSXWgbtNExXhF5/kL8n8cyapcgj+F1TtEc15MITQkByIQaeF3savoiItAy9PpgV
         /XhqQ96b3vBFUJyWUiwYKAyaXYfidA0/bEevqwECzfULz4udJPh9xvEvcD8bdTRPUqVK
         fP1ZXJSTO7gKeJcH+A+LtHgmeg+W7vfFvZQWOCtM62qfaurgohsauQ3rPJkeao9e2zhA
         4AtA==
X-Gm-Message-State: APjAAAWm+/bmZKejRptaWFsrY17Urx8HCzGerOr6LuU2+dqNgCL1ibC0
        pQmtlXoWWiHEQYB/mjhte8S38Fs9wTiv8WFVTa+jUw==
X-Google-Smtp-Source: APXvYqwbpWP66GXm/rNAlVwVFe1EFBHTEBTH4MFkwxtikKVjKIDgNk0MFJS9ldHI34Jr0XQgu7g/Czdez2vUfYyBf3M=
X-Received: by 2002:a05:620a:1014:: with SMTP id z20mr20244553qkj.196.1580680402600;
 Sun, 02 Feb 2020 13:53:22 -0800 (PST)
MIME-Version: 1.0
References: <CAFOYHZAx-MM26AuJmscK=kGgukQ62vkyqAqU49U-5WRaTp4mGQ@mail.gmail.com>
 <20200202214243.GA1090206@alpha>
In-Reply-To: <20200202214243.GA1090206@alpha>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Mon, 3 Feb 2020 10:53:11 +1300
Message-ID: <CAFOYHZAyYLdqUwkctL94T4fSPHj+FyMJqnWmkUu_g4=_wQJ9MQ@mail.gmail.com>
Subject: Re: git log FILE vs git log --follow FILE missing commits
To:     Kevin Daudt <me@ikke.info>,
        Chris Packham <judge.packham@gmail.com>,
        GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 3, 2020 at 10:42 AM Kevin Daudt <me@ikke.info> wrote:
>
> On Mon, Feb 03, 2020 at 10:27:52AM +1300, Chris Packham wrote:
> > Hi,
> >
> > I've just hit a problem where git log doesn't want to tell me about a
> > commit that touches a specific file.
> >
> > I wanted to point someone at a particular change that I knew was made
> > to a file so I fired up 'git log FILE' and to my surprise it wasn't
> > listed. I wondered if I had remembered wrong so went grepping to
> > confirm the change was in the file I thought it was, sure enough it
> > was there.
> >
> > Poking around a bit I found that git log --follow FILE shows the
> > intended commit but git log FILE doesn't (it does show other commits
> > that touch the file, most of which have tags if that's significant).
> > The file hasn't been renamed so I didn't really expect --follow to
> > change any behavior.
> >
> > The version of git I'm using is 2.25.0 from
> > http://ppa.launchpad.net/git-core/ppa/ubuntu bionic main. I also tried
> > 2.24.1 and 2.23.1 with the same problem.
> >
> > Any suggestions for tracking this down?
> >
> > Thanks,
> > Chris
>
> Hey Chris,
>
> Try `git log --full-history FILE`. When passing a path to `git log` will
> enable history simplification, which might explain why certain commits
> are not shown.
>
> Kind regards, Kevin.

Yes that shows the commit in question.

Based on the description of the default mode that actually makes
sense. The change in question was a removal, but there was a merge of
another branch that never contained the code that was removed. So the
simplest history involves commits from the branch that never contained
the change I was after.
