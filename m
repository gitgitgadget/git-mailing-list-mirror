Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D009C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 16:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FAF2081B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 16:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfLDQce (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:32:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33272 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbfLDQcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 11:32:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so9442507wrq.0
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 08:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIv3jpkB01ixTywMmE4lQwzsk6XpUWPMc4YK0qhEhJY=;
        b=H7CwkRtRdDaQdt2GBsvC4mPZRGcYaMljSD92YVJdUFVNU+ytTfQbYzJ88DYMBLlawg
         FDrvyaRr7Jqq3urwitazagUsFPLOdrohVb9KHG0cGFeQmXDSQgcMg1A5XBz0MEHf5Bnr
         FOy5B4lTZpPZa1ikSswuXa5WNhUlQmnkSelZxW+GRBfgfKlYxOG3TZdNjXXk8fK9CQS4
         UrymnCibx/eqKbhTwcLfojjLZCMTJ2uVvb+ryOk+dJbFXJjJrH8jyzox5RsnnhkiOlXE
         On2izsrb5IiucnpADbqRRpHvU/e8vjxIQDWomHudPGYQro4bTQWuXTp4Na+nG3cRJKSD
         D4fg==
X-Gm-Message-State: APjAAAW9BrhguzexGzxgdsQqhrbvHlN6hFxWVmHWSfsegcDz9HCYabbs
        WbCBwf6MrjW9EjDDEw8mzu5fHdvIT2FC7m5P6vY=
X-Google-Smtp-Source: APXvYqyruQ7GMhwZsaBtdJ7YplXcegFm6rImUBvda1vd7lYNewa+ztYsGcGRSMZa8hFovHyhGg22C0sitFUzYcByZ4Y=
X-Received: by 2002:a5d:528e:: with SMTP id c14mr5262812wrv.308.1575477151559;
 Wed, 04 Dec 2019 08:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20191203201233.661696-1-mst@redhat.com> <20191204044449.GB226135@google.com>
 <CAPig+cTFbpAo5+kahLT+7E1zQe24S5icm0SSB=HF4xqsD2VdAA@mail.gmail.com> <xmqqlfrs5acs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfrs5acs.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Dec 2019 11:32:20 -0500
Message-ID: <CAPig+cREF8BSVbCoOUaRMPOyfD_bfD5PhxgM4QZgot7sziCNug@mail.gmail.com>
Subject: Re: [PATCH v2] contrib: git-cpcover: copy cover letter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 4, 2019 at 11:23 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > I could even imagine a new option -V<n> which has the combined effect
> > of setting the re-roll count (like -v) and automagically copying the
> > cover letter material from cover letter v<n-1> located in <dir>.
>
> I actually looked into doing something similar but without any new
> option (i.e. unconditionally --cover-letter with -v<n> would check
> for v<n-1>-0000-cover.letter and does the right thing) some time
> ago.

Yes, I like that better than a new option, and wanted to suggest it as
well, however... (see below)

> But I think that was even before we integrated the range-diff stuff,
> which does seem to use the "given we are doing <n>, let's compare
> with <n-1>" thing, so perhaps it is not too difficult.

Yup.

> I am just saying that I think the change would not have to be opt-in,
> but can be unconditionally made, simply because replacing the BLURB
> HERE placeholder with *anything* written by human user previously is
> a 100% improvement ;-)

I had started writing the same in my previous reply but then realized
that it could break existing tooling which uses -v and --cover-letter
together and which searches for the well-known BLURB HERE placeholder
to replace it automatically. If I'm wrong about possibly breaking
existing tooling, then I'd also vote for this behavior kicking in
automatically with -v and --cover-letter specified together.
