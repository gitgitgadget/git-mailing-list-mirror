Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC46C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 12:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DF461447
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 12:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbhDUMIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbhDUMIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 08:08:17 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2BBC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 05:07:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id j7so20177900pgi.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 05:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rl72Ih+2mrO3kORB04QjIdVU3ANR1TAFIh4DLKeGbPo=;
        b=WH+Nc+u0rgXZBDwIJZaKJptxQi1nNP3v6Xbxy2rUYhFcV78aVF6CwcxpJShON9RK88
         z46ybR+uw9aFPsRAHB1mm9nfgA3O/a+DBadSXIfJgQabQd67Y0LsME/zIhGPu1YrMbgT
         RNH9I04IqxWmeRc/YqZBZTnLsqDMKlr5lho3lVqbbL9LG2KvKr4BlHX3s8D1ZbeZ0VjG
         b543jrnGKm/94yGZfhU8TqG2JB7mW7tRHyhs7g1cBfhNaB4ZosFcSB33OCbcq5IGOTU8
         gks06wKmtVZbzaiuUDiRcA/+RvIDt8M85M/qVWwNSsAhHIRJfuC7cV7EPZoK85dizz58
         8KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rl72Ih+2mrO3kORB04QjIdVU3ANR1TAFIh4DLKeGbPo=;
        b=fP6ptoBpr0w9K5pFNNd3mL5vyikSWXxfHvrMksNy7ciyeytVtaHSSp5tq82wyYd+B/
         5wOrjzUPKwK/scLBKUim+PFGr9OanJ8TRHbHNkRrWxXCiDwtfMi7A4f4EsHmqU8UvYvH
         m0sCH5PDOviaeEpL07j3hVDPgUOoeUnDEcmHJyI1OrZkQUuYUaoRsyGgpVViG5QkDNEh
         q6r+XmlZyHTukVcBjH9kRDQByntmJESVnqsr+h3Xz4EVHIzX+wsXaqOoztzMUf/uaclZ
         rZIwr38uDQHuYNuyAxa/gV0BMmTv+RE6wGJeTLOksY/pvmUZNhjB7NlPqXCyrwgtj8qg
         jFBA==
X-Gm-Message-State: AOAM532iWmTl2QI/ZWqe/djwLo0n43EoexWWWqWGYS1xHG1JoyFdKx7b
        Kveiah73RUkpySVaKCNXcKQX1At+KQc=
X-Google-Smtp-Source: ABdhPJwcCOshp2VENVkH8LyzMAvW8hiCJ0H7eHERP14IuDFB8QEMoDGqQ/U6Tj6aTMbWg1u8dfdEdg==
X-Received: by 2002:a17:90a:540b:: with SMTP id z11mr10894690pjh.133.1619006863802;
        Wed, 21 Apr 2021 05:07:43 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id gt22sm1996154pjb.7.2021.04.21.05.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:07:43 -0700 (PDT)
Date:   Wed, 21 Apr 2021 19:07:42 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: strip CR from base64/quoted-printable email
Message-ID: <YIAVjpdwQhPJbVbl@danh.dev>
References: <20210421013404.17383-1-congdanhqx@gmail.com>
 <YH+ct4haFn4q5qNB@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YH+ct4haFn4q5qNB@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-21 03:32:07+0000, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> On 2021-04-21 at 01:34:04, Đoàn Trần Công Danh wrote:
> > When an SMTP server receives an 8-bit email message, possibly with only
> > LF as line ending, some of those servers decide to change said LF to
> > CRLF.
> > 
> > Some other SMTP servers, when receives an 8-bit email message, decide to
> > encoding such message in base64 and/or quoted-printable instead.
> 
> This really isn't an SMTP server.  It's mailing list software, namely
> mailman, and I would argue it's a bug, even though we may want to work
> around it.  For example, re-encoding the message breaks DKIM signatures,
> which means that mailman is likely to cause mail to be needlessly
> rejected.
> 
> 8BITMIME is now so common with SMTP that I'd argue that we should just
> write off servers that don't support it (especially in the context of
> SMTPUTF8 existing), but this isn't the case of an SMTP server being
> stuck in the last century.  Can we say more accurately that this is
> mailing list software (or just call it out by name)?

I think replace "SMTP servers" with "mailing list managers" is
correct. I don't feel comfortable to call it out, since I don't know
if other managers do it that way or not.

> 
> > If an email is transfered through those 2 email servers in order, the
> > final recipients will receive an email contains a patch mungled with
> > CRLF encoded inside another encoding. Thus, such CR couldn't be dropped
> > by mailsplit. Such accidents have been observed in the wild [1].
> > 
> > Let's guess if such CR was added automatically and strip them in
> > mailinfo.
> >
> > [1]: https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.guru-group.fi
> > 
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> > 
> >  I'm not sure if guessing the heuristic to strip CR is a good approach.
> >  I think it's better to pass --keep-cr down from git-am.
> >  Let's say --keep-cr=<yes|no|auto>
> 
> I think we may want a separate option here.  When I send a 7bit or 8bit
> body, I expect text canonicalization on the line endings.  However, when
> I send a base64 or quoted-printable body, I don't expect my data to be
> modified at all, and absent a compelling reason, doing so is incorrect.
> In most cases, using base64 or quoted-printable is going to mean that
> the sender knew that the body shouldn't be modified, not that mailman
> modified it, so we should make line munging in this case opt-in.

Make sense, this patch was sent mostly for some discussion first.
Would you mind suggest something for the option.

I'm thinking about --quoted-cr=<nowarn|warn|fix>, mimicking the
--whitespace option.

-- 
Danh
