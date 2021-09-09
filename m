Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4020C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 08:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B07061132
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 08:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhIIIH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhIIIH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 04:07:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CFEC061757
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 01:06:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jg16so1859138ejc.1
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 01:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=L5lqsdbW6OjaiJ0RvGcYrBHMAoxicoEC0wQm/QEkzow=;
        b=aWn7PHvqgsysF1WF7O3f9Z/Nsjrhqk277t2CQEsXWiAEwRGCo8MSYqnRwhZF47SHm5
         sKsUhXTH+2NTnl2wn7biZDZ1e7YYhriloIEqWpmgTCIxBpwsnk0YmpQk0tp6LiiQI0+I
         hUGHpPfgquWfA9VHWVjpMUaJyMp8POkIQCk8ZgI5FGxdt6Zlx0Pzu8wsHSXbbWyPoVs/
         3OMxZ4T6zpMiftA0sNEZBCTibOkKlIacZK1LC4LUz4rKcWPS0nKGjcOq1Z2CpJtPYQW2
         nQK3qGkMv6AxFf/ylB5UjnxUfbd1YObK1lMnfX53wO5GPc6QrI3Uko8UvOoMwPs26lSu
         r6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=L5lqsdbW6OjaiJ0RvGcYrBHMAoxicoEC0wQm/QEkzow=;
        b=3gaE20X00lsMmuxR1Up+MIl1X/PcTAGfSr+tGgMz/rAzGmfjd6JK+dc4I6BmHW9F+w
         zCjAlRGbrN/rU0Qsn8FwafKCYqoQhcg+oV23Yew+9uSgW81DV1hBk5qB0BHoN74R2v26
         qxMO6ND0GFKvucAcSwkE7Y6zOCAqMozX2VtaF1k8MkFkaXTPdPQfB7/lZWE1JDbFRDlJ
         5vP/Glu99OLR+aeo2vFVTi4RGA5Bx9H8lpbqob0BwWGhUyaJKB6kioV3cfVZYUeqKy+s
         3ylmbum3oif7Ezho1X4F+Y6pfH2d+SrqkrrshHj0qECM1/QJXq7qwFGW7v4YaWpHqmHr
         4PfQ==
X-Gm-Message-State: AOAM530RqEy75M+UEvkJ/tXQ6PEOGtTdPqluj8CtPCFSsrDiIt9p3N2D
        SfGu92rNxluabsXs7OwVCAE=
X-Google-Smtp-Source: ABdhPJwx1ICWi/Z6rXa8aMY43RRraN38wGFz5qr/H1oh4wl8uIXqLp0k1faIy709QUF4mhQ6Wegnvg==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr2063231ejc.504.1631174777225;
        Thu, 09 Sep 2021 01:06:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c25sm497345ejm.9.2021.09.09.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 01:06:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 9/9] pack-objects: rename .idx files into place after
 .bitmap files
Date:   Thu, 09 Sep 2021 09:54:44 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <d8286cf1075dc85231128145c5abb0db3881032b.1631157880.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <d8286cf1075dc85231128145c5abb0db3881032b.1631157880.git.me@ttaylorr.com>
Message-ID: <878s06fa14.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Taylor Blau wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> In preceding commits the race of renaming .idx files in place before
> .rev files and other auxiliary files was fixed in pack-write.c's
> finish_tmp_packfile(), builtin/repack.c's "struct exts", and
> builtin/index-pack.c's final(). As noted in the change to pack-write.c
> we left in place the issue of writing *.bitmap files after the *.idx,
> let's fix that issue.
>
> See 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-21)
> for commentary at the time when *.bitmap was implemented about how
> those files are written out, nothing in that commit contradicts what's
> being done here.
>
> Note that this commit and preceding ones only close any race condition
> with *.idx files being written before their auxiliary files if we're
> optimistic about our lack of fsync()-ing in this are not tripping us
> over. See the thread at [1] for a rabbit hole of various discussions
> about filesystem races in the face of doing and not doing fsync() (and
> if doing fsync(), not doing it properly).
>
> In particular, in this case of writing to ".git/objects/pack" we only
> write and fsync() the individual files, but if we wanted to guarantee
> that the metadata update was seen in that way by concurrent processes
> we'd need to fsync() on the "fd" of the containing directory. That
> concern is probably more theoretical than not, modern OS's tend to be
> more on the forgiving side than the overly pedantic side of
> implementing POSIX FS semantics.

Some weird gramma/phrasing of mine left over here, i.e.  the "[...] in
this are not tripping us over.". On reflection perhaps it's better to
replace these last two paragraphs with say:

    With this and preceding commits we've covered all the cases where we
    wrote another auxiliary file before the *.idx file, and should thus
    never have another concurrent process try to use an incomplete set
    of pack-OID.* files.

    This assumes that the renames we make here and elsewhere appear on
    the filesystem in the order we performed them. This assumption is
    known to be false in the face of pedantic POSIX FS semantics. See
    the thread around [1] for discussions on that point.

    We fsync() the file descriptors we're writing out for all the
    auxiliary files, but we don't yet fsync() the file descriptor for
    the containing directory. Therefore our data might have been written
    out, but it's anyone's guess what the state of the directory
    containing the file is after we write the *.idx.

    In practice modern OS's are known to be forgiving on that point, so
    this will probably solve races in practice for most users. It will
    almost certainly make them better than they were before when we
    didn't write *.idx files last. We should more generally improve our
    use of fsync() to cover containing directories, but that'll
    hopefully be addressed by some follow-up series.
