Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE04C2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD06216FD
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQnHMj2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgKLUjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgKLUjL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 15:39:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA73C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 12:39:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j10so7634638ybl.19
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 12:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uEL4fO2tVBH7nxS/JKfXz3WXtJEGj33I2dNmV8l7vEs=;
        b=bQnHMj2w88RHhEA+WwelOxvtSVzpvE6oNONqrdZfAYpT6nwptGxplrkh1blmdr0lQo
         dJFUEBO2Hv7CuscnMGKBTdea0RCbZ6zL+t3cp6xXHSXlpVC971iW/4FFISZ4s4KeUt/i
         Cle9VDRG/H+j85RBAItXAntavudKomRCmVY7RZ7ZwDIhX9e0jXVulohZx5ynpeHl+wvi
         swcMpwvIIWECl5whpFfdc2Bo6uZbTtGu6WJ/POeZMJZXwRZL15YNz6VZflTlDunm6N/d
         cYMB9QNg24naVAqENjE8+vm9T6Lx2icDtCeDL1jWVlPdUrAY1eu7dvnmldsdj/NslSof
         ZUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uEL4fO2tVBH7nxS/JKfXz3WXtJEGj33I2dNmV8l7vEs=;
        b=hyMg1U3L1GP2qHdhRsyb5rOpvsNNwPdjcHccISUboMnMfN8W5W7Xa8MB13hUp0Pbxc
         6jGLz+yNYti4d285a4Wk+VNSmyUa0FhEQ97Pm9CzHYGxUcUwl7HiAlkuJToZ1PUDF5DL
         TGj1a0UGtOmY5An/bwwnL+/VjOogqrJInzlnXfF6BUOdyf0DbV2RNDmbz26WYhWTc3lQ
         yv/XPWtcFU2CCFoZSLH4TegDEolycWMu+7DnjaMQLfZLj68xGJgkB+eAn9aWBbWYt3kt
         +IGQb/Oroe2qpzv7C/Jja12NCW3eWCaE/qbA3pA6uU4K1/1GFeZ3hnPK1YmwlqH84eaC
         cJlg==
X-Gm-Message-State: AOAM5324izcevK93RSlIwz6TcnBGIJoerORjvniLJ5lhmLQDriIh3YLK
        Xrem25jRGSFHTQMhsQ8TBNP8/DE7OjcdohC97umV
X-Google-Smtp-Source: ABdhPJwVH3ffxBu49vPXhuVkel2pihI8zEbG6oVNN1nEdFJHCAgFAysDO1+Vktu4YFRd3NxoGuSFwvPXiT6KrIpWRWy0
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2f55:: with SMTP id
 v82mr2143643ybv.438.1605213546467; Thu, 12 Nov 2020 12:39:06 -0800 (PST)
Date:   Thu, 12 Nov 2020 12:39:04 -0800
In-Reply-To: <CABPp-BGr4kpjyZc3Rbh+8StPbWWqo36Kg0P=dgqctwX0SCGPxw@mail.gmail.com>
Message-Id: <20201112203904.3443874-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGr4kpjyZc3Rbh+8StPbWWqo36Kg0P=dgqctwX0SCGPxw@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH v2 13/20] merge-ort: step 1 of tree writing -- record
 basenames, modes, and oids
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Nov 11, 2020 at 12:01 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > > +struct directory_versions {
> > > +     struct string_list versions;
> >
> > Maybe comment that this is an unordered list of basenames to <whatever
> > the type of ci->merged.result is>.
> 
> There actually is an order, and it's important.  It's reverse
> lexicographic order of full pathnames (the ordering comes from the
> fact that process_entries() iterates paths in that order).  The
> reasons for that ordering are (1) all the basenames within a directory
> are adjacent so that I can write out a tree for a directory as soon as
> it is done, and (2) paths within a directory are listed before the
> directory itself so that I get the necessary info for subtrees before
> trying to write out their parent trees.
> 
> It's not until later patches that I take advantage of this ordering
> (and when I do I have a very long commit message to describe it all),
> but I can add a comment that this is a list of basenames to
> merge_info.

Ah, yes you're right. I'm not sure what I was thinking of.
