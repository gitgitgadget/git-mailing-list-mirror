Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8F5C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiLLV3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiLLV3v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:29:51 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A283899
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:29:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id n16-20020a056a000d5000b005764608bb24so654804pfv.12
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bl8GUkBpu58MQW9qQY25nJGM0Cpjlm9RFfEP3oOttjw=;
        b=Nk+plG7Wu5ncXaNadtX6R+YOZ7keCF/s8oPQGIqAwPZD+Kc2xo1by4l9H0v6dDZuby
         a1mCBD5kkNidPkZy6z3mxuS9dmlL6lbrGYUeLr43+Oja+8HEoVy28VboC/HMyLKJvtDr
         iBPKwnqazONcqqfrnNwwKd2NCX7JepYvcbKQmL1+05oaf8A7PZfvAFpL4s7eajMXYt9/
         dSAjvywFgiA70xdsGnR29t7t4SgJzBFXCaYRvgWebRLBeM3pV+gqvYvI34OuEhamtkig
         NB99R1GxiVov7BMN4hMbcwDD2B7KtiYB08dLqj/YzPwm+hQkzrGTJiDS4EiwP4eYxxxJ
         inpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl8GUkBpu58MQW9qQY25nJGM0Cpjlm9RFfEP3oOttjw=;
        b=HWk4GGsU3aAOe94Yd5kZx3IjqM4QvDrwuFgLpEBh1x9tAOAsCP2AcSolM/SWi2gaSz
         6W+9/A1QVTcEVIkyK5PUW/eVasIdPVgJor3xI5Crtbz2FNfjLN5zIv2TOm7FGXExBof1
         Hl3hOJCf5fVMCGw66ry9qqa0cqP7L6zoOTlpfbEmR8wbt8foygQlvui0L3MmBMNuoHkI
         Oxe3UW6TW9yAuv1XRef1UYYCvY00P16wow1oUEZUyhm+ldC0Q35ZHFIRTyvbrISrP/30
         q7KDxW992Q743Kh+UjjWN7etaqVBMB83G6hjBBkH5/LeZVJAsYE6aAl4Fb2XIzZNEb7r
         Y+wg==
X-Gm-Message-State: ANoB5pmFlemjORb8vYJC/Kj4VeEH9AtaZpzPmHODole5Riytqf/KJ5uD
        cySXBrxxP4hToEsrKZ5zBNmMQGk5c6n8OIPdoFN3
X-Google-Smtp-Source: AA0mqf57qvShfWw68XYxvSl+d3dmAZbRRSKCtrVGbh64EKXlA6Gy1M6J7V4Yi2uQWcZmgqMeo+9TOAwI7yBz9kfsi5Y9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:4002:b0:219:c1e8:114b with
 SMTP id u2-20020a17090a400200b00219c1e8114bmr42008pjc.94.1670880589621; Mon,
 12 Dec 2022 13:29:49 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:29:47 -0800
In-Reply-To: <Y5ebC1qwJi5VwnCh@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212212947.1559820-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/4] object-file: emit corruption errors when detected
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> On Mon, Dec 12, 2022 at 12:59:55PM -0800, Jonathan Tan wrote:
> 
> > > And possibly put a comment above open_loose_object() that "path"
> > > is only guaranteed to point to something sensible when a non-negative
> > > value is returned.
> > 
> > Junio made a point that there could, for example, be no path when the
> > odb list is empty (maybe in the future) so I don't think this would be
> > sufficient. But there is already a comment there pointing to a comment
> > in another function that states "path ... (if any)" so this is something
> > that callers should already take care of. In my changes, I'll initialize
> > it to NULL and whenever I use it, I'll check for non-NULL first.
> 
> If we return a non-negative value, then we opened something, so by
> definition, don't we have a path of the thing we opened?
> 
> I think the case Junio mentioned was if we for some reason didn't look
> at _any_ path. In which case we'd be returning an error.

Ah, my reading comprehension is failing me, sorry. We do want "path"
to point to something sensible (well, whenever we can) when an error
occurs, though, since we want to include that path in our error message
when DIE_IF_CORRUPT is used. So guaranteeing "path" when a non-negative
value is returned (and hence, no error occurred) is not so useful.
