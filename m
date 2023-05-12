Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87485C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 20:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbjELU0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbjELUZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 16:25:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE128106DC
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:24:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so8285869b3a.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683923065; x=1686515065;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGHlqdL/GZV5ImwfpFesbyKkCAvu2uCN29v4nmqfg6Q=;
        b=XuKf34by4Wr+DEZkgNg2s5xseGYb6TPBIbIbKEk0ojUfL7xzg/hllC0yrUFM+hSHMk
         OTpTnHMuj18BP6Ol96fI2iBu5g5pBrww9VWjCUtdazqaAMhG25W7khc4+ANB39CiepbM
         X1y4RO3XnZs7vjs69dIGU3qEPBDQVFABNRb3Yflz89GTgEPs9MyM9lVPRA5YIeJ54LRd
         d8Jfqpg3dZ0SK/6ESouIwJ9n1QC3FqlynfpxqWa4MXgYN2Qe6ywp3i11JmX+CbDEGom0
         PWyEPiGe3TmsfSRjC3VTXLNEmGkYSxTXNdxW2SpQNKIkz5bJjTk3H3F0+l3f0R5QFbuw
         ru1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683923065; x=1686515065;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PGHlqdL/GZV5ImwfpFesbyKkCAvu2uCN29v4nmqfg6Q=;
        b=YYmYOyX3y5J2qSBQGHGxj3VMNn2yLAX6TeIpwsYrv06PET29a6bTW+5xPHIhLub8t6
         4XAsMADBg8cIvpOWgsxUu0Mk4QrswQn/E9hZLB1lu/b3Se4sh8gZyBiCQHiyweN3rd3I
         XKRVAagZPDvLsdXuhuK4nxusxd3VeBav4MCGlQaAGkmn2S53AKwqg0obSI51mC0700W5
         KwQfXgavMgjQB2t0ejqqvBmo+YV8mkSCFm+6m65u8Wzrm+QUiAoEIJ93Tx2YDx7LilJa
         7hoNZawpDckEAVTMKUVDY1rtYwurhFterwPQCF34ahjyr0x7o3Mv6FUVv8Zx+NXGIBAx
         RsNQ==
X-Gm-Message-State: AC+VfDxD98Sp3993kvAiGnqbobButDTqRvRbder69nH+bhu88MVt7kv+
        9dADW3YCGK9E7QEFNgp2xMU=
X-Google-Smtp-Source: ACHHUZ6lbWaCQoWHgyHueHCJBsJgPdB6SxUsfe/PitIa/Y8LXhz8HRrMcQT1+T7+lkitmsLi/DaPVw==
X-Received: by 2002:a17:90a:a595:b0:247:14ac:4d3a with SMTP id b21-20020a17090aa59500b0024714ac4d3amr29967275pjq.20.1683923065094;
        Fri, 12 May 2023 13:24:25 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902729700b001a3d041ca71sm8357266pll.275.2023.05.12.13.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 13:24:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 0/7] strbuf cleanups
References: <20230511194446.1492907-1-calvinwan@google.com>
        <20230512171429.2202982-1-calvinwan@google.com>
Date:   Fri, 12 May 2023 13:24:24 -0700
In-Reply-To: <20230512171429.2202982-1-calvinwan@google.com> (Calvin Wan's
        message of "Fri, 12 May 2023 17:14:29 +0000")
Message-ID: <xmqq5y8xpabr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Reroll with last couple of nits fixed. Thanks again to everyone for
> reviewing this series!
>
> Calvin Wan (7):
>   strbuf: clarify API boundary
>   abspath: move related functions to abspath
>   credential-store: move related functions to credential-store file
>   object-name: move related functions to object-name
>   path: move related function to path
>   strbuf: clarify dependency
>   strbuf: remove global variable

Looking good.  I see Eric's comments, to which Phillip agreed to,
are all addressed in these patches.

Will replace; let's mark the topic for 'next'.

