Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C248CC7EE2D
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 23:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBYXaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 18:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBYXaK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 18:30:10 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C1FF09
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 15:30:09 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so6569111pjb.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 15:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mWESqnCWDCDfEKV1OGWc2pZbWHMHFDM6EZajPORcLls=;
        b=hK0OpqkLkmS9hMWAewUcOKk5MwSWXy4VCu/sRdrTlSJFt4fOqDPHsMEAYMrcOTFy91
         Fdzn1E3VCt23K/TOeL+e0TtQA0pAWW3LMMd26PhG4Q0TisIxgENjsQ22bsDbaf0I3DC9
         E9J85VSUFlLCX5dyZXIU8FVqRdkokSVI2W5z0WtG7oB/bOpZerBYUsKpu4pJ88tq2Il8
         0XgRdvgUGa//sDw4djiXw+Xi5C8dpHV3jklGWX1tH3UcMSgJaORdkRijRxgf1EZZWOKo
         CRmjrejsUTAzQvzdGJS2qbknI6gKxAPXE71HaBQnOVixoAjXbXFahubHZUgkWZjYlaCN
         xwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWESqnCWDCDfEKV1OGWc2pZbWHMHFDM6EZajPORcLls=;
        b=6Vij1EQLTMNsV+frxDmNJHtnislSNC3lAEnNk4feHqbff61qxoqi2/YsWDRpvAvDP/
         GtIRffP/E76jPHY3obf10kAa0Zn+W2IGAlGVpDbViSgOXLocYol5Ahzx/RKSI3GUc9yQ
         +PTVevTkB4YsaWvNbEFU0sdVoPBp8Psf7qpfIDg5qvIVNS6ROwYQoGubkXyD+BUmRTPH
         4uvUAu2cBDCM3wYa4An4KdZo/Pz0aU4/XSk5o1ZTsiJXMVPnhUtRN9PI2VAkk37WEyUg
         2EemesC3QC9Uz5AeXV6R9sIjfmHOnNUIAlbq8A1kw2RPCinDD2bGR4m7kfcEme1oJKJQ
         5NtA==
X-Gm-Message-State: AO0yUKWJswZDTTHqpNC88TMoC+AbK08lpazi6/JA9rRc4a3jOMr9TChW
        8dSM/AbWSE+TIt/CvQWj4+U=
X-Google-Smtp-Source: AK7set9y8+3R6+vnVHhTuOLJo4U7M7jIFbL0Y8wFljF0dA5fffeywkFauDq9BS5mHbYj2u9/k8SbmQ==
X-Received: by 2002:a17:902:c941:b0:19d:14c:e58c with SMTP id i1-20020a170902c94100b0019d014ce58cmr1274367pla.65.1677367808611;
        Sat, 25 Feb 2023 15:30:08 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00195f242d0a0sm1735678plp.194.2023.02.25.15.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 15:30:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 00/11] Clarify API for dir.[ch] and unpack-trees.[ch]
 -- mark relevant fields as internal
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 15:30:07 -0800
Message-ID: <xmqqzg91tjb4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1 (thanks to Jonathan Tan for the careful reviews!)
>
>  * Clear o->pl when freeing pl, to avoid risking use-after-free.
>  * Initialize o->result in update_sparsity() since it is actually used (by
>    check_ok_to_remove()).
>
> Some time ago, I noticed that struct dir_struct and struct
> unpack_trees_options both have numerous fields meant for internal use only,
> most of which are not marked as such. This has resulted in callers
> accidentally trying to initialize some of these fields, and in at least one
> case required a fair amount of review to verify other changes were okay --
> review that would have been simplified with the apriori knowledge that a
> combination of multiple fields were internal-only[1]. Looking closer, I
> found that only 6 out of 18 fields in dir_struct were actually meant to be
> public[2], and noted that unpack_trees_options also had 11 internal-only
> fields (out of 36).

Nice.

Will queue.

Thanks.
