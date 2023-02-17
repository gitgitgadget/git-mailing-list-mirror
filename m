Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A4EC6379F
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 15:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBQPnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 10:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBQPnS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 10:43:18 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7550E2C672
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 07:43:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p15-20020a17090a2d8f00b00233ceae8407so1555990pjd.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jB7WiV96fmtBZog27E2hIZV6HYTwXLAAGQOyMDkq8DM=;
        b=iUJkv3icksJK6HwKSEDTL+Kyz4j6XGwn1xmv5NB3nxSCNNl9BOA8lDBixcrwuUkz14
         UT33RLK8SjEaZr2UZ2WaeNitRRGxF1tftYS0BwMeiNVBtGIPJjJwR94chenEHV6vrkZ1
         OZGGTqBju+yFMzUamkIxfChEC2JhkGPN6yZS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jB7WiV96fmtBZog27E2hIZV6HYTwXLAAGQOyMDkq8DM=;
        b=CXMIWR/b4kh1CNG3WzceJCY7iop7jb5KTYSwR01Im7EzFVU/pQJCO8diBjo4aDTEa1
         KtVI1OK4g5TEj5jOItv3Pwk/B6fcjZEWtSGNYJPi54YZtE40jfZm0D1ur5IJfTmQ6jFi
         l4CE1nLnRZXrqtF1/cwDS7GZwng1bjFZt7goSsUj4Sl5saEScuIpTBoJJwwgtmC/Iieg
         Be2wea8BhFwQeGJ4aJ/Zva0HS9iaAeIqy47slCYFSMh0tVXo2CopXEm3ZELUngi0JH0N
         y4sruacR26xNO1adlgcIpxo0jw8+0n/3pb4bYUjGbc0n8TAx3VqC+Hr/QHYen1+cq3kb
         Ja1g==
X-Gm-Message-State: AO0yUKXzUkQ8IchYI8yzUSF6qEByA2EZCg107bZ7x8SMR8F3ydoUiug0
        Yirx2TXyjogxGD0ryDXzOCL3cXBnHBOI0MC1
X-Google-Smtp-Source: AK7set/TxgqtUbrUfdwdbbOPSWmcKkt70tXz844IYTDNB+ZxDUYpRFzue91J1RPrzn2UDPBNyHOkXQ==
X-Received: by 2002:a17:903:2888:b0:19a:a2e7:64c3 with SMTP id ku8-20020a170903288800b0019aa2e764c3mr9017450plb.68.1676648596742;
        Fri, 17 Feb 2023 07:43:16 -0800 (PST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00195f242d0a0sm3269494plp.194.2023.02.17.07.43.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 07:43:16 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id ep15-20020a17090ae64f00b002349579949aso1634592pjb.5
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 07:43:16 -0800 (PST)
X-Received: by 2002:a17:90b:3ec6:b0:234:7d1:b5e5 with SMTP id
 rm6-20020a17090b3ec600b0023407d1b5e5mr1786868pjb.43.1676648595373; Fri, 17
 Feb 2023 07:43:15 -0800 (PST)
MIME-Version: 1.0
References: <Y+6G9n6cWRT9EKyl@google.com> <Y+6akicTFG9n0eZy@coredump.intra.peff.net>
 <xmqq5yc1p7yn.fsf@gitster.g> <Y+7PcqpYhF5ZuApG@coredump.intra.peff.net> <xmqqpma9m4i1.fsf@gitster.g>
In-Reply-To: <xmqqpma9m4i1.fsf@gitster.g>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 17 Feb 2023 08:43:03 -0700
X-Gmail-Original-Message-ID: <CAHQZ30Dq1_vdJj_hakqXKFUbuqn9ysNsw-zzN83RmUVbibA3Gw@mail.gmail.com>
Message-ID: <CAHQZ30Dq1_vdJj_hakqXKFUbuqn9ysNsw-zzN83RmUVbibA3Gw@mail.gmail.com>
Subject: Re: Feature request: Add --mtime option to git archive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 7:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > A similar option in is to simply start using "0" in the meantime, like:
> >
> > diff --git a/archive.c b/archive.c
> > index 81ff76fce9..48d89785c3 100644
> > --- a/archive.c
> > +++ b/archive.c
> > @@ -470,7 +470,7 @@ static void parse_treeish_arg(const char **argv,
> >               archive_time = commit->date;
> >       } else {
> >               commit_oid = NULL;
> > -             archive_time = time(NULL);
> > +             archive_time = 0;
> >       }
> >
> >       tree = parse_tree_indirect(&oid);
> >
> > Nobody will complain about changing the byte-for-byte format, since by definition it
> > was already changing once per second (cue somebody complaining that they
> > have been using LD_PRELOAD tricks to simulate --mtime).
> >
> > I do wonder if people would complain (both with the patch above and with
> > brian's proposal) that the resulting tarballs extract everything with a
> > date in 1970. That's not functionally a problem, but it looks kind of
> > weird in "ls -l".
>
> And owned by root:root ;-)

I fully support both of those easy changes. Only reason I proposed
--mtime was that https://reproducible-builds.org/docs/archives/
recommends setting SOURCE_DATE_EPOCH, but honestly for my purposes I
would always use 0 and root:root.

>
> I am sure people would complain.  What matters is if these
> complaints have merit, and in this case, I doubt it.  I especially
> like your "it has been already changing once per second" reasoning
> for this change.
