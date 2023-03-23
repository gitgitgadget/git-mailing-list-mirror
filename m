Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DF3C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjCWQGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjCWQGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:06:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6688731BDD
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:06:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a16so17557971pjs.4
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679587576;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/SyXYX4utvGsmsmALLOP3gNv86SIXSemxuDrjWgF7Y=;
        b=CqXoT5wjFtmxasVsAXR0mgIsXNeFQe1oYpTYvZswb8dvncCMhOkXnf+sxaDhR+e9eb
         uPc5xM83kwAWaa8Rp3jCxWoSeT1nAI3L0Djhpl1L7FTHATi4dsTp5vytOJzw2RA1mfzR
         GhQOVLYE5ydoBRto/lK917Epwbf6OoTW8beAGnv4A+RVFLZScEzULt7uQ9+R+8wlB3Mb
         iL2wgqxCBfZg2RKp8SIMxZ6jtnqqr+GfgfF+C4ka4OYE+6VYkKQRh1hC4Y7gcXsKn3YO
         U23EJqx50Ufmeuj7dqbiM7e5FI+aVc5f/+n9w6Y+C255Xxgfpba8x/Dm6vo4MmxieyAp
         SYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587576;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K/SyXYX4utvGsmsmALLOP3gNv86SIXSemxuDrjWgF7Y=;
        b=kOiZIkB55JqLVHS0sDLrDfVez3vyhca+ImsqNL5Ze6T9PwqyZuC/uQD1LykFzcgr32
         NhHVG1gTH6EDSq79G/CdmMF4Lq4Kt4tu0Zza8d9jvNLvCNOmhRl6fBKOJ3zQV4hcD4nh
         jjT7BpVKMgDTe1jwkaRYo8YGJi3QY4NLFC4SXbLqC9uSInsjph2DzNQ8WoPFweX+rgHd
         VMimY1K4qo5Ulf27qX8S8luk+QNhTbEbvei0czR2R7PWZxF3RRgtDaq1R5dg4tCD4Mdz
         KRrisNKoNpq3pGZVN3VzmlxTJMzOV/JEHzilxT3YrV8dyGCPKR9gfDZOxqtfyjHnRTWJ
         CW8A==
X-Gm-Message-State: AO0yUKUxgSw0lKzXyIupWiLh2khD1IfZP24CUbdUQu7y4nH281szAjav
        n9DG7byfSo56TUdCrR8rDtg=
X-Google-Smtp-Source: AK7set+fWoT8qTpFUerXw3CmhWUqj22jSetj/VVPAWSK2QdbT3rctaArfFuLqAcCRPJJHOHE+JMkjg==
X-Received: by 2002:a17:903:27c4:b0:19e:8088:b852 with SMTP id km4-20020a17090327c400b0019e8088b852mr6105982plb.10.1679587575566;
        Thu, 23 Mar 2023 09:06:15 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902860700b001a1d4a985eesm7497890plo.228.2023.03.23.09.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:06:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] split-index; stop abusing the `base_oid` to strip
 the "link" extension
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
        <f1897b880729b649ab24da14cbc3432d44b7c731.1679500859.git.gitgitgadget@gmail.com>
        <xmqqjzz8cwdp.fsf@gitster.g>
        <ba23850b-0fc5-4a82-49df-88550ae8b4ed@jeffhostetler.com>
Date:   Thu, 23 Mar 2023 09:06:15 -0700
In-Reply-To: <ba23850b-0fc5-4a82-49df-88550ae8b4ed@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 23 Mar 2023 09:59:15 -0400")
Message-ID: <xmqqh6uba1vs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>> +enum strip_extensions {
>>> +	WRITE_ALL_EXTENSIONS = 0,
>>> +	STRIP_ALL_EXTENSIONS = 1,
>>> +	STRIP_LINK_EXTENSION_ONLY = 2
>>> +};
>> We do not need to spell out the specific values for this enum; the
>> users' (i.e. the callers of do_write_index()) sole requirement is
>> for these symbols to have different values.
>
> There are several calls to do_write_locked_index() that pass 0 or 1
> as the new final arg.  If we update them to use these enum values,
> then we don't need integer values here.

Good eyes.  Yes, the new caller that selectively passes
STRIP_LINK_EXTENSION_ONLY should pass WRITE_ALL_EXTENSIONS, not 0,
on the other side of ?: as you pointed out.

Thanks.
