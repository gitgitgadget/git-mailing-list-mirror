Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F1C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 06:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiEPGL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 02:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiEPGLX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 02:11:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B0FCC
        for <git@vger.kernel.org>; Sun, 15 May 2022 23:11:22 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id il11-20020a17090b164b00b001df666f7a90so619696pjb.8
        for <git@vger.kernel.org>; Sun, 15 May 2022 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=85pvB8XA7mCJ+syZIAzhIx1DqPADYSgryrn+PYracQw=;
        b=PwxF1GfwuBukC73GaJd4gXF96Jyh2cIHZOp2pcAd7Y/tZxAOYkD3B81sscJgIYL4/A
         iiWIBHx7TeoK4txy9jvoe1X4Nr5IYMp6mKPR1TzAWivqeK+8pHrEp7H8Cw7HBT6SGPYJ
         XqNlQ1tHhv+gV5wG4TiW3vRGh1qs6AVFpjeNEEdn4r3rR/fsVlaAUcHgKOnDscmC2MzU
         HUoYh9k1AyBPo4RIw3omjjBxLYT/LmZTMfvMLjhqVV+Tl4EWxfMRa9Fx1P4rsveXvvGh
         G9Oe9l2Ay+EN5L8QbKaMu3GWLkJNSsf6H1UcBFAl6+X4uwzjMdyebfLiSSSSqTSQ9SCn
         dMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=85pvB8XA7mCJ+syZIAzhIx1DqPADYSgryrn+PYracQw=;
        b=GLGxy5Su+dtW0FdlVrpBO7bVYgDZBuB8edk17+ySbD4svy/SUqbUq3cDp8LdvGShGW
         KKVIkZJ0Z39VQs/tTZQTbpsSYQ2M1PpRL0uIvb/3Q160Qkbkuf6vG13HdelkpdmR+gJY
         FB5eSfQiaHS+z211Xju0Ce5toqEpBXcdcTdYRuOgTNRrTzx8zb6K4dvD8PWmIW/ZYYZq
         zwu7OVOMGPDR7T9FL/kOyKEbmPaSqJVGyBKGjkZDukforWc5dQVZb5c6wgC7LMFHYzIm
         nKQzwwFLk88q3QFpCEMBx2drcvJ8rgPqtsYjIULUdXJAZfKcJeO53ZXhva+0urMBcbOX
         oRng==
X-Gm-Message-State: AOAM531uNqiIaZVPwjD6oekhAry6gs8jcP3pVVPmKgpCVa3yni+H0JIQ
        A/QhdaleX+q5ltcxfUTq9a80R5uMzS3IWBQgs2OD
X-Google-Smtp-Source: ABdhPJycFzDHjgrQrPMeSvH9F/75Ym5y/0X+Q9G7MrCPyoGy+MtTYOORLIrMm62qcmesocOGXO8KoLQRSWDaA4Sjy89L
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:20f:b0:158:d86a:f473 with
 SMTP id r15-20020a170903020f00b00158d86af473mr16389915plh.92.1652681481947;
 Sun, 15 May 2022 23:11:21 -0700 (PDT)
Date:   Sun, 15 May 2022 23:11:19 -0700
In-Reply-To: <Yn+v8mEHm2sfo4sn@nand.local>
Message-Id: <20220516061119.1569730-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: Re: [PATCH 2/2] builtin/pack-objects.c: ensure pack validity from
 MIDX bitmap objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        vdye@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Fri, May 13, 2022 at 04:06:39PM -0700, Jonathan Tan wrote:
> > (An alternative to the change in this patch may be to reset *found_pack
> > to NULL when it is found that the pack is invalid, but I haven't
> > investigated all the callers to see if they can tolerate *found_pack
> > moving changing non-NULL to NULL, so the change in this patch is
> > probably more practical.)
> 
> I haven't either, but I think that this points out a flaw in the patch I
> originally posted.
> 
> Consider this:
> 
>   - `want_object_in_pack()` calls `want_found_object()` with a pack that
>     has gone away and has zero open fds, and `want_found_object()`
>     returns -1
>   - `want_object_in_pack()` continues and calls
>     `want_object_in_pack_one()` later on, with some pack that is the
>     same as `*found_pack`
>   - `want_object_in_pack_one()` then _doesn't_ call `is_pack_valid()`
>     (since `p == *found_pack`), leaving us in the same situation as
>     before.
> 
> I think that would be sufficient to hit this race even after this patch.

Ah, yes, indeed this would be a problem.

> I'll take a look to see if `want_object_in_pack()` callers can handle
> `*found_pack` being set back to NULL. They should be able to, but I want
> to do a little more careful analysis to be sure.

Sounds good.

> Thanks for pointing this out, I am so glad for your review! :-)

Thanks for your kind words! Thanks for your explanations too.
