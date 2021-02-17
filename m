Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE8C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C21264E58
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhBQTrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbhBQTqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:46:49 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF15AC061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:46:08 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t7so11540083pfq.6
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TJ2g9MYyr7btr/Z2sq09bFXZ6kKIpg2WKsvXAcsk8og=;
        b=Qjk+rbuYyeQ0q8/ItmsUqKTiGU5aMJSJxTpqYlcieLrxp5S0UvA7bFT0lxgCYHEpv9
         T6UDbMU7Yu4tC8LRalE7Nwu2phq8VkKKgb9YJJFGuMlq+AXlJBHyuvM4V1tLcFC4jEx0
         bdBQH4o4sJFJRACOgiDmJSemr4/ioq/fQNEb1JRkoi+AIwC/J4LY0dZcUxYoUsSSvtzq
         vklD7rVGeOrdgDsjY5QAUJVaqkU85TBsxtzgQKG/YrYj0/3Bvn9vFgCo6rU+YZq+tbHN
         h0bQcKw06s8CSDo7l9f/BdZZRNzPpLSfVYAW4S0IxdnxzKI/50hWFMiJ9aMOIkIu87R6
         r55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TJ2g9MYyr7btr/Z2sq09bFXZ6kKIpg2WKsvXAcsk8og=;
        b=J/5CXL82TBPtZihpIdVGEUVBZJAAgmGA4dwSLhF7Fart3RlCwBkxW9abQeigLGl5su
         bhDtM1lC/FAxJInR4sBrPfAWFZmsth8bQ1w2Y6AXlirXEjH94rS+AOqS7R0bm8MmCYs+
         UGNJRv7KvREyXZ5oBy5w78M2xMfFY48KHNZpqdvBRa7F/Bk2TRq1TBVobvCu0yrH4ZnI
         Wl1esDIQthLdgLn4EQF75rWpqj5PlRN09Kuc0UXgRYH+HTfyaOKt7skU/dimuyocJC8u
         flk1BuquAyG0KaGiZOhooSL3aq0bR9Pfh4IqHKu6rgAWf9DOxVmhA8wkXzqdzTE3agxP
         quyg==
X-Gm-Message-State: AOAM5321pZ9tT46q1R9N5ID3m2ndMZvwZQlO5Qw3+nqGlZMSpDpsRobi
        WIzBZigaNaRUb4MQSVE/1dxUqbtF5QQGX+cdLp8P
X-Google-Smtp-Source: ABdhPJxpvoPUpHTEHXUo5/R5dSokytWj1wru/WCEEHLQCsfT6CMG666GWaD5qIoU02T75XdNxQA/JRZ2vF/hwPtAxOFM
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:ed58:: with SMTP id
 m24mr823138pgk.45.1613591168279; Wed, 17 Feb 2021 11:46:08 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:46:04 -0800
In-Reply-To: <xmqqpn0zoc2l.fsf@gitster.c.googlers.com>
Message-Id: <20210217194604.871194-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqpn0zoc2l.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: Re: [PATCH 2/4] http-fetch: allow custom index-pack args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     steadmon@google.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Josh Steadmon <steadmon@google.com> writes:
> 
> >> +--index-pack-args=<args>::
> >> +	For internal use only. The command to run on the contents of the
> >> +	downloaded pack. Arguments are URL-encoded separated by spaces.
> >
> > I'm a bit skeptical of using URL encoding to work around embedded
> > spaces. I believe in Emily's config-based hooks series, she wrote an
> > argument parser to pull repeated arguments into a strvec, could you do
> > something like that here?
> >
> > I'm sympathetic to the idea that since this is an internal-only flag, we
> > can be a bit weird with the argument format, though.
> 
> We tend to prefer quote.c::sq_quote*() suite of quoting; does this
> codepath have very different constraints that require different
> encoding?

My main issue was that I needed to join arbitrary strings and then split
them, which is why I URL-encoded them (so that they would no longer
contain spaces) and then used spaces as the "join" separator. With
Josh's suggestion, I wouldn't need any sort of encoding or quoting, so I
think I'll use that.
