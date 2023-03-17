Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC3CC74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 19:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCQTW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCQTW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 15:22:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC7A20D3F
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:22:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso10089261pjb.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080940;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvwIP/x1XZPeKVCakhXa7nkAxfF8AzDy9VNB4K3whc8=;
        b=Mp2dUf54M7ih/NRN/4gLDv6lSg8peQHKbMRqKvxUN6uIuw9dgDHIotwS+MppbvDaJp
         NKhTP2BnomJZ3jLbp6n+XvBi15I0xtRywW3boNhvuD8wzEUoPrU2kHs8KDPC9pPxoJc7
         AerS6LS26f2B5Yvxizk1HuMonSFBZv3V0MbdxwTO3BoGDbTCGl/XXm90nc17EIHTXrA6
         ELllcouha6wyeDUn3twu1Mx7QN8YmHBmr57bzf/JILkljTAMhT179v0ROh3hNY5TteRg
         ZZR1LIrQjECwLoBiL3KDjpyFS4UxIDsQqramXG9cY0C93C/JhHJZKQ/BubjEuXRHC1Ts
         wFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080940;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvwIP/x1XZPeKVCakhXa7nkAxfF8AzDy9VNB4K3whc8=;
        b=fsd75VpUaTnuXt7/VSzgn2VHtxdjOtde4hoXTZdjn/X2zBLqd9B1N5DTl8syxwPbX5
         sRjse8h6CaZcfVloyRqLE3YgozKAKjjNi/5PM5+4NU7z6oEH/TUHMUcCMHDYcAmYiKvb
         9ly1mYrJGd1c/3dypKR7NtbIl8t0A//0d6FIfz7cS/OGjsL5ayIFheyJZ8Xu0g/RzN5P
         ibRW/kOJ2Gn2AvaNmeGyq3xSL/cydAWkGtbFOBpD60kbUYlXyaoC4TUNw2D0mievB5p2
         IowXIFDLriBFtDgiKXkooqS5gmnLTThKD3WulXUh3SchLhFkqcO9oWr2sgmylz1yo5yr
         BOcQ==
X-Gm-Message-State: AO0yUKXHtvx0AaEMAb2SYyyNxmGJ6mxgHGsEBM8r2bVn8tehixtYKrF6
        iC9k1F0R+HXqbKwGFJE7J/xmAZwm5I4=
X-Google-Smtp-Source: AK7set8UTGcvwYpAG/tD8hT3OgI4JblLlmwhBWIIt+UVf0Fco4Ix2bBJolLm6IkbQ4TgkVbMLFx2Ug==
X-Received: by 2002:a17:90b:38c6:b0:22c:816e:d67d with SMTP id nn6-20020a17090b38c600b0022c816ed67dmr9633480pjb.24.1679080939893;
        Fri, 17 Mar 2023 12:22:19 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id t8-20020a63dd08000000b00502ecb91940sm1833115pgg.55.2023.03.17.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:22:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/17] cocci: remove "the_index" wrapper macros
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
Date:   Fri, 17 Mar 2023 12:22:19 -0700
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 17 Mar
 2023 16:35:04
        +0100")
Message-ID: <xmqqbkkrgp3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> In 2.40 the last use of "USE_THE_INDEX_COMPATIBILITY_MACROS" went
> away, this series does the same for our long-standing migration of
> "NO_THE_REPOSITORY_COMPATIBILITY_MACROS".

Is the series title on the Subject: line still valid, or did you
misspell "repository" somehow?

