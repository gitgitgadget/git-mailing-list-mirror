Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0AAC433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 12:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE8520708
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 12:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7Z4kpmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgHPMYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 08:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgHPMYP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 08:24:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55027C061786
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 05:24:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so14506491ljc.10
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 05:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uAo9M6IF+4UmEf7zNr05kXITDb57B+bSjZeu3lOLhA0=;
        b=q7Z4kpmoO8mJCtXv6CW1aTcj4bqSRnmTIq0phhcy+27Uz6kh5c3XrVvqo7XMnR2hVT
         nVBrXizckTvllWIBEkG/QKrj8TH/lhaLOKPw4WPNL7cMLhQKu7/YDPcIiNfiHmNgtL8z
         YtpjaJJgT2N6kDKR94YS0Wb/Ok/OlH4IH6WxLrzZKIgPqMrdbG4S3D4kLzrYEQAuefg7
         DWVaIIumjXIlQLnrMyNE8zUuPD3rLH9ArHWdlOBioaAWTJbGw7Q/MgoCOJfC3fqAKNSZ
         ab/AZQG4Z8jNPMb3EWhfvg3CdKErjLQ5Amu6SouAb9kJaOCw4LQkC3gbqfpEP2KZBOdF
         YzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=uAo9M6IF+4UmEf7zNr05kXITDb57B+bSjZeu3lOLhA0=;
        b=pp2++esu6M8cqzb2LEvK4YxQovgczGvnj1V+nPB+3DTSYvFlFaxhcH0IPIOfY5toWI
         sR66PzzePsQYghQYMz4VmhfZk2EoNNrGODbPzccg10B3L1VrpvJmrngp/KGyPByYTa+V
         MdWrbt6YLIuHJ9J0g0iiQZKDwiWibrO+9ik0ZJ3PRxtGSHJtsrZLzQllscGelkSduVV1
         1gG9VbUg1fgF5yD5/QvOUfh/M96J8TmT0NkWHmoiAkxrlghCGmM4jc6hVbQaVv+kFPpv
         FG3PBbq7ohWomm+83W6M+PIg+OmGj4LCX/zXHaRJMg0ELFhSFAjA+3tZ3NgqzikyAFRd
         qpAA==
X-Gm-Message-State: AOAM533qYnqKxp0S15pMuTCSBDr0k0RJvyd66K1xHQ/ziZlUes4B2UDP
        HNNcVyqRQPpstVJWdihn2uQ=
X-Google-Smtp-Source: ABdhPJwJ5oh1oP1+5lNUU6UncgtjLAOU/sOIRApvyJUaR5/nOup01u/jAYKyUxGv8l+shzJ1AV5NzA==
X-Received: by 2002:a2e:910b:: with SMTP id m11mr5326181ljg.159.1597580651547;
        Sun, 16 Aug 2020 05:24:11 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f23sm3596739ljk.74.2020.08.16.05.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 05:24:10 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Altmanninger <aclopte@gmail.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, solly.ucko@gmail.com
Subject: Re: rebase -i: quick/inline reword
References: <87sggab031.fsf@osv.gnss.ru>
        <20200816001401.1144752-1-aclopte@gmail.com>
        <xmqq364n5f0b.fsf@gitster.c.googlers.com>
Date:   Sun, 16 Aug 2020 15:24:10 +0300
In-Reply-To: <xmqq364n5f0b.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 15 Aug 2020 22:36:04 -0700")
Message-ID: <87imdipymt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Altmanninger <aclopte@gmail.com> writes:
>
>>> >   !f() { GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash "$@"; };f
>>> 
>>> These are very good and useful features indeed, and they are examples of
>>> batch processing that is very handy for automation, but lacks
>>> interactivity. What I rather have in mind is being able to put all the
>>> messages /simultaneously/ into my favorite text editor and edit them
>>> more or less freely till I'm satisfied, then "commit" the overall result
>>> by passing it back to git. Essentially "git rebase -i" on steroids.
>>
>> git-revise is a third-party tool that can do this
>>
>> https://git-revise.readthedocs.io/en/latest/
>>
>> For example, "git revise -ie" allows you to edit all commit messages in
>> @{u}..HEAD in a single buffer.
>
> I only looked at its description but the UI the tool does it with
> looks quite obvious and intuitive.  From its source, the "merge"
> operation does not seem to handle merging a side branch that renamed
> files, but that should be OK most of the time, I presume.

From the docs:

No merge commits may occur between the target commit and HEAD, as
rewriting them is not supported. 

>
> Nice.

Yeah, it is!

-- Sergey
