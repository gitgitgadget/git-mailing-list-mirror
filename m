Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF30BC7EE2A
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 02:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbjFCCar (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 22:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjFCCaq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 22:30:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CA9196
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 19:30:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25669acf1b0so2381087a91.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685759444; x=1688351444;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJyyJ2GY9QIM6ij/mIv95kPk5otPBKm0I0yVuHcvlHo=;
        b=rzvUeCrcAKeyLAfwpEtBeub6jSyL07yZkHXPuj5VCEB8nJbyO+r1AjC91mGhhfgeDj
         vActXM0qUv+SQW9Rl2UKwXz9gsBKTnFg8ln4GMPbsVdFeRkNozyV6LtvI+Nw6ga9p8ah
         t6RcT2wB0nmQFGKoAXKmwuLukGzFJUFs2cqL0Bda4e1SrQzzEoE/lws4FrqT1y/h/YqZ
         m8T9S4c9eN1utk28AVv56rK2E2OjVKtqfAa3aYKLBrNpG68o1n2dTCsJz8gE6jZJdReu
         r8oAWUYh5ATGISG6ImiANu6gOhOYyK35XnAM/ZlvkGoBOKu4YjkQ/a4hoT2NZGUmSyuR
         4VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685759444; x=1688351444;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJyyJ2GY9QIM6ij/mIv95kPk5otPBKm0I0yVuHcvlHo=;
        b=BbOXzWF7Mf6wfDNfRkDJkdofXR0iM8YzSXrwVEAuklNKgtmjqQGwLkJ5egP5pFz90Y
         9eRZMvfFxDK/ZzD6oDban6PY0PN1NnMXwRkCil7O2pmqDOmNesYwI4etnkHmCpuCwHfp
         oSSKaEeTaoUmAhg+kDw8ATMT68pjWzljK1GziODqgYRlKpFCiGLgEEnbv7cHvfLNGxDc
         v4rBn8NsJiLHNvLIFq9KDSNtYO5oUUgkszE+nXqF24Pcp+3DKoncb8N7Uq+wM4ly5P52
         NatKBJ8+OXTJIt/xPSfhVpes8+FTdTzXgdHJZKBM/XOx8/rDrW0n3VOmhGZUy4/KCss8
         7mxw==
X-Gm-Message-State: AC+VfDz55XSV9dLQkLqB3CNs1F0tpFJqDE7IKj+HuldUkUsF+eMzeXLg
        U0a1qK4s73T0X7tC2t5ey14=
X-Google-Smtp-Source: ACHHUZ7H1Av50wix3rSL1Btd6+w8GcgnB6GbXZPLiLT78W48tm7wupugtg2OdSUzi5ZusiZBUZAAEg==
X-Received: by 2002:a17:903:41c7:b0:1a1:b3bb:cd5b with SMTP id u7-20020a17090341c700b001a1b3bbcd5bmr2154807ple.62.1685759444589;
        Fri, 02 Jun 2023 19:30:44 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id f23-20020a170902ab9700b001b1a2bf5274sm2030951plr.22.2023.06.02.19.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 19:30:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Alejandro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>,
        asedeno@mit.edu, git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH] statinfo.h: move DTYPE defines from dir.h
References: <CALVMLfLw4P=VnBOYA-WbHRNPZiAiO05h4k+cSvPJuaqkjgp5ew@mail.gmail.com>
        <20230602192700.1548636-1-asedeno@google.com>
        <xmqqilc571hf.fsf@gitster.g>
        <CABPp-BHZ6a8VEuK=miMAcBG9RbUz+epuQ+d1xvwbRj_tsnYqcQ@mail.gmail.com>
Date:   Sat, 03 Jun 2023 11:30:44 +0900
In-Reply-To: <CABPp-BHZ6a8VEuK=miMAcBG9RbUz+epuQ+d1xvwbRj_tsnYqcQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 2 Jun 2023 19:04:31 -0700")
Message-ID: <xmqq4jnp6zvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> There are two _different_ things named "struct dir_entry" in the codebase:

In the longer term, we should rename such a local type to avoid name
clashes with the global one.  But I of course am OK to leave it
outside the topic to clean it up.

In any case, it is worth saying in the proposed log message why
name-hash cannot use cache.h if we make it include dir.h; it is easy
to do so (i.e. "it has its own 'dir_entry' that is used for other
purpose").

Thanks.

