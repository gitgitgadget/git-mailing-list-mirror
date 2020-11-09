Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCFCC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BFC206C0
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FahohDGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgKIWrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgKIWrf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:47:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D930C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 14:47:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y11so12650894ybm.22
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 14:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nV+eLiVSN4gAOz/2Anh5Jrp2U73fcgEmJjHD3SxqdQU=;
        b=FahohDGZvkZrd4AlVrI9pZydoBwEXtamcL19Kku7d2AVyZTIANFVTyZuFsvFZHnEkb
         T/XJco+00w89v3CCJ8GPY1hTT4PHBQ2h0fzI2TQjzOgbFvCrDT0wXXdwUlrjx4undliN
         KPKylpSRA0Egcj0StBMKUiDOpE+KZ/Kb/p86RmckaAx7hmARqmc0VYHP4qbDSx+q3Jao
         En0YKOrtt8cDVOobNf7tGyTrcvboRBnE451KoXkYI9PI2eSow/mtl4n9n0LIMXtCLzoU
         MbHRSEDhsOTbvfykcSLgaPjd80QjPLdmJ1b4Du+cm58Tfwl61E+Lk8r6d6cqEnO5E6BH
         QWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nV+eLiVSN4gAOz/2Anh5Jrp2U73fcgEmJjHD3SxqdQU=;
        b=B1aqxi5h1ArJF8Zqy6ic0lGr4CLNH+ZZqrAyOAod3ffhxqgEr9Rysfys5t/KehS/bG
         QG9kBEJSKLOSoU3rsYm4DeoGdfSphCxi55BZIMNsQ9I10TQWMd/1lPuM40SK/Ho74pa0
         c5kZrG4SHBcYdre5F+/Cwwg39h9YVl+RZ5rAu3JsQgXvwLieKctPsLfDZDIkPf6qLEdk
         X+rc07QhQDBHJpECWGVWbIqNNA75X2e3ObYG9ew0XttT9OujOzRkCva5efSe/LUYFl/d
         ToHDbVAumP2tXcnHdCXkJb7aht8U/YqBKu0/y2PKXv+zgFOL2eMpjVd0C5NPS6istlEZ
         TcgA==
X-Gm-Message-State: AOAM532Fvew0P6PqbJKJaLCfsibYgqNVQYVG6T1mCaIsMmtGOaDsXTDl
        w02jQsJk3i2GDcU9Y07c7lPYMI482r31Vjyi5g2d
X-Google-Smtp-Source: ABdhPJy5gYRoW6npcYQz0B8nBCnt1Q9QiCd2WgUBQo81jIH5S/1uvpPG0KDAMxdodhKwXCWuw8Urhjkwu2kCsM2hg4ds
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:3b8c:: with SMTP id
 i134mr23652301yba.372.1604962054703; Mon, 09 Nov 2020 14:47:34 -0800 (PST)
Date:   Mon,  9 Nov 2020 14:47:32 -0800
In-Reply-To: <xmqq8sbab52p.fsf@gitster.c.googlers.com>
Message-Id: <20201109224732.2549561-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8sbab52p.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH 4/4] Doc: push with --base
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, peff@peff.net, jrnieder@gmail.com,
        git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> People expect that a single repository at their hosting sites can be
> >> used as the central meeting point for the project, just like CVS/SVN
> >> servers were in older world.  "git push" would need to accept that
> >> reality and start common ancestor discovery eventually.
> >
> > Thanks for your reply (and everyone else's). I was thinking that a more
> > rudimentary form of the feature would suffice, since I wasn't expecting
> > much more need in the future, but looks like this isn't the case. I'll
> > be thinking of a more comprehensive idea.
> 
> I said "eventually", meaning that we may not have to solve it
> immediately, but judging from the need for ad-hoc workarounds like
> sending older commits that are not necessarily at the tip of
> anything from the receiving end as if they are tips and then another
> ad-hoc workaround like this one, it seems that the need is real.

That's true. And if we need a more comprehensive solution than putting
bases as Extra Parameters (and don't think that base-in-Extra-Parameter
will form a part of that comprehensive solution), then I do think that
we should go for the comprehensive solution instead of making something
obsolete that we will still need to support later.

> Would the earlier refactoring of the negotiation part into a
> separate negotiator module help, or did the refactor not remove the
> deep assumption that it is only about the fetch/upload-pack traffic
> and we need a design for push/receive-pack from scratch?

The negotiator module might help - looking that the API, it takes a list
of known commons (none in this case, because we want to skip the long
ref advertisement) and a list of tips to check (for this case, the tips
we want to push), and then the negotiation starts. So we might be able
to use it in a push v2.

Having said that, it might be possible to reuse the existing fetch v0/v2
protocol to perform this negotiation (preferably v2, so that we can skip
the ref advertisement). We'll just need to add the opposite of the
"no-done" capability to make sure that the server never sends a
packfile.

Once we have found the base commit(s) either through push v2 or through
fetch+opposite-of-no-done, we'll need to send the packfile somehow. My
proposal here could do it, although then we might run into the problems
Peff describes about Extra Parameters [1]. If we don't use Extra
Parameters, we would probably need a push v2, but we might then run into
similar problems to what we had during the fetch v2 migration (e.g.
unexpected subtly different behaviors).

[1] https://lore.kernel.org/git/20201103151859.GA444466@coredump.intra.peff.net/
