Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D384C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 00:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AEB206FA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 00:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YopT81Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHRAEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgHRAEM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 20:04:12 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3087C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 17:04:12 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id k25so9191847vsm.11
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmfqm/VQuO4+PYDM3lQckifqq2UdHPtLwU4wbJ+jIAs=;
        b=YopT81Ra1Y0++9SZadh1GKF1y+0Zlp6QndLPvF7P4GkmFa9gSp+BkgOclBQPPsdr4U
         uiibdintqLomv+0qmeWeHvL0Tu62P9U7pzDXfSVxVBU2YjIG5PwCj/CSiipBMX109Gvt
         lcDB6BvnQrQvP4Ye7w9rVFURxXErtetk394/2AJ51GKva4MEQAAhCPVCJdCSPivLrJbS
         Aq3ZMGwLOyzA+ml/iRRVArZ5N7g7i1gxBdV8JzLgAh9aVE2UHeLxyaX5wPGmzbWrRo95
         BXyKzBx3s/XjzYDw2c3/RgSL0B1QqZ4+J+YZ7sP08EMnGgzBaEQSysGcw60yVPJezVWn
         mlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmfqm/VQuO4+PYDM3lQckifqq2UdHPtLwU4wbJ+jIAs=;
        b=nZxBC5oWBCl+7sWUDAU2/dej/rhGPa5At3D8dMnpNMgC3qWIJ5iGaeO/oRopaarx9h
         QthbjztmshDza5F07yFZ1HKEU9l6BIZSke/RPEDPyhbZxSe9iKStuPzC758Oy8gJR6dP
         raMmV/EgBmkHf3Ki/TOGE+Z9vZApZHaa/cX/7lvY8Rg+JdJfDhBHYgTHo5eBsM4EyxiI
         h/U8/iUM1/IraQL5Lkh+rF9tOFVbREN9qTYH/xUGZF4DJpX2hFyFJUUjiQl9nKHPPt5S
         ovSABj69sBVmopKI8h3C0pMWM1CcARdTbF2qOFnHinU2s6smIkdCCQo/AB016K55xnu+
         mjvQ==
X-Gm-Message-State: AOAM5320H2x3Rc1RLKAG3k+1tjp2N234xaIt9DnfAbFhojGU8BNj5nL7
        HeSSWGuRLQgKCI6ydLyAk7JZzPieaLWKHxq0MJ4=
X-Google-Smtp-Source: ABdhPJyrQv3JiJG8QMdWW3/5kbi6Z6GfU+G94109FS+KoAwUM2ydqFpdx6gSfBHkVc9Q6N6XhzoK9nSOnEpMLOoR8m8=
X-Received: by 2002:a67:8807:: with SMTP id k7mr4904048vsd.153.1597709051513;
 Mon, 17 Aug 2020 17:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-3-jacob.e.keller@intel.com> <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 17 Aug 2020 17:04:00 -0700
Message-ID: <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 4:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > Refspecs today are commutative, meaning that order doesn't expressly
> > matter. Rather than forcing an implied order, negative refspecs will
> > always be applied last. That is, in order to match, a ref must match at
> > least one positive refspec, and match none of the negative refspecs.
> > This is similar to how negative pathspecs work.
>
> Yes, enumerate what positive ones match and then exclude what
> negative ones match from the result is a time-tested pattern our
> users know how things work.
>
> > @@ -530,6 +530,9 @@ static struct ref *get_ref_map(struct remote *remote,
> >               tail = &rm->next;
> >       }
> >
> > +     /* apply any negative refspecs now to prune the list of refs */
> > +     ref_map = apply_negative_refspecs(ref_map, rs);
> > +
> >       ref_map = ref_remove_duplicates(ref_map);
>
> How was the ordering here decided?  Should it result the same set if
> negative ones are excluded after duplicates are removed?
>

Good question. This was what was done in peff's original patch. I need
to understand a bit more about what ref_remove_duplicates does to
really figure this out.

> > @@ -1441,6 +1445,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
> >               string_list_clear(&src_ref_index, 0);
> >       }
> >
> > +     *dst = apply_negative_refspecs(*dst, rs);
> > +
>
> The block of code whose tail is shown in the pre-context has
> prepared "delete these refs because we no longer have them" to the
> other side under MATCH_REFS_PRUNE but that was done based on the
> *dst list before we applied the negative refspec.  Is the ordering
> of these two correct, or should we filter the dst list with negative
> ones and use the resulting one in pruning operation?
>

I think we need to swap the order here. I'll take a closer look.

> > +     if (item->negative) {
> > +             struct object_id unused;
> > +
> > +             /*
> > +              * Negative refspecs only have a LHS, which indicates a ref
> > +              * (or pattern of refs) to exclude from other matches. This
> > +              * can either be a simple ref, a glob pattern, or even an
> > +              * exact sha1 match.
> > +              */
>
> "a ref (or pattern of refs)" is clarified with the next sentence
> anyway, so let's not say it, e.g.
>
>         ... only have a LHS, which indicates what to exclude from
>         other matches.
>

Sure. There's also a slight bug here because in "fetch" mode,
standalone LHS-only refs cannot be globs, and I need to fix that too.

Thanks,
Jake
