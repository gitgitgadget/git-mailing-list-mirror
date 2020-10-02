Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7062C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7FB206C9
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbr+K+OO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgJBVXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 17:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJBVXV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 17:23:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21855C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 14:23:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v106so3027317ybi.6
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 14:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=M2fp1TQlYHHlKURlW+UU15i0JhtNGkpBSZlAdk8bN7Y=;
        b=fbr+K+OOVqY892I0C0FrxHu6Fe9nRiKA8p3F/coVRLYdAnDMWFWgs5YCjiaFclfJQi
         o8BGMsQBjqHBmW4bZ62S+uaTp8JGceCKb4VgJC2dQuGlaym20U13aVaMaOTzFOWrNI8v
         swgPyeruatfqOuSEC8GKZGg1KQu/429rpV5d2OW4mC9qaTGzZbHbk7LawYY8KGOV9sVa
         inmU5jvRB3q7SURM6i3YtXaElrmXRWFI1utVahDSPOJM2wXKGg8ywUckmFC81WZzccin
         TQmnytBbHmNUHTZ9v3lfEY7V2WSegfCBkjOBnO0qpdg5qsnLZ/k5ZV9nmxWDLhdEQ2Kv
         DWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M2fp1TQlYHHlKURlW+UU15i0JhtNGkpBSZlAdk8bN7Y=;
        b=APpqD2mItuvJQ/NCc20c/joQvSMqGjdtFV/SNND6K2LhJ4bMdvXKPu0VnV1G21H+M1
         U1KSEcUrkksbxRKcaHpx7rCnsaDABIlvO4tsSP+Z5fJOKOhFl3JaTGAbewKHTQ4xvo25
         EkXxVF5OuFBrd1Q18HpPLOtEOOsnDAv66TY6WMqj8a0KFmvjFip7JwIC9e9Uob757bpW
         3Nmk38MhLDDnxOM1no+Qd7psEU1qFe7r0bgDxT3V1nWCwfQ7bFj/jtVjZz4F/ZvWJvuT
         BZ7N3mwBftCUPi7/2B9NrPsE0unENqUKlUxvu53ir/RNxP5oJKrMsqhFtYRyp+LJmt/V
         pnZw==
X-Gm-Message-State: AOAM532QORvjjApCo98ruAcjBzEUSLHnK2FTeaXgREAUvU2/zHAjP2pO
        G4mhwul4RAoHemDTO2qsXGalD7YcSee8
X-Google-Smtp-Source: ABdhPJwFaSMVUndreQAbjV3DGbQzhQTsouAaAj3qqfDtE/xNdYz+Xo7k4dA+J5wh10vGcta2zdUqftvZPGUj
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a25:f8b:: with SMTP id 133mr5734754ybp.365.1601673800315;
 Fri, 02 Oct 2020 14:23:20 -0700 (PDT)
Date:   Fri,  2 Oct 2020 21:23:19 +0000
In-Reply-To: <xmqqlfgqes95.fsf@gitster.c.googlers.com>
Message-Id: <20201002212319.71516-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqqlfgqes95.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

Shengfa Lin <shengfa@google.com> writes:

>> Discussed with Jonathan and Junio regarding whether we should support
>> letting user specify timezone or restricted to UTC only. There was no
>> defnite conclusion.
>
> I do not think was involved in that part of the discussion to
> consider UTC vs custom zone, though.
> 
> What I said is that git () { TZ=UTC command git "$@" } is simple
> enough that I doubt it is worth the engineering effort to either
> read configuration file early (which is tricky) so that setenv() can
> be done early in cmd_main() and/or audit the codebase widely enough
> (which is time consuming) to make sure that we pay attention to the
> configuration variable in all codepaths that matter to do the
> setenv().

Thanks for clarifying.
