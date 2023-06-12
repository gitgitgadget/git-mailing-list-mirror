Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AC3C7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 20:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbjFLUxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbjFLUxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 16:53:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BFE5269
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:49:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so4061865b3a.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686602923; x=1689194923;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xps+tXAIZ02iWRUYzIzMEfCNUAjP220Bxy2DQDbk658=;
        b=AfpNVAZ0lSGNm0pNfj7nc2eT2y4K0+hUPDMuSTafOgcJpLShDH5/Wo7Hb3ICu1gxlc
         i+YBKEZPDlqqh6d+2js0KkvC++V7DDXJsI2FQSq3Mus58XJNObpwAdxOYWjxegzlRKc0
         r7CifJw9xQ86X1uNuKwOWUs8Jf+aS46aDkh85sdxYH9Wm7asBV1/3+w2+4AcW4ROUc7C
         VusOT0C9RqXE9MWlVJQnbVv9buvZEEjG0rKrtk+Z965KDt7khfJgS27DBBUfthtZhryP
         37bhZ3oC4yxqtT1mGj6+rm4ovwrkmb99OXSnAOAP5YDmJOaTA1G5gZ+Kj/ydPDMlOIz3
         tvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602923; x=1689194923;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xps+tXAIZ02iWRUYzIzMEfCNUAjP220Bxy2DQDbk658=;
        b=aEzL70PPkq8l72Fn0tvh+Yo6u19zihfkgUQcmZAIM0TvD5rXAbGsqRi1aak2FTcaO7
         dNWXP40WAmFf6pF9dga8arl6TVuxsjzadKiANW4RudOivVYJ/o5/k55//UmcEu6MLPRC
         gndoO0UNLGhTu0JIGnpVaxVQiAx+Z0lsCQItIf8hsVlyvpAcuLt3yyeXgOmttJMJHzGV
         2kWIaFqurvzpRpTCLd3S6TLjdGkCcLUDekuNoeumb1Ff6leBYuLJR9b8lMu988CwIliR
         lnc4QFAlOIB9lPUByCuTTVqWFJvhU52116+kcr5VNRUFBc7RkgjEXo3dVoLBUFSC66Jv
         x4gw==
X-Gm-Message-State: AC+VfDxpUEGH5MRG+1/rWlk7ubqbTDFrrxFD5vNbIvx891BZY5zbYXUx
        NlwMKJCxexrTioL+B20UoN8=
X-Google-Smtp-Source: ACHHUZ6+dyELdwwgTngC7MQPMq8/nHwFMUAleNk11ojWGL8a1qz8w4JtLBjCct3KYdA6pKh/8TeNjg==
X-Received: by 2002:a05:6a00:a8d:b0:665:bd58:c947 with SMTP id b13-20020a056a000a8d00b00665bd58c947mr1263580pfl.10.1686602922924;
        Mon, 12 Jun 2023 13:48:42 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id u6-20020a62ed06000000b00661694f1469sm2380030pfh.74.2023.06.12.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:48:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 5/8] common.h: move non-compat specific macros and
 functions
References: <20230606170711.912972-1-calvinwan@google.com>
        <20230606171002.914075-5-calvinwan@google.com>
        <25d47081-2096-bb8a-dca3-bd5ea931c879@ramsayjones.plus.com>
        <CAFySSZBZVn=7gBB19_uNxeUwS9Y8Q6ZZiCT=AwfuBy4+d34piw@mail.gmail.com>
Date:   Mon, 12 Jun 2023 13:48:42 -0700
In-Reply-To: <CAFySSZBZVn=7gBB19_uNxeUwS9Y8Q6ZZiCT=AwfuBy4+d34piw@mail.gmail.com>
        (Calvin Wan's message of "Wed, 7 Jun 2023 10:02:02 -0700")
Message-ID: <xmqq8rco9zkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Is there a particular problem here?

Doesn't it defeat the notion that each header file is safe to
include twice via "#ifndef FOO/#define FOO/#endif" safeguard and
makes anybody who sees the recursive inclusion to think twice before
they can convince themselves that it is OK for this particular pair?


