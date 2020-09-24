Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B737C4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 23:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBC2221E2
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 23:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTO9HeXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIXXdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 19:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIXXdp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 19:33:45 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256AC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 16:33:45 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id x203so311458vsc.11
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmnFj+P984/sX20OJgkYBPU6fVvgQr+3y6R+54a56tE=;
        b=WTO9HeXm62a1AGfJjxPjLnz/W58aYVfarTJpAgNwReipkwQCZod1O9qtPB6aB9TxbU
         MKv7ykfcjKHqVXyDNEvzFkBZg/3AOBSpfBs1NgAeppX6TZ2QVjCyOJoErdLFlbl8hvM3
         FML6exix7f9tfRscMncos0A5CGLKRyaGOiskwox6KwgbvQZGx0Jz0kom8mnuLBdRM1Fr
         L9JsDNUN9CF92ZxQ0CHTs9XZrPvZOwp0moowHDJPiQi7fdV1MP8cd/rhSPky2C58+zff
         MZYF7g6BOOfiKRoszQEHlqR4Sfbk+VrtYu/THCADZR/OmcaVrdpCMrxFk6S5uslwXRpn
         lRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmnFj+P984/sX20OJgkYBPU6fVvgQr+3y6R+54a56tE=;
        b=VnEJMKEIHUev6MXqWuwvg6CB33npAiFGdo6u5h/CLHkBYrR2RS4gnCEP+B6kL64Qxc
         c3kxRQxCbrcrAFj3LILDEbDAZ6nVEbKzX3In/0dRZJbha2ZzGZxFg2CBQsmIgKC/jtGb
         mEN/EGLpXLLq7f/v+tVXeUML+/qRAIPeC2eriGLmwz8OMhzwwiADywN3znCIgb0rAdTg
         nsVgSAvBGP1i9rEWEN8wNrpdKenJhBufvpMGIVM3aBt5Oaumrza2x5pAp58TQnIWyNzm
         vrE9hEKaxmmMk5yZp/166ltZXOexgPcMmG3HZaZRb2KCZOphvkbMAKYcIS0TfprxnEVH
         UpRA==
X-Gm-Message-State: AOAM532yI4hCMdcj3qMv2a3IHPUrdIgKTrRr2cl7n8UIg72/HwhZDYab
        Sn5pFpGV989Tz2PJNRFFKjtrRDaelj8KcxbrACESbEezkyo=
X-Google-Smtp-Source: ABdhPJzGeO+PIqm7pkVevZk5TBX6a5Akuzt575ab0yZsoCxwwYDS7ofnjrZ2HOjbOT+mUg5bRTESJsyuHfZDU/04/Dw=
X-Received: by 2002:a67:e248:: with SMTP id w8mr1355466vse.33.1600990424207;
 Thu, 24 Sep 2020 16:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200821215247.758978-1-jacob.e.keller@intel.com>
 <20200821215247.758978-2-jacob.e.keller@intel.com> <xmqqzh5onea1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh5onea1.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 24 Sep 2020 16:33:33 -0700
Message-ID: <CA+P7+xr-xhC3Rr3BXT-5LLUAic1Tx27pmhZAu5T0iGwfQ6qAUA@mail.gmail.com>
Subject: Re: [RFC v2 1/1] refspec: add support for negative refspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 5:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > @@ -66,6 +74,28 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
> >       item->src = xstrndup(lhs, llen);
> >       flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
> >
> > +     if (item->negative) {
> > +             struct object_id unused;
> > +
> > +             /*
> > +              * Negative refspecs only have a LHS, which indicates a ref
> > +              * (or pattern of refs) to exclude from other matches. This
> > +              * can either be a simple ref, a glob pattern, or even an
> > +              * exact sha1 match.
> > +              */
> > +             if (!*item->src)
> > +                     return 0; /* negative refspecs must not be empty */
> > +             else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
> > +                     item->exact_sha1 = 1; /* ok */
> > +             else if (!check_refname_format(item->src, flags))
> > +                     ; /* valid looking ref is ok */
> > +             else
> > +                     return 0;
> > +
> > +             /* other rules for negative refspecs don't apply */
>
> This comment confused me a bit; did you mean "other rules don't
> apply to negative refspecs"?
>

Yea, this should be reworded.

> > +             return 1;
> > +     }
> > +
> >       if (fetch) {
> >               struct object_id unused;
>
>
> > diff --git a/remote.c b/remote.c
> > index c5ed74f91c63..2f583d72c3f0 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -1058,7 +1172,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
> >       const char *dst_value = rs->dst;
> >       char *dst_guess;
> >
> > -     if (rs->pattern || rs->matching)
> > +     if (rs->pattern || rs->matching || rs->negative)
> >               return 0;
>
> OK.  These "special" ones do not participate in explicit matching.
>
> > @@ -1134,6 +1248,10 @@ static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
> >       int matching_refs = -1;
> >       for (i = 0; i < rs->nr; i++) {
> >               const struct refspec_item *item = &rs->items[i];
> > +
> > +             if (item->negative)
> > +                     continue;
> > +
>
> And a negative one does not decide if a ref being pushed will be
> pushed out for real at this point.  This helper is only to enumerate
> the candidate refs to be pushed out; the caller makes a separate
> call to apply_negative_refspecs() to cull the candidate list later.
>
> OK.
>
> > @@ -1339,7 +1457,7 @@ int check_push_refs(struct ref *src, struct refspec *rs)
> >       for (i = 0; i < rs->nr; i++) {
> >               struct refspec_item *item = &rs->items[i];
> >
> > -             if (item->pattern || item->matching)
> > +             if (item->pattern || item->matching || item->negative)
> >                       continue;
> >
> >               ret |= match_explicit_lhs(src, item, NULL, NULL);
>
> match_explicit_lhs(), like match_explicit(), are for explicit
> matching and should not be called for the "special" ones.  OK.
>
> > @@ -1441,6 +1559,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
> >               string_list_clear(&src_ref_index, 0);
> >       }
> >
> > +     *dst = apply_negative_refspecs(*dst, rs);
> > +
> >       if (errs)
> >               return -1;
> >       return 0;
>
> And after grabbing all the candidate refs to be updated via this
> push, we filter out the ones that match negative pattern.  Can it
> also produce an error, or it can never fail (to udpate errs)?
>
> > @@ -1810,6 +1930,9 @@ int get_fetch_map(const struct ref *remote_refs,
> >  {
> >       struct ref *ref_map, **rmp;
> >
> > +     if (refspec->negative)
> > +             return 0;
> > +
>
> Again, the idea is to let the existing codepath to only deal with
> the positive refspec elements to keep the same behaviour, and let
> the caller filter the ones that match negative ones out of the
> result.  So we return without anything here for negative one.
>

Yep, that's what I went for. The only real downside here is if we
forget a code path that should honor negative refspecs and doesn't,
because it will "accept" the refspec list with such a negative
refspec, but not do anything with it.

> Nothing jumped out at me as being suspicious so far, other than that
> the GNU "?<empty>:" thing needs to be fixed as pointed out by Dscho.
>
> Thanks.
