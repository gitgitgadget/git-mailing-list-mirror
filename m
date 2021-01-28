Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C664AC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 01:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B6A64DDA
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 01:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhA1BHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 20:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhA1BFa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 20:05:30 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DDCC061573
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 17:04:29 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id h13so2647221qvo.18
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 17:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7+fDE/rf8GpAe2hx2kmELCtBS3URUB5pJAH7vb/swnI=;
        b=u/j6NowL1oi/k2CAkUW1HtRmvPl98wHK5KmC1H6PehLofyjwIx/xWONbTm5LN54cZN
         xT6xrxeIlyaqbUEGGXyI45stIKerxgFIE+P+bB+p2m6SLrVDHVZ2NQmrRk6o3CsSzncQ
         x/QFKbCmK6F7gCOwnkYGGjXcR8w5MMwYgOcp819JYRtbEuz0qv+klI2esXrpWRfFrC+0
         ETsZMAqfGYVV2HMHdlS9gY/VIREpJo4UqzvHCf/o76cAP7GEjl6FhOCHuphWDQnMnc3Z
         1xRc61Gj2EP22FVQzmVQ1EwOh/T3TaJ+isW1YxmBkRNIa/qt9d/nv2czpcOqMCpYV8EI
         vwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7+fDE/rf8GpAe2hx2kmELCtBS3URUB5pJAH7vb/swnI=;
        b=LMxQdNySZ9ZAIoTN3rBL3LLGWHNio3+fyVng1+MM4acQZMG+6nGNzOxfFKsyDTW8hd
         LyBsEisvgYu5iY7YZIdhxtFP+dkcnKNEgIXWoFi6GXJds/akSEfzW9tVRKx8LcsmBCiJ
         oc2AS9PdWUyhVNE6DKRNhjtBlj/DxSG3aBQial+i3jf2WWZBcWBFG2OpyiZ3PaCwozHa
         0eO3GI++IAnQ5kJdoHynnuAQBvgUGpsaLEMKgU57akPmKy7Zi2r8anbI3BZOYPuUxsIs
         3T2YRHs+xi9KOlThED7c+LrMSJoPm/Y1HLlvaBAJIoACfPAv1Up3mwsR9u9j2AplRPpw
         BVUQ==
X-Gm-Message-State: AOAM530ePiCsMfZSQJxYegrzUQI8YY9vymmn4/vdPdbmLIzvQy/r3QC0
        3EiRqtYEE4q/spHDG+Mk5nJrip1SoAQWJVHrN9Eb
X-Google-Smtp-Source: ABdhPJzoqxYnNkjQ0uqh3IVZqYTTEmi0tFsBFk85KmcCn4rKiWeG39vtHr7kaKxPdetCESg6Iblt2ZlqyEvJIRpXYgB0
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:3f0:: with SMTP id
 cf16mr12967899qvb.25.1611795868655; Wed, 27 Jan 2021 17:04:28 -0800 (PST)
Date:   Wed, 27 Jan 2021 17:04:26 -0800
In-Reply-To: <xmqqmtwwwjbw.fsf@gitster.c.googlers.com>
Message-Id: <20210128010426.3882500-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqmtwwwjbw.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Ehh, please don't.  We may add multi-pack-index there, or perhaps
> > reverse index files in the future.  If you care about having two
> > packs logically because you are exercising the out-of-band
> > prepackaged packfile plus the dynamic transfer, make sure you have
> > two packs (and probably the idx files that go with them).  Don't
> > assume there will be one .idx each for them *AND* nothing else
> > there.
> >
> >> +	ls http_child/.git/objects/pack/* >filelist &&
> >> +	test_line_count = 4 filelist
> >> +'
> >
> > IOW,
> >
> > 	d=http_child/.git/objects/pack/
> > 	ls "$d"/*.pack "$d"/*.idx >filelist &&
> > 	test_line_count = 4 filelist
> >
> > or something like that.
> 
> FYI, I have the following queued to make the tip of 'seen' pass the
> tests.

[snip]

OK - I'll include these changes in the next version.
