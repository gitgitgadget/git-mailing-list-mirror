Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B689C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540A720724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NszCIbhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHUVbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:31:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36640 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbgHUVbu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Aug 2020 17:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598045508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0ECUkpASQI2kI2vSmd+8ClIx+Hdt4i6sFQT39QMrxM=;
        b=NszCIbhzVGjH1SvlPvhBSA/uM/9+jK1lNOEBL6HnEKrNw+bXU1RWPIOAmer04/zlH7pC/4
        1DJUeT+0+c/rS+DMiq+9zF8tLKzdPm2fPNyl3FO71f3aUNyFVN/4oYPL6Uv6iomBW9qcR7
        XC87BfiXjhiBJnhPpr3xJgx4vHnZDcY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-YXgb-hMoOX6jmKXMZYdzKw-1; Fri, 21 Aug 2020 17:31:46 -0400
X-MC-Unique: YXgb-hMoOX6jmKXMZYdzKw-1
Received: by mail-pf1-f198.google.com with SMTP id f5so2089426pfe.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0ECUkpASQI2kI2vSmd+8ClIx+Hdt4i6sFQT39QMrxM=;
        b=nkfxFgq6aw1aBjF9BEXd+yTdgVX90xnd1WR4+BTnrtrnOgbnjy8dYCdAgEMDgYRnte
         PbZYGndM0B3dhOPG7TCSRbJ3l0fnGGMTtZ5WZjg1fUJ6/X7p7WxhYUI2n14IGR0irMIt
         nGenrONQVQHqepUMlj4ofwHYY2iRPphIqXyn9/UwF7FuqTEOCMi01LkisGEa2ECavHNn
         JVrgamB9fDzqBgqcw+OhYa6VORsESN82CYsmyc54cVBNG1dFxtUU2HFJXGJ2b37pQgbA
         o0pg5ZTWBxAdbcNiSMIh7K+0tzJ7yeytIdk6tEJ3nEKiv+6WDOWs5KTfsRRHdro9eeP+
         BE/g==
X-Gm-Message-State: AOAM530lh3tyqgmByMa4f6zNOKdEd5C3XYknUqYHzCytbfXsohpRZQ71
        7boBAwQKe7zL0g3mmThLYCYTUzIC2qLrsU4MrkjeKb3C0E/cPdHUlBc5L//4IAaO88Vxt6S4SUx
        TbZX+KZeX+WTvoj0ZvbOno0E7e58V
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr3828024plk.183.1598045504694;
        Fri, 21 Aug 2020 14:31:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0QZ7Imp+1+UgAE4bfCSuuB8W+YvtCxMHgZbd0rUPlZ0q0ssqGl5orG4bY7fkbtHTKqfRINIU/mGr9OOByPq0=
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr3827983plk.183.1598045504084;
 Fri, 21 Aug 2020 14:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
 <87ft8fvoow.fsf@igel.home> <xmqqr1rz96ry.fsf@gitster.c.googlers.com>
 <CAOW=8D3WZyoc=PpyzmPRYM2MT_=F4tnuTxJ0Z+_dHMb4Xk8imQ@mail.gmail.com>
 <xmqq5z9b91o3.fsf_-_@gitster.c.googlers.com> <CAPig+cR12i8KQjiWYm8DGuAc9BfJqanmNBZcZfwHGsrt2hW3Dw@mail.gmail.com>
 <xmqq1rjz8zy7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rjz8zy7.fsf@gitster.c.googlers.com>
From:   Alvaro Aleman <aaleman@redhat.com>
Date:   Fri, 21 Aug 2020 17:31:33 -0400
Message-ID: <CAOW=8D1nFgRRPyD7yxW2X7ZcAA3yaMzWJy7B3ykuPBJk3t8X5Q@mail.gmail.com>
Subject: Re: [PATCH] ident: say whose identity is missing when giving
 user.name hint
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One nit though: There is no `--committer` flag for `git commit`,
unless this has changed after the v2.28.0 release:

```
$ g commit -m message --committer someone@somemail.com
error: unknown option `committer'
$ git --version
git version 2.28.0
```

On Fri, Aug 21, 2020 at 5:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> >     If `user.name` and `user.email` have not been configured and the
> >     user invokes:
> >
> >         git commit --author=...
> >
> >     without without specifying `--committer=`, then Git errors out
> >     with a message asking the user to configure `user.name` and
> >     `user.email` but doesn't tell the user which attribution was
> >     missing. This can be confusing for a user new to Git who isn't
> >     aware of the distinction between user, author, and committer.
> >     Give such users a bit more help by extending the error message to
> >     also say which attribution is expected.
>
> Much easier to read.  Will steal.
>

