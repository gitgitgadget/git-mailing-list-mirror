Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9948FC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 12:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245330AbiFJMz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 08:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiFJMzy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 08:55:54 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CEB666A3
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 05:55:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h23so2870830ljl.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9YA9EO+Gqo/l/MJJlwf5eFL6WfqKZsdGBCYn9VMmxY=;
        b=pp8CfYSg7jyxqtdDHozbjIDJ/Efm9HGCSYk1CcCdF4Vj7xwVEwox5EWu+XRVa96Xec
         O4IBGnWP18A92GSSvk6htmX8AnP8moonMMMjCXc0+yNyPxJM7U1XYT2Fh6d5lHw17qx1
         oTuYFx4APgUS1l8I7fjzATtGDP9T1NZKXFB+NL6Q8RoYr/g4YpYYIzBjyv0nhJZLWeWU
         k0YSmJrP/CxX8vm6CdU0R1u5CnU3dlNlDxD0HZwyZjb0to1bsPZbHt3ywDjYa/YIQGav
         o+uHpfXLk2cZepMvXqqFGHy9kvn4hniIkhTU+6keAgN96r9gaf6q6RGjZbhc/psdOxT1
         AaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9YA9EO+Gqo/l/MJJlwf5eFL6WfqKZsdGBCYn9VMmxY=;
        b=IAGY9eXlQALTVzi81WNKdqRpI/sXMuo/lUZ2agcNGuRID0AxsHqqG7oftx9p/GRW3r
         uNpovjHS55/7qGGYYHdw4Qx48rHq0Lxv11hbWqtcJAcNc9FnlS01mXYTAFINGM1a1ePt
         elu4BBqfAUAsXNVIYwgt7cl3Peihgvrn19nvOc6y2HVwLux6CQI6wbfcfufI08ulGsyb
         HbClnEGAimlW9cdXSldvLeszLMNN76VduXwfQPxt4Q/VJfvBjNlekaBk3o05MMk6TizG
         vwieHAaS0W9Hmqui7vP+uwcZshqE9bo99rm0MpQ0NGYN3l8pLpRIYzELTcnzxPkk36Pl
         ig+A==
X-Gm-Message-State: AOAM532ldsJ9yxpvV6Pdo3WfJ0HHO6VDRNKzryTYZAJX6cZWeGwKqLgN
        M8+i6r8V1I1SQrVMHT3Tm2tQyPb3B8FDTjNUTtI=
X-Google-Smtp-Source: ABdhPJwczQ6+FXvbnqkSeGq1LQugRSNwb8rTIe3WEEdDre0h8QlrttOj4d505lzPTL54rMQFl0uZ6qqda3JI2kphVa8=
X-Received: by 2002:a2e:84c7:0:b0:253:c9ef:6d2b with SMTP id
 q7-20020a2e84c7000000b00253c9ef6d2bmr61626210ljh.124.1654865750990; Fri, 10
 Jun 2022 05:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com>
 <20220609030530.51746-1-chiyutianyi@gmail.com> <nycvar.QRO.7.76.6.2206091114070.349@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2206091114070.349@tvgsbejvaqbjf.bet>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Fri, 10 Jun 2022 20:55:39 +0800
Message-ID: <CAO0brD3co2FB+UdhNDShT_uwWhTxuKeW9TuX6T_5yZ4CQkFjPw@mail.gmail.com>
Subject: Re: [RFC PATCH] object-file.c: batched disk flushes for stream_loose_object()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     nksingh85@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 9, 2022 at 5:30 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Thu, 9 Jun 2022, Han Xin wrote:
>
> > Neeraj Singh[1] pointed out that if batch fsync is enabled, we should still
> > call prepare_loose_object_bulk_checkin() to potentially create the bulk checkin
> > objdir.
> >
> > 1. https://lore.kernel.org/git/7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com/
> >
> > Signed-off-by: Han Xin <chiyutianyi@gmail.com>
>
> I like a good commit message that is concise and yet has all the necessary
> information. Well done!
>
> > ---
> >  object-file.c                   |  3 +++
> >  t/t5351-unpack-large-objects.sh | 15 ++++++++++++++-
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index 2dd828b45b..3a1be74775 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -2131,6 +2131,9 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
> >       char hdr[MAX_HEADER_LEN];
> >       int hdrlen;
> >
> > +     if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> > +             prepare_loose_object_bulk_checkin();
> > +
>
> Makes sense.
>
> >       /* Since oid is not determined, save tmp file to odb path. */
> >       strbuf_addf(&filename, "%s/", get_object_directory());
> >       hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
> > diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
> > index 461ca060b2..a66a51f7df 100755
> > --- a/t/t5351-unpack-large-objects.sh
> > +++ b/t/t5351-unpack-large-objects.sh
> > @@ -18,7 +18,10 @@ test_expect_success "create large objects (1.5 MB) and PACK" '
> >       test_commit --append foo big-blob &&
> >       test-tool genrandom bar 1500000 >big-blob &&
> >       test_commit --append bar big-blob &&
> > -     PACK=$(echo HEAD | git pack-objects --revs pack)
> > +     PACK=$(echo HEAD | git pack-objects --revs pack) &&
> > +     git verify-pack -v pack-$PACK.pack |
> > +         grep -E "commit|tree|blob" |
> > +             sed -n -e "s/^\([0-9a-f]*\).*/\1/p" >obj-list
>
> Here, I would recommend avoiding the pipe, to ensure that we would catch
> problems in the `verify-pack` invocation, and I think we can avoid the
> `grep` altogether:
>
>         git verify-pack -v pack-$PACK.pack >out &&
>         sed -n 's/^\([0-9a-f][0-9a-f]*\).*\(commit\|tree\|blob\)/\1/p' \
>                 <out >obj-list
>

Good suggestion. I will take it.

Thanks.
-Han Xin

> >  '
> >
> >  test_expect_success 'set memory limitation to 1MB' '
> > @@ -45,6 +48,16 @@ test_expect_success 'unpack big object in stream' '
> >       test_dir_is_empty dest.git/objects/pack
> >  '
> >
> > +BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
> > +
> > +test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
> > +     prepare_dest 1m &&
> > +     git $BATCH_CONFIGURATION -C dest.git unpack-objects <pack-$PACK.pack &&
>
> I think the canonical way would be to use `test_config core.fsync ...`,
> but the presented way works, too.
>
> > +     test_dir_is_empty dest.git/objects/pack &&
> > +     git -C dest.git cat-file --batch-check="%(objectname)" <obj-list >current &&
>
> Good. The `--batch-check="%(objectname)"` part forces `cat-file` to read
> the actual object.
>
> > +     cmp obj-list current
> > +'
>
> My main question about this test case is whether it _actually_ verifies
> that the batch-mode `fsync()`ing took place.
>
> I kind of had expected to see Trace2 enabled and a `grep` for
> `fsync/hardware-flush`. Do you think that would still make sense to add?
>
> Thank you for working on the `fsync()` aspects of Git!
> Dscho
>

More rigorous inspection should be adopted.

Thanks.
-Han Xin

> > +
> >  test_expect_success 'do not unpack existing large objects' '
> >       prepare_dest 1m &&
> >       git -C dest.git index-pack --stdin <pack-$PACK.pack &&
> > --
> > 2.36.1
> >
> >
