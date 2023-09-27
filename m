Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01381E82CAF
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 16:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjI0Q1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjI0Q1U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 12:27:20 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E08DD
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 09:27:18 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1dcead29b3eso4219530fac.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695832038; x=1696436838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jjHTXfFJ1ky9uCjQj7H5Q544PHKYl58gOvaYgLbWlI=;
        b=KB81YXapRBQ4Bd99VVW6kReqoMneqG8Q8cBiIHHfExGsBl+ULO48MS2sruLP5dNpVY
         TPGJZyf7UUO9nw9CGQznbCEzbl1IGzqMCGOTz04FwKhGzn1jNsUvQOV6l5SMQy5HNPSv
         /Zt1GmijijJyWf9A5sbpElIPJD3dBTUT3I2k/7qNHKxFkLEQl53O7fLk7XBpa2hG3KUO
         QZV/ejernb7ZlYE3lVizWhyE9gBmF5sjKr7aknb7ZawFR9/kX1R0K9Sz0gd8Wf8vPDyA
         UWI7xBxdaQ8LcKqKgsNa35LQprR3kGDdFk9E0rsoLcJcSUyeeQsOWl72VecR44tz27dq
         MMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695832038; x=1696436838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jjHTXfFJ1ky9uCjQj7H5Q544PHKYl58gOvaYgLbWlI=;
        b=OkzL2acaXhzqT7ai5MvY0QYucsq1LpebgIG3HXg1/2e/ZcsxNHtPX0DWzyh7VWS/oK
         C/YNH7EbxvjevKNOkRxZ2rcFhxUBpirPfpPEJ0njIFvG2TkE/6IEcrcFXAVDgQjClQW1
         RvtDtaG82nAt6ltUCwBK34Qqy2ZubLRZnoZdXu97oPLFvez0iSrlgPpT96QLTt1VZVhH
         doUyDOngO9cYAkcU7dZyAilcdyQuttWPZyrP62Kea8P+5QqlipIjkSzA5Y1d/LXQho8k
         yZdNTEez5Fugj7EppXAZa4pCe698AuDDMij4mg4vim7rg4Uvw/pGLsgoyqfIw8kU+l2g
         Tsmw==
X-Gm-Message-State: AOJu0Yz4ysS53YE7QQdIr2OuajD6o/3nYH0pD1Fh5HGsOOVUWRiR+mwx
        f2uJhRx56gL3SOgb2mnBY2Scu9NeGvw/5pogMjQ=
X-Google-Smtp-Source: AGHT+IEesAzHAi62ywqwRPoOzTfn1pnvhnGWYj9z45ACGVmmO7/LYwJc5IbxYnBD5oCeBnMW0e4MePrrKMepXXe6aY4=
X-Received: by 2002:a05:6870:1584:b0:1bb:cb02:7b97 with SMTP id
 j4-20020a056870158400b001bbcb027b97mr3248673oab.37.1695832037862; Wed, 27 Sep
 2023 09:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230915083415.263187-1-knayak@gitlab.com> <20230920104507.21664-1-karthik.188@gmail.com>
 <xmqqh6noc13c.fsf@gitster.g> <CAOLa=ZT_DVw4Na-rj4mk2ULkrqDyVP2_cOpgdLozFjn3RJbTvg@mail.gmail.com>
 <xmqq5y435obx.fsf@gitster.g> <CAOLa=ZThB0DrRKg98tr7JLu8yPRyDXe_ngkpS3ZfesHQ-f1DLg@mail.gmail.com>
 <xmqq5y3yw5qz.fsf@gitster.g>
In-Reply-To: <xmqq5y3yw5qz.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 27 Sep 2023 18:26:51 +0200
Message-ID: <CAOLa=ZT0OhGo-9zhHq4NFQ7mBiMpwnUPPf3ou5nYMSTQP-VV4A@mail.gmail.com>
Subject: Re: [PATCH v4] revision: add `--ignore-missing-links` user option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 6:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > Let me prefix with saying that I was partly wrong. `--missing` does wor=
k for
> > trees, only that it's ineffective when used along with the
> > `ignore_missing_links` bit.
> >
> > But for commits, `--missing` was never configured to work with. I
> > did a quick look at the code, we can do something like this for
> > commits too, i.e.  add support for the `--missing` option. We'll
> > have to add a new flag (maybe MISSING) so it can be set during
> > within `repo_parse_commit_gently` so we can parse this as a
> > missing object in rev-list.c and act accordingly.
>
> Do you mean that process_parents() would now throw such a commit to
> the resulting list successfully instead of omitting when "--missing"
> is requested?  That sounds like a right thing to do but at the same
> time is a fix with major impact.

Yes, but with appropriate flag added. Which will be a new flag.

>  I do not offhand know what the
> ramifications are, for example, when bitmap traversal is in use (I
> assume such a missing commit would not be catalogued in the bitmap?).
>

If there is a missing commit or object, will there even be a bitmap?
I can think of the two scenarios:
1. Object is missing before bitmap creation: In such a scenario, the bitmap
doesn't get created, since an object is missing. Could be any type of objec=
t.
2. Object is missing after bitmap creation: In this case, the bitmap
already exists
and rev-list won't even know that the commit is missing and simply output t=
he
objects as if the objects exist.

Overall, this makes sense, but curious to hear what Taylor has to say.
I also might
post a patch series in this direction to consolidate our thoughts and
get a feedback
from the list.
