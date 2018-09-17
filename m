Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244E61F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeIQWOJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:14:09 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:56173 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQWOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:14:09 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so12030724itj.5
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OwDLm8aAYnRE2f2rc0mgCWEZORyScd6CHzAQtAAbhE=;
        b=cnzlLu+O3GaiJHVTRVudfDS/DQMd7FrNrv5XlKaJuafZbKjZB6yPlS2zUrV6trEhAA
         u/TN8dBRhRWAcyu1LHVzEHTHw2HNk6Vqa1W40U8ptLYSGPdX1CNIXKCmXd2l7mFcZQQV
         AD6R+lprGlGyEwffJn7nUY14ZFUCeiU9ICNaE3esyMvnSx6WEUobym19cgNB1hSjmkbW
         QIQDxeqlYAxqRD4cqTN5cfoiDFujSRIqT1VOb/V2rnkP47C8ghjg1N+KJ2k3eDUM3Sh6
         ugDXsrbLyTV7hHQsOtX57p1ASHdGi+GGGK6kOCGMl9h0n8b72BRwVcw2kjyaXfwCziqo
         /hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OwDLm8aAYnRE2f2rc0mgCWEZORyScd6CHzAQtAAbhE=;
        b=R9e9LllD3ci1ioHXW+EIydqxHsjvGQxjLIFHwjGloI6onaPmelhhUyHzygTmgyZzSw
         ziyrOZhuCGKE0vlvQE9QopjVY7jI2toc5xeXKD0XguK20f1uc+oSdLDBj52wxig02uMW
         VD+fOf4YKnh41f96w3T+86jznB9io2FgtIcRnIiAsTeTpqrRtCLu5L0BI8uyYEQLdecO
         GUM4d74I4ky4IQAohM5Bx3dsxAUJcsWPocx2O1oVz3XhI6iqrFZeu9eNF6AZtxprCiIW
         LnA8RQzlpmmHMO/d01Vlc55wX5kaJNqW5pGVia9aA7TYl0ApUHwDLvny7K59p+1wJkUz
         1S2A==
X-Gm-Message-State: APzg51D49lPjGrSeI2LI7yQNbWeF8fLmn3am9844svFA1iWUZAVKc+yx
        TNfB+6MLNGnEkQXFCjWlwKNVTruCndhE7RkscrY=
X-Google-Smtp-Source: ANB0VdaqipKUlcdieYFH3vEumaf8evZ+JxZL30MXZj+HEQl3f6On4MGE3dlYFvVhknaNni7155Zp9NaAuV7zZGRudKM=
X-Received: by 2002:a02:270f:: with SMTP id g15-v6mr22252187jaa.94.1537202758656;
 Mon, 17 Sep 2018 09:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-3-benpeart@microsoft.com>
 <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com> <78f62979-18a7-2fc1-6f26-c4f84e19424f@gmail.com>
In-Reply-To: <78f62979-18a7-2fc1-6f26-c4f84e19424f@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 18:45:32 +0200
Message-ID: <CACsJy8AYq=FivKZ869tvjwuSc70tuaPV0HJ0aRp=VFbJBSpm=A@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] read-cache: load cache extensions on a worker thread
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 6:26 PM Ben Peart <peartben@gmail.com> wrote:
>
>
>
> On 9/15/2018 6:22 AM, Duy Nguyen wrote:
> >> +index.threads::
> >> +       Specifies the number of threads to spawn when loading the index.
> >> +       This is meant to reduce index load time on multiprocessor machines.
> >> +       Specifying 0 or 'true' will cause Git to auto-detect the number of
> >> +       CPU's and set the number of threads accordingly. Defaults to 'true'.
> >
> > I'd rather this variable defaults to 0. Spawning threads have
> > associated cost and most projects out there are small enough that this
> > multi threading could just add more cost than gain. It only makes
> > sense to enable this on huge repos.
> >
> > Wait there's no way to disable this parallel reading? Does not sound
> > right. And  if ordinary numbers mean the number of threads then 0
> > should mean no threading. Auto detection could have a new keyword,
> > like 'auto'.
> >
>
> The index.threads setting is patterned after the pack.threads setting
> for consistency.  Specifying 1 (or 'false') will disable multithreading
> but I will call that out explicitly in the documentation to make it more
> obvious.
>
> The THREAD_COST logic is designed to ensure small repos don't incur more
> cost than gain.  If you have data on that logic that shows it isn't
> working properly, I'm happy to change the logic as necessary.

THREAD_COST does not apply to this extension thread if I remember correctly.

> >> +static void *load_index_extensions(void *_data)
> >> +{
> >> +       struct load_index_extensions *p = _data;
> >> +       unsigned long src_offset = p->src_offset;
> >> +
> >> +       while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
> >> +               /* After an array of active_nr index entries,
> >> +                * there can be arbitrary number of extended
> >> +                * sections, each of which is prefixed with
> >> +                * extension name (4-byte) and section length
> >> +                * in 4-byte network byte order.
> >> +                */
> >> +               uint32_t extsize;
> >> +               memcpy(&extsize, (char *)p->mmap + src_offset + 4, 4);
> >> +               extsize = ntohl(extsize);
> >> +               if (read_index_extension(p->istate,
> >> +                       (const char *)p->mmap + src_offset,
> >> +                       (char *)p->mmap + src_offset + 8,
> >> +                       extsize) < 0) {
> >> +                       munmap(p->mmap, p->mmap_size);
> >> +                       die("index file corrupt");
> >
> > _()
> >
>
> You're feedback style can be a bit abrupt and terse.  I _think_ what you
> are trying to say here is that the "die" call should use the _() macro
> around the string.

Yes. Sorry I should have explained a bit better.

> This is an edit of the previous code that loaded index extensions and
> doesn't change the use of _(). I don't know the rules for when _()
> should be used and didn't have any luck finding where it was documented
> so left it unchanged.
>
> FWIW, in this file alone there are 20 existing instances of die() or
> die_errorno() and only two that use the _() macro.  A quick grep through
> the source code shows thousands of die() calls the vast majority of
> which do not use the _() macro.  This appears to be an area that is
> unclear and inconsistent and could use some attention in a separate patch.

This is one of the gray areas where we have to determine if the
message should be translated or not. And it should be translated
unless it's part of the plumbing output, to be consumed by scripts.

I know there's lots of messages still untranslated. I'm trying to do
something about that. But I cannot just go fix up all strings when you
all keep adding more strings for me to go fix. When you add a new
string, please consider if it should be translated or not. In this
case since it already receives reviewer attention we should be able to
determine it now, instead of delaying it for later.

> >> +       /* if we created a thread, join it otherwise load the extensions on the primary thread */
> >> +#ifndef NO_PTHREADS
> >> +       if (extension_offset && pthread_join(p.pthread, NULL))
> >> +               die(_("unable to join load_index_extensions_thread"));
> >
> > I guess the last _ is a typo and you wanted "unable to join
> > load_index_extensions thread". Please use die_errno() instead.
> >
>
> Why should this be die_errorno() here?  All other instances of
> pthread_join() failing in a fatal way use die(), not die_errorno().

That argument does not fly well in my opinion. I read the man page and
it listed the error codes, which made me think that we need to use
die_errno() to show the error. My mistake though is the error is
returned as the return value, not in errno, so die_errno() would not
catch it. But we could still do something like

    int ret = pthread_join();
    die(_("blah blah: %s"), strerror(ret));

Other code can also be improved, but that's a separate issue.
-- 
Duy
