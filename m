Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979CFC433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 00:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FD560202
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 00:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBSAn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 19:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhBSAnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 19:43:25 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9C9C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 16:42:45 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id k16so2286097plk.20
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 16:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=J5bCZZ+mGDWQpg/yNmTq/SLTsTTUPHX9GuEdvRT8yo8=;
        b=JmBWpKRe1VPcbqjVejr6hsJbqttOO0eSb8AnWWOTz2zi5IIXvYsjBuJ3mOpsrHS+RW
         HscVGz36x++GkuHdImu0NHq7b+27jKEWGG9cQ8uCPOtQrRehoDZowQqfyGOkzRi/5ig7
         ADzATv0JVOZjf3VlTDaWWXtEVAF4s6n2tKVG9lfqYhsq6u9d5Psb88zxTh6EeecLAfL/
         cpIBRmW6fOSCHV6Zepfhm7PF25NR6N0eI1MdFMr5Jum1CB0W56oAOJ9GJo8OvOfgw2yl
         nF7lYwMQwrLluBlo+x0I5xoyv1Js7jPqy0jhT5SBVpYSYAiha2ebPHpFLZFFcTqtrsob
         w40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J5bCZZ+mGDWQpg/yNmTq/SLTsTTUPHX9GuEdvRT8yo8=;
        b=dGWvy+PFlmxoo8hpqXB2bYR3qqfhMEun7Rf0VZXk67J3JNOXKgSuFvm78XpsozTrBL
         TYOC27QJi4l6ek3Hd9t4cNWznsNlp+NE4WIqiuxMivdTkmQhTt4MxzheMfZYR73YI1jJ
         pxSTzZoQt/XEV0qvTGVEASCNJ19LbcA7kEOofqmbryF/hNac0F4MVzn74hoxR8e7SY17
         SxDF9bvOcDyus1rnZjrBCkAs6akRLYhbBsZ+syS+acTHMZBhH6ZDiYgxSeZY96gf0USM
         qqTl6tAk+txB8BW0lgAAAwzxGKpgUnXNoUPcwqhwJoNEI0/yotcz7YV2rmeNHm0JjD2P
         kKPw==
X-Gm-Message-State: AOAM533b2kyy1pmGGqEtRVGG8mA1Me0hZq+A97YUfPWHQvNOZxBFePQF
        ZDbwBvNFqtokHhYTDyOWPR8apE2QEsGxkH2DLoan
X-Google-Smtp-Source: ABdhPJx8RFRDbbBEIIxqGtE5ZbYpvIpec3OloFpinB1I0OfKy5MFjM3JrzDPYG7lNrIIW4y4SuReVQy52JYEDC3oOIZu
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ed94:b029:de:8844:a650 with
 SMTP id e20-20020a170902ed94b02900de8844a650mr6426874plj.56.1613695364731;
 Thu, 18 Feb 2021 16:42:44 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:42:42 -0800
In-Reply-To: <xmqqy2fldsy4.fsf@gitster.g>
Message-Id: <20210219004242.1179999-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqy2fldsy4.fsf@gitster.g>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: Re: [RFC PATCH] push: perform negotiation before sending packfile
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> For a real implementation, I think we'd want to do the negotiation
> inside the conversation between send-pack and receive-pack, so that
> what is agreed to be common between two parties will not shift in
> the middle (in the same spirit that upload-pack grabs all the
> relevant refs first, advertises them, negotiates what is common and
> creates a pack, all using the same worldview of where the tips of
> refs are throughout the process, even if some refs change in the
> meantime).

Upload-pack does that for protocol v0 ssh:// and git:// but not
http(s)://, and does not do that for protocol v2, I believe.

If we were to do that, I don't think it would work for the transports
that have are stateless (e.g. HTTP). Also, this seems like it would
involve a significant reworking of how the server serves (receive-pack
would need to know to communicate just like upload-pack does temporarily
before proceeding with its usual behavior, and the client would need to
learn this new way - as opposed to the idea in this patch to do it
separately and reuse the already existing fetch and push mechanisms). I
think the greater complexity is not worth it for something that won't
work in HTTP, but I'm open to other opinions.
