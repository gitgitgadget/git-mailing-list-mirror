Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B392C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjECV6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjECV6g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:58:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456C76B4
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:58:35 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaff9c93a5so27372355ad.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683151115; x=1685743115;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lS13Nw3zq0cfmRso2wkHJycNJR8Ufn6rYIWE/PmCWqA=;
        b=VcDKHTpkgmUPkaByk2J8haoH6ETKEcVQRD0TjxTwPnD5uHv5/rYN5420KLzjVSrpIJ
         a0qcFt5+uOLVJbnlx88yosgQRh/TNUlQDNFdI0F77UiMFsnvBneEyxpAOSGSpW6W0llf
         oQ0JDxvyYpEa1Ns9620u+48bIDg/dUI+1o0q7T51+3tvoSIO1iixuA30Jo3YrYEu109D
         NGG6OejIdL4PXIphuHVz7dtbcr4+Ef4j3BWS4LgH6kDhcbfVpdCd9ocTzEcySXZ7AT1+
         GpfvSZSwxmrWpL2UztVJUR+73/Q3TiiOvsfd4G+02fH394AlxmlwUP5aACB9tZPrTCRU
         s4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683151115; x=1685743115;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lS13Nw3zq0cfmRso2wkHJycNJR8Ufn6rYIWE/PmCWqA=;
        b=biWEeLGACXwcRV/ahix1zj9OlQK1Q5qoi9LaHcleT+Hw68Mo56Zx1mxBUUHeP1+Tc/
         lmzYH08V/H2ZoUmjFpdKvqLSwGcPmA9hYRnftCRjExOjbKxtU0zPREl6OpddfNMjWO4g
         joJC/kZMqCnUEQzpg+PTXDdK7UkcvEEEymkj7n0Tl+WZRKztpNplud1+rgAzKpd3joxj
         4SmyIk6tDV31OwXdHKQMzW4eT6I47MV/X/1sLoFT5DMGXMcTnfvq3IeHev7IudkoHW1s
         wQGR3kTRKEoZtfSJM8OCIgatwPjKGF6aFuAP9+GrWCRSC2UwTqqBHkrvf6gvC/rFSIrS
         iJOg==
X-Gm-Message-State: AC+VfDz8mEQJfykyi5JOI8hCM9lBKym776aWOpxL9RwhzU8ldtvcDyXh
        dgAADgtKaDYLHYI0IYNoZW4=
X-Google-Smtp-Source: ACHHUZ6yeaZ7qsf9VNNV7FOwD5kG9Jr19XTra60ED5hT90tAgDdEi9Fv6VfzLc32NsDRhD0kE7Ud0w==
X-Received: by 2002:a17:903:183:b0:1a9:86ca:38cd with SMTP id z3-20020a170903018300b001a986ca38cdmr1625978plg.2.1683151114681;
        Wed, 03 May 2023 14:58:34 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001993a1fce7bsm2555530pli.196.2023.05.03.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:58:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] pack-bitmap.c: use commit boundary during bitmap
 traversal
References: <cover.1682380788.git.me@ttaylorr.com>
        <91ed8c70f22dd2c47c60d650323579fc42cc7f2d.1682380788.git.me@ttaylorr.com>
        <xmqqh6t3ztee.fsf@gitster.g> <ZFLVQdjXoEmGImml@nand.local>
Date:   Wed, 03 May 2023 14:58:34 -0700
In-Reply-To: <ZFLVQdjXoEmGImml@nand.local> (Taylor Blau's message of "Wed, 3
        May 2023 17:42:25 -0400")
Message-ID: <xmqq5y99oz5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hmm. This is from code that Peff and I wrote together a long time ago.
> My recollection is that we only care about the UNINTERESTING commits
> between the tips and boundary (as you described it), but no further, and
> that we could discover that set during limit_list() alone.
>
> But maybe not? I honestly cannot remember. Perhaps Peff does?

Yes, that matches my understanding.

By the time you finish limit_list(), from the "revision traversal"
point of view, you have done all the hard work already, sifting
commits between the ones that are and are not interesting.  I am
surprised that whatever you learn only after reaching that point is
still helpful to optimize some operations.



