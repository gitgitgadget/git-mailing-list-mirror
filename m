Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD20C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 18:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FE421548
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 18:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq8F33i7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbgFSSOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732226AbgFSSOb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 14:14:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0AFC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 11:14:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e4so12555813ljn.4
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hwpRSLFQHujyED6ESsBrU+hkmtGERCqxP0g+3Irw2as=;
        b=iq8F33i7npUpUDSvXouKD8VC0Zohve7kO9Spx1djdC2r5wdAls5tIGui7nRc/4GWLi
         mD1jinnUtCt+Tw8PD1Jcu9qIYCPkFfiOwsklQ3FNivZDQWy5Jcss2HU4wMrtXV3URIaa
         f7EzAEQONwNty53a7JxgRgvZ3tBU5a6CUAl+GR9tbyFlCgRXlxt1m4wLLTQJN9MLk3YC
         yax9GXzfoDOEM5KigqNMf3ipjjgYmHYdIOOhzRPy/2l0YPkfevHSUh141PPqdsAYxf7E
         8DrVe38h0HgDI/RZpL+kqrNk/+aGtmUe1OekARovWYtKaK2jVwU9HQY7uLEUL11FiRnC
         WyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=hwpRSLFQHujyED6ESsBrU+hkmtGERCqxP0g+3Irw2as=;
        b=YTaiYntkVCyJ+7ykQN2lednrzkwtm7xWcOli4I1259qeL/oIKgZh2guSFD0AtDvucQ
         VfxIkLd4URxP0dJyt7/5O7PEf5AkzSKsBev+ZmelQJ0MryZLedcQaqG+tdbWfgr+J/4P
         YZazoAA5sGbNu70XQJXqiFc/LZIBgRJFk94Bjk0kyKN7K249MdoyqGIS9wgItOnRxBzv
         FQBg5axsCIDmmWcI+vT5+w36AqINcs1KFSz4ALBlr3lTeS2xoAlsjC6KeGnYoUu2d/i6
         WXr7qqtFPyMtur+nzPQE4quTZNTHA6Z9c8IupeWWqyNpznqEumozfC2C4Rl2lrdOZSRN
         ac0A==
X-Gm-Message-State: AOAM533jsv+NG9Vs1g5euGd7gedJ66M6V3CtoHBQui7fUNaKXiCMawBf
        9wfluRVAyFLmFKu9G6cvFMOPK2c+
X-Google-Smtp-Source: ABdhPJy6QY5gcoTNifwGGOQXc8aLeZ6g03sv4sa9y6m6U4vaLtoRABnsKW4Sx08fTC1oTELkY6S56g==
X-Received: by 2002:a2e:595:: with SMTP id 143mr2395977ljf.67.1592590467597;
        Fri, 19 Jun 2020 11:14:27 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j26sm267620lfm.11.2020.06.19.11.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 11:14:26 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Annoyance wrt ref@{1} and reflog expiry
References: <xmqqzh8zgcfp.fsf@gitster.c.googlers.com>
Date:   Fri, 19 Jun 2020 21:14:25 +0300
In-Reply-To: <xmqqzh8zgcfp.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 19 Jun 2020 11:03:54 -0700")
Message-ID: <87o8pe3ou6.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I have been disturbed by this for a long time, but not strongly
> enough to do anything to it.
>
> This sequence works
>
>     $ git checkout -b newbranch
>     $ git commit --allow-empty -m one
>     $ git show -s newbranch@{1}
>
> and shows the state that was immediately after the newbranch was
> created.
>
> But then if you do
>
>     $ git reflog expire --expire=now refs/heads/newbranch
>     $ git commit --allow=empty -m two
>     $ git show -s newbranch@{1}
>
> you'd be scolded with
>
>     fatal: log for 'newbranch' only has 1 entries
>
> While it is true that it has only 1 entry, we have enough
> information in that single entry that records the transition between
> the state in which the tip of the branch was pointing at commit
> 'one' to the new commit 'two' built on it, so we should be able to
> answer "what object newbranch was pointing at?".  But we refuse to
> do so.  
>
> And it is unintuitive.  It is understandable to the users that all
> the ref history before "reflog expire" is lost---it was what the end
> user asked Git to do.  But after creating one commit on the state
> (or do anything else that moves the ref) and finding it regrettable,
> "git reset --hard @{1}" should be a viable way to recover from the
> mistake made _after_ the reflog entries were expired.
>
> Opinions?

Makes sense. The first solution that comes to mind is immediately record
current state after "reflog expire", so that there will be 2 entries for
the case in question.

-- Sergey
