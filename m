Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37365C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 08:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EAE221FA
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 08:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgLBIL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 03:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBIL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 03:11:57 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9581DC0613CF
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 00:11:17 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id b35so544857pgl.8
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 00:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Sir8Z+7Ts13dihDrqYszvVK6RS/qHKB6yZH3UWloVx8=;
        b=tHl4e+fi266/I8RuEW4jM084zHg0Q7SxHWKUVH1uKk06E/V1vWy0bHtoXratZCdwHK
         kzgqgj8SwOi5+q2oTkP1RlV8NGML2sBcJ4i0ApCCvagyzui7X75a68v+juku5lrB5ljr
         1Fu5qxKG33Ii8Qt2NybogsoegAHg3XzHVQ2glySpabn/4cqkwmxvMGsp/8W0zL2q6VwS
         pwmMjSzXTZiZcvdYz8LRVF2V7586j8Jr9RVKqPRP21/AKu6Ngdpw/5A5nswZrEG7TlwI
         tvTUtZC/8qsEwUxcp4emwmbw9D7wquRzCE9gEjRSvmnBO+thK8kWzJfMM6RttqzFNd4K
         8uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sir8Z+7Ts13dihDrqYszvVK6RS/qHKB6yZH3UWloVx8=;
        b=SYm4IRic8V8gw8rWNlcHHEk24LC5fpviJFgb3kepcADj+m3GcFI5LqR2QyneRyXtEU
         wimfWtfTzgjtbqVACo3w6Fk0Z+PFu0CoDzSlraukaCEoVf6thX3NdXD2fpzEPK2fJOCa
         20EOH92mUYTYVtaCA6OyWty6fjzd4Mvl90o93Savm0skXiZt2lQ4Y+Ej2yEikItPr+Ae
         hEhbujGXu5ealJBqL03yjmQFxEfu8LhtPoDu/y63q5O8+1miTWzDV4HHU1Jhe96SAI+J
         VuumsmPaPxWuAk4Ew9e9rIQvwJfCQsFQjvz+80PaCpKfSBAq6M50AZ/ub8BTqxDX6lQa
         Rs2w==
X-Gm-Message-State: AOAM531nJMpp4fcVRvw0KQW8f8OvkesJNeHBrgek6gURymfl1Sd9JPsP
        A1yMRZ1GLSJDwguOCu28B0eHoCjdXf66mocSMlhz
X-Google-Smtp-Source: ABdhPJwoItPD9KF/I3Ej+JZQTWjws6MWEjoXvYu5H3DgcJiLOEdgoolM452HW07ESQNzA0hy1b34e63xLgYGTtfjSIsj
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:17a4:: with SMTP id
 q33mr183434pja.0.1606896676701; Wed, 02 Dec 2020 00:11:16 -0800 (PST)
Date:   Wed,  2 Dec 2020 00:11:14 -0800
In-Reply-To: <X8bVHQ1eyDkv2CLT@nand.local>
Message-Id: <20201202081114.3485460-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <X8bVHQ1eyDkv2CLT@nand.local>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, peff@peff.net, martin.agren@gmail.com,
        gitster@pobox.com, git@vger.kernel.org, dstolee@microsoft.com,
        szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Dec 01, 2020 at 03:37:25PM -0800, Jonathan Tan wrote:
> > > Once we can reach a good decision there, I'll send a v3 (which currently
> > > lives in my fork[2]).
> >
> > I did, but Stolee has a point that the algorithm will change later on.
> > I'm OK with the parts I reviewed (patches 10 to 18).
> 
> Ah, good to know. I'll hold off on a v3, then, until you have had a
> chance to look through the remaining handful of patches (if you were
> planning on doing that). I haven't touched those locally, so it'll be
> good to hear any comments you might have before sending another version.
> 
> Thanks for all of your very helpful review :-).
> 
> Taylor

You're welcome! I've gone ahead and reviewed all the patches subsequent
to 18. I think others have looked at the patches prior to 10, so I'm not
planning to review the others.
