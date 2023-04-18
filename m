Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39396C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjDRUrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjDRUry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:47:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC46B759
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:47:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b73203e0aso11587452b3a.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681850855; x=1684442855;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1L+R71d/6Xo4RBRtnRhlf/6lCxcWdLgrDZJFAG/EkE=;
        b=EId/GIRe06YNycEe6wavvTMcjcgUefjWpme1ojstBfNt5mENYXxPl3EHkYPNNTodiD
         d6ZhxFDYQxTO2Nx0D7jfqacfwar/8z3UoyFQ97v81cVQqwbVH6nqlSz6SQcASHMpfiXn
         glRE3x7dZlKjF0azVUTut+H0q3OXv2dlxU1SK+Ig2T7m8OeI4t7wXjzZ/D2COwvKQdKr
         MpiUW7rrNXzDpBEVVzfgHQ6A7fMJ2dMQTuPy8ER9ypANWZKAZWcXxhhoRBQipRXrs//0
         gqAvJQ1f+r+ndIl3RWOtwICQWI/VXvvXNH0uwlfjpHL6M2TqLcWon6hbyU78FESMvzvH
         nGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850855; x=1684442855;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f1L+R71d/6Xo4RBRtnRhlf/6lCxcWdLgrDZJFAG/EkE=;
        b=BSTYdRe69ZkPV30xtgcEcW3LkC3sHoMUzw+tX6F7vJfPwEc879eCkLBBwgLhoEWkxK
         413S0lCPO5IjsVqFYbCvLjtlZutyB7WBhpFj6QCmsNeGBH6lcz+nYJRfPz/Cw3qyJ7V/
         L7iJ1nOZUhUPvCLMZPxEAXXCxBQQdpETz9S1uyL44JUu8TI1f9+BKKdOALIEXvQ/VC0m
         kb90fpPtyuux2MLv9uBm94ApG7kjh5lTc1Jev1vmdL61LFjoV3cSTnWmuApKpKgZiP+H
         nwJ4Es5EXmPT/mcUKLSSDvJzTpNzr2SiZjjuADx2WDyjbSYoh8oVC/W6YN0HQoRyrRCM
         GO8g==
X-Gm-Message-State: AAQBX9cC3O4udMyV4YjTBxE/D326CnmwYBAWgTzRpTgV3MpL5+r+e2m7
        NIAxWV9CyZ24nNh7j4fJk9E=
X-Google-Smtp-Source: AKy350aAca5DRL5d3Ptk/NzYnuqEKNMmtboQ4PJHQoNbTSeAa/ScUr9+Eq4SVr0ZimVz2bmN6t8lnA==
X-Received: by 2002:a17:902:d503:b0:1a0:53f3:3761 with SMTP id b3-20020a170902d50300b001a053f33761mr113142plg.15.1681850854659;
        Tue, 18 Apr 2023 13:47:34 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b00199203a4fa3sm9914202pli.203.2023.04.18.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:47:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, Michael J Gruber <git@grubix.eu>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
        <20230416054735.3386065-1-newren@gmail.com>
        <20230417073827.GA39931@coredump.intra.peff.net>
        <xmqq1qkio4cq.fsf@gitster.g>
        <20230418033904.GA60552@coredump.intra.peff.net>
Date:   Tue, 18 Apr 2023 13:47:34 -0700
In-Reply-To: <20230418033904.GA60552@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 17 Apr 2023 23:39:04 -0400")
Message-ID: <xmqqa5z4dijd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> All of that makes me wonder if we wouldn't be just as happy with it as a
> string in the first place. In three out of four locations that use it,
> they want the string anyway (to feed to getaddrinfo). And in the final
> one (git-daemon), we need to convert from the user's "--port" anyway, so
> there's always some string-to-int parsing. And depending on the #ifdefs,
> in most cases we turn it back into a string anyway to feed to...you
> guessed it, getaddrinfo!
>
> The exception is when NO_IPV6 is defined, in which we do want the
> numeric value. But we could delay parsing until that point (and
> otherwise let getaddrinfo handle, which seems more correct anyway).
>
> Something like this (though I'd probably split it into a few patches to
> reason about the motivation and implications of each):

The updated code keeps the "port" as a string and turns it into a
short integer only when it is needed, which is nice.  In the future,
parse_port() may even want to be extended to call something like
getservbyname(), to allow something silly like

	#define DEFAULT_GIT_PORT "git"

