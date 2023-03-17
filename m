Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7D8C7618A
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 16:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjCQQVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 12:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjCQQVg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 12:21:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7962DC16D
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 09:21:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso8417894pjc.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679070091;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRYp+vtTJrZ/9lBbCGLlrapqIJYJu7H6USXAMaPRqXo=;
        b=BCQVdI8+F3qAq8UJJzfIe4nW305uixd+ZFs9TMEh0cFCBXBtRDU+VW/WzF9HpNy0Fy
         KE13l8ZI1bPp6QgedVtkd89WQWQlJwJYqyi7o9OjBzGrBZpr07wQP6YDVm5iwtTdJ8lA
         BL0yEGP/ljYcUE7kcjPqp/uHEsCwL+cCcXRJcvhsjnTrQ70wAUHu/5sqbNWyZI7ezuHm
         kz9aCoioMPU+V75B8YcpBuk6LKYKg5A14JUs9fQnjEYxGLor6VQAUAA7dz1+5vzGTL0P
         TwCZBeHE8inTX1n/lRdAZO3ULDb/5k/YRPYnC8ZZ+OUMBXKYhbzMeqJ+xUCmnihZkILB
         fI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679070091;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRYp+vtTJrZ/9lBbCGLlrapqIJYJu7H6USXAMaPRqXo=;
        b=MsIBXi2Mdfsw6rwTl1aitNJ/BZbZIKBF0j6r3iqLViru804f4nKczGlhWsAiZNUBOf
         GXvTfpyxCqFi3/qaGscLnCT/EVeDkma4Vln1fDodzFur7crsMLUqVWGlyi1RTuLgpM+C
         RjmfClibKcyYbRyIdcnI9WtluztGg+NNOwsPchMYx0Snr8eg2Rvwz0EzbjuJEFyw+Lai
         4dLRZJi7DT7F/llFIeA8gQfgRaM4S7oXrC4aVotnXc4o58LqBUWK5GiC42tN9VYKqPoZ
         pPlVnElF2Ey0GAEf0+FXmx3UNICznusoo+dXUFzdlk7HM/wysvF5q6Nn5FgR0WzkzmXP
         3H2A==
X-Gm-Message-State: AO0yUKU1cvv1to6NMe39/TOX+0KIfQ5SH2vLFrtIa1j2ye6lV9A/0iaP
        vS7Q1AgDfvrvYFeB0jMO/zQQRcSOEyQ=
X-Google-Smtp-Source: AK7set9dbvupU0X5WKj0FaJzxGhMJbG/t/XSPooAVgHwCrpkHnTQ3O7R3AVypeu+/+0bPeuQ4O51HQ==
X-Received: by 2002:a17:90a:de94:b0:237:47b0:3235 with SMTP id n20-20020a17090ade9400b0023747b03235mr8673736pjv.32.1679070090592;
        Fri, 17 Mar 2023 09:21:30 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id r13-20020a63e50d000000b004fb26a80875sm1691718pgh.22.2023.03.17.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:21:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [RFC PATCH 0/5] bypass config.c global state with configset
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
Date:   Fri, 17 Mar 2023 09:21:29 -0700
In-Reply-To: <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 17 Mar
 2023 06:01:05
        +0100")
Message-ID: <xmqqpm97gxh2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Ævar Arnfjörð Bjarmason (5):
>   config.h: move up "struct key_value_info"
>   config.c: use "enum config_origin_type", not "int"
>   config API: add a config_origin_type_name() helper
>   config.c: refactor configset_iter()
>   config API: add and use a repo_config_kvi()

I haven't reached the end of 5/5 but it is a shame to see that these
obviously good and trivial clean-up patches like [1-4/5] have to be
buried in an RFC patch and benefit of applying them alone becomes
unclear only because it is done in an area that is actively worked
on by others.  The latter is unfortunately inherent to the approach
of "commenting by patches" but hopefully we can see them reappear
when the tree is quiescent.

Thanks.
