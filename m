Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC641C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 10:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F962610FA
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 10:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbhHZKD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbhHZKDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 06:03:25 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3AC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 03:02:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id z2so1635917qvl.10
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i45fNP7rTkY9SlBDElBX8Y5GFTmN0W3Z8jHtuqYUfSk=;
        b=Q8o2R+2pdv4fxUgimTwGHhAk9p6/rKT53tuIjwXd8TnO7er0aqntgkf9PTfeyMmxYh
         3iOnGdGgHJgFCRAbLK337jn6ZSqLChY40R3bWzNLuDGnlHPOMl+nGJk9lbk7kg3pYYg6
         OC3v23xOq6di76DuOCySspr6sQ5y6yYZYwelg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i45fNP7rTkY9SlBDElBX8Y5GFTmN0W3Z8jHtuqYUfSk=;
        b=UONhhXcyiBgsXBZa+oaH+c2F7DRgVj6bPn8sWmkl8BBVPQKBAVjO9nBPZe8ePvoB8C
         7/KC8DAlhcmWTmlmb1qIeVSG16FHkie3o9fdEiwwyD+ZIgr+IUobL6WADeV7uWenvebw
         gPkGZz0x8pssYWuMMGP80qV75U+YdYWmb/yDzFY+lqkjXTGak2a898SAu7JLvvvPPjPS
         yJHTSI1dVwiN8szAEwiCYlLqmjr+kDBi2SjZEhk3fDFCdpH6KNZJuXqiTRzDW082Y7A+
         zRCJOCTTtgyB+H6LVcX9UI2pACQC/JbnY2PSgQu/xW4F6KRf2sx+k2NXDWVSdqQVNTLl
         2Vzw==
X-Gm-Message-State: AOAM531NpxdXpgiomdxqKb6rn34K4+0DLqGkYPaeykoNjpqO+AKKEk+u
        YVwW6OppEw5xCHlyEKyRzbJ6UHAe6QdnUXsi3auAtw==
X-Google-Smtp-Source: ABdhPJzAbC6wSvB4iPKSFo4lP+uksesb8XHk7qs+NEZi/7ncPZMtT17PAK3NkNgs4InAkVMEy73xbtfu/ziUy8wclPg=
X-Received: by 2002:a05:6214:592:: with SMTP id bx18mr2699919qvb.26.1629972157615;
 Thu, 26 Aug 2021 03:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210824140259.89332-1-jacob@gitlab.com> <YSVfq9lZGdSRCcP9@nand.local>
 <xmqqczq2mseb.fsf@gitster.g> <YSWSd5fMbSD5duOU@coredump.intra.peff.net>
In-Reply-To: <YSWSd5fMbSD5duOU@coredump.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Thu, 26 Aug 2021 12:02:26 +0200
Message-ID: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] upload-pack: buffer ref advertisement writes
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Are there any consumers that rely on having information early (where
> buffering would be a detriment to them)?

I think not.

> Hmm. Seeing a reduction in CPU time is surprising to me: do you have an
> explanation for why the time-savings isn't coming purely from "system"
> (i.e., any blocking I/O)?

Pipe writes only block in the IO sense if the pipe buffer is full.
Otherwise they seem to spend their time in spinlocks and copying into
the page buffer. In my benchmark, I don't believe the pipe buffer was
ever full.

I'm not an expert on the Linux kernel; you can see CPU flame graphs in
https://gitlab.com/gitlab-com/gl-infra/scalability/-/issues/1257.

> Yeah, I had the same thought. It also feels like this is a problem
> already solved by stdio. I.e., a lot of the packet_* functions can
> handle descriptors or strbufs. Why not "FILE *" handles?

My colleague Patrick Steinhardt (cc) made the same suggestion
off-list. I'll post an alternative patch set to this thread.

Jacob


On Wed, Aug 25, 2021 at 2:44 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 24, 2021 at 02:42:20PM -0700, Junio C Hamano wrote:
>
> > > None of this looks wrong to me, but it might be nice to teach the
> > > packet writer a buffered mode that would handle this for us. It would be
> > > especially nice to bolt the final flush onto packet_flush(), since it is
> > > otherwise easy to forget to do.
> >
> > FWIW, the packet-line part of the system was from the beginning
> > written with an eye to allow buffering until _flush() comes; we may
> > have added some buggy conversation path that deadlocks if we make
> > the non-flush packets fully buffered, so there may need some fixes,
> > but I do not expect the fallout would be too hard to diagnose.
> >
> > It may be worth trying that avenue first before piling on the user
> > level buffering like this patch does.
>
> Yeah, I had the same thought. It also feels like this is a problem
> already solved by stdio. I.e., a lot of the packet_* functions can
> handle descriptors or strbufs. Why not "FILE *" handles?
>
> It would probably involve using the original descriptor _and_ the
> filehandle in some cases (e.g., ref advertisement over the handle, and
> then muxing pack-objects output straight to the descriptor). But that's
> OK as long we are sensible about flushing at the right moments.
>
> It may not be much less complex than just implementing buffering in the
> packet_* interfaces, though. The tricky part is likely to be the
> interface (not itself, but avoiding repetition between all the
> fd/strbuf/buffered variants).
>
> -Peff
