Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F71C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB816103A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbhHMQok (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbhHMQok (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:44:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABBAC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:44:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p71-20020a25424a0000b029056092741626so9636815yba.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i4UnAyCqvBhAtc7SSis/9JAcWupprO/NYmHbf2a7pws=;
        b=UunanQs8ebJkJVW70hbRb+V4ueKbIBHzt1Fm0az+bI0utLTNouSUANBGGe7kGzM5O4
         x2LT9vPsYYMWvBONnuwy/ATZ9DcCHAkSkzc2BgY6BQiVnUnODBR0slDmIWWT8WdifMys
         MWznULzQrc34HOT/PPjRNkqr8jjJ8Of/ttOtMDCurpL3mYELIsKPkK90NTbGsNTJ5yB9
         CiGOsN77vWAAocVxZjG8jD29NB6ZEsQd4M2sBO+SbWF3a2YXzA7/O9+nQ/17FtLnGthD
         YW3cZ4E5j53qX7Plf4PzSiYbHHGkYin7L0EAJT1xV+W9z5Ld9ZoFXAWcqlP0SKy/2BOT
         Apdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i4UnAyCqvBhAtc7SSis/9JAcWupprO/NYmHbf2a7pws=;
        b=ipmjpSlArPO9fs2HSwwtxBxkrVxbNP5UTbQOMWhn2d5Iay19Vnrfi1kKm3nkGiAnXT
         GgMEPkKMOoP393DQHidTLyi1OchOwdCA6iAOeLKl56eN+fesskthgDeyyJfpdCqG6hI7
         2OmAL7R4vbHbwmeAm4OYG9hq7k4GiRLDzMwCbn4eeVFZp1aW0VSFKjg7LAeA1DeUHe6S
         KL43VCm6PUaLsSPaSVNmCKoKT5HgzYjDoHThn/bhzWJwuOcoUSg4Wjq0qnDicxc7p11k
         r9O6WBU9Fdo/Luk45BU7C9URZd66xr/QJ1pY0Oapkwx3SMpKjEmjvWawQzmD8h7b0V4K
         Mflg==
X-Gm-Message-State: AOAM531AIm/JMNfTo+nk45qhnajN4v3XoWw6pA8b9GKVEvslPsLMOWm5
        6ol4+vz/gp2PBCEBhasdQM2fhxGRKMxCVDYXUHKG
X-Google-Smtp-Source: ABdhPJwoL2bLugVaZ5DlfdoTb27t+iyZkYTe5YQ/gYRqrmitqYxNZz+zPITC2AH91TbvFlel+9XQ3ZzbxRyk2vbiHfSY
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:3889:: with SMTP id
 f131mr4213009yba.422.1628873052261; Fri, 13 Aug 2021 09:44:12 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:44:10 -0700
In-Reply-To: <YRRGrKztksYi8of2@google.com>
Message-Id: <20210813164410.3219275-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YRRGrKztksYi8of2@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 6/7] grep: add repository to OID grep sources
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Aug 10, 2021 at 11:28:44AM -0700, Jonathan Tan wrote:
> > 
> > Record the repository whenever an OID grep source is created, and teach
> > the worker threads to explicitly provide the repository when accessing
> > objects.
> 
> Since this extra information is not used by this series at all, does it
> make sense to only include this patch with the series covering the rest
> of your partial-clone-with-submodules work?

It is used by this series - it prevents an instance in which the
submodule ODBs would be lazily registered as alternates. I'll add a note
in the commit message to this effect.
