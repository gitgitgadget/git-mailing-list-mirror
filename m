Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05ADC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjC1Oef (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjC1Oe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:34:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FD1198
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:34:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so12742095pjl.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680014066;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8xxoTxRy19EoavF1AE+c9GKrw1dzLkK7uTPVksL6TQ=;
        b=IlNPa0dAkauQm0Vk+AwjNt1s83KUmZx7S9T7R2VPifwr2jN9b2OQr8x+io6IzEBZvq
         SSr4u250kQbYBlfh+MW7Xi/7AgpGp7wnJ0z+AVN76CxUXFW/trmK85Jbd5Z8f+PgikHU
         UOAqfBThsqrrQORomkWDtJXdeaMMjvB84z+xhq+pHjO897ANabgBt0gKxmRDTeUvqNMf
         hqKIeHQGaqFj+54KnbIQkAZbPDHwnD5cwlz2xs/7En0S+ersZSNAwZlbQqcNaaFLPkVx
         FedF30jCYvWA7B9dlROMk2mNWMrT2+1zBXblQZh1MxOmLDGAStihd6gG32w/gMRJpaaL
         m75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680014066;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s8xxoTxRy19EoavF1AE+c9GKrw1dzLkK7uTPVksL6TQ=;
        b=0z/NqAAVGhR9o2XM/inxO4afFM7ROhR1Ob1X96hWwpuG5x30CdasbPu6x95uOyrN4S
         +GGNq+Kg//7ShDGhehiNmsjuUypJri/xkHPprcQssUoggbDrRs8ZzXVAOVNKUoIPPkA/
         yoVaNgmItcKN0v82FbzHZ8C2pw6xZXpSTFVCBSwR3a6nlvZEcyQecWmDD4TVJplGmS0Y
         KTusm4XRNQcD141ucvHlfL2ZzbIl6rhL4DOLDSN45Oriwczii3prTgunwMfvAxgGrfP6
         w/gRSI3Dnq1aWjqxTxQv40HhxETq5IiRMWZxj4IkQlbemsqj4kUwO/9M2mhpssHhgLsX
         j54w==
X-Gm-Message-State: AO0yUKWg7vyaHvm6cmgM9O5EfgX7roLuad+vF2RPoqZanBG+kn4L9n/D
        kJfonB4T08JczMrIVh8ifaJidiiSoH8=
X-Google-Smtp-Source: AK7set9etpG/L7eat3UFOcctn9ZodECBmAHcJ+nXqM1Mn/ed/KKFJoryLtesZNNlsE4e/0ER9QWyPQ==
X-Received: by 2002:a05:6a20:bb24:b0:db:aae4:7b41 with SMTP id fc36-20020a056a20bb2400b000dbaae47b41mr11195019pzb.21.1680014066326;
        Tue, 28 Mar 2023 07:34:26 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78515000000b006259beddb63sm20772469pfn.44.2023.03.28.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:34:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/17] cocci: remove "the_repository" wrapper macros
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
        <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
        <xmqqpm8thss8.fsf@gitster.g>
Date:   Tue, 28 Mar 2023 07:34:25 -0700
In-Reply-To: <xmqqpm8thss8.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        28 Mar 2023 07:09:11 -0700")
Message-ID: <xmqqlejhhrm6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> On what commit is this targetted to be applied in the first place?
> It does not look like it would apply on the same base as the
> previous one is queued.

OK, I managed to backport them to the same base before replacing.
