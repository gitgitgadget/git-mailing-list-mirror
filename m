Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849EBC433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiAGTKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAGTKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:10:09 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C903EC061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 11:10:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q25so17115522edb.2
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stLZxm1zayyQosUZ88hfTnoM8lsHzOb2z+DVnzcA5v8=;
        b=j8ZBn8lCGR419jNxDY6i0qrwpWWnORAUlvpu0S0mIHVABXZotZvLQD/59h7hZhkVor
         tcRqGv06kRshJxZRh/hz6Rl4mc407np5aeV/tafY31ODD3fY0IiURBmcFSsF+7vNXyvp
         3HAN5LKsuDD0+CustRgWHuYFcMtdD7rmatcpxKSS/8U4HzWWjhuekQT/4bPq2DIIw2NQ
         6CJd5i17N1p2xb9B6oWaTfXVS+ylzZsFXVclr9CYUMftAWXmfIdYRd8hXOjv/jDIxRRs
         huJpG/C3qLiBBBBIVuAre6QRP+XeZ55tuLzHveEz4G9W74BNx/x5nrM3W3eWFhhG09OH
         vPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stLZxm1zayyQosUZ88hfTnoM8lsHzOb2z+DVnzcA5v8=;
        b=gJPgOD3WrpJMJlLBymxlJsaS0VqydRRrNra8JM5za6hhrQI6M6yU6g+svxgpC9x/cq
         FUkrk1LQMTA9LLAIfBvBGu5X9ar2DHPp2eSyPEQSvUY07N89p98dh/cGxD6+HrlE8tBC
         JpybRwVNtbhkov5RvAuA4cCp8MgB02MukiaCFaWp00Kct0veJnRfQp3iX6Fbkm5D/aYn
         h01w8farGquhAESzjyV5lmfbi/2A4oDyU3yJ3dPMKj0NpRd2VuDgB22k1rar5DEsYuS6
         7EU2z7AVwTm+wRfoJM1bCXZOmr4jUawbPieszcvGaP20nU4w4ASj6po3Tr3zxYl1NRd3
         mFkQ==
X-Gm-Message-State: AOAM5316dbWbA1rUO6cPqOTAuAX6BWMzzNeN6mJDEMsG+kWshwUa05Js
        08I1Pkl3lea6vPNtnBCPGGBWzKjX6rRPl4BX5CQ=
X-Google-Smtp-Source: ABdhPJwx9ItkAnYU/seeZRWRNVL/rvYwG4pJ1KSNHvCVuf0d7lJWoqi+Y94b11EK/MrNlTmX6d3k9lfYu1Pf+sbhdPg=
X-Received: by 2002:a17:907:60c8:: with SMTP id hv8mr50335000ejc.192.1641582607315;
 Fri, 07 Jan 2022 11:10:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com>
 <CAP8UFD1jTgxCc-r8vzBGUt8SRS=h5jA1KSz6Fw1XpKXB5-XtoQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1jTgxCc-r8vzBGUt8SRS=h5jA1KSz6Fw1XpKXB5-XtoQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 11:09:56 -0800
Message-ID: <CABPp-BFph66FFH26gHTHnMW1OQpZQ7nUJBfr7vWJ_ZmXRG+DcA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] merge-tree: implement real merges
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 7, 2022 at 10:12 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jan 5, 2022 at 6:27 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > The only output is:
> >   - the toplevel resulting tree printed on stdout
> >   - exit status of 0 (clean) or 1 (conflicts present)
>
> I thought that the merge-ort API could (at least theoretically
> according to merge-ort.h) return something < 0 in case of internal
> error. In this case I would be interested in knowing what's the output
> of the command.
>
> > +The first form will merge the two branches, doing a full recursive
> > +merge with rename detection.  If the merge is clean, the exit status
> > +will be `0`, and if the merge has conflicts, the exit status will be
> > +`1`.
>
> No mention of what happens in case of an internal error in the merge-ort API.
>
> > +       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> > +       printf("%s\n", oid_to_hex(&result.tree->object.oid));
> > +       merge_switch_to_result(&opt, NULL, &result, 0, 0);
> > +       return result.clean ? 0 : 1;
>
> If result.clean can be < 0, this might pretend that the merge was clean.

Ooh, these are very good points.  Thanks for bringing them up; I'll
try to address them in a re-roll.
