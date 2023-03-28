Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A3AC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjC1UYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1UYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:24:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36735EB
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:24:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so13880060pjl.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680035052;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfdXOvGkEpMagKXoMFTruSOVoV1kcGgTsTwxZg3Kowc=;
        b=anBp8ce7x72VukrrQsuJ6AGQ9knXCSdrtlANdlCcAjzQcknY2KCYzRrvdimBjG8c0f
         i1cTLyRQ4Sr2A8qqudBvL0hDu66LZjfdfEvjFUpeMXt83BpsGIFVRtIm4ITAVhCCUHd0
         d99HbPwbqafoHQ7cCO0yYloziNkwfAthPm177SKBFp/twcS6ejhTM7s7na8kOEeOVvHz
         pKhyDMaXWvQMrOdoH1I4C1/fxMdtf61rrIsMC3e7yS3oQbCSoy4BVa0P5j1duX4PEpy4
         9qcffRx0Otn8V8lhq3qCJnl7xYoXuLmXIAN9zHI/u0UREvGf9vMwML1BS+FxGNunXUUD
         aGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680035052;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfdXOvGkEpMagKXoMFTruSOVoV1kcGgTsTwxZg3Kowc=;
        b=x2aUlek+5hrSps/sQoejZJosLKRRU9s1wLQskykFaBD8oMM5XUbdAca+r6cPDKZ+gM
         R+NasOW2YaCgLSY38hZmy1HI32oQ3961bwVEjmoJQi1LLxRUGxjd0EdQFInwxxwXPzBl
         mIsu1DieJ/tSfv3v2qf8Yv67hNWLiueJN3ImvYpvthFbczBy04yQokN+yteRIbo/8CSG
         6oaalX577MZyGYcgNlwb01sP7QVoe0GOOLZWU0uVP2QQLl5SBpcUDJW0z2MW0AuiFkEV
         poRrla49WFNun+SUJsleHm3WStWDVulI59DP3GpDYddAjHEtp2omeqczFYupfgBOmeMk
         Xj4Q==
X-Gm-Message-State: AAQBX9cr6QIm8P8jroJ1yODYiO7icpZ7vF2nmYWYUQir/ZNELZcPE9fi
        kkNqdpw/U4KxNpRGVhFPa8c=
X-Google-Smtp-Source: AKy350YIzX+Jmqj9KIi1pHewFZBgn9+mr5io6Q0RAnyhU0u/OVr/vTl7nldLW9SnwK6eKhZyT5Z3xQ==
X-Received: by 2002:a17:902:f552:b0:19c:e6c8:db16 with SMTP id h18-20020a170902f55200b0019ce6c8db16mr20803756plf.27.1680035052555;
        Tue, 28 Mar 2023 13:24:12 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019fea4bb887sm21630044plb.157.2023.03.28.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:24:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Raghul Nanth A via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Raghul Nanth A <nanth.raghul@gmail.com>
Subject: Re: [PATCH] describe: enable sparse index for describe
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
        <xmqqjzz29hkw.fsf@gitster.g>
        <ff521177-b0ad-c567-c51a-a6c191584d7c@github.com>
Date:   Tue, 28 Mar 2023 13:24:12 -0700
In-Reply-To: <ff521177-b0ad-c567-c51a-a6c191584d7c@github.com> (Derrick
        Stolee's message of "Tue, 28 Mar 2023 15:46:38 -0400")
Message-ID: <xmqqo7oceiab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>>  			setup_work_tree();
>>> +			prepare_repo_settings(the_repository);
>>> +			the_repository->settings.command_requires_full_index = 0;
>> 
>> Offhand, the only case I know that "describe" even _needs_ a working
>> tree or the index is when asked to do the "--dirty" thing.  To
>> figure out if the working tree files are modified, the code calls
>> into run_diff_index(), but has that codepath been made sparse-index
>> aware already?
>
> It seems that this is a case where we can rely on the existing
> changes around run_diff_index(), which is nice. We get a very
> easy win for a narrow case.

Hmph, so "diff-index" is already sparse-index aware?  I looked for
any old commit that flips .command_requires_full_index to false for
the command and didn't find it, and if I recall correctly (I only
checked when I wrote the comment you are responding to),
cmd_diff_index() does not do that, either, so I assumed that nobody
has converted run_diff_index() yet.  And that was where my question
came from.

Thanks.
