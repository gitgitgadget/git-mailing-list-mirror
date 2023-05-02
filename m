Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ECFC77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEBVbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEBVbe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:31:34 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252BF1992
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:31:33 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6a8955b3462so1604046a34.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683063092; x=1685655092;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDuYYBbnW8KGtDIUz0d4mz3E0G354Ehca1X9zmmuip8=;
        b=DXLSEJ5GVZXB3Bs1YAiM7ePnJuFPfiZTLMgIGcZ5vAePKiZBeYn9+RLlbdp3GHRMVE
         y0M1BgeVWxYAKEoLjnMaVBRaCzljg4E7zbEPjs9WTLKE5YXUv6reOwL381v+TZOkfNIJ
         KoaG9StT3Qv7rp6UZXM0hxUWGwyKuIePgBBt2Ci5B0jTVuvJxLnA7FHhLxCDNLchtiND
         ERDxtDNcwu7dTBW4gPk4I+pwazPVrQsPQNmI5rNlINNmupWOE/DtmuUfxaIQuJxK/AC2
         GglKeEMf8pIpPp9K1mLmq+zX/PAHga+7Eu5cmP9/qdmzbB243sUQ4HEvEnouDoo+tw0p
         9ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683063092; x=1685655092;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tDuYYBbnW8KGtDIUz0d4mz3E0G354Ehca1X9zmmuip8=;
        b=Okw50dUgo3vkT+XenjU/B8jmgCzLL6/T8rdBTAtu7pB09+XAb6XdfaZn5U5WGFLECW
         4DMxjdt9k2yaf99Eg4bbFau3aYigzGgmOkWTspbl0tLa03aYIhlx2XI3ygHDj2P0t7Ox
         HFTeF5foZjm/PtYbmVFfzVHIjH0sgBld/lUXkiH8sg3Dhms75CB351SLL61/Ne6MvBMi
         cg4oRLPOlXN8LyS/PeIZ14Uaqq9eFDA6dwpXyyYWrP7AFJbqDdYjKQEYuBKbApShLOn0
         F79jZgxMr12EnBxZLnDRoDOkZEP4ZdAkduTtEcSWYq4qaQAL5Y16Ms84dIdNvCG0yEZb
         RhEQ==
X-Gm-Message-State: AC+VfDyxd8IdBA45zI18iW+lIkLE4oQX9/8tg9CxpqIR9NVZ5N8eevlJ
        6QB4Ia0mUSi4/yum9rzQj0Y=
X-Google-Smtp-Source: ACHHUZ6lfQfuLfMu0hd47zQti09Y3KZ5OS1ln8WDMMmpRmTeJjl+Mc77bUDXa0AjBfJqd1ibyiCdLg==
X-Received: by 2002:a9d:6d06:0:b0:69f:578a:d1ea with SMTP id o6-20020a9d6d06000000b0069f578ad1eamr9540976otp.32.1683063092453;
        Tue, 02 May 2023 14:31:32 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p21-20020a9d76d5000000b006a3df644d31sm13254907otl.37.2023.05.02.14.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:31:31 -0700 (PDT)
Date:   Tue, 02 May 2023 15:31:31 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <64518133eea7_200ae2948a@chronos.notmuch>
In-Reply-To: <xmqqh6t3ztee.fsf@gitster.g>
References: <cover.1682380788.git.me@ttaylorr.com>
 <91ed8c70f22dd2c47c60d650323579fc42cc7f2d.1682380788.git.me@ttaylorr.com>
 <xmqqh6t3ztee.fsf@gitster.g>
Subject: Re: [PATCH 3/3] pack-bitmap.c: use commit boundary during bitmap
 traversal
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:

> > Relaxing the bitmap traversal to allow it to produce over-counted
> > results gives us the opportunity to make some significant improvements.
> > Instead of the above, the new algorithm only has to walk from the
> > *boundary* down to the nearest bitmap, instead of from each of the
> > UNINTERESTING tips.
> 
> Is it only me, or are all readers equally confused by the use of
> the term "boundary" that hasn't been given any definition?
> 
> > And is more-or-less equivalent to using the *old* algorithm with this
> > invocation:
> >
> >     $ git rev-list --objects --boundary $WANTS --not $HAVES |
> 
> It is especially confusing because the "--boundary" (at least as I
> originally had invented it), i.e. a commit that is smudged with
> UNINTERESTING bit, whose parent we did not bother to dig further to
> paint with the same UNINTERESTING bit, is not something we start our
> computation with; it is something we learn _after_ completing the
> history traversing.  So I am utterly confused X-<.

I don't know if it's the case, but in my mind all the `--not $HAVES` are
boundaries. Some of these might be overshadowed by another boundary higher up
in the topology and thus not shown, so in a sense are "uninteresting
boundaries".

Perhaps because you invented `--boundary` you think a "boundary" is only an
interesting boundary which must be computed, and all the other are not true
boundaries.

Cheers.

-- 
Felipe Contreras
