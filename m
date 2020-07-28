Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48854C433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 18:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2499220714
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 18:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tE3Jghql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbgG1SXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgG1SXq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 14:23:46 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A8C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 11:23:46 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o5so15410320pfg.10
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kkeSEbzdkwxeZxevPRokA+7VlIyPhs20D3mZtLbs9uM=;
        b=tE3JghqlP6Ba4a+hR1jZc/kurcFVI7FvkHeNcLXL6v55+jFa0HapWx7WT+wlieKGnV
         Q0kHHOSjd2U9vLzA0WH/5N+cgWWooN1vSkeE9bhX88iMeVDhzIbhtyQFHTqAL/SHZSvC
         LYZ7TT9H/5V7CCVe7/YB/xqOKwtS+mwHe/p7RhNnNY9ciHhVWF+pxRAF1PiMl4acb3Ey
         k7a/pYEyTxEowGinlcY7QGEMK1lq6HKWNfSXw9gqtr9AyaOx4ko09zN8Dn6T7T39X6Uv
         tVmniOROxtYkLxqjolSISwtCf10odFoxMmkODFXADTpqW2VCYy5p+IEZYex3xNWP70tW
         l9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kkeSEbzdkwxeZxevPRokA+7VlIyPhs20D3mZtLbs9uM=;
        b=mDIa+oSUk+qBO27o2KBSDsocu2+l+sg+3RoKSUvwXN5617JQoRyqD4FJdcsb0DMH8k
         tma1cm8Ka0m5ywapcujPysDkKTQrcAL+SsCCuvd1DumYeeLx/bTVFZgcNEFNaFtoKsKP
         CT1yFE5B2FU2Bd7lbf3y0Y68luYPzGGBgLGeC6FXijaKTn2HIARUjb7/dEruavPtVkvL
         5wOCRvQrIIxf8hHXPR484QMrZQA+G4BevayomgEEZBHTOtmZyqJEt7XV6KW+XshLJshZ
         UN87ka54WVbcOq2tjqeI6UXNf04/IgfrzMDy5XbMhxqKbALy840EsfUmtDCMLmZr2bWI
         y+NA==
X-Gm-Message-State: AOAM530cGOm4bN9u5RdGhHwm3c6WUfwXzRLZYQnHbAIFsCxnnF8CuaWg
        RG8PU776yQb7ZTBwig0/3juzZpzHKA5reL36c4iP
X-Google-Smtp-Source: ABdhPJxc5zzik26dxCZz5kRKpp8A8Og3WT8kbAxiAVkevI/JoOpFMhAO+UbEhsvEHih+1H4IRgvrVmWkzQrsVpBCzKAa
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr533493pjz.1.1595960625628;
 Tue, 28 Jul 2020 11:23:45 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:23:40 -0700
In-Reply-To: <xmqqwo2oe8r9.fsf@gitster.c.googlers.com>
Message-Id: <20200728182341.342162-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqwo2oe8r9.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: Re: [PATCH] apply: do not fetch when checking object existence
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > There have been a few bugs wherein Git fetches missing objects whenever
> > the existence of an object is checked, even though it does not need to
> > perform such a fetch. To resolve these bugs, we could look at all the
> > places that has_object_file() (or a similar function) is used. As a
> > first step, introduce a new function has_object() that checks for the
> > existence of an object, with a default behavior of not fetching if the
> > object is missing and the repository is a partial clone. As we verify
> > each has_object_file() (or similar) usage, we can replace it with
> > has_object(), and we will know that we are done when we can delete
> > has_object_file() (and the other similar functions).
> 
> I wonder if we want to name the two (i.e. one variant that refuses
> to go to network because it is trying to see if a lazy fetch is
> needed, and the other that goes to network behind caller's back for
> ease of use in a lazy clone) a bit more distinctly so that which one
> could potentially go outside.
> 
> Depending on one's view which one is _normal_ access pattern, giving
> an explicit adverb to one variant while leaving the other one bland
> might be sufficient.  For example, I _think_ most of the places do
> not want to handle the details of lazily fetching themselves, and I
> suspect that the traditional has_object_file() semantics without "do
> not trigger lazy fetch" option would be the normal access pattern.

Right now, I think that most (if not all) places would not want to fetch
at all - so *with* "do not trigger lazy fetch" would be the normal
access pattern. This is because (in my opinion) if a caller checks the
existence of an object, it most likely can tolerate the object's
absence; if the caller couldn't tolerate it, it would just directly
query for its type or contents or something like that.

I tried to communicate this in my documentation of the deprecated
functions/macros, but perhaps it could be written better.

(One other option to consider is to just change has_object_file() to
never fetch, although I think this is more risky.)

> In which case, renaming your new "has_object" to something like
> "has_object_locally()" would be a good name for a special case
> codepath that wants to care---if the object does not exist locally
> and needs to be obtained lazily from elsewhere, the function would
> say "no".
> 
> And all the other names like has_object_file() that by default gives
> callers a transparent access to lazily fetched objects can stay the
> same.

If my analysis above is wrong, then yes I agree that we should do this.
But we might need to find another way to indicate which has_object_file()
has been checked and which hasn't - changing away from has_object_file()
completely gives us a way to indicate this, but if we're sticking with
has_object_file(), we have to find another way of indicating that we've
looked at this call and it is OK.

> > I mentioned the idea for this change here:
> > https://lore.kernel.org/git/20200721225020.1352772-1-jonathantanmy@google.com/
> 
> Yup, I think that is going in a good direction.  I suspect that
> apply will not be the only remaining case we need to "fix", and
> using the new helper function, codepaths that have already been
> "fixed" by passing "do not lazily fetch" option to the traditional
> API functions would become easier to read.  And if that is the case,
> let's have the introduction of the helper function as a separate
> patch, with each of [PATCH 2-N/N] be a fix for separate codepaths.
> 
> Thanks.

OK - I'll separate out the helper function into its own patch in version
2.
