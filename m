Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62561C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1858561057
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhDTXoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhDTXoS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:44:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04340C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:43:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e7so30467913wrs.11
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OpbhbGdXcT+D5LGPcH/dk65tz2tMN+VitHibfana6/g=;
        b=DqOnr6xtPxhXZHcABhmpVj46UIny06khNS4HAYPWag76CcR++EePyhf/6qkUE22AH8
         aLC13uMHVeqZAOlpp/xN1uFKN9MtlAoJnRiAjTiKrKTOr3PEZzpIhRdqCBSxnjTtO40c
         h8he0zr/8c1Goy6khmT1zqzaZKrK55ryzM1+YldOwR0veXK23DOeS6+Jls5pDecn8GRO
         B0xF6m7acE43RBVVYTFEWyGYcRKBTutUKA0rh6u5LR0/kw/HnQdXdx8YbCJiU2GsXGgV
         yafyH+3k9NmRASY6MjSXFmJ39Q3q2uV4iUQzFyDTQ1Koy50pTwxHX5JPveVOgO7WBxuy
         cBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpbhbGdXcT+D5LGPcH/dk65tz2tMN+VitHibfana6/g=;
        b=KyoTYbVvuzm8Qxs4/P7rNv6lLwS5MDuV17iHzYG4sJ4pVPxBQ8w1hJmzYpwLuEBtm3
         4gNQLUUytau6NdRzIIjPM4QfcbONw8vSU+1xjuy/wNzWyr7AV7iH1tdJt/TPwVpPNaLR
         F5lSirRU6L9pHV2YQf114ahr2lLaOygEJ6MdWg+OHVm7Ozu9PzM3HwzmkGwvkaOqSIdX
         VcX3gyWmZKsHkTCpR6t/d0VCMBVUHYlMWONreboiZFvmlcly67/BwSXAuYO9bLdacjnd
         kioLD7hauqhWNhDSrGFztQp/G3SD3GsKA4ClSy+2TKIEVq7sytQ+y2NdWzJfyMWWIeY8
         fwkQ==
X-Gm-Message-State: AOAM531wop+Wz6OSKf/tT/5fByIyThHVNi9rIrxD8ZsKt0z7qSAX9OCB
        N4/JK4m1/6iPV42QETAC4zwS0MmKhyGKbDWSOL+IIirPGfM=
X-Google-Smtp-Source: ABdhPJzIJsii5VsnmBPgtDg23H2IcWwYKlxQ/scGd2ovbkB60cGtYkyPnA/qPEZApYLv0rYeGtiqZ1RVVjlvy0k7U8Q=
X-Received: by 2002:a5d:4682:: with SMTP id u2mr23627764wrq.167.1618962223600;
 Tue, 20 Apr 2021 16:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210415212017.1407303-1-bga@google.com> <xmqqmttznqj6.fsf@gitster.g>
In-Reply-To: <xmqqmttznqj6.fsf@gitster.g>
From:   Bruno Albuquerque <bga@google.com>
Date:   Tue, 20 Apr 2021 16:43:32 -0700
Message-ID: <CAPeR6H4V2_bAHaU4SCC8uGorj1bQEKLX5LWtXFuoHNRpo=dYPg@mail.gmail.com>
Subject: Re: [PATCH] object-info: support for retrieving object info
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 3:15 PM Junio C Hamano <gitster@pobox.com> wrote:

> > +int cap_object_info(struct repository *r, struct strvec *keys,
> > +                 struct packet_reader *request)
> > +{
> > +     struct packet_writer writer;
> > +     packet_writer_init(&writer, 1);
>
> This triggers -Wdeclaration-after-statement below.  Move it down.

Done.

> > +     int parsed_header;
> > +     struct requested_info info;
>
> Puzzling blank line here.  There does not seem to be a good reason
> why 'parsed_header' bit plus 'info' pair together closely than to
> the other 'oid_str_list' variable, so it does not make much sense as
> a grouping aid.

Done.

> > +     struct string_list oid_str_list = STRING_LIST_INIT_DUP;
> > +
>
> Here, just before "parsed_header = 0;" after the blank line that
> separates the decls and the statements, is a good place to say
> "packet_writer_init()".  Also it may make more sense to give initial
> value to parsed_header where it is declared.

Done.

> > +     parsed_header = 0;
> > +     while (packet_reader_read(request) == PACKET_READ_NORMAL) {
> > +             if (!strcmp("size", request->line)) {
> > +                     info.size = 1;
> > +                     continue;
>
> And upon further inspection, nobody seems to use parsed_header at
> all.  Let's lose it.

Done.

> Next time, perhaps try "make DEVELOPER=YesPlease test" to catch
> possible problems like these early?

I did. But I was coding on a MacOS machine (which defaults to clang)
and it looks like the warnings are not triggered at all in clang even
with -Werror being explicitly set. I switched to a Linux machine and
got the warnings.
