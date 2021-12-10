Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7146C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 22:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbhLJW4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 17:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhLJW4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 17:56:32 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2EEC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 14:52:57 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w6-20020aa79a06000000b004b0b8817661so3304821pfj.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 14:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=66q1XNkUFL65MOBXZc7LH7H0y4R8V2HArw8k+W9NIdw=;
        b=ntyMvPm2BGv+TdRCrOqmHXxpdFYNMfii4LLTGRHyFmKBZkMKgk2EFGtk4Kj4DjgjPd
         Mx/EjjOFJTmixd1DKwaCYjISMy9+ndT1O/bF4DhBTaTU8ked97GG5X7ikC745GYTA1YX
         iBb4+s33zlcTFMmoGzewG3Bgp9k5iQTAE4ZTkuQ+bcQyBi7WJvcwHqTrfReXLOAoZtXK
         UAeX7WwOI0WQRLc2tIoYRk5fnFGms2/V0Q5uNSHrakvh2B/kZHqxoDM2Cxm4CAfNLZ+z
         jgITI1btJ/AiazVH+IVr41mL2e0EoQKTpRVmsEBu4nykhRYcj7QQPR5UjtU7Xwv0qfpV
         tznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=66q1XNkUFL65MOBXZc7LH7H0y4R8V2HArw8k+W9NIdw=;
        b=WQk6wKeeBarOz6L0FLieYdd/rplwCvI5jn6oivO/Bzi0mPHtYQ3KXAO8H2diWHj+Z1
         rvBm9e5i9AYy7djzvN3J+GZ5AcqBX3U+Dw7xZcARuCiU9bFHOlX5+MlmqtKZv/eUKIpL
         pD3ji4HvH9+agrb5RQLt1LpGTxn0e6Oxd51y8Ogxzb50FKMhCnfBtFhvguYI+fb0Ko1B
         aQG8z5rcM4bvholCrp7cMhgudZP6lebVIlflKJhLmes7joQ0xUtjuiBIj5uGDZP5aUjR
         YNFvSLViLDROxPbblUHEi8cx/dRT2waO94GrFIp+uSB40z8+MpCDvx+yfqG8yv0cfFxH
         67tA==
X-Gm-Message-State: AOAM533QZmMC8CsFmCGpEJgPP0Qzuav+ibeXgpmWJEL096OM/a0WViXu
        rDckf0nZtDsoUou1zv168cDyAslE8hu0HQ==
X-Google-Smtp-Source: ABdhPJxnUkoYrCE68fQE9FmpQ+C+buvl2PIwBaAzyVx9/jnnZwTJlimqRchFcQEvf/Yt8sQ6MM1d9XxO2bL5YA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:8d6:: with SMTP id
 ds22mr27694372pjb.194.1639176776865; Fri, 10 Dec 2021 14:52:56 -0800 (PST)
Date:   Fri, 10 Dec 2021 14:52:54 -0800
In-Reply-To: <e30ae0dd-739b-7ecd-735e-992395b31ccc@iee.email>
Message-Id: <kl6ltufg843d.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <e30ae0dd-739b-7ecd-735e-992395b31ccc@iee.email>
Subject: Re: New (better?) hash map technique in limit case.
From:   Glen Choo <chooglen@google.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>
Cc:     Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Recently I saw a report [1] on a new theoretical result about how to
> manage hash maps which get nearly 'full', which beats Knuth's limit
> formula. The full paper is at [2]
>
> As I understand it, the method adds the gravestone entries early during
> has collisions to avoid clumping of such collision insertions, rather
> than always having to enter the collision list at the end. This keeps
> the available slots relatively randomly spaced.
>
> It feels like the old random bus arrival problem where the average wait
> for next bus is identical to the average time since the last bust, which
> is the same as the average bus interval (thus 1 + 1 =3D 1), and the
> technique maintains that advantageous perception.
>
> Given Git's use of hashes, it sounds like it could have uses, assuming
> the theory pans out. I've not yet gone through the paper itself [2] but
> hope springs eternal.
>
> Philip
>
> [1]
> S. Nadis and M. I. of Technology, =E2=80=9CTheoretical breakthrough could=
 boost
> data storage.=E2=80=9D
> https://techxplore.com/news/2021-11-theoretical-breakthrough-boost-storag=
e.html
> (accessed Nov. 18, 2021).
>
> [2]
> M. A. Bender, B. C. Kuszmaul, and W. Kuszmaul, =E2=80=9CLinear Probing
> Revisited: Tombstones Mark the Death of Primary Clustering,=E2=80=9D
> arXiv:2107.01250 [cs, math], Jul. 2021, Accessed: Nov. 18, 2021.
> [Online]. Available: http://arxiv.org/abs/2107.01250

Very interesting, thanks for sharing. I haven't read the full paper
either, but this is an interesting result.

It seems that this result is limited to hashmaps with a approximately
equal number of insertions and deletions..

From [1]

  They found that for applications where the number of insertions and
  deletions stays about the same=E2=80=94and the amount of data added is ro=
ughly
  equal to that removed=E2=80=94linear-probing hash tables can operate at h=
igh
  storage capacities without sacrificing speed.apacities without
  sacrificing speed.

and [2]

  ...We then turn our attention to sequences of operations that contain
  deletions, and show that the tombstones left behind by those deletions
  have a primary-anti-clustering effect, that is, they have a tendency
  to speed up future insertions

Do we have any such use cases?
