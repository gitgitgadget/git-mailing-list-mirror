Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A0EC433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 23:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbhLEX74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 18:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLEX7z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 18:59:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC9C061751
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 15:56:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m24so5909080pls.10
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 15:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=APRV1Hkx7REflHTCYTXSjpHaRagc7r+EvvxUolmpfbc=;
        b=Zffgxv6XKOZ8LUclRVHkxNpbhTwPnBkdUWQ30+4lWMR0tpie0iMzeGDuEM8ADbOfgd
         UNCzJP9vUTf4zJBQPw4Wc4SyWisit/kj+kwS+d7QJmpH1/LP15ENJIgQCMoNMhBaU72l
         xIO5FGUviPxe9fWq3vhg9ISLOLKM9E1UkJJ/Sr5YgMD96aTkiIP3ZDyZ8uvZRpji11cW
         5C4MF+IqVFrSRhFYb+p4aKP0T/8vxvNSQQlBnVBFhQ23vqY5yUog2Efj3aEKRtq8P/t1
         WO6lniNwsvlKXyJNFf+ANec72VDLdK4oG/AphPm57PgQg3VRflOKQrjEu0G0CQLhTzUF
         yaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=APRV1Hkx7REflHTCYTXSjpHaRagc7r+EvvxUolmpfbc=;
        b=pd21eOWbIM8DBYsvINUvUyhD34J2sDezrxR9XYShvzLhE0HjNWiWMRekg5bDUL1jdq
         AgxVyJy2++7kH+5nQ36lnwUPLO4ZItWrYEt5qEWra960wgU/PMwHI4zIMbXmXC4Oo7mp
         CAJntPxYBxxJoTi62FFWNS2PwuBMQgxJdjx1P8sq7xDc8b8gmivWpO7YHGdDA6iKQ0UQ
         MuhntYMVOSQ3+Sxtz2Gr0HpLDmH1t5ATgZqs6+sTya0oPQBqoShL9oLcvitFGk1DJ+sK
         P/IYoXQ4U+Tj0KQnIjZxN0lo1Snwf6/MEZBB/zUcxtT8fk7M1K0eonDyIWu/lD7pwcJQ
         Sg6Q==
X-Gm-Message-State: AOAM532wWBei0ABI+S806abpPruFNI++/eKj7p80QHFENrbShZWT+u1h
        dD0a5twe4hyvJYeKN8lA18U=
X-Google-Smtp-Source: ABdhPJxmEZmk+rVyvHKp3IBJyMciYcqroYkJ+RMhYZDkRa94x1wJ2mKPExvwKYlcsCiSiviNyKgGLQ==
X-Received: by 2002:a17:90a:8c0f:: with SMTP id a15mr32796180pjo.25.1638748587174;
        Sun, 05 Dec 2021 15:56:27 -0800 (PST)
Received: from localhost ([2620:15c:289:200:33cd:af64:d2cc:36ad])
        by smtp.gmail.com with ESMTPSA id o124sm9944177pfb.177.2021.12.05.15.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:56:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] tmp-objdir: disable ref updates when replacing the
 primary odb
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
        <d8ae001500c788cdabf4e6918da0a7ce89a48fc6.1638585658.git.gitgitgadget@gmail.com>
        <xmqqtufmlxmb.fsf@gitster.g>
        <20211205234408.GA26229@neerajsi-x1.localdomain>
Date:   Sun, 05 Dec 2021 15:56:25 -0800
In-Reply-To: <20211205234408.GA26229@neerajsi-x1.localdomain> (Neeraj Singh's
        message of "Sun, 5 Dec 2021 15:44:08 -0800")
Message-ID: <xmqqsfv6ip1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> On Sun, Dec 05, 2021 at 10:23:08AM -0800, Junio C Hamano wrote:
>> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>> >  	/*
>> >  	 * This object store is ephemeral, so there is no need to fsync.
>> >  	 */
>> > -	int will_destroy;
>> > +	unsigned int will_destroy : 1;
>> 
>> <CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com>
>> ?
>> 
>> (https://github.com/git/git/pull/1076#discussion_r750645345)
>
> Thanks for noticing this! I also lost one other change
> while splitting this out: we are referencing
> the_repository from the refs code, but as of 34224e14d we
> should be picking it up from the ref_store. I'll submit
> an updated series as soon as it passes CI.

No rush.

Reviewers and other project participants would appreciate you more
if you took a deep breath, after seeing a CI success, and gave a
final re-reading of the patches with a critical pair of eyes, before
you send the updated series out.

Thanks.
