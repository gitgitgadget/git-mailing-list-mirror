Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41733CE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 16:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjIXQPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXQPD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 12:15:03 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11A83
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 09:14:57 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57bb4433cb2so723838eaf.0
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695572096; x=1696176896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX4lrW8XEgzK5uzxWO86VD1c6gHGLSJh6jUU+zDHcRw=;
        b=fUUAN1Iw6mgKg3hC98BNxaxVhjpGs/L7b9zgTJ6WdMaGS6IXY3LhPP45ecO7BZANb7
         fz4IpNRFvWHmDwFSN8dXS6vu5Vvi3wh7HDzygKW0rvn4dkYIC9zu9AN/iRkMsPbsiD1g
         UFe05N+VTKQcBPubTHRHZP9DJahfwBKDtpCUaHcG0zs0XG+7ldRA2jkEEch8AHI5sdEY
         VRKEe5INiKeerpJGS/YKKTpr2DfxhGWAt+Si0iJHQpQOLW1NsVyxkh+FAzqPrJVQKMLq
         SiwqZC4SUk8V5IUlLQnJwTyeTbge8vmzu8k4ZvxE5z3tjBRHnm11p/vdoWgdoUb2mvfY
         bCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695572096; x=1696176896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX4lrW8XEgzK5uzxWO86VD1c6gHGLSJh6jUU+zDHcRw=;
        b=uljKt37tgCfIAcO4yGwqtIlkd9m06fmPcPy3xZ2pFEvI+Z25qJZaAwWUZ3GENkGoq9
         XXvOuZNBRxJk7HNxAYnVs47OUgEWaL6vbuQm9Qpx+wuIiNTo7iLs4tNHDA4ApnnP0lux
         lbsC8wPrvBmQ1Rjy88Ncy7JEL3QmKRwEQINr8d7x+6kROxkRQBVuZRJctlHSzH+p71rP
         BoqTeB+cDPUCL7k2jKwH0C9GwJffoSf3+xDHxADqMzy7Qmjqu1q0HD5o1Mi7bFXXzBYZ
         mo/sgfqqNMt09X2+9xHOsOU8OuIJ2iAyhYNkbIDs6iB8cN1yfD/KCQqcVdCflYZnvrwC
         YCmQ==
X-Gm-Message-State: AOJu0YxoqIhFGp6th/8fmSQ74dGbwu8+6vHgpGvu4nPGIebDVpGrQDnC
        FG8enSliVx72wLxbihnSrlJJJalDC8mjCUJ2OHI8jPCtAJYxgA==
X-Google-Smtp-Source: AGHT+IGhj6zu/dskso4LqbSK8p4n6TBFcM9R3vQdaRvMuE2qdVpPOso5LbkJIL4YzuwSm09wMylkJ3+T1JvS5gYBXRA=
X-Received: by 2002:a05:6870:944f:b0:1c8:bf19:e1df with SMTP id
 e15-20020a056870944f00b001c8bf19e1dfmr5047650oal.13.1695572096265; Sun, 24
 Sep 2023 09:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230915083415.263187-1-knayak@gitlab.com> <20230920104507.21664-1-karthik.188@gmail.com>
 <xmqqh6noc13c.fsf@gitster.g> <CAOLa=ZT_DVw4Na-rj4mk2ULkrqDyVP2_cOpgdLozFjn3RJbTvg@mail.gmail.com>
 <xmqq5y435obx.fsf@gitster.g>
In-Reply-To: <xmqq5y435obx.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 24 Sep 2023 18:14:30 +0200
Message-ID: <CAOLa=ZThB0DrRKg98tr7JLu8yPRyDXe_ngkpS3ZfesHQ-f1DLg@mail.gmail.com>
Subject: Re: [PATCH v4] revision: add `--ignore-missing-links` user option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2023 at 9:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > I was thinking about this, but mostly didn't do this, because the
> > interaction with `--missing` is only for non-commit
> > objects. Because for missing commits, `--ignore-missing-links`
> > skips the commit and the value of `--missing` doesn't make any
> > difference.
>
> Hmph, somehow that smells like an existing bug.  So does the "trees
> are not shown by --missing=3Dprint, and show_object() is never called
> for missing objects unless they are blobs" you mention.  When the
> user asks "instead of dying, list them so that I can ask around and
> fetch them to repair this repository", shouldn't we do just that?
>
> I wonder if these bugs are something people may be taking advatage
> of and cannot be fixed retroactively?  If we can fix these and nobody
> complains, that would give us the ideal outcome, I would think.
>

Let me prefix with saying that I was partly wrong. `--missing` does work fo=
r
trees, only that it's ineffective when used along with the
`ignore_missing_links` bit.

But for commits, `--missing` was never configured to work with. I did a qui=
ck
look at the code, we can do something like this for commits too, i.e.
add support
for the `--missing` option. We'll have to add a new flag (maybe
MISSING) so it can
be set during within `repo_parse_commit_gently` so we can parse this
as a missing
object in rev-list.c and act accordingly.

It would invalidate this patch series in some sense. But I'm okay with
that. Does that
sound good to you?
