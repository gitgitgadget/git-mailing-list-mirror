Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD61C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 18:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CDB22A83
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 18:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbhAUSh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 13:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbhAUSfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 13:35:10 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C385C06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 10:34:30 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id q200so1760815pfc.14
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BFd6KvjRbuf7zF5OQkgOMYbuRHMefY+pfBk6wOwSykg=;
        b=F0n7ZClXpTOLV5Rsib0RNMw+UU1Vpv9DieFCHmU1AmkLGOF2U1V3vRD+FvSHepFuHL
         JHDjvD4zprZu4FnlxCoZA6CzjXpcFCpHL2r1lkxfO4qGnOdtdof9qFJa+mfIYF4fUflm
         WcABwdtne9yEwBxCVIxK0T2AwK5j84g3o+aE6kWV+7QFynCfBGeQU7n17yyscJ/RliFe
         7J2oxm6F2mfOUIF4Jjfry4oe15uh1/gqqaNFj5YPhWcOCje8IgvqYaKosYD+MnjTT2Gp
         Kn8EqULR0ZNo/fCGMAgb49KPeuY45ed6AVB93+KpRnIiDRH6fJN56AQ7KJ6OgDt6Aw/I
         wnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BFd6KvjRbuf7zF5OQkgOMYbuRHMefY+pfBk6wOwSykg=;
        b=Jp4iSqUvOsXegcaAIpgnJovkY7biOgHDBk4jUV4hBRTH2w90czWjQFJn747gHbk+yW
         Z/+VAzMUbphVCRqE5w5Ls7CivlDS0rGFC3xku/CCXfdY8DofQ8wP/GoCFk9nMBdz6hqG
         UbUnR+q1D4dLihJxRgVmyk/vpaCkc/VRkyraGlMGWWWcnZKGKZCLjCzkvYocrSQY8K9q
         Nh10Rw2Pcjzjy0OdN+i4hqGhHLHhPD7DmL1C17/1wmR5/0U35cCS8UIgjN++57ZAN05a
         UHylNAfKi0NuzV/Gg+scSteoNRmjeyn6SxpRcJihX7OLo1iAEK0ExMAfVuGEquvHI60t
         LQvw==
X-Gm-Message-State: AOAM5305S1IcVHID64+bE+FJSb7yWYYNW6518zJ4HaypUDMPgLVnqfRR
        URXO/2z3ILVqc0gLP4/buAtxj5EGEhH78TAOR1Rq
X-Google-Smtp-Source: ABdhPJx1yakWslmmJ2CxbI8f74CrRLmvnlA5BcvvMBdnuQ0tbsPWDPJvE13Uuzs0SlJ4rTo7WMjIp2eONaSlxbggSFLG
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:8fd5:0:b029:1bb:4d06:deda with
 SMTP id n204-20020a628fd50000b02901bb4d06dedamr696259pfd.24.1611254069419;
 Thu, 21 Jan 2021 10:34:29 -0800 (PST)
Date:   Thu, 21 Jan 2021 10:34:27 -0800
In-Reply-To: <xmqq8s8so84r.fsf@gitster.c.googlers.com>
Message-Id: <20210121183427.1783539-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8s8so84r.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: Re: What's cooking in git.git (Jan 2021, #04; Sat, 16)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jt/clone-unborn-head (2020-12-22) 3 commits
>  - clone: respect remote unborn HEAD
>  - connect, transport: add no-op arg for future patch
>  - ls-refs: report unborn targets of symrefs
> 
>  "git clone" tries to locally check out the branch pointed at by
>  HEAD of the remote repository after it is done, but the protocol
>  did not convey the information necessary to do so when copying an
>  empty repository.  The protocol v2 learned how to do so.
> 
>  What's the status of this thing?

Several people have commented on the high-level approach (and I have
addressed those comments), but I don't think anyone has said that the
code itself looks OK. I'll see if I can get some of my colleagues to
review this.
