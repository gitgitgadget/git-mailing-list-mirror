Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0312DC3F2CE
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 03:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E1720675
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 03:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLiWEXPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgCAD2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 22:28:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38661 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgCAD2J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 22:28:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so7944942ljh.5
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 19:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcyIGOfKpzYo67BiEqadNUaidaPdZQbLQiREPq4kh7M=;
        b=mLiWEXPhYCAY9w1Evgb/TRj2tzjK24SnofozsR8/urmSuorneOAcClPINfLHwabhZI
         Lw+TLXoD3Qea41+lqPF69mdqhAemCjKDJucLF+q562bE5SY9PICcSoLAg/GqYAUE7Zc0
         nAsp9WFcwcydqxUcISwQtfiTidZgcZJqg46f4Y//irB0SidYNFkipFx45sRQEfmqVmHe
         LMhgINjUPLSabg7BZwADbRIfmMf8y9JL+rk7nB6wVikRbg9D/4r9CmvGJt0Ix3lDaXmg
         RRNPE9GTaHJ+RrlO2m5X13EgegscEq2ZIsqAb6TJAuB6TrbLxcvZlcntUmxdoBBileaJ
         XCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcyIGOfKpzYo67BiEqadNUaidaPdZQbLQiREPq4kh7M=;
        b=EtBl+FoNnIihHfvS8GRFlZIxf6O/Bvh970eYMb/oJTiHsD3utAiebMkv4v8bHNi5AS
         HX2xXGjwZxL+LPfxNbr79ri43ZYIo2YbSNsKR1BcpjxCdXER0N/oFhsPF76yEQ2xxOM0
         fnMkIP9+dFEICEo9qaksBwImRv06778Li1miUPwFj9y6VmflvAWyBc+sDzfUk6YTcKbq
         GLDomQn8b3n/1fljElBdrwOHtiJF3xlfi2nyFqwZerBH4bo9iAgudIVSNKBuPhcW2hBD
         zaxbSQnQCgnvXRzvlUhThFVQFX67jTSdh13W10BVxNEEBr4SJoMOcl7Aabn+rcZQqzlV
         XO+Q==
X-Gm-Message-State: ANhLgQ2woKbM6R4CQL1J+NY1/hDfqUIeB+01QRE8QAvWiw/bSeudT2ye
        LdyuizJwgn7+LVGG8qgGnWApUWPApcfTTH5AIYAqKA==
X-Google-Smtp-Source: ADFU+vtxvbC6afPqfBjRwGOCGkYaLcHmPRqDxgsjwI3xasbKlJmXCvF3gtgEiV2JLhws2YME37AqdfvlO0O4RRRg+1g=
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr7566380lji.291.1583033287672;
 Sat, 29 Feb 2020 19:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20200229212258.373891-1-alexhenrie24@gmail.com> <CABPp-BEewypPoDrWesk=6twgj2TMGFYdaYzdrg5p4K+mExHqeg@mail.gmail.com>
In-Reply-To: <CABPp-BEewypPoDrWesk=6twgj2TMGFYdaYzdrg5p4K+mExHqeg@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 29 Feb 2020 20:27:56 -0700
Message-ID: <CAMMLpeS2Fq3Nj2QjvNT6i_+ceDHW-pUqTRUhmARWen-jWQfsJg@mail.gmail.com>
Subject: Re: [PATCH v3] pull: warn if the user didn't say whether to rebase or
 to merge
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 29, 2020 at 4:31 PM Elijah Newren <newren@gmail.com> wrote:
>
> Ick; we don't need the warning to regurgitate large sections of the
> manual, we only need to provide pointers and then they can look up the
> details in their favorite way (google, stackoverflow, looking at the
> actual manpage, etc.)  How about something more like
>
> > +               warning(_("Pulling without specifying how to reconcile divergent branches\n"
> > +                       "is discouraged. You can squelch this message by setting pull.rebase,\n"
> > +                       "or by passing any of --rebase, --no-rebase, or --ff-only\n"));

I intentionally made the message similar to the message you get when
you try to commit without setting user.name or user.email. Providing
the user with clear information on the spot is much more effective at
getting them to do the right thing than expecting them to use Google
or reread the man pages. We also want the user to understand that they
only have to set pull.rebase or pull.ff once, whereas a command-line
flag applies only to the current pull. Nevertheless, any warning
message is better than no warning at all, so I would be happy to
resubmit with your proposed text if there's consensus that a shorter
message is better.

-Alex
