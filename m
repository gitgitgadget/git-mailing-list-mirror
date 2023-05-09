Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D92C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 16:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjEIQDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 12:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjEIQDY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 12:03:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3B53594
        for <git@vger.kernel.org>; Tue,  9 May 2023 09:03:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643557840e4so6550219b3a.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683648203; x=1686240203;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izHhQAkaC6vScCjAdhfRQl8WGfQnQlNfegcU7+xtsHI=;
        b=ZEo5uPgM6ssLcZNn/zTdqlXwszuy3IdmTV1TwF1Vl36BRmaUJemMlhUxM9eIw4uaYQ
         Se+d5ZOXx+4rKpD9ehxNbdCHcpMDHScXfvBr5pCazAlCH+AEtricNgS3kSOzMDsixq6p
         6+cqx3FOMFIlBh2OjGQBAahCzNg3ZUBRZZ+USfIl1AQwqB2gclIG08KT4HqLLe8KpSWa
         ytAKk2C1hRayxLzg3eWvVpvKPQHmG+X7aaFP4OQ8wenDtieXxbBmoypWKiTAn6pH6VVJ
         ll2dwaus5eHmkA4PNttG+qr4HuXpYNOKJVcEdwI12klyjpCC2m0r6UcGC8YnuiF63pnr
         r8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683648203; x=1686240203;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=izHhQAkaC6vScCjAdhfRQl8WGfQnQlNfegcU7+xtsHI=;
        b=C/BXT63boZTPY5tBxnUGoZUnLiHQVVVjY9uTrTUlrHShzc0/HxCltnI496ua3QDB69
         WK7Xs7w7G91cSBg1P3vM+ZqUcAxplY38dAemmbTt2F7q4bfl5Stf4MoR6l/Cliuh0zCx
         tkqA5ANc3BahASHEHDhGctkIkOoqMgbxFdZaPz9nAcgwJRSQlqxL+5dMQkIGFjURl6pX
         Ofl59xlKgIC8Ha75ItpKgpkteyAW1exk8W+kxad29/LyAVzB6uuPicVz18Qy0vshf3aR
         zyCBmoVyXf/svhwcrn4jldOOi1uMfj8iDQ12EVR0IOXsUBI6HEKjU6xf+BMfGdy/4IFk
         v4rA==
X-Gm-Message-State: AC+VfDxW4T9EvdxJJE3HQKZeOMs5zOtUG5Chzo74zVMFxlSdwctKaZ6l
        t43jviPoerG25v9SwZAb6Rs=
X-Google-Smtp-Source: ACHHUZ69kvCCPtj9GHG7ERCXJleVxyF5KCavIE6V+H4e8MR0M/X1aQC4/520tZGvxI7lKvLK3gRodw==
X-Received: by 2002:a17:902:d507:b0:1ac:310d:872d with SMTP id b7-20020a170902d50700b001ac310d872dmr19536839plg.52.1683648202760;
        Tue, 09 May 2023 09:03:22 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b001a64ce7b18dsm1771550plc.165.2023.05.09.09.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:03:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/24] Header cleanups (final splitting of cache.h, and
 some splitting of other headers)
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <xmqqzg6ergdp.fsf@gitster.g>
        <CABPp-BErrVUnuDjL73edDpmkKUvs6Ny6cYwvueXw1toB4JcF-Q@mail.gmail.com>
Date:   Tue, 09 May 2023 09:03:21 -0700
In-Reply-To: <CABPp-BErrVUnuDjL73edDpmkKUvs6Ny6cYwvueXw1toB4JcF-Q@mail.gmail.com>
        (Elijah Newren's message of "Mon, 8 May 2023 18:31:00 -0700")
Message-ID: <xmqqlehx331y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Sure, I'm happy to rename ll-merge to merge-ll.  I prefer a suffix
> since it is common to see files sorted by filename (whether by Git or
> by the shell) and the suffix tends to keep similar-ish files together.

It can go both ways, though.  Grouping lower-level things together
has values, too ;-).

If foo and foo-lowleve needs to be grouped and read together to be
understood, it is a sign that the conceptual separation between the
higher- and lower-level things is not done cleanly enough.

Having said that, I do not care too deeply either way, as long as
it makes it easier to locate what we need to in the end result.

Thanks.

