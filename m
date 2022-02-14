Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA88CC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 02:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiBNCwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 21:52:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiBNCwa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 21:52:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0EC50471
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 18:52:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m10-20020a25800a000000b0061daa5b7151so31115185ybk.10
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 18:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3PVEXZIANuUAuarM1Fffez+QRMiAUm1qdMcgOkg/jmg=;
        b=rzz3IV5OUieM9KKx8w7FeBitljbeQDpsu6l9W/tFGieYPSVw6wGTCkabqms4cBTkST
         5eytWwIBXLTv3uz1SqlUeXhME1KinimR/12gUvxbrOONfoGOajEoPiSAxP9934SQS8Th
         zNOdkV2m3xb0SM6Mj90cD9EFhhrHN4U1E41kAhUTLHSYFTshrBLClmGJ2kEd9dN18iaK
         lyCKdAxmimbF4pYu8uhrwpkcmufoUCL8NjXG2I88j1TLb1pbunoxShh8llYk3/FmXmuI
         PgWikANv8TjvR7OG2yoM9+2EIjjG5NQ1Srp3uMeQNhFq3IiJ0mNDtlugNIPNix/Mu5kf
         sQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3PVEXZIANuUAuarM1Fffez+QRMiAUm1qdMcgOkg/jmg=;
        b=GZhdVci9I2HJHR9jtAnWYy527TnBv8he3JCIUS4zsFitJZtArwnd0MpLKqut7MBXAk
         AAREhVpktOZ8vf1AjFJxsvswMLkzWvk+EJ9djE+n+6JKrj0uYyTRyPcKfeMT63cueCKD
         GT3yqAe4dC9njeadTQzPGDDmHdv9q3r1sDbbApB+oAnN6msg2ww5UHIqHs4owsga7zWd
         0UjWrAXVmN2ZRq/e9GiRlHP0679eFNnKkyHzpf/D59JB7T3q0hZi0Ovj1uGf4pMOQPoN
         m3wezyFsODMLyhezHiaS6lQZchOnHrCAhZbBPVq8oRGEB7nxDE573DOWaDy2c6LD1AQ0
         R2Zw==
X-Gm-Message-State: AOAM530y2k12zth/VZn4sihCys3va8yMFlT9e0sqNPCtuhA+iTnW7uiB
        3PzX0xdMvuU29yqn7I1ZyPuzANp5TNFy0g==
X-Google-Smtp-Source: ABdhPJyGb+3/WBTDvOvYdVBeeI1zmRbnN/vQmNOuOhfh9AmsP9o7u1IBQ48gS/uXMsHG7zXlZR6fi1I3KU9GkQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:c794:: with SMTP id
 w142mr6401551ybe.632.1644807143502; Sun, 13 Feb 2022 18:52:23 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:52:21 +0800
In-Reply-To: <xmqqy22hcodn.fsf@gitster.g>
Message-Id: <kl6lzgmuw462.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210230422.690368-1-jonathantanmy@google.com> <xmqqy22hcodn.fsf@gitster.g>
Subject: Re: [PATCH 8/8] submodule: fix bug and remove add_submodule_odb()
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> I would write the commit message like this:
>>
>>   submodule: fix latent check_has_commit() bug
>>
>>   check_has_commit() will attempt to clear a non-initialized struct
>>   repository if initialization fails. This bug is masked by its only
>>   caller, submodule_has_commits(), first calling add_submodule_odb().
>>   The latter fails if the repo does not exist, making
>>   submodule_has_commits() exit early and not invoke check_has_commit()
>>   in a situation in which initialization would fail.
>>
>>   Fix this bug, and because calling add_submodule_odb() is no longer
>>   necessary as of 13a2f620b2 (submodule: pass repo to
>>   check_has_commit(), 2021-10-08), remove that call too.
>>
>>   This is the last caller of add_submodule_odb(), so remove that
>>   function. (Adding submodule ODBs as alternates is still present in the
>>   form of add_submodule_odb_by_path().)
>
> Looks more clearly explained.  
>
> We still end up calling add_to_alternate_memory(), so I take the
> "let's have this early" back.

Ok, so I won't send this patch separately. Thanks Jonathan for making
things clearer :)
