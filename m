Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F42C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjC1UOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjC1UOU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:14:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AA32D5A
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:14:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c18so12808731ple.11
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680034458;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXXQ3/9uaz6Bp14xTF+X/fCos3Lho7SH0XT/WCXV8rg=;
        b=PZ3h+h/PSbJ/rVZJ+6Mh1nwXVDTc6IUTqLbTG8znUqIG6f9btnJ1/wDcUUsJ018+np
         R7+8QO3mldY7plrkniQFcKc5nDpzUv3h5OwJdbcpLmcoeMuHo97ad5RwSyXBcG91NTQo
         +5x+Yzp+ANfR6/V9rv46IKW5Dl/ntEaKh4VVrM0Xyy11P9vSIlnviF+rSrrXxQEJBbq0
         Ve47tn1yX3lZEvmJN4j4UnVre6/rjbLGZvbPNI10UN9fsAEbp3lSZUBFG7FAiIMNvgvB
         gLTayT8dt1HiN7HCfu1TQtcu7N5HQb/aG7eOTO3ZqpFhW16CSK1MITNqOTzNvgAgGp2I
         MKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680034458;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LXXQ3/9uaz6Bp14xTF+X/fCos3Lho7SH0XT/WCXV8rg=;
        b=b10L/G05lWA7jgo/js8czmdq0CyqSrmTvnCodlZCMgubeS/eFsNeq2BBMI6sqNYaC9
         toiYrmbwUkm8G+Xz8G+A5m4j2xwHUKCuN99F4K2+mQWgGnl2w21vRByvutC28XZA50Qq
         euB16wMs9bFettgAa1RNCysIc2f+SnE5BZ4/+rJ8+PBnYDngNNWGFTjU4mpT+x1E+wMT
         2d9D0ei1u1Lxjcgg8Ts+M148p1oBKYb0Zu0dGFWpfBKOk9cXYQliYAIxPvKrSIlvyrz8
         vKwsAXaHQa5udMq8jes9PmPvpLh7DHwlVEkV2E86bA3Z5Wsn78/vWI5ffLe47Z3gyyNV
         vgNA==
X-Gm-Message-State: AAQBX9f2WG0+LoLSbUec3dLVo3l+Fl6Xo+d02OporsNFVnWTkcMUJRwc
        p1xhR9ygqN8gRHYlIj50wJI=
X-Google-Smtp-Source: AKy350b6TRl3yxAuZKfBoiHLwRZTzy4Xne5TuLMClH8MKAVfkmi3OK0lnrXBi7yE6i8qmTy2RjeNJQ==
X-Received: by 2002:a17:90b:4b8f:b0:237:30ef:e593 with SMTP id lr15-20020a17090b4b8f00b0023730efe593mr18369105pjb.24.1680034458612;
        Tue, 28 Mar 2023 13:14:18 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a474200b0023377b98c7csm9372852pjg.38.2023.03.28.13.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:14:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 0/8] config.c: use struct for config reading state
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
        <kl6llejgdacq.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 28 Mar 2023 13:14:17 -0700
In-Reply-To: <kl6llejgdacq.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 28 Mar 2023 11:00:53 -0700")
Message-ID: <xmqqsfdoeiqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Note to Junio: 8/8 (which renames "cs" -> "set") conflicts with
>> ab/config-multi-and-nonbool. I previously said that I'd rebase this, but
>> presumably a remerge-diff is more ergonomic + flexible (let me know if I'm
>> mistaken), so I'll send a remerge-diff in a reply (I don't trust GGG not to
>> mangle the patch :/).

A patch that is indented by two places would not be mechanically
applicable anyway and even without such indentation, the hunk-side
markers like c000d91638, gitster/ab/config-multi-and-nonbool, etc.
you have in the patch would be different from conflicts I would see,
so it wouldn't be very useful.  There should probably be a mode
where remerge-diff would omit these labels to help mechanical
application of such a "patch".

In any case, remerge-diff certainly helps eyeballing the result.

In this case, because the difference between v2 and v3 does not
overlap with the area that v2 (or v3 for that matter) would conflict
with other topics in flight, my rerere database can clealy reuse the
recorded resolution for conflicts between this iteration and the
topics in flight just fine.  I'll push out the integration result
after I am done with other topics.

Thanks.
