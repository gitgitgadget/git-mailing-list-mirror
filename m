Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761D3C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 18:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiLLS54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiLLS5O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 13:57:14 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4318360
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:55:22 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id k79so547005pfd.7
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQbs9SiyqLk2GXAa19bon+IbbIVzIvauw+kDfKZHpqM=;
        b=amcARtd4Jo91GZa7BBVLALjr4PZ+kM4NUjxinFGTnKQMuC60hMBRDw7ucHCuJZtxSI
         Er1nhwtZegm3aXhfQhAEdcRlM69Cs6dZ+pQAKti7QQEpsOxqXlO/GdiFGhu2oePTLadc
         vg7VDEnPom9NYVioaqrSWIPxTAjVNt/fa+h7pDpmH6SUa9B33qexC6xBTmhc1csRfHUd
         2EKtGuUdnMQR7kP2LVHHIS/Oopi3OE+tagOuD1qaYtBipF2IR+30fAZYxq5WCt+hYFHq
         MqjOo+LNK7zudMkGJuUTRs9t1Kfliq6HcRG7JirCxO5FzH93iUhKFvNn0njeYilfTHV0
         x0IA==
X-Gm-Message-State: ANoB5pmPlGi78uxslZHaMVGv6yfTiq3wZ/SqJ7/O1HGI70bMAD3RxqXN
        vet6VnkNSbxg+zpW+PlvNvDADdYHss8OH2bwrj4=
X-Google-Smtp-Source: AA0mqf7Ylbn/4xa+8M/JID9YEkhAN43sZJ/L4f/xakKGQjN5OIMs7m2AwJmzA+oeJQZCctDHR2OYCaTIJo9/W8l8VFY=
X-Received: by 2002:a63:d43:0:b0:477:66b9:341b with SMTP id
 3-20020a630d43000000b0047766b9341bmr70406692pgn.130.1670871322205; Mon, 12
 Dec 2022 10:55:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
 <CAPig+cRSY+c-fOQBeC5ff0-s3+_kzFEjcBOSHP6C8ca9t7zr+w@mail.gmail.com> <37efcfcd-fea1-c1d7-65f7-ae5f2d2a12e6@github.com>
In-Reply-To: <37efcfcd-fea1-c1d7-65f7-ae5f2d2a12e6@github.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Dec 2022 13:55:11 -0500
Message-ID: <CAPig+cTA=4DZEhM23tVfoRjxPuBAgs=+UGc5+-6rg4DYQxxKdg@mail.gmail.com>
Subject: Re: [PATCH 2/4] read-cache: add index.skipHash config option
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 8:59 AM Derrick Stolee <derrickstolee@github.com> wrote:
> On 12/7/2022 1:59 PM, Eric Sunshine wrote:
> > On Wed, Dec 7, 2022 at 12:27 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +index.skipHash::
> >> +       When enabled, do not compute the trailing hash for the index file.
> >> +       Instead, write a trailing set of bytes with value zero, indicating
> >> +       that the computation was skipped.
> >> ++
> >> +If you enable `index.skipHash`, then older Git clients may report that
> >> +your index is corrupt during `git fsck`.
> >
> > This documentation is rather minimal. Given this description, are
> > readers going to understand the purpose of the option, when they
> > should use it, what the impact will be, when and why they should avoid
> > it, etc.?
>
> I will expand this with explicit version numbers for older Git versions.

Okay, but that doesn't address the larger questions I asked. The
documentation, as written, gives no explanation of the purpose of this
option. Since you conceived of the option and implemented it, you
implicitly understand its use-case and repercussions which might arise
from using it, but is the typical reader going to understand all that?
Namely, is the reader going to understand:

* why this option exists
* what problem it is trying to solve
* when to use it
* when not to use it
* what the repercussions are of not computing a hash for the index
* etc.

Are the answers to those questions documented somewhere? If so, then
the documentation for this option should link to that discussion (and
vice-versa). If not, then those questions should be answered by this
documentation.
