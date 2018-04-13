Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEEA31F404
	for <e@80x24.org>; Fri, 13 Apr 2018 22:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDMW1F (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 18:27:05 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36373 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeDMW1F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 18:27:05 -0400
Received: by mail-wr0-f174.google.com with SMTP id q13so8219530wre.3
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 15:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8QqCtVuKghxQk/pusYZcxC64qX9dKup0tpLheDIinhE=;
        b=pf7EodbatVAch/ddvUhqDPae4YOtEvPIM+V1Xcs4QCFa0QsNzFqotzBN3HyVzdpMjP
         rY3qGTh0bo10nGXkihldlopD+cecYPz04hp6HOgB7NyxvXBSDXHTv1tnjNgfAdt6Jb7Z
         c2g46odZxaqXV76UC804GW+LSVIyIuyPO2ZfZfIKv7fgG4VmB+U1tgNQnpgj0LxLqNpA
         LiNQXDsg9dhjeuBY01GoFOkjp3ytA5aKTTP1ECdbT6HXKzBnWSkW/t8VS5t8ZQFkYz+4
         axGiGiaFZrQ67cToLLZOXMeTPkSG26OWRwm+PgPhdywBlLTkbY7lnELYKojPBlTdUSws
         APkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8QqCtVuKghxQk/pusYZcxC64qX9dKup0tpLheDIinhE=;
        b=N4GtMouBm7RoR4drSaDzSOBw03cG1hcUsTpZl9qftclXrIFg6fmLC/Md7KmHR0QqAH
         bWJh6VKl5URsOCWarT/3cBPtxsv9//NcfNqCELKgNu+U32oZauLyv9CQjS3jjt9lJPiO
         TaTeI84ufpFCiLccyZ4fTlDRBGwyw72dJJzSg1HZeMMbQJdTSk5i6R99hvDiTQM7Jogm
         zhlA0wybph2A2UrjCjBQoNGNMTrxLECAMEynxB/1yML8pAaA0i/7SzQ0mfnNmy3UrmRU
         7cRlsYAXR+t0bHiDISmodmhlc6u2dmRHXW+aEKjKTViOV+3oUivYpROCtHl8hT33ppTF
         dXZQ==
X-Gm-Message-State: ALQs6tAkWvHNHKcggq/ATd16K1I2t9pdbcZaoKpuYu/TuYXJjH3iV91t
        vR3MsyE0/1WwqPvdw0yv/fI=
X-Google-Smtp-Source: AIpwx48VRHy5TKHKAv8fEDhPDPY5MDHqIiWhReUMhie8TBHtNKMfvpZKcof3q4OQsY3K5ccRsqDygg==
X-Received: by 10.223.219.198 with SMTP id e6mr5228618wrj.212.1523658423323;
        Fri, 13 Apr 2018 15:27:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e202sm3197897wma.43.2018.04.13.15.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 15:27:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Optimizing writes to unchanged files during merges?
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
        <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com>
        <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
        <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
        <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
        <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
        <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
        <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
        <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
        <CABPp-BFZZJ=rgOYqgsxD1A-Q5AU91e-HQ6WbAsGSqNppADXySQ@mail.gmail.com>
Date:   Sat, 14 Apr 2018 07:27:01 +0900
In-Reply-To: <CABPp-BFZZJ=rgOYqgsxD1A-Q5AU91e-HQ6WbAsGSqNppADXySQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 13 Apr 2018 13:04:01 -0700")
Message-ID: <xmqqmuy62156.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Yes, precisely.  Checking the *current* index is not reliable in the
> presence of renames.
>
> Trying to use the current index as a proxy for what was in the index
> before the merge started is a problem.  But we had a copy of the index
> before the merge started; we just discarded it at the end of
> unpack_trees().  We could keep it around instead.  That would also
> have the benefits of making the was_dirty() checks more accurate too,
> as using the mtime's in the current index as a proxy for what was in
> the original index has the potential for the same kinds of problems.

Yeah, I agree that you are going in the right direction with the
above.

> It's certainly tempting as an interim solution.  I have an alternative
> interim solution that I think explains well why the code here had been
> fragile, and how to just implement what we want to know rather than
> making approximations to it, which I just posted at [2].  But I can
> see the draw of just gutting the code and replacing with simple brute
> force.

Thanks; I'd love to reserve a block of time to think this through
myself, but I am a bit occupied otherwise this weekend, so I'll try
to catch up after that.

