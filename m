Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E66C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD97206CA
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnRElACP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgKKRNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgKKRNO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:13:14 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24700C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:13:14 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id y22so2801104oti.10
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XMdWjtYWGkwzQGX8+rpnWb+J5jSmY2Mi1p9VmrP1EM=;
        b=rnRElACPyRd5C0fsIO7s1Trvs+W4+A+1dDazmevMUsiJzTIm1THUCpAVokVFnqiiV1
         xxOqk8d0NXXEriehNvfx02ZKWYyCkVt1erAxjZwR/lmNnXS/nacOS1ccWkCJdPrigRG1
         22HKT2JBZ1v+GYFT5qdyQUTexrkMh0Ei+QNOj98q4LbRZlqP6guWvJuANI4mYCU7ZgQi
         Lb5vWHfT/rkKlme/LVKEpTFXfpipXJpP+ocQgWxRdWL5on9MkfBiBCWZ6nKmDkUAmnRe
         po6QHtBiZ3htOUBzFl+18w0yzC7i7/jvSd71Sh9O3fFxzPwrdEIEx2Ji4kslZGH0nmTp
         G7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XMdWjtYWGkwzQGX8+rpnWb+J5jSmY2Mi1p9VmrP1EM=;
        b=Nn1T3UUZZuEyrrDdVgSgZ4ozeH9bsEFonLmChQ8/Az0Ew389mPh/oXzzE5kB75MRBG
         QqFAoB0szEQWppPgRunIAowtGx1L4F8UoR9nVmASx1VGqeZtLzBCG3zp3fMZ09LgGh2v
         NCW9CvcMUBDMrZsjcetOSkC7w/yHlm8m41NinjmySe/dveZW5H/ZXXO7HftFqCNsiLUk
         0ZOosyJZZSdajOgTpEqaE8GKICfOynal0BFul1cAErCTuwWvpw9hAMCciL4/6nkk7SuE
         bukYIMFom+qIljFkMY+rAlaxgmGq5hyjz6iAwf9V2NOl6OpaXQiqnKFnqgC3BBk7x300
         oboQ==
X-Gm-Message-State: AOAM532euX81Qptp1mYW3q01X+8inGTvJ/HLOdonJ294/g6PHaffQxPk
        mOcIeRHZMeqRfMdHDReeJMMF3Zqy/ba195KatdxazSADQOk=
X-Google-Smtp-Source: ABdhPJyQeha1OEMbEDlAM8lYsStVKlWJJjw2mRk0F9Y025gWOqk1AImLUFYSUdDZoL29MbouFPSRVeRVH9cQiBBYFlg=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr19142784otp.316.1605114793525;
 Wed, 11 Nov 2020 09:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <20201102204344.342633-8-newren@gmail.com>
 <c4b9b64c-f0a0-5824-44b9-072370cfc465@gmail.com>
In-Reply-To: <c4b9b64c-f0a0-5824-44b9-072370cfc465@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 09:13:02 -0800
Message-ID: <CABPp-BGk8FBt8WWw_h8t2jiE4quBoMeaco19F-fJ6V_vOnsNww@mail.gmail.com>
Subject: Re: [PATCH v2 07/20] merge-ort: avoid repeating fill_tree_descriptor()
 on the same tree
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 6:51 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/2/2020 3:43 PM, Elijah Newren wrote:
> > @@ -99,6 +99,15 @@ static int collect_merge_info_callback(int n,
> >       unsigned mbase_null = !(mask & 1);
> >       unsigned side1_null = !(mask & 2);
> >       unsigned side2_null = !(mask & 4);
> > +     unsigned side1_matches_mbase = (!side1_null && !mbase_null &&
> > +                                     names[0].mode == names[1].mode &&
> > +                                     oideq(&names[0].oid, &names[1].oid));
> > +     unsigned side2_matches_mbase = (!side2_null && !mbase_null &&
> > +                                     names[0].mode == names[2].mode &&
> > +                                     oideq(&names[0].oid, &names[2].oid));
> > +     unsigned sides_match = (!side1_null && !side2_null &&
> > +                             names[1].mode == names[2].mode &&
> > +                             oideq(&names[1].oid, &names[2].oid));
>
> If the *_null values were in an array, instead, then all of these
> lines could be grouped as a macro:
>
>         unsigned null_oid[3] = {
>                 !(mask & 1),
>                 !(mask & 2),
>                 !(mask & 4)
>         };
>
>         #define trivial_merge(i,j) (!null_oid[i] && !null_oid[j] && \
>                                     names[i].mode == names[j].mode && \
>                                     oideq(&names[i].oid, &names[j].oid))
>
>         unsigned side1_matches_mbase = trivial_merge(0, 1);
>         unsigned side2_matches_mbase = trivial_merge(0, 2);
>         unsigned sides_match = trivial_merge(1, 2);

Hmm, I like it.  I think I'll rename trivial_merge() to
non_null_match() (trivial merge suggests it can immediately be
resolved which is not necessarily true if rename detection is on), but
otherwise I'll use this.

> I briefly considered making these last three an array, as well,
> except the loop below doesn't use 'i' in a symmetrical way:
>
> > +                     if (i == 1 && side1_matches_mbase)
> > +                             t[1] = t[0];
> > +                     else if (i == 2 && side2_matches_mbase)
> > +                             t[2] = t[0];
> > +                     else if (i == 2 && sides_match)
> > +                             t[2] = t[1];
>
> Since the 'i == 2' case has two possible options, it wouldn't be
> possible to just have 'side_matches[i]' here.
>
> > +                     else {
> > +                             const struct object_id *oid = NULL;
> > +                             if (dirmask & 1)
> > +                                     oid = &names[i].oid;
> > +                             buf[i] = fill_tree_descriptor(opt->repo,
> > +                                                           t + i, oid);
> > +                     }
>
> I do appreciate the reduced recursion here!

Technically, not my own optimization; I just copied from
unpack-trees.c:traverse_trees_recursive() -- though the code looks
slightly different because I didn't want to compare oids multiple
times (I use the side match variables earlier in the function as
well).
