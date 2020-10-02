Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFEDC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA42206DD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJwKH3/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgJBGhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 02:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBGhS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 02:37:18 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EC9C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 23:37:18 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w126so404181qka.5
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8yDgCeW4dMLbXSRj+eFnURAAz1BJ0RguYCCf5R9gw2o=;
        b=jJwKH3/qo3RlNOJdTTLS6QkCY20HBwyvWwZlUtxGumNW663adYEX6qeqFDlwrdCwBT
         jz1Dp1/Uq/hD9gIjEl58DHbNl9rVM2UXa+6V82SDPPNpYeXp7fWM9CAg/XEYBTiRIT3G
         CzcvqocMX1Y15bFphbGP7Oza6EKHBVqHBXDEgWSUUpVxgz6VppYbciPL5LTf3UoIcW3z
         OUuc0IZq0zMsor66+16x1XyoD2a4VVWbIy93bju+dXHq5HITOEVJ8//kIz9E3VSw+/yz
         PHRaCASmhOFi7YtmOTVYwKJW/EMzGeuyvaDxeKPxXsuJzIaCX0gP35p3+ac5ZW2MMSIY
         82qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8yDgCeW4dMLbXSRj+eFnURAAz1BJ0RguYCCf5R9gw2o=;
        b=TAuuk8ilJ7pI81+M52e/WpxVUXB6BnHJkqks5mYg8VztV8pmXLhK0Zm4eWnwBDfBBI
         aDY1VaZ4TibxPJC2dMXnUd+0F/Z0bjmX5E61BJPr14Ff0gRA4R4JYBqSPW7s03av4IVS
         OYwg8E6stmmL22jyry5aia5DdaC9dp8yqsFU8fibX7Xbo1qvuNF5RGpmNvHEMiCapRhy
         vyxftuTI3z6wh1a9AnUqBzoR5WihAqZNuXUrNm1WAlE+W8P5k/qMiDidCCZHCE2ed7BA
         sBYS0o2a0+TsGg8m5rRqt8V2SEz98rpEcl8Bi6redf+myHZsk52U0NwbcdCWjZ/BPYUn
         v6Ew==
X-Gm-Message-State: AOAM533kztqxrb0nfo5S4NDLxdnAJMGddzfq3R8Ss9mh3EXwIU5E2CS8
        VUIzoS75JvLuqRZEhbpI7Pssp8b399ao
X-Google-Smtp-Source: ABdhPJwrs2YgdI495QKOjNexANFxodKqqLY2VyAtEuctY8uYlSx+DBZGDPz1ad2RCUKBEkvINMkFekECnlsc
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a05:6214:9a9:: with SMTP id
 du9mr787916qvb.25.1601620637185; Thu, 01 Oct 2020 23:37:17 -0700 (PDT)
Date:   Fri,  2 Oct 2020 06:37:16 +0000
In-Reply-To: <xmqq7dsaeqij.fsf@gitster.c.googlers.com>
Message-Id: <20201002063716.4087336-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqq7dsaeqij.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> 
> I think (haven't actually tested) "git commit --date=<datestring>" option
> is handled the same way, i.e. comparing these two would be a way not
> to touch the environment variable.
> 
>     TZ=UTC-09 git commit --date=@1600000000 ... &&
>     TZ=UTC-09 git -c user.hideTimeZone=true commit --date=@1600000000 ... &&
>     git show -s --format='%aI' HEAD~1 >output0 &&
>     git show -s --format='%aI' HEAD~0 >output1

Like this?

test_expect_fail '...' '
         echo t1 >file &&
         git add file &&
         TZ=UTC-09 git commit --date=@1600000000 -m "t1" &&
         echo t2 >>file &&
         git add file &&
         TZ=UTC-09 git -c user.hideTimeZone=true commit --date=@1600000000 -m "t2" &&
         git show -s --format='%aI' HEAD~1 >output0 &&
         git show -s --format='%aI' HEAD~0 >output1 &&
         test_cmp output0 output1
'

I tested it.
