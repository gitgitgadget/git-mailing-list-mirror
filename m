Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69BC20248
	for <e@80x24.org>; Sun, 24 Feb 2019 18:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfBXST7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 13:19:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42024 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfBXST7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 13:19:59 -0500
Received: by mail-io1-f66.google.com with SMTP id p196so5732206iod.9
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgYfX5LANtdk7OxQlHhVGmtizBblhoIjDL/nWX3fC/Y=;
        b=kuWQiwWd42FHOd31AXlQS2/IuK4J61ALs8I+n3Bpj5OaTwlev+fayJkCHyGJVwzIny
         CCVm5cSMDOyNMMHa8YiTVa8MlWFvvPEDM/1BpZK9VO4FR7FOS3qyO5p6x9C+r0LkGHMG
         LoqOuVPOrPSA267rba6OaLEOtl7oVIaDhWvH2z5LIPYbund38Xv9Y1l/9n+KQkqf4A8P
         rq8HTgUSSywXm9QkN/+Z6TzkB1VGXq99QQfUzyqQMXAnGbBQBlVd7WJieFGhxcsPBvdC
         0NUycieTNAQlH7VLc7swXI9/WzyMZx0XjNu90HFrDj6tcOprza+L4OQU+s+To8avnYN+
         h+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgYfX5LANtdk7OxQlHhVGmtizBblhoIjDL/nWX3fC/Y=;
        b=hRhqPaI7vJNovolg4G9KVDkmUNVIDPJdYfwmhKrIYSa/nqgFOR1lO3bVfLKVUH6O4q
         Wfdsj7++tk8eGc5aA7Cc3tU7jzuS+Y1mTrIv2RM/g0uTC9MIC0pvHBsh9MGaSB6wilEQ
         od01tN1HbU+qhjItMMoEDEUnz/JqId90kklk/Prz6YAtd3fwLXj64jCwdJqjfIHu5/PN
         kAI/aFL2tvCTue2uNBeqGfjrqRaj/3DnjzJd7AGKnho5+sc8otoGweGyd6X0+sDAk6ro
         MHQ0ZzK4ZkqNNUWDOQs4a5GOdpiPHs+vjGjJDPGWkvJOBs7E4OGt01YcCouGeWX6BrE3
         I/gA==
X-Gm-Message-State: AHQUAuayarvRG/ppnGsI8iG43iPlp3epb/Klqp8X6evTokQwAHzit7MW
        jZCYOUrpfstMesYi1/HfDBIh/CMnG7mZJFQ4FCyT6g==
X-Google-Smtp-Source: AHgI3Ib9WaBZbzvyfvzjzfJ8h1kThAEjRxJz3Vh6iORC6t19khexkfDq0UtXTjyhfPV3E2mOjvoXPmnvVFNgdfbE5qE=
X-Received: by 2002:a6b:c30d:: with SMTP id t13mr8574742iof.66.1551032398054;
 Sun, 24 Feb 2019 10:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-4-matheus.bernardino@usp.br> <20190223214856.GQ6085@hank.intra.tgummerer.com>
In-Reply-To: <20190223214856.GQ6085@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 24 Feb 2019 15:19:46 -0300
Message-ID: <CAHd-oW71y7nadq96c_4WDgs=xuTy-Kd98arJxv7eMwvZ3LkPXg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir traversal
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 23, 2019 at 6:48 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 02/23, Matheus Tavares wrote:
> > ---
> > Changes in v2:
> >  - Improved patch message
> >  - Removed a now unused variable
>
> s/variable/parameter/ I believe?

Yes, you are right!

> > +     while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
> >               strbuf_setlen(src, src_len);
> > -             strbuf_addstr(src, de->d_name);
> > +             strbuf_addstr(src, iter->relative_path);
> >               strbuf_setlen(dest, dest_len);
> > -             strbuf_addstr(dest, de->d_name);
> > -             if (stat(src->buf, &buf)) {
> > +             strbuf_addstr(dest, iter->relative_path);
> > +
> > +             /*
> > +              * dir_iterator_advance already calls lstat to populate iter->st
> > +              * but, unlike stat, lstat does not checks for permissions on
> > +              * the given path.
> > +              */
>
> Hmm, lstat does check the permissions on the path, it just doesn't
> follow symlinks.  I think I actually mislead you in my previous review
> here, and was reading the code in dir-iterator.c all wrong.
>
> I thought it said "if (errno == ENOENT) warning(...)", however the
> condition is "errno != ENOENT", which is why I thought we were loosing
> warnings when errno == EACCES for example.
>
> As we decided that we would no longer follow symlinks now, I think we
> can actually get rid of the stat call here.  Sorry about the confusion.
>

Ok, I also read the lstat man page wrongly and though it didn't check
for permissions. Thanks for noticing that. I will remove the lstat
call in v3.
