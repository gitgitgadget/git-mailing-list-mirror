Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC1C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE02206CA
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qU4ekqxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgKKRHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKKRHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:07:30 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B094C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:07:30 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n15so2789104otl.8
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DWX5S4XJ0WeGx9Jndi/OQVjP03ab8soVPd+StDFfzVE=;
        b=qU4ekqxfyJ6+jG8JZvHv0jjM8oItrvC6mDlBEh9RCNEMjFAj980Idkq1Vb7xuFgVbi
         IqigY4tnluuT+y1B4IZw/cvk5zFW+1yXESHgwqFPL/3fGKAGG67Yf+XQ436/cWMcFR85
         oqrQQEExsygFnJfXebi+eqPzu+p84hD8KE2hvff3Z518E1jXOdhcRJ5IIO7GekOv8Ryv
         fSOG+3KDwlefHVl3nYYp6En/Gfo9DDNX6d7d5ROtvGSy4UhygmQTIoCX3wNxAipvOrYt
         rMGtP8XQi7AGJLElVBATsQm6B8QWhu+lPcvDe40577WBfIxK9/MbztuLRnQnhy9Rqymj
         KO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWX5S4XJ0WeGx9Jndi/OQVjP03ab8soVPd+StDFfzVE=;
        b=cXN+KaWWbVyU9ZSGnOD2X4QVHTBOJ5bqAA8Qgo6mKj53Z7bgflo9b6c+06DyBRBjFD
         ECCDBOCnFvAoJkuSCPe8sYzVl2wTLlQovNnBxL2ciPoi44kdGD6fP/tZUsh3Qdg6iYTP
         dhXDbwVOlragM2PZiJAE/7/PtdaNIz6jMYIN87/X6j/bwzlhLGS1hlrHKpa4ALiuK8O+
         BEQj1xe8Z4h46vdQaR4PgiE8mVpBQU1aifFQ/svqWwAh87IYSxi073ZIK3RV8rrauu2b
         vzU7GoiHSDcnJU8BWbN9L20lrgNvvO4VmJ6ez7Is2Xmk/ekFnWWSvNTVaHc/ycxFdRes
         bABw==
X-Gm-Message-State: AOAM5339toW9RyhyV7NAIxq0TJyNpfFh8oy09cLVNlL0W0sA5U7pjiWe
        2VNeEWewlaNhr/sm7Lbqzb1Fp9FBV3gyIFbWdEI=
X-Google-Smtp-Source: ABdhPJwD7G7KSch5LyOSKdhTvFJ4dgCVHlK+CCactGSpn5pqEVP/xlA/apIusblmOtIXCRxJ/A94HqmbmJ9L+a5tHNY=
X-Received: by 2002:a9d:8d7:: with SMTP id 81mr18827232otf.345.1605114449526;
 Wed, 11 Nov 2020 09:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <20201102204344.342633-6-newren@gmail.com>
 <267dbe58-e319-0904-3552-bf56530181c3@gmail.com>
In-Reply-To: <267dbe58-e319-0904-3552-bf56530181c3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 09:07:18 -0800
Message-ID: <CABPp-BER+nzGb42fB2__tF=a8Y-JQ-Fzi8PZ9T6nWG-5RZfzhA@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] merge-ort: add an err() function similar to one
 from merge-recursive
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 5:58 AM Derrick Stolee <stolee@gmail.com> wrote:

> > +static int err(struct merge_options *opt, const char *err, ...)
> > +{
> > +     va_list params;
> > +     struct strbuf sb = STRBUF_INIT;
> > +
> > +     strbuf_addstr(&sb, "error: ");
> > +     va_start(params, err);
> > +     strbuf_vaddf(&sb, err, params);
> > +     va_end(params);
> > +
> > +     error("%s", sb.buf);
> > +     strbuf_release(&sb);
> > +
> > +     return -1;
> > +}
> > +
>
> This seems simple enough to have a duplicate copy lying
> around. Do you anticipate that all common code will live
> in the same file eventually? Or will these two static err()
> method always be duplicated?

I anticipate that merge-recursive.[ch] will be deleted.

merge-ort was what I wanted to modify merge-recursive.[ch] to be, but
Junio suggested doing it as a different merge backend since it had
invasive changes, so that we could have an easy way to try it out and
fallback to the known good algorithm until we had sufficient comfort
with the new algorithm to switch over to it.

> Aside: I wonder if these errors could be logged using trace2
> primitives, to assist diagnosing problems with merges. CC'ing
> Jeff Hostetler if he has an opinion.
>
> >  static int collect_merge_info(struct merge_options *opt,
> >                             struct tree *merge_base,
> >                             struct tree *side1,
> >                             struct tree *side2)
> >  {
> > +     /* TODO: Implement this using traverse_trees() */
> >       die("Not yet implemented.");
> >  }
>
> This comment looks to be applied to the wrong patch.

Oops!  You are correct; will fix.
