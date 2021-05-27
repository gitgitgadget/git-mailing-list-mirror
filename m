Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C876DC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAF1611AE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 18:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhE0S3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhE0S3r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 14:29:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C1EC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 11:28:13 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u14-20020a170903304eb02900ec9757f3dbso370650pla.17
        for <git@vger.kernel.org>; Thu, 27 May 2021 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eUk8ZrfP3FU0wUtp5VvOwM6xqr+OmQHFIqK5AzsDQTk=;
        b=aJlz+XsxiauXtABjKw0Hytdb7gvUg5kip73ZiR0VdKNqu1xGlTqexajhaX87WBm28e
         Il0kfZ5nNUYH6bjr2o1khmYoW3vQ6tVCNsbWFWZ/YRg1m2in2NpVxKEA4poXLcbGIOSb
         8q1r5eLyAIBpQ+u4devqdIbiFT7/vXMsCQfXBj5kPmyAs+x6sbu87Z5iOoPLhMzkHfzU
         qUiFJtbvM9+5Bi7iwbRbfsQloy/+BUZdFjCjnVH4Vv/BY5eqyNpyCTzk57vmVxjL/8To
         4IMDmIm5Ypg09QyG3f8bB/5HFyAR5loG+qMqE/L7aeqhs8TTnZ6VRteUfJXLQdpCOIZP
         lQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eUk8ZrfP3FU0wUtp5VvOwM6xqr+OmQHFIqK5AzsDQTk=;
        b=Oyd/PfnHCCw/SkBGtOWmMsoIAhh4ewWQayIMCOZlhoefxOzEsoCkkBCOJ9HL16C2RU
         fjv5RRDmtLvDKoUggh4xyGNpMstl8jbxPC7nJPw8YuOm570pvxnHUQt3C9Ssv+LOm2vO
         zpTgxo4d6fq+8Evvg2mp/3pte1GMxMh82o8sZ4AuMmvXz6UUILqBflMZexnm5HE5GoWn
         oy7M0rQQQD/LZ/AdK6Zop8a67tHDDEL74ZggMC/wx7lkwoHUKd69XLvivRZ22UzFIZWz
         WOOLGkx2M6UNsEtUOUI6yi2K5J/+QUAulXFdhCxbCdbApVFQ6+E2/sNUUdhfwasO/Djc
         risA==
X-Gm-Message-State: AOAM531gUeXwmwwp+MgnkYTEFfl7HZW1PKu4CXB/V6AniVPn9vIrwOKW
        BzUI7FY3BYXqpRgs0SLfKkVE3qej53sGgdrOhN15
X-Google-Smtp-Source: ABdhPJzDpT/PjgpGtk8YUdsxUfvQVfONZX/vZIm7XEDIDusV+YDRH1NJv2TLFbllAsDzjFYlItyf4oLcRJH5+rOIApLP
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:a794:: with SMTP id
 f20mr10864024pjq.195.1622140093144; Thu, 27 May 2021 11:28:13 -0700 (PDT)
Date:   Thu, 27 May 2021 11:28:11 -0700
In-Reply-To: <patch-17.17-c5e6686765-20210520T111610Z-avarab@gmail.com>
Message-Id: <20210527182811.2682205-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-17.17-c5e6686765-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH v3 17/17] fsck: report invalid object type-path combinations
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        j6t@kdbg.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Improve the error that's emitted in cases where we find a loose object
> we parse, but which isn't at the location we expect it to be.

I'll hold off reviewing this for 2 reasons - firstly, I don't think it's
related to the other patches that are about reporting a wrong object
type, and secondly, in the case of repository corruption, I don't see
how useful computing (and reporting) the hash of a corrupt object is.

If someone else wants to take a look at this, that would be great, but
otherwise I would suggest splitting this into its own patch set.
