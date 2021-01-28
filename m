Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D058EC433E6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 00:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A435264DD1
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 00:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhA1Agw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 19:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhA1AgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 19:36:19 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00106C061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 16:35:38 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id e2so2662320pgg.10
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 16:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+b4098rAtJWhQiuk7COdvlulFXYyf1L/x1GbF6QHFc0=;
        b=txcQ+cvdG8LUOqRbybcBif0jWr3ThzvizkjygtOirxGc/N6eqM3p0KYRJWK1a4hBNQ
         Lw1R8oF8TjV0uOADKHs4kfK6c4rLVW/Qncs0Yp2CYXopf5XJI27blokINoy3KKC+472Y
         Y9TdA0APYQh0tshVqLqIVK/kQ1B56sxnfGepykh+RvtQ04NlaV4UWxChEzi6eSfDZFHg
         YVR6B47WBuWFaRskJWt+khKb+gk9537n38NsLD3bF4U2VUW9eQWP9eIww6wbOmk+XX6A
         BIEpPNIyfWzq4t+nrX5828tQV4eSzocdjI1BiJrtapenHCvlb8rutM3FbKy4MK+FJfmV
         SiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+b4098rAtJWhQiuk7COdvlulFXYyf1L/x1GbF6QHFc0=;
        b=NhsoeGgIBUBQ8XEgRohYA/+eydZYWzjugwlydKGZGdbsOGg9prSEc5nuCJoWWcIM88
         Q689pQ8rhSHBkCyJNWjctvg63RaQvYhGKWZMhJDA5On6ztg+1oSwtLvMI8L/5xkESVeF
         +AhLjyBn+3nfStK29mZLyu+6S4uoNZ0zCNi7jGzmOevt5VygQeH5Htb6fDT/gpxS9CBE
         Sw19Tn0E6sfLVuci3AAVGEAyfeVdVkb9+XhvfNkgWmfchj1L1ihCS8ZEAGdBTGc1//tm
         z2n2o8KdDayqAIrPwCPazyTe2Ved37MrACL2STsAYf1ggLYNWpH25rGP02Q6c00Sr7pu
         Z3lg==
X-Gm-Message-State: AOAM531JATan7iQMIHMFwf9/ecTjdWvlJGloGL9FmrIipGYq6MGi9ifJ
        1fcv/xY3Mk/0SFjl0m0JBkSYvuNiouNJMTYdQgtu
X-Google-Smtp-Source: ABdhPJwX5sLtsQEaHN1uaYBFPql26CPSHOy+OAMo7wZ+0M3ptYG+2HM2lILnrET2AX+MNk4M7Zf2tDr3Qfz6IUJO+vFF
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:794a:: with SMTP id
 u71mr13738697pgc.91.1611794138338; Wed, 27 Jan 2021 16:35:38 -0800 (PST)
Date:   Wed, 27 Jan 2021 16:35:36 -0800
In-Reply-To: <xmqqa6sy26gq.fsf@gitster.c.googlers.com>
Message-Id: <20210128003536.3874866-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqa6sy26gq.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Re: [PATCH 0/4] Check .gitmodules when using packfile URIs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > As part of this, index-pack has to output (1) the hash that goes into
> > the name of the .pack/.idx file and (2) the hashes of all dangling
> > .gitmodules. I just had (2) come after (1). If anyone has a better idea,
> > I'm interested.
> 
> I have this feeling that the "blobs that need to be validated across
> packs" will *not* be the last enhancement we'd need to make to the
> output from index-pack to allow richer communication between it and
> its invoker.  While there is no reason to change how the first line
> of the output looks like, we'd probably want to make sure that the
> future versions of Git can easily tell "list of blobs that require
> further validation" from other additional information.
> 
> I am not comfortable to recommend "ok, then let's add a delimiter
> line '---\n' if/when we need to have something after the list of
> blobs and append more stuff in future versions of Git", because we
> may find need to emit new kinds of info before the list of blobs
> that needs further validation, for example, in future versions of
> Git.
> 
> Having said all that, the internal communication between the
> index-pack and its caller do not need as much care about
> compatibility across versions as output visible to end-users, so
> when a future version of Git needs to send different kinds of
> information in different order from what you created here, we can do
> so pretty much freely, I would guess.

Yeah, that's what I thought too - since this is an internal interface,
we can evolve them in lockstep. If we're really worried about the Git
binaries (on a user's system) getting out of sync, we could just make
sure that subsequent updates to this protocol are
non-backwards-compatible (e.g. have index-pack emit "foo <hash>", where
"foo" is a string that describes the new check, so that current
fetch-pack will reject "foo" since it is not a hash).
