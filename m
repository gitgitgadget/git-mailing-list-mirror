Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F53C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 22:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjEEWdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 18:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjEEWdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 18:33:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D292106
        for <git@vger.kernel.org>; Fri,  5 May 2023 15:33:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643ac91c51fso666897b3a.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683326008; x=1685918008;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XA421N67JXxV0ufEJC4XQk24ZWXAbZ3Bsl+AtG6E7o=;
        b=ExQaRI4ziTxw8xljmz5iAK1fyq7Yj64sZTBjRS9OFO1M/n2kwxAgGOc+0Og/gQ+HFq
         GWxHRMi5olzn1KjaOjJ0yy6iZ3HdL80bdIKH+yDg7xZ5JPzruXNPdJSKPCf2dfhMVhyo
         chtre54swH83/VpJgH3iBgXtjV0GaHuVCVN1hVceh4VBbaoKVxW+oAhj73HbChajR2SP
         m74z4bPagtQG4hj46ogXgnGfpvPaxJNyinrzFp2c0IYPMyDrfOsAdaR7InUTSncjeIE8
         yuK/JZG+iOFuyc6vO7tFoMkIp7Rir0VPGsY8/Kopq/srJrqGYeGFu3k+4dHWghdXgGBY
         r+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683326008; x=1685918008;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6XA421N67JXxV0ufEJC4XQk24ZWXAbZ3Bsl+AtG6E7o=;
        b=JCtWkWzlsG2+s7aMNde2KzBNam7IKLk9Xe/AOzsJ4Fj/IHeKuW+0NJlXM1Bgfhv47Q
         egIAxnw6HDm7etgkRc8esHPnDb5voub+L3JZpgCpWG37F/KiCWXRNe9kbhOSjH0iEdWt
         S6f4Mp7xiaDCzGwiw7hpKJWlVjZ1bjqnKKxBVlwrCC4YFrW3nn+q/8h3JQlwK1lr/Z1u
         7DklFe5syEjOEFQq94nhVtIugTHjTJnvtO4C1/BFCBRQYZCUbJXLSxJ7DEvy6vW0M5TO
         EvYDoXmgCv3BzuI+0xSf7cVHx7HeukLJaVhvF/Tk7A6jSNpINIsqbg0SF2kyBIKMdmqO
         cChQ==
X-Gm-Message-State: AC+VfDwJlZOU7qT8KDP0Uh6RFhbsX+nybVqDQcXUREJnz9SY+aMi0RDb
        2WbaMooKnrabuy9doud1CPY=
X-Google-Smtp-Source: ACHHUZ7iDS86Tx/5rvO/Bkt9QJ4Z34fx4hWAAkvi21pUlWAnv+Do8ZZcVUXHMznYkhM4ZgrcPYXjZg==
X-Received: by 2002:a05:6a00:1ad0:b0:63b:5f78:d6db with SMTP id f16-20020a056a001ad000b0063b5f78d6dbmr4313929pfv.21.1683326008344;
        Fri, 05 May 2023 15:33:28 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78044000000b0063b1e7ffc5fsm2082197pfm.39.2023.05.05.15.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:33:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 0/7] strbuf cleanups
References: <20230502211454.1673000-1-calvinwan@google.com>
        <20230503184849.1809304-1-calvinwan@google.com>
Date:   Fri, 05 May 2023 15:33:27 -0700
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com> (Calvin Wan's
        message of "Wed, 3 May 2023 18:48:49 +0000")
Message-ID: <xmqq5y96csso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Strbuf is a widely used basic structure that should only interact with
> other primitives in strbuf.[ch]. Over time certain functions inside of
> strbuf.[ch] have been added to interact with higher level objects and
> functions. This series cleans up some of those higher level interactions
> by moving the offending functions to the files they interact with and
> adding documentation to strbuf.h. With the goal of eventually being able
> to stand up strbuf as a libary, this series also removes the use of
> environment variables from strbuf.

This round hasn't seen any comments (mine does not count ;-).  The
7/7-only v3 still says "environment variable" to refer to a global
variable, so I am not sure where we stand.  Is this back-burnered?

