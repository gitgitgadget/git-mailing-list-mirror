Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E9CC4167B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C9B238A1
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgLGS1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGS1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:27:16 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D765C061793
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 10:26:36 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id o12so11823574qtw.14
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 10:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IAJd+AZc9XnXu6Q8DIAAwbmFBsuy1xLhtQ3j5dTK2GE=;
        b=pC0moBYLl4QXR5eEYVWqWA53MnxLX5q3kji6YZtcIM0DG0Q3/yxR0DP75C7/sT5X45
         OVQMVmL0bjQbvZvLdB7X4f2KPuS1NCcjvNBnAagu6WvJI2hFgqOBp1j7HsqoeQuKyqi1
         pRz1sXZ1iN28UmLn1+DSfzSAPhYTsQ3z6fMJhxnLeHrytTg+nG+nvVJJ4zNzDMMe9MLh
         lQqX6/G+91kDuoSs49oy1zPUYfrHgApTvdzqCCYxZ9wHnHAk7vhmhACVhObmNg70nCA6
         rEYOPRWqmWeUuRnmqVVsqrZ2lBBq+ZS7x8JjNFyQV9SlJKw8BCNo4jG16DHDw8wC7Y8z
         CNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IAJd+AZc9XnXu6Q8DIAAwbmFBsuy1xLhtQ3j5dTK2GE=;
        b=Dof3B5Up3DSXZBSXU7obX0o25Rufi0L9UkVFNzrdrtGplaDPdlvhjkF8FyPKKDf+yS
         vHFvg9YLo1dKmWN1cvM9BloHAaH/cLBt0ZLNeTD/0O0s26UxyBlHJqImkludAmdIf6I9
         2WTpGc9YOqD1WkQSa7cs+Pnb6+v6COBtEXGibjP7PgVRzLCsx6DGYE1BxRrHrsx+ivRR
         R2BG8sMuBJfRbochqVhW7r3d5R1ETCUvOXMBkTAzvmeHXBc3q5FjmZ8RxLALJ2ddK79f
         iyEF0XdK3Aba5zlRrMbnshfRJm8X2OgxNtfJBXcfnp8ZKDxeEDy5PLWVKL8SL7nhoJQD
         0JBQ==
X-Gm-Message-State: AOAM532BcHRfkN+rB0aEkflZxFgwRE8iHxRqziVB77+ylUI5I9ZwKmJH
        cVplFgBW7DDMPCximhO1fk81faUV8x3jzl197DDI
X-Google-Smtp-Source: ABdhPJwnrftL8xpZ/AcXR0gpkBGuXxWkM01OUOlqi+hl66LdojMSGs4Lf0KoUgmGZvmnkciFTP5V+IHP9i29QIB5CBpp
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:f981:: with SMTP id
 t1mr22588921qvn.60.1607365595260; Mon, 07 Dec 2020 10:26:35 -0800 (PST)
Date:   Mon,  7 Dec 2020 10:26:33 -0800
In-Reply-To: <X8fcAZU30P5MdfRR@nand.local>
Message-Id: <20201207182633.3036948-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <X8fcAZU30P5MdfRR@nand.local>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: Re: [PATCH v2 24/24] pack-bitmap-write: better reuse bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, stolee@gmail.com, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Dec 02, 2020 at 01:22:27PM -0500, Derrick Stolee wrote:
> > >> We could even skip the whole maximal stuff (for commits with existing
> > >> bitmaps) and replace "c_ent->maximal = 1;" above with "add to list that
> > >> we're going to append to bb->commits at the very end". That has the
> > >> advantage of not having to redefine "maximal".
> > >
> > > Hmm. I'd trust Stolee's opinion over mine here, so I'll be curious what
> > > he has to say.
> >
> > It would be equivalent to add it to the list and then continuing the
> > loop instead of piggy-backing on the if (c_ent->maximal) block, followed
> > by a trivial loop over the (nullified) parents.
> 
> Jonathan: does that seem OK to you to leave it as-is? If you don't have
> strong objections, I'll go ahead with sending v3 a little later today.

Like I (just) said in [1], I think that my comment stands, but this is a
minor and local issue that does not affect the functionality of the
overall patch set so I think you can go ahead and send v3.

[1] https://lore.kernel.org/git/20201207182418.3034961-1-jonathantanmy@google.com/
