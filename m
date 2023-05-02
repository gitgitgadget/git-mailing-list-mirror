Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F2C77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 22:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjEBWbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 18:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEBWbH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 18:31:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F058FE6
        for <git@vger.kernel.org>; Tue,  2 May 2023 15:31:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64115eef620so573879b3a.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683066663; x=1685658663;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEFBOO9YGS2ggM88CXwm1MdNkpd55BXIEe7Upa6MRA4=;
        b=ATgvwbag0tmT1XDBN05pnyv+4QOWJxPVAkq4dkrjUuyzpbvCvqxwNvw+M+nh7mD10U
         COZxWE+7iOc029wZS6xKLjAb3z450a6WJq2SDfBpCplR+ei5iMOvNpkh1mk1qh6tnf2V
         y6LeiZM5v7fxpB/3kC3pd2/WPKqRC9WgzY7j2g+9TGLPH+wLK8dbhWvVkjfbsW0NGEoF
         BFzIRAWsXUCNwBNN1DWrGfJpspf0NeUIct2yy6OSkV6btsZulRWk2FCP6dbyWfpBZqcu
         FrgCcYq0XVy8txNBbrqbFaWOwrhACChgk/kuEGSaD2PysxDGacOlKxaNCQH7J0WWQTEm
         7+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683066663; x=1685658663;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nEFBOO9YGS2ggM88CXwm1MdNkpd55BXIEe7Upa6MRA4=;
        b=Z+arAJLGh4E00G4CEMeUqarxW+HqSEqvcNZ4W89doso031bk44XuRnry1Dp77GRykh
         AhTl0kVYkGaj52xpkFsc+PaoxIJj6aY/u+01Hauug9qxcYjmilrAkgYtDYwzpuPtAkma
         U1GHTcwMol+svH3uqt+1OK7kmmCgt15iRdwj5hf9sKoTYpmWTOWTOYBfFrV4a4zMgMAq
         9cuoyhnEE1nxy9DSRGkTL+Vpy0kd2tGJ0S2Wid9UOkTn2AJfTkaZS4OZeuDfUjHJBOKI
         U/Zu777+TETTDqtz7xpAG0gArO8mZvfF1jztDiZN73Wv09F75bizJHqkqEIPY5dh0vw3
         yFHQ==
X-Gm-Message-State: AC+VfDz5CdmEBXzyTbyitvS40swN5rEuNePZ7uubd33ARU+FA3xt+zV1
        H42Gi2MYDC5CQMfpdqZvPyw=
X-Google-Smtp-Source: ACHHUZ4zLR16X/mcpycCj1z1BcfjRDMYsoARiLqoGrUHcpHLZVCLJMHvXul6JD21lv36Ew8TxwY01g==
X-Received: by 2002:a17:902:d70d:b0:1ab:f74:a118 with SMTP id w13-20020a170902d70d00b001ab0f74a118mr90803ply.19.1683066663317;
        Tue, 02 May 2023 15:31:03 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709029a8100b001a66fd54dd4sm20225877plp.258.2023.05.02.15.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 15:31:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 0/6] strbuf cleanups
References: <20230502211454.1673000-1-calvinwan@google.com>
        <xmqqttwuxtnz.fsf@gitster.g>
Date:   Tue, 02 May 2023 15:31:02 -0700
In-Reply-To: <xmqqttwuxtnz.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        02 May 2023 15:20:00 -0700")
Message-ID: <xmqqildaxt5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But if we were moving in that direction, I have to wonder if some of
> these functions also need to be renamed to lose their strbuf_
> prefix.

Just to avoid misunderstanding.  I do not mean to suggest renaming
these inside this series.  It would make things too noisy and even
more distracting.  But in the longer term, as we treat strbuf more
and more as one of our basic data structures, it would make sense to
lose strbuf_ from functions that are thrown out of strbuf.[ch] with
this series, and reserve the prefix to functions that are left in
strbuf.[ch], i.e. those that are about string operations.

