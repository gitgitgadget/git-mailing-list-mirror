Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2054C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6E82071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrESdc3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgI3UuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbgI3UuF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 16:50:05 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC60C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 13:50:04 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 7so1607046vsp.6
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tw4NrIHgsbYMEeF8Mn5AFqQye920eE3eVse7kZO8YbE=;
        b=ZrESdc3nOllXewcGL5JRlCHZhaW4qv3EwxRb01mVaonpBjZSK9cPtNRoKs/566S0oB
         ABFS9T5OmDzelxKNdYuVZL6xM8Mei8O70NtgQcp50rL+jj5Nz1S1LSUeTJaWGA+1+taS
         e3A5MymE51xipoEkybRqIcPXByjptD3ezCTBRGN98bG4WfrcpN8d+Dz/uEukX9VcJAfM
         gMag5c3MPWrUW+L4S8g+0uDWfiiaAIt+grFiQz7zg+Poa8ULX6EpPqTuw9bASBQGA21e
         RQ0tj/H9FXS+HBUlB44rFhC3MNvetk7TbEr+diLh3GChuXzojqc0xM2tst6abRLQowPV
         X+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tw4NrIHgsbYMEeF8Mn5AFqQye920eE3eVse7kZO8YbE=;
        b=fFbLPulXRAwr2vIyDkjhlfmkk3QK/gYLiAGhb2JX6ufQXuA849E7ZFXVOuRUTE04NU
         V7VSj+VVaXDk9gz3KK40x/8kLGaKURjn4FhQqcqCB+mj0QRRJaU4w9czklHxZXKz+Ijp
         zOjmtwzJjUvH6JoHwCA9trD6W6A/zLpnOcFZelwKeMLg7gsKxjnohMpBtG2rQ7/+VBvF
         ndz96JIXDpFK/faxOPjiTrj7fENFs95J9qYIzWfBZIR85RHPfV8pZd1krsxqLvmql+h+
         4AwOUmqmadW+TowiwM8DMxZlH9DYsRqB6qvXqks7T76XtwpLxdcrQu+aRZmVXxok2ZIF
         87/g==
X-Gm-Message-State: AOAM530AQlc0+UMPh8Xa+TX8MBsrY9BMSR/E7bLrgbcNCyh362QuDb5t
        3wK3T3FC2L1hQcicqe8OjraF1GSOa70BFJxoKAM=
X-Google-Smtp-Source: ABdhPJyCPn5LVuel0HfPdOBkTU/QoHnleTXKSkPqjjqqMKfP3XNp7fghQWRPK8eI0s2Pr5latKLRESuvPOPhBiVlZbs=
X-Received: by 2002:a67:fa03:: with SMTP id i3mr2881773vsq.24.1601499004153;
 Wed, 30 Sep 2020 13:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200925210740.1939450-1-jacob.e.keller@intel.com>
 <20200925210740.1939450-2-jacob.e.keller@intel.com> <nycvar.QRO.7.76.6.2009301428580.50@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009301428580.50@tvgsbejvaqbjf.bet>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 30 Sep 2020 13:49:53 -0700
Message-ID: <CA+P7+xpDoqspwEG_PABvP33FL-+mo6zXvWxf5FKOiSrydXjBKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] refspec: add support for negative refspecs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 5:36 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Jake,
>
> On Fri, 25 Sep 2020, Jacob Keller wrote:
>
> > diff --git a/remote.c b/remote.c
> > index eafc14cbe759..26a127142344 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -682,6 +682,91 @@ static int match_name_with_pattern(const char *key, const char *name,
> >       return ret;
> >  }
> >
> > +static int refspec_match(const struct refspec_item *refspec,
> > +                      const char *name)
> > +{
> > +     if (refspec->pattern)
> > +             return match_name_with_pattern(refspec->src, name, NULL, NULL);
> > +
> > +     return !strcmp(refspec->src, name);
> > +}
> > +
> > +static int omit_name_by_refspec(const char *name, struct refspec *rs)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < rs->nr; i++) {
> > +             if (rs->items[i].negative && refspec_match(&rs->items[i], name))
> > +                     return 1;
> > +     }
> > +     return 0;
> > +}
> > +
> > +struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
> > +{
> > +     struct ref **tail;
> > +
> > +     for (tail = &ref_map; *tail; ) {
> > +             struct ref *ref = *tail;
> > +
> > +             if (omit_name_by_refspec(ref->name, rs)) {
> > +                     *tail = ref->next;
> > +                     free(ref->peer_ref);
> > +                     free(ref);
> > +             } else
> > +                     tail = &ref->next;
> > +     }
> > +
> > +     return ref_map;
> > +}
> > +
> > +static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
> > +{
> > +     int i, matched_negative = 0;
> > +     int find_src = !query->src;
> > +     struct string_list reversed = STRING_LIST_INIT_NODUP;
> > +     const char *needle = find_src ? query->dst : query->src;
> > +
> > +     /*
> > +      * Check whether the queried ref matches any negative refpsec. If so,
> > +      * then we should ultimately treat this as not matching the query at
> > +      * all.
> > +      *
> > +      * Note that negative refspecs always match the source, but the query
> > +      * item uses the destination. To handle this, we apply pattern
> > +      * refspecs in reverse to figure out if the query source matches any
> > +      * of the negative refspecs.
> > +      */
> > +     for (i = 0; i < rs->nr; i++) {
> > +             struct refspec_item *refspec = &rs->items[i];
> > +             char *expn_name;
> > +
> > +             if (refspec->negative)
> > +                     continue;
> > +
> > +             /* Note the reversal of src and dst */
> > +             if (refspec->pattern) {
> > +                     const char *key = refspec->dst ?: refspec->src;
>
> Would you mind fixing this? This keeps getting reverted...
>

Ack.... I swore I fixed this... I'm not sure what happened on my end here.
