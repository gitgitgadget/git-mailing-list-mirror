Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D160AC001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 06:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjHCGQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 02:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjHCGQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 02:16:44 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C71272C
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 23:16:43 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-583c48a9aa1so5877127b3.1
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691043402; x=1691648202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X1EYXpxIiDxFZMTJT4wOXkiPv07cAMwxxwIRjrrtFU=;
        b=QKIkn+sdVQGxSmFktOLOZc1NSrmG9s6kAXFCM4YRPScznYPfyPjGLaBq1tDPJD8phF
         aBsPMYorol6Z+icZudJC2uM6GDwWxyzgE4iGZrRa2rykjWe4hE5rVAZFp2eluARakY69
         jrah1RMGmhLdnU7bYhVaEBuAAzap1+848VeihWalx0kd0g0GN83kj01WBBBRvTgdWp6O
         ezw+7hRWOYtZ9NEdcneeI4s2zLHE1wOFjje6JQbXHMjrcDRRGDOmtOub26deNRF0jfW7
         4c97N2XOl9oG3PHrdmM1zVz5RN8jTE7sG24v9YMVLFRXH1R77P6jkc+/LTABwmti74YW
         UgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691043402; x=1691648202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X1EYXpxIiDxFZMTJT4wOXkiPv07cAMwxxwIRjrrtFU=;
        b=V9tHxxlg6zsD/OMNOP8Pra7UV6jTXfh4oM41F8sHfDADDy43cRL4WqgJGVRX6z9SX5
         iXNwkf4nfG6vjZTkEGx4GE3j73TwMxdfJChCeB6rsAPcMOGuX3qilJDX9fGZGc/hoVQ8
         khw1MWLRyIKiKOqDDS8i6b+fcr8qcLbeXaakrZ6T9e7BjycAdq2aPsSUUMY0AMgqtDI0
         avohjUxF1lem1oO6N4CxpGLE10J14GL7J9N7g94D7GEFQ+T6t0/2PaP/wR9YkzK245Np
         h2QI/t2ZYJbQhG51B4Ip1xVTUuQAouSOKJKc2QHdNPdoCWBDflzx5Y8R5UoYWH23V649
         4E2g==
X-Gm-Message-State: ABy/qLZgXp6JYC8DSzaVZV8uyiSlkciuuN6FaBGTLMkngaRpMd3qWTQf
        b95KquBDjMm1z0CVYezdI3dYNAorW3Qbmzbo7ZolfeJXgF8y5LlP
X-Google-Smtp-Source: APBJJlFG1+pdhqJAWkIdISv8dNhlIfGewalmMuMymbsNqxW8xhs9eZ89sB1KrHYBJ4npWyqiudfZDyMj7/NTNCMMeis=
X-Received: by 2002:a81:83ce:0:b0:56d:34:893c with SMTP id t197-20020a8183ce000000b0056d0034893cmr17850290ywf.4.1691043402148;
 Wed, 02 Aug 2023 23:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RvAbmS1SwFja8_+NSBBoL0gTH1RgpSN5CYtDWZscMYZA@mail.gmail.com>
 <CAP8UFD02tYrz+bxoR_GQfYuxxrmv5=BXjcZuiqXbX3m7N2dPaQ@mail.gmail.com>
 <CAOLTT8TXYpyadp=Z6K44G59iSar5ieyLwmSph4ypwxGo9doHYA@mail.gmail.com> <xmqq1qgl9zgm.fsf@gitster.g>
In-Reply-To: <xmqq1qgl9zgm.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 3 Aug 2023 14:16:30 +0800
Message-ID: <CAOLTT8Sht6xsVDOmEdGow8wrHvDDdEx7fDyqXC31MOTxVkSifg@mail.gmail.com>
Subject: Re: [Question] git rev-parse verify for non-existent object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=9B=9B 00:32=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >>       --verify
> >>           Verify that exactly one parameter is provided, and that it
> >> can be turned into a raw 20-byte SHA-1 that can be used to access the
> >> object database. If so, emit it to the standard output;
> >>           otherwise, error out.
> >>
> >
> > So why doesn't "git rev-list --verify" check if 20-byte SHA-1 can
> >  "access the object database"?
>
> Hysterical Raisins.
>
> "rev-parse" can do many things, and one of them is about expanding
> strings (like "9e4df4da", "jt/path-filter-fix", "seen~7^2", and
> "9e4df4da0786797b1d51ed8fd3dfc18970772a91") given from the command
> line into hexadecimal strings of the full length (they are often
> called "revision").  "--verify" tells the command that on the
> command line there must be ONE and only one "revision", give the
> full length hexadecimal string for it.  The command fails if the
> command line argument cannot be turned into a hexadecimal string of
> the full length.
>
> Now, among the ones given as examples in the above, "9e4df4da",
> needs to look at the object database to turn it into a hexadecimal
> string of the full length, because it is likely to be an abbrevation
> (although it could be a branch name, too).  "jt/path-filter-fix" and
> "seen~7^2" needs to look at the refs and probably into the object
> database (to see what the 7th generation grandparent is and what the
> second parent of that commit is) before they can be turned into
> hexadecimal strings of the full length.
>
> But "9e4df4da0786797b1d51ed8fd3dfc18970772a91" is already a full
> hexadecimal, so it is given back as a "revision" without checking if
> there is such an object in the object database.
>

Well, so the "git rev-parse --verify" command simply converts the revision
into a 20-byte SHA-1 without actually performing any real "verification", w=
hich
can be quite misleading.

> Checking if it can be turned into the form that can be used to query
> the object database, and checking the object database using it to
> find out if such an object exists, are two distinct steps low-level
> tool authors, who would want to use the plumbing tools, may need.
> The current option set allows the separation (and ^{object} suffix
> lets you do the both at the same time, too).
>

Thanks for the answer.
