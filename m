Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AB6C4321E
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 14:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiCJOcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343972AbiCJObe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:31:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631BECA31A
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:29:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4so5405855pjh.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2iM/In/GcepHWMmmxrvoH09cWD3Q2y2flO1kFb31CVE=;
        b=QSIgXED/sFG9lY7p/0I9TiTawgKdPb6wqtANqoAhj/3VMDJpxBSYNv5Feajr5wLSVf
         2YfFCf03EoMWo9O/O+LRYff4acZ4WUf4LqFLD7HLUjt0Ix1HAe+V7tGf01yHmoJRwsFq
         iaq4LRuYgqAA9I1lO5DhNgkSSYEXNka/9v90g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2iM/In/GcepHWMmmxrvoH09cWD3Q2y2flO1kFb31CVE=;
        b=1UUVt4LYGq0iEFYT52K4WqbO1JVdu4d1nWfGCrLGRNc75Z+xp1fC7+En5i1YOEfqEx
         bZG4ieQUWnRg1vb5q1dIlAJaBslu8LiDFQPyjzFqu/4AIeb6wG2UHPoJ++Ao008uT9mj
         jKDS9oZOVqR4ipTh3MHyL5cQ4yaWL7EUTmhpZdNCNtUUVbIWRNd6HUv9F/Ow/lirLXY9
         URfdLnvUh2cv0J24ZS6GwtHCdWMgaOJhTVs7bWiqxpckdnKrsu9TqNqID83fbu8nOF1e
         hwAktxL1BSzPRjIIAjp70Tfm8QEGtI83Fq6TW23X34yBbpywYzcDZtYETpFtIzzeWz6S
         9aSQ==
X-Gm-Message-State: AOAM532lsdcYTrAbn/pziQFOj00Y1cBICIpjpUNGvWFr1uUXz3TduQfW
        Y3OdCENmB8Lkb5cOay4tQq2M1s7bCwYJst8M1hnhrg==
X-Google-Smtp-Source: ABdhPJw1BL72gQ0H3iZKctnU4EfEsUDxrNrlpJSKPjAjc5JryMN53csvT57U0AXDwAFVb3Buzj4k/E/V6T9Q6BM20sU=
X-Received: by 2002:a17:90b:4f8d:b0:1bf:7f90:35c with SMTP id
 qe13-20020a17090b4f8d00b001bf7f90035cmr16095366pjb.166.1646922553643; Thu, 10
 Mar 2022 06:29:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <20220309002729.3581315-1-calvinwan@google.com> <CACf-nVeEBDQse0coA7QpQmQ92y9kDwXoTmayD8_NY2OHNZ5v+g@mail.gmail.com>
 <xmqqzglylslh.fsf@gitster.g>
In-Reply-To: <xmqqzglylslh.fsf@gitster.g>
From:   Robert Coup <robert@coup.net.nz>
Date:   Thu, 10 Mar 2022 14:29:02 +0000
Message-ID: <CACf-nVf-O5+_nMrdBiRJ5sHg7g+DjTkPy1VuErDnEXJ0-9OJ0A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] fetch: add repair: full refetch without negotiation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Calvin Wan <calvinwan@google.com>,
        Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 9 Mar 2022 at 21:32, Junio C Hamano <gitster@pobox.com> wrote:
>
> The way I read Calvin's suggestion was that you won't allow such a
> random series of "git fetch"es without updating the "this is the
> filter that is consistent with the contents of this repository"
> record, which will lead to inconsistencies.  I.e.
>
>  - we must maintain the "filter that is consistent with the contents
>    of this repository", which this series does not do, but we should.

I don't think we should strive to keep this "consistency" =E2=80=94

>  - the "--refetch" is unnecessary and redundant, as long as such a
>    record is maintained; when a filter settings changes, we should
>    do the equivalent of "--refetch" automatically.

=E2=80=94 we don't know how much data has been pulled in by fetches from
different promisor and non-promisor remotes (past & present); or
dynamically faulted in through branch switching or history
exploration. And I can't see any particular benefit in attempting to
keep track of that?

=C3=86var suggested in future maybe we could figure out which commits a
user definitively has all the blobs & trees for and refetch could
negotiate from that position to improve efficiency: nothing in this
series precludes such an enhancement.

> ... isn't "git fetch --fitler" that does not update the configured
> filter (and does not do a refetch automatically) a bug that made the
> "refetch" necessary in the first place?

I don't believe it's a bug. A fairly obvious partial clone example
I've used before on repos where I want the commit history but not all
the associated data (especially when the history is littered with
giant blobs I don't care about):

  git clone example.com/myrepo --filter=3Dblob:none
  # does a partial clone with no blobs
  # checkout faults in the blobs present at HEAD in bulk to populate
the working tree
  git config --unset remote.origin.partialclonefilter
  # going forward, future fetches include all associated blobs for new comm=
its

Getting all the blobs for all history is something I'm explicitly
trying not to do in this example, but if the next fetch from origin
automatically did a "refetch" after I removed the filter that's
exactly what would happen.

We don't expect users to update `diff.algorithm` in config to run a
minimal diff: using the `--diff-algorithm=3D` option on the command line
overrides the config. And the same philosophy applies with fetch:
`remote.<name>.partialclonefilter` provides the default filter for
fetches, and a user can override it via `git fetch --filter=3D`. To me
this is how Git commands are expected to work.

Partial clones are still relatively new and advanced, and I don't
believe we should try and over-predict too much what the correct
behaviour is for a user.

I'd be happy adding something to the documentation for the
`remote.<name>.partialclonefilter` config setting to explain that
changing or removing the filter won't backfill the local object DB and
the user would need `fetch --refetch` for that.

Thanks,
Rob :)
