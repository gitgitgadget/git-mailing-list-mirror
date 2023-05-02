Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E2C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 15:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjEBP6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 11:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjEBP6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 11:58:40 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F3D1989
        for <git@vger.kernel.org>; Tue,  2 May 2023 08:58:38 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6a5f765d5b8so3209845a34.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683043118; x=1685635118;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWdSziyZDOwqgSOX+bPiJOQN6FnfOEASNHm+osDe8C4=;
        b=JG7ve07DGhUbOivfKI7s51kFU/yQwHMV8JSj7FtF5D8uEIaZXdPcicSPZnn/+4h+vj
         UcJHUcm4ybCv6MDJWdgp88/6AQQX0d6pI4AWw28HgKcMmMGGtgv8+6Ucc94qTgY4zhfB
         l6k82geeqJ3N1CxlP8DLHjJ4zeAajQsZVDKDzJFvFWRwsm3Dx6JQp+9bfl06XC3Ol1lF
         I93TsVt8RMlmLrz7W7yHG6aun2abtYSqaOXnlxkbIGM8hQh1DWJejMNob6KXLhtgOeKT
         2T8Dtbx+8WFXoqRSaVI1odcEfnWhD3ypc981roWnOFWIjgZD3UO348ssn8/S8twVV/+V
         5Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043118; x=1685635118;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWdSziyZDOwqgSOX+bPiJOQN6FnfOEASNHm+osDe8C4=;
        b=LKTPt/6VOlsSQZ+cm2eimBLaGzoGB0AVNbbdmiegeqWOtkM3gkTpmzaGvoUdFv5Sxx
         jGrSxi74pW3iRS5834tUJLPT/Fbfbk0YuT6UF2KvVluE4WiGLAt2p7ZargrLOLbC4whY
         7SmB31c7lOASrGCJcQnzPbnSs7vbD63CEo/WitQX1Z7NEB0OYf5z7ePxHccvGlQPZgi9
         NhtENdP0Z57+nh1ffIxbOzlYFI52ki2ceXgwcLJaH1o0c3GSRi+gtV+js+jK+m1Ofb4B
         yHW1fjAjRT25dV3DpAlnJNUq2rs/7iQ0d5hB7Y/dh10EN4GiAdWj1Gpjt1ExtVfZsrZD
         q04w==
X-Gm-Message-State: AC+VfDz37UyLDYTDLe2fV3K3R1+3YOol51Lz38yrLA19T+QVM6OvWbYn
        T9HPp3NrqEWZSp0jCzbbcfQ=
X-Google-Smtp-Source: ACHHUZ5VczI9BKnucPPdTxd1/dQCWzNlgFnFIbpCmOWw5CtG017Q0dmE8ii2MSLSSkGfkbtvcDmKxA==
X-Received: by 2002:a9d:7357:0:b0:6a6:389f:ad88 with SMTP id l23-20020a9d7357000000b006a6389fad88mr9484914otk.13.1683043118146;
        Tue, 02 May 2023 08:58:38 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w22-20020a9d77d6000000b00697be532609sm12834016otl.73.2023.05.02.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:58:37 -0700 (PDT)
Date:   Tue, 02 May 2023 09:58:36 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Message-ID: <6451332c869d2_1ba2d2946c@chronos.notmuch>
In-Reply-To: <xmqqedo5jh6a.fsf@gitster.g>
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-3-calvinwan@google.com>
 <xmqqedo5jh6a.fsf@gitster.g>
Subject: Re: [RFC PATCH 2/2] unit test: add basic example
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> As a technology demonstration, such a hello-world test may be fine,
> but I would have liked to see a more realistic sample that links
> with reasonably isolated part of Git codebase, perhaps testing say
> functions from <quote.h>.

I don't know if that's the case for Calvin's proposal, but at least when I
tried to do that for my proposal, one major issue is that there's no shared
library to link to, making it difficult to play along with other shared
libraries.

-- 
Felipe Contreras
