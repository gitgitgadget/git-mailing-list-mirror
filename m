Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E08E1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 16:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIHVcf (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 17:32:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43041 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeIHVce (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 17:32:34 -0400
Received: by mail-io1-f67.google.com with SMTP id y10-v6so3846489ioa.10
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BieaxxbCHC/+XByAvH/OXnMhy/Yo0402o5mj+sIb5dw=;
        b=MnjWEx2kn/PKExgoojBO9GL+ZjechZs6/WmWCjd92YI6xda2l+fmk/16FuOwlw4p5b
         qxzz+868aMitMtXk+BS4tADYdaHrlhcbSvW4NRQWUypD5swKZLpiEkcrMRSk32ldmwvB
         r1q9/ECiVNZcnWQbEswJSyhzAVGRryVxDxhuBqcMrpzflkGme1yVu+B9jsHFyqs6XmH+
         9BzaM4GIbhP/Wqqbghl4odxqKfkBJcD+wRs111ijof5b99LQcY+rxGTY1//fi0MDebHj
         mZmnY62S/Io/9ST+RapbAW3BaanqY42XbrpwevO+/zVPg044WU5exwBl7/u1iZ6I5tsF
         00+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BieaxxbCHC/+XByAvH/OXnMhy/Yo0402o5mj+sIb5dw=;
        b=STcA9R7np8Jn4dbSyebU0rixYrfb4P+DQw82mer10YMRJvQsOlOLcUuzxt3eep7gTv
         hsSk8qhJXxrsAqEI2cKu1LywPNCQ4Q0Glyz/wP/Dg+9UeNr8cWor+gPbMBOYajfDk4me
         551nwXu9OC6A1hPhSeZThzVmAOlyhboDVXmZhnCLpsQffScCDG4rh9aLL42FaJyzoIhz
         9NJQgpc2uQXEf/aR+VTdxPOY7sdzkhYtr6Xb9j8umaMaovx719MwETx6FSW6RzEz12HG
         s6xX5hwQ3JavWwx/tpAtAcrNkccBpggGEk0y0XtxHQ8s5Jiiv8kS4F6EswLZFd1jrWNn
         f+sw==
X-Gm-Message-State: APzg51CSXZ+wZqzPyfoeCAetzUZ13FvS2ApySxHbid4o49d4HMqJ8vK6
        1cqUQTmU2CqdxJBQaTb69pm8ANXwpAn+o1rCFH0=
X-Google-Smtp-Source: ANB0VdYQBJo3mUnDSZ1+SGv+rATMFaJ4LuRyYx82fDH5TTy8IpRPOTS6ytOPVH+oHGgVvhLxp1AMlLnGnr3xsGpFB5E=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr9889305iok.236.1536425171926;
 Sat, 08 Sep 2018 09:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180906024810.8074-1-szeder.dev@gmail.com> <20180906024810.8074-6-szeder.dev@gmail.com>
In-Reply-To: <20180906024810.8074-6-szeder.dev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Sep 2018 18:45:46 +0200
Message-ID: <CACsJy8CAPcD7pHgV-KWb39cFAvL1Yn+89y5znhcOgTG8O57w_A@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] split-index: smudge and add racily clean cache
 entries to split index
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 4:48 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> Ever since the split index feature was introduced [1], refreshing a
> split index is prone to a variant of the classic racy git problem.
>
> Consider the following sequence of commands updating the split index
> when the shared index contains a racily clean cache entry, i.e. an
> entry whose cached stat data matches with the corresponding file in
> the worktree and the cached mtime matches that of the index:
>
>   echo "cached content" >file
>   git update-index --split-index --add file
>   echo "dirty worktree" >file    # size stays the same!
>   # ... wait ...
>   git update-index --add other-file
>
> Normally, when a non-split index is updated, then do_write_index()
> (the function responsible for writing all kinds of indexes, "regular",
> split, and shared) recognizes racily clean cache entries, and writes
> them with smudged stat data, i.e. with file size set to 0.  When
> subsequent git commands read the index, they will notice that the
> smudged stat data doesn't match with the file in the worktree, and
> then go on to check the file's content.
>
> In the above example, however, in the second 'git update-index'
> prepare_to_write_split_index() gathers all cache entries that should
> be written to the new split index.  Alas, this function never looks
> out for racily clean cache entries, and since the file's stat data in
> the worktree hasn't changed since the shared index was written, it
> won't be replaced in the new split index.  Consequently,
> do_write_index() doesn't even get this racily clean cache entry, and
> can't smudge its stat data.  Subsequent git commands will then see
> that the index has more recent mtime than the file and that the (not
> smudged) cached stat data still matches with the file in the worktree,
> and, ultimately, will erroneously consider the file clean.
>
> Modify prepare_to_write_split_index() to recognize racily clean cache
> entries, and mark them to be added to the split index.  This way
> do_write_index() will get these racily clean cache entries as well,
> and will then write them with smudged stat data to the new split
> index.

Ack. I was aware of the first half of of the racy solution but did not
pay attention to this smudging business.

I wonder if untracked cache is also racy like this. It also only has
half the racy solution because I only knew that much. I'll check this
later.

> Note that after this change if the index is split when it contains a
> racily clean cache entry, then a smudged cache entry will be written
> both to the new shared and to the new split indexes.  This doesn't
> affect regular git commands: as far as they are concerned this is just
> an entry in the split index replacing an outdated entry in the shared
> index.  It did affect a few tests in 't1700-split-index.sh', though,
> because they actually check which entries are stored in the split
> index; the previous patch made the necessary adjustments.  And racily
> clean cache entries and index splitting are rare enough to not worry
> about the resulting duplicated smudged cache entries, and the
> additional complexity required to prevent them is not worth it.

Yes. If we have to make updates (racy or not) we have to make updates,
and the version in the shared index becomes obsolete by design.
--=20
Duy
