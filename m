Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AF3C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566D260FC0
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhIPStQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348443AbhIPStH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 14:49:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43086C094ACF
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 10:26:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 41-20020a17090a0fac00b00195a5a61ab8so5412923pjz.3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o/AY/65x9ZEzjDWufGzXKy7v8OAUoDkzPtjN0fwapPE=;
        b=CaW1sf0IytCIntA1u//6H1BMtHWcmqnZCVn3pe1yDUW8l6YIlGFHw4X4E8LjD6HdNf
         P55Nddayyn5DPzulW750XtD7GnY31/EO12otn+qF1UEd2j02sFNNDoGbknjsgpgKf85i
         ft8SOWw1PA60NytAaE+lDT8z4x6OXE9VUNCxB3SZz2QISu63PCCt3evKKqPIIk5FaAKt
         B8GXXVe/+dhNkGuZHUIfzqPFlWPkd3YIJQ+j6tKeCr6WhZ7vlmoREAh9lcS+iDgfG+8q
         eaomoJCFZc8zIRb+1GW1BhwBThuw/RrRjt96NrbxwTYCAZB0p5QE6U7xbOqvwGuTWzCl
         ENtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o/AY/65x9ZEzjDWufGzXKy7v8OAUoDkzPtjN0fwapPE=;
        b=4Pz0PH1xOThw0/bKpLBoCi21ockc7FmqIcFpFhFFvRMjV5migxB5jk9qZb8DMfiyDE
         N2a/OJaRge6PmsizHVOO5/iNEKY9PBT4SYfknAO3a/5+FP7IqdYIZGWC1wMzvYs+Znlf
         lJRpQQIVH+Wlft1NRU359u/skyf+4chkvAWL5UpBC/Laruht9zrWPgy1KBVMJp9NCGKE
         MPzO9Nn+GKsaUhVTdsya+ilxFZnatQnDPCDSHrALksfI5L8pvaAH8hpv2gzVVz36Vxxz
         v/IsPthX6whN78zhzYivP9VHSn9YguME2NddFsZCpzr/sHh+sKBI5tL81P0LrgzrXpIf
         JVpQ==
X-Gm-Message-State: AOAM530kynkxvTDnf53BacCGdhxGQFlXWguq4YynJ02MzICe8vzhoZSm
        Cf3ZUk2OPtx0ol81Fi8UuMsvIbCP7ovCcL3btz7Y
X-Google-Smtp-Source: ABdhPJx135B85NxVL2w//e64nocYCdlEpkBVep/LK49r4n1MWq7AQYkXdp2+D926RMzoDU3HgZXLRYdnx2PmSdKvsxRs
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:97b2:0:b0:439:14a9:2bf5 with
 SMTP id d18-20020aa797b2000000b0043914a92bf5mr6152461pfq.45.1631813171751;
 Thu, 16 Sep 2021 10:26:11 -0700 (PDT)
Date:   Thu, 16 Sep 2021 10:26:09 -0700
In-Reply-To: <CAFQ2z_ML_g6DTiG92srq8UCCu_D8bi6z1mP_znt24TJagVfi2g@mail.gmail.com>
Message-Id: <20210916172609.1074157-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAFQ2z_ML_g6DTiG92srq8UCCu_D8bi6z1mP_znt24TJagVfi2g@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: Re: [RFC PATCH 1/2] refs: make _advance() check struct repo, not flag
From:   Jonathan Tan <jonathantanmy@google.com>
To:     hanwen@google.com
Cc:     chooglen@google.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Sep 15, 2021 at 12:41 AM Glen Choo <chooglen@google.com> wrote:
> > In the current state of affairs, the files ref store and the packed ref
> > store seem to behave as a single logical ref database. An example of
> > this (that I care about in particular) is in refs/files-backend.c where
> > the files backend validates oids using the_repository's odb.
> > refs/packed-backend.c doesn't do any such validation, and presumably
> > just relies on the correctness of refs/files-backend.c. I assume that
> > this also explains why some functions in refs_be_packed are stubs.
> 
> The loose/packed storage is implemented in terms of files backend (the
> public entry point) that defers to a packed backend in some cases. The
> latter is implemented as a ref backend, but for no good reason.

Yes, the packed backend doesn't need to be a ref backend.

> I think Jonathan is right, but I also think that teasing apart the ref
> backend and the ODB is premature until the ref backend itself is a
> strongly enforced abstraction boundary.

I think both efforts can proceed independently.
