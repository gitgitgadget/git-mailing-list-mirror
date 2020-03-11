Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A917C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 17:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88C320737
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 17:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtJLX1/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgCKRBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:01:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41313 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgCKRBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 13:01:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id o10so3146443ljc.8
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=OpjHLnkbfDzpjI/W2FT19AqRrYODRAJriqaJdGq64OM=;
        b=LtJLX1/KDq99xiGshN9JO9GNtZavpyaH2WsiqXCBVA2+EWKC9kD//ta8jmwnR5RUmp
         +VE2mhTq2BTErVwj+nuwkxA+mwkFbk6peGzqwL3rB/2FIU2nyPTogJ0gtmXOvmpy4EmD
         FxaE7lNxnIJKA33JkH3m4bHqw8BcVohxaQ2biYtLZhNwzeAV1O+yGNJRNKYgGgFcN1FG
         JS1AAdbfdSzMqErnJ/9x6ndZeEnTLGsmwoEJE2HC0qvWBAUCk9K/xZ9uijhAyRS50/uk
         cRyOkcHSQTxHt84vyrIpe0vNj6M/LgYRDoWaK7BrPly8uxMxruWbDu8JGFwFM5XtJwLd
         ewYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=OpjHLnkbfDzpjI/W2FT19AqRrYODRAJriqaJdGq64OM=;
        b=HuUeZ038+61jIRM51SH6gsq0VLeo6a382uc9SMRqmRPbxgUrwfiWYxlOZZHQDiFi0H
         +agBsydbfXmbr3JPmVWTRZ++nOjKHH4oJkdr8x65zjgoxWrdhv7lKUCUx1wjifuS7Mna
         y5JnSxnpIhFsuV3dI9obecfZKkz7lfbGuI4Lc5DFz6T0Y3uz2EZwBOPnoKs/+dnLv0qv
         BcgxTZFdImGM7UDxCSLMOAhZNU0QoK3AViStQG+Ev9DPRXmwCpO19UCunRF+lRDEo6m4
         0gc3Z7tfyT3cloD1Qfr3ZlLJ2P2/OslgZ1wF2A3d6fXz2709BIMMcPIOGDh7Jsg/xSzE
         tN2g==
X-Gm-Message-State: ANhLgQ0M7HFAVnghzVtHmg19MyAxCGy3CnDNrJhxwlau4qB/sqHiulyb
        cK3IsPYriHpp3oNfhCybXIpdJUwJ+aXz6h3gNP4=
X-Google-Smtp-Source: ADFU+vsZkFUK2+mJngWIT91uAmPLRlgewsST0Qi7oDVkUckTshD/zQUqOBhzByDY5KbMof24PeX5WFMKHmvNHu1Dv48=
X-Received: by 2002:a2e:854e:: with SMTP id u14mr2658273ljj.27.1583946080180;
 Wed, 11 Mar 2020 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BhLe0xF_k2ASV=ZuM7LVvxui_cxzB9UrJ2MDCyyNUmtw@mail.gmail.com>
 <20200311162517.GA27893@coredump.intra.peff.net> <CAHd499AGQ5k7ON+YY84b6LY1sh9MOw8fsrE2shOibujX1iKeiQ@mail.gmail.com>
In-Reply-To: <CAHd499AGQ5k7ON+YY84b6LY1sh9MOw8fsrE2shOibujX1iKeiQ@mail.gmail.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 11 Mar 2020 12:01:09 -0500
X-Google-Sender-Auth: JXYG2WKbNCNPTOb3_i7-1fv0qy4
Message-ID: <CAHd499Dbqa9jZ0bLTiayy+S6c1si1wOYddA1SDUz22g-Jp-TQg@mail.gmail.com>
Subject: Re: Using push.default with push.remote.push
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 11, 2020 at 11:56 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> On Wed, Mar 11, 2020 at 11:25 AM Jeff King <peff@peff.net> wrote:
> > > The current behavior seems to be working as designed, but not as
> > > desired. The first push command pushes *all* branches under
> > > `refs/heads/*`, instead of just the current branch as it normally
> > > would via `push.default` setting. It sort of feels like if a resolved,
> > > explicitly defined `push.<remote>.push` config is found *and* it
> > > includes wildcards, the `push.default` setting should still be
> > > respected.
> >
> > Then when would remote.*.push with a wildcard ever do anything?
>
> Maybe this is where a potential disconnect is, but I've always viewed
> the wildcard refspec as a mapping, rather than an all-inclusive "Push
> all the things". In other words, I view it as more of a structural
> guide than a behavioral one. I recognize I probably have this wrong,
> but it probably speaks to how some users view it, or at least, some
> valid use cases to have more of a structural mechanism to map branches
> to remote repositories, with `git push --all` being a supplement to
> say "Push all branches using this mapping".

Also, apologies, I forgot to include a response to your first reply to my OP:

I think `branch.*.pushRef` in this case is not enough. It implies that
for every branch I want to be mapped in this way, I'd have to manually
specify this config. Rather, I think a `remote.*.pushRef` would be
more appropriate, so that it would automatically set the
`branch.*.pushRef` version as needed, so I only set up the mapping
once.

It could also be I don't fully understand your recommendation, so
apologies of that's the case.
