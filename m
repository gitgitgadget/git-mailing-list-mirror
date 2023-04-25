Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF436C77B7C
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 23:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbjDYXuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 19:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjDYXud (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 19:50:33 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B0AB219
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 16:50:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52091c58109so6003192a12.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682466632; x=1685058632;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8SZeWQW/4Fc3wYmGiQL9j6wJKMmaMBhZEXjn3Pnp6E=;
        b=AM3GWZ6cpduAH/lp8ueZmJElqODQjSDqYgNIkUCWE9b3Hb6q17slWyu4Jdf7Q7uU8U
         iei+H9kThz6GMJ/zUZulm6b2h97INtm8UvKI97IkyhLV7/jle0QyHX+DXDJKqhXzNCUO
         7AmW5bOsWPOw8VGP9KjGhMWWZdfDYx7/YpRtJjGna9ZQzgCxdrLQ3DEU/yXJYxCEPJKa
         UN+1+UxVqz/xDCxEjzaK1Ct3NBFphh9GT3iRS0RswDiSOb73P3qNEkjo0+7Xn/gI9yP6
         n1KQIfDxMRXUNb3sNfR5986P6vsb4mBJ4AKBrAhuwL7PELz23Gi7G1Kts+dFVeKc2N9f
         HwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682466632; x=1685058632;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A8SZeWQW/4Fc3wYmGiQL9j6wJKMmaMBhZEXjn3Pnp6E=;
        b=dcDtiJhAR98cdIvaNgK8O3K+iCKC/o79qBdTRj+PeOysZswKXainXI7IAY7+nIUpws
         jnLRS61+EsgM86LSSF/81fVYk4NZpmQFCcg/pmWZWwz4rr4UyuZV04WU07+D6khLP6yT
         phWXloXedUdjRkLx8hM/1tPqvQ8zJ272NuBA/npiV9jxZ7qKfd+y5lQqT/brR8p3/jFj
         aecQ5WnO5H0djimPRWtxAeHSbCV7aB050oJUcJBa3gVOfPrLubPRRWcAPZhQT1MvzvbE
         M39BeafkkF08BVOksjbrvOUxDGlEDLd5a1/k9Q9VjSaV9hTz/Alsi9TsdeOp/hJlMte0
         nwEg==
X-Gm-Message-State: AAQBX9fvFiNpNMucvgDEsABNcwGoSgGlE9t++x4lLbRIurn4PZHVVzvS
        LLkpFU7NdSZasEqyjbe6F9/jE7j6H10=
X-Google-Smtp-Source: AKy350ZjA9UWYuHJ9G8sIJb2natpBcdGdHsOq4OMDrZsqrrCI6h0IKHFMNHvOR6t6/3LEX5OC6RPUQ==
X-Received: by 2002:a17:90b:1bc8:b0:247:9d19:311f with SMTP id oa8-20020a17090b1bc800b002479d19311fmr19665285pjb.30.1682466632548;
        Tue, 25 Apr 2023 16:50:32 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ep8-20020a17090ae64800b0024739e4ad02sm865376pjb.28.2023.04.25.16.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 16:50:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Javier Mora <cousteaulecommandant@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Commit graph not using minimal number of columns
References: <CAH1-q0hReZoDWmXo7St10Dk6uc+6ZUQSxqvu1cJ7w3r7ftR9PQ@mail.gmail.com>
Date:   Tue, 25 Apr 2023 16:50:31 -0700
In-Reply-To: <CAH1-q0hReZoDWmXo7St10Dk6uc+6ZUQSxqvu1cJ7w3r7ftR9PQ@mail.gmail.com>
        (Javier Mora's message of "Wed, 26 Apr 2023 00:39:01 +0100")
Message-ID: <xmqq8refy114.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Javier Mora <cousteaulecommandant@gmail.com> writes:

> git log --all --decorate --oneline --graph
> # ^ displays a complete mess that doesn't resemble two tracks

"git log --all --oneline --graph --date-order"?


