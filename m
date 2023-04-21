Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C866EC77B7E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 22:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjDUWFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 18:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjDUWFu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 18:05:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3710F2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 15:05:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1763eea08so23280935e9.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682114747; x=1684706747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw0gKPv0ICFTsC6v2oN1yI6BsvdMAfF34ZENuj/oHyI=;
        b=EhHv1yd2c5hul+Smi9bspiwQMZSaGYfZAKbIHA44zP0y61oC6ZKrb7WQMrkqXMwXTm
         0ds5EiegsCSmAOOrRx9qbzWreRyEslQ9zB15J2KvbqN8aZ5NbB10KqRQmqb6z3U8a1gQ
         Cx25TIFYsgqRgWex+4rMnQUsKh/hEamKfM8nstrnrdpHSqO8lNQEBI7FY+HembbAaX+c
         kTOJ/33FPsgsf0Or9TapUlplXwvySp37D/QNEMG8vmiGpmRG+B+EZbNDoKAqmSPlNYTW
         RTf4KUt9hgBMu998927kkt+OHbrQKUl4FS1ksrpFV+ZzHYzm/qfMyxaGFSzjt/EbFIqp
         vgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682114747; x=1684706747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yw0gKPv0ICFTsC6v2oN1yI6BsvdMAfF34ZENuj/oHyI=;
        b=mD6Fgj8f5ey0MyrCjU5fTRvSmhC5e8dyx5mTwUgd0pf94ZOgNLsurSoF0hL3BlA4Gw
         cU+GMznbSQehS5wwJLXg3+lpN8cO+0/r3yRcRRZ4s25/am+R9m2Vz7blsuF/UZ65TV+Q
         sB0Ag5NMbgvyz2SMhS1jIWTNcf3KIb1db13duY3AYiBjZRLiq20cE4XuVPHgelwLGuJV
         CCreDfPBrWaRUWIa3iaSr0cvDE9SYKSB1FA47s/3kNR9Bk/XHcyOoivfaJpbO3L4yLFV
         Q0slsmEtIUsm2o5fpuuGjYzE045yKqwqWwq3YJOwRQn6FIjp833dbHBatmY3bYRNxOTa
         N11g==
X-Gm-Message-State: AAQBX9emTx2SGjxsmqNLdPcCrCoae5SIUMjcoFP9/PL/wUdUeVMoFO5s
        5P+InwKUybbfIDI5gnIUQb2wgXFZvqUmqJZ2QTA=
X-Google-Smtp-Source: AKy350bdxTozaXh9lxM9knwsjYxQe5U9JmqhRejsaQ+VJVA+PJCH8H+1G2omTxjFSyeeXtvaLgtXMOMam0MfM77J3yg=
X-Received: by 2002:a05:600c:21ce:b0:3f1:8aaa:c212 with SMTP id
 x14-20020a05600c21ce00b003f18aaac212mr2854025wmj.33.1682114746810; Fri, 21
 Apr 2023 15:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <m28rf0pa2m.fsf@meyering.net> <4322c414-2bb7-924f-0f6d-dbf517599c3f@cs.ucla.edu>
 <CA+8g5KFqgtKadru7g0LMPpoNDO0vxGGsva_+hQAUcOOfMTd22w@mail.gmail.com>
 <c5j7tduynkzhqpcgqc7iei4mmlnlwvfohmj7ryfhifpay6hhtn@ha3apuuzhxzz> <508ca102-63a9-6334-fee8-7a1ae84c7a23@cs.ucla.edu>
In-Reply-To: <508ca102-63a9-6334-fee8-7a1ae84c7a23@cs.ucla.edu>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 21 Apr 2023 15:05:35 -0700
Message-ID: <CAPUEsph9MvGhyh0zTz3o5ELj0XKMdPNvghrg6VDRh25UipgXwQ@mail.gmail.com>
Subject: Re: Compatibility between GNU and Git grep -P
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Jim Meyering <jim@meyering.net>, grep-devel@gnu.org,
        demerphq <demerphq@gmail.com>, pcre2-dev@googlegroups.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2023 at 2:11=E2=80=AFPM Paul Eggert <eggert@cs.ucla.edu> wr=
ote:
>
> In <https://lists.gnu.org/r/grep-devel/2023-04/msg00017.html> Carlo
> Marcelo Arenas Bel=C3=B3n wrote:
>
> > After using this for a while think the following will be better suited
> > for a release because:
> >
> > * the unreleased PCRE2 code is still changing and is unlikely to be rel=
eased
> >    for a couple of months.
> > * the current way to configure PCRE2 make it difficult to link with the
> >    unreleased code (this might be an independent bug), but it is likely=
 that
> >    the wrong headers might be used by mistake.
> > * the tests and documentation were not completely accurate.

Just to clarify; those points were made about the GNU grep codebase, hence =
are
not really relevant about git's which had an independent thread[1] and
that will be better to use instead to avoid more confusion.

> Thanks for looking into this. I'm concerned about the resulting patches,
> though, because I see recent activity in on the Git grep -P side here:
>
> https://lore.kernel.org/git/xmqqzgaf2zpt.fsf@gitster.g/

This is really not that recent, and has been released already with git
2.40, so at least at that point in time git and grep 3.9 were
consistent.  That was changed with grep 3.10 though.

FWIW, it doesn't seem git had any issues (other than the crasher with
PCRE2 10.34) with the transition to matching multibyte digits with
'\d' and which is what perl (and therefore PCRE2) does, but as I
explained in the other thread I think it might be wise (on the context
of what is usually matched against with git) to not do that in the
long term, and was therefore working on adding the necessary features
to PCRE2 to be able to do so.  Note that no decision has been made
though, which is why I didn't even bother sending an RFC patch.

> Given Jim's strong desire that \d should match only ASCII digits, I
> doubt whether GNU grep will simply use PCRE2_UCP without
> PCRE2_EXTRA_ASCII_BSD.

My assumption is that you would also need PCRE2_EXTRA_ASCII_DIGIT, and
indeed bleeding edge pcre2grep[2] had a compatibility option added
assuming as much.

> Either way, we should see what the Git folks say about this.

The proposed patch for git would IMHO just cause the same risk I was
trying to prevent with my proposed change to GNU grep.

There are no plans to release PCRE2 10.43 and based on its regular
cadence wouldn't be for another couple of months, so this code is a
little premature and will need updating eitherway.

Carlo

[1] https://lore.kernel.org/git/2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucl=
a.edu/
[2] https://github.com/PCRE2Project/pcre2/commit/3bbdb6dd713b39868934fdc978=
ba61b81da6d1c5
