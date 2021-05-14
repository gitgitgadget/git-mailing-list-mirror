Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9524DC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7356761354
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhENUM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhENUMz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 16:12:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F9DC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:11:44 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso321506ote.1
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yTZ8BChIr15dORP3ySdAEk/zED2EQLGFfdnwMG4Fpbw=;
        b=vcx6DIOW7+TE3H7TwAq0ARt7MIS+cEAC6axHO6l23meDWnv2xgt9lYSFwRyVB70Rvy
         RsXYgWMJCAtBtlYNezPPpAKAGTF84fKRbN2YY572xJ1BYO7a40E82bec/CjwE7lFIbDL
         2qv9gFbAPg0U3nGH+N740Ym4d5iitE2WLtf7by0588yjRdwah7fhYubARhgttNaYzot0
         F7jU0fgUgbjpZPwwSLIWNzZZTVFguqS1AwXxrZkAF+xfcXhf3BO6Y0hau6KFOQYwbVB4
         E0x8h9qkdn1smnZKCNFC5MphXchPz7dE6HgiZfpMIzS7Zq6d+ilrHfhX8VIGIBYwc9FO
         ztMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yTZ8BChIr15dORP3ySdAEk/zED2EQLGFfdnwMG4Fpbw=;
        b=eGtUEEX8S/ix+QVILSWt9IYxJALWV/5M5iyJio2RgQD9CjM9JVCX/sdnDgsXdM7aLD
         wrG6daYuWqzbpIX7CCjrX3oZbwvY0UiwLzKxXa6hsuyt7Xxgn3j1qMvA0h2wQdJOBR0M
         tzcx0trTv0jyVWhWqh0AOvNpM2y6eL7to2UJNW6OOi9hq4zGAc1U3uwEmr7fyWkcJXW9
         7feZdZKYbCM6KAvbf8SbPMe7HAvnymHgCCNBoBAcCh4QJuLr8FKr2XaYXBOQLqS+5gb6
         AEaGAjAeT8AVg21gPpYr1SNmDaJVSOmSUXmL08n/JA3EnTQtGwIoNuqJNvOidN4lpl7X
         8AOA==
X-Gm-Message-State: AOAM530bij+87VCF+nZT+didwjbSGJCixekIJzYK0S6hhpjt9absqcJP
        AlLRw3yROcnPSAxPwjGI2GY=
X-Google-Smtp-Source: ABdhPJwnzL6hhdYTN6F8yPRhCFrD698Z+4GU9PmB+5JgsGHcbQ2RKjKRbttSOscSpgxIEb3CoJvtLw==
X-Received: by 2002:a05:6830:246a:: with SMTP id x42mr40780036otr.335.1621023103453;
        Fri, 14 May 2021 13:11:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z6sm1400948oiz.39.2021.05.14.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 13:11:42 -0700 (PDT)
Date:   Fri, 14 May 2021 15:11:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <609ed97d9013_43127208bd@natae.notmuch>
In-Reply-To: <CAN0heSp7JFS3j+DypQm=P-rPzyScvs+Yed75AXYBsQpbJtVytA@mail.gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
 <609dd5171e7de_19566208ca@natae.notmuch>
 <CAN0heSoK5VfP68Us2e2bwSfTzY=5FBEBjxuTHRXeA_qg5MH65w@mail.gmail.com>
 <609e6be4bc14d_4312720861@natae.notmuch>
 <CAN0heSp7JFS3j+DypQm=P-rPzyScvs+Yed75AXYBsQpbJtVytA@mail.gmail.com>
Subject: Re: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Fri, 14 May 2021 at 14:24, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Martin =C3=85gren wrote:
> > > On Fri, 14 May 2021 at 03:40, Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > >
> > > > We should be submitting bug reports to the asciidoctor project as=
 well,
> > > > so in the future it's less likely we find ourselves in the same
> > > > scenario.
> > > >
> > > > Preferably the bug report should be in the commit message.
> > >
> > > I don't have an account with the website they use for their issue
> > > tracking.
> >
> > GitHub? It probably takes a couple of minutes to set up an account.
> =

> Yes, it's GitHub. I'm not interested in having an account there. There'=
s
> some trade-off there with me not being able to report bugs, but that
> cuts both ways, so I don't feel bad about it.

I don't see what are those both ways, but OK.

> > > If you want to submit a bug report and post the link here,
> > > that's fine by me and I'll include it in the reroll.
> >
> > If you would rather have me act as a proxy, that's fine by me.
> =

> Thanks. If you have better things to do, no worry.

I do, but reporting bugs doesn't that *that* much time.

> > Just give me a simple example that produces the issue.
> =

> Here are three variants where AsciiDoc 8.6.10 renders the same, with
> emphasis:
> =

>   single quotes that will not render literally: 'git cat-file'.
> =

>   single quotes that won't render literally: 'git cat-file'.
> =

>   single quotes that\'ll render literally: 'git cat-file'.
> =

> With Asciidoctor (2.0.15),
> =

>   asciidoctor -b docbook5 -d manpage -o test.xml test.txt
> =

> the XML contains

I'm not talking about the XML, I'm talking about the man pages. I'm not
interested in intermediary code, I'm interested in the final output,
which does seem to work correctly:

  ruby -r asciidoctor <<\EOF
  puts Asciidoctor.convert(<<REOF, backend: :manpage)
  single quotes that will not render literally: 'git cat-file'.
  single quotes that won't render literally: 'git cat-file'.
  single quotes that\'ll render literally: 'git cat-file'.
  REOF
  EOF

  single quotes that will not render literally: \(aqgit cat\-file\(aq.
  single quotes that won\(cqt render literally: \(aqgit cat\-file\(aq.
  single quotes that\(cqll render literally: \(aqgit cat\-file\(aq.

Cheers.

-- =

Felipe Contreras=
