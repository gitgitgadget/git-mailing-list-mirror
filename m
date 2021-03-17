Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41356C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 02:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154D164F8B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 02:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhCQCGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 22:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCQCFy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 22:05:54 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51AC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 19:05:53 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w65so40247346oie.7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 19:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GSN2zkpIfUoYWU5+l0BoPqmBdBEZN1gwqgM8ZT9j2N0=;
        b=vMX46qiFf8Bpy88A1rBmDskKBqb5eshqQtXZd+YOJWuUmUkaV9+4pvw0mmWyMJBR1O
         zfKCTJDZS3N3Y9BVuxNtPQZWcKWwC9WhLon3KGn+URlEWdpJhXF3JmjH85bXCaO11v7h
         EOKq/fzHGLLzIaD4EYXKdHk/pD0lJiFwYUCpK/CFfmEAC8ZVs9PUXR5NNiie4F7hho5E
         AMxMuLJ/OFQl73VxyR95a7ApROQugwr1pE1+0kvg/eY13U+XRtjupXZf1aoRn9tPo8D8
         AL9cvLKE3SOC5mxQNuqOsMKT8NNy72R0WXXTSJddpWVFiZnWVw0mpQZApMtBeYxTbPKN
         RlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GSN2zkpIfUoYWU5+l0BoPqmBdBEZN1gwqgM8ZT9j2N0=;
        b=P0agiobSYplIv63BwKRyIR8HItLC35S9/1isrp6n0B+mlFB/jKx01qOTQOTP+7Y4of
         Kgoz3TVVEv/RNf8hvDDM/+dRuqfObGsCIVRewJTz296IrO/V/EkHqfFpxDnZewEgBXED
         V2W4EO/V0n48PvIY880uBYofXGUTDlkUcZb69itszbDXN7nX5SBKavZ3HgmJddBoDPWp
         vGR7MlhJj831KTbqtpy73vtCCBjiScMC0xo+BPgHXCuKsFhul7OYvGnhTLEttI/UL5hm
         txUX8gryzwn2eeGU3qoHnsYZgy66oIW/ujdOD9EgoMMtHhbYLkGYcUNbw3wHN80mjg0T
         mf+Q==
X-Gm-Message-State: AOAM530F4zIt41p40Yrs9zpIEc2KtKcsKqOeDwGoNXClCe9GV8dJnSCY
        Q+QTWjcOe4t7k7AwlEYX1Bxk1LBlAuQloJLeaDI=
X-Google-Smtp-Source: ABdhPJy0m7pzIXxDzOrQzqjY9/YRetw/httWA8tR8RAu01Flh2reHFLaGtPcsnK1GE5dF8b1ecbo0j7ZpO7kKUDkp+c=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr1216020oia.44.1615946752837;
 Tue, 16 Mar 2021 19:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com>
 <pull.885.v5.git.1615883137212.gitgitgadget@gmail.com> <CAPig+cQSUewNPNRP95HORKLUDCrRsmX==r_bEHacNEuTUMwFQA@mail.gmail.com>
In-Reply-To: <CAPig+cQSUewNPNRP95HORKLUDCrRsmX==r_bEHacNEuTUMwFQA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 17 Mar 2021 10:05:41 +0800
Message-ID: <CAOLTT8TMRBVkOfq3SjaNNX_Pc7E_Gd=iT08AaQWDe8MPM0VZ1w@mail.gmail.com>
Subject: Re: [PATCH v5] format-patch: allow a non-integral version numbers
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=887:36=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Tue, Mar 16, 2021 at 4:25 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Usually we can only use `format-patch -v<n>` to generate integral
> > version numbers patches, but sometimes a same fixup should be
> > labeled as a non-integral version like `v1.1`, so teach `format-patch`
> > to allow a non-integral version which may be helpful to send those
> > patches.
> >
> > `<n>` can be any string, such as `-v1.1`.  In the case where it
> > is a non-integral value, the "Range-diff" and "Interdiff"
> > headers will not include the previous version.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> > diff --git a/builtin/log.c b/builtin/log.c
> > @@ -1662,13 +1662,19 @@ static void print_bases(struct base_tree_info *=
bases, FILE *file)
> > +static const char *diff_title(struct strbuf *sb,
> > +                             const char *reroll_count,
> > +                             const char *generic,
> > +                             const char *rerolled)
> >  {
> > +       int reroll_count_int =3D -1;
> > +
> > +       if (reroll_count)
> > +               strtol_i(reroll_count, 10, &reroll_count_int);
> > +       if (reroll_count_int <=3D 0)
> >                 strbuf_addstr(sb, generic);
> >         else /* RFC may be v0, so allow -v1 to diff against v0 */
> > +               strbuf_addf(sb, rerolled, reroll_count_int - 1);
> >         return sb->buf;
> >  }
>
> Thanks. The logic of this version is much easier to understand now
> that the number parsing has been moved into diff_title().
>
> It may still be a bit confusing for someone reading this code to
> understand why you don't check the return value of strtol_i().
> Therefore, it might be a good idea to add an /* in-code comment */
> explaining why you don't check whether the parse succeeded or failed.
> However, if we rewrite the code like this:
>
>     int v;
>     if (reroll_count && !strtol_i(reroll_count, 10, &v))
>         strbuf_addf(sb, rerolled, v - 1);
>     else
>         strbuf_addstr(sb, generic);
>     return sb->buf;
>
> then the logic becomes obvious, and we don't even need a comment.
> (Notice that I also shortened the variable name since the code is just
> as clear with a short name as with a long spelled out name such as
> "reroll_count_int".)

Yes, It is better to handle the return value of `strtol_i` in an if judgmen=
t and
use `v` instead of `reroll_count_int`.

Thanks.
