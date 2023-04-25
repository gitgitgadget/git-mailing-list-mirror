Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A700BC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjDYSyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjDYSx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:53:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3718B80
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:53:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso4907577b3a.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682448746; x=1685040746;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ySchA/rbFTUIZxKOk7ewKdfNlyNN7M9VgxrNWz/GJJ4=;
        b=dZBuwSiXsn4pp5B/T3R2qBNNiRb4eQxncRs5j+h1085LZM9r5E2TJ2s53BYf9dMslg
         niiIpsVDrONSzKQGst/eFJN29dS7ZabX/LsfdgBi2jo31i2YjyN0IrPI2aE6p29GuPlI
         Q00peEhN+FThgTwgG+vQjUImyeccBEY77xof7g2rzH+YkEs6p3huPLY27BwsFvHSogSJ
         SLAHNw5fjzFesn7shcLCYdUHvtU16HDWaSFwxJjJUoI53N3/GS22jMCRk9ZcoyBNUt+x
         8CTcn4p3XE7e9PyR/6yVHsR7f/Hf+Ea20L7XZESyYBSEVpVjSqOapsYOXIadPWpvOQrI
         COQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448746; x=1685040746;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySchA/rbFTUIZxKOk7ewKdfNlyNN7M9VgxrNWz/GJJ4=;
        b=Io3xnJRyCwGwoIKnk2KfWumbHIi+G1Jtpa+mDtFXY6jTZbvwbwAgXuB3TwWP+pfiNT
         puJGGzbmxXr29v758KpYYlqIegIHIlcL0zDg0A5wWTbzFD2FOQQVF4KqiVJbRCUkzKmu
         jkG4CQ9MKPb98pd5BxCtIVxzSjXjzdWoY34M+QL1Bo0vXi1dmeW2VcSzL61SR/eTHCgY
         CFAYVGtKnMJCyCcSpYOCgbL78A1a9LNAa5TYGD8p/VkP2LPC/TH3dHYuELVfR+LKoyOO
         7aHu13KtcHf8xe9+DaRTh3xKkMPEnT3ob3Hnse4JTty9Z4vzgiZ3o3JLYHdhox0WRgqA
         eFbA==
X-Gm-Message-State: AAQBX9dsaPehCT1o69UdNg/lTUBfavdwlmiqW6eux6KLehJQ4itp3pfU
        QiRAxYJl1i0so/HcRKmnSzQ=
X-Google-Smtp-Source: AKy350a00o81qnL6AKu6K4PrW8RYb8r5TIlUuzsNylpSQsz9GEss212fpzNbLmLKE0Ke/WW0AJXQdw==
X-Received: by 2002:a05:6a20:1593:b0:f2:fcba:7872 with SMTP id h19-20020a056a20159300b000f2fcba7872mr15760137pzj.28.1682448746212;
        Tue, 25 Apr 2023 11:52:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id fd17-20020a056a002e9100b00625f5aaa1d9sm9640348pfb.83.2023.04.25.11.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:52:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] pack-bitmap.c: use commit boundary during bitmap
 traversal
References: <cover.1682380788.git.me@ttaylorr.com>
        <91ed8c70f22dd2c47c60d650323579fc42cc7f2d.1682380788.git.me@ttaylorr.com>
Date:   Tue, 25 Apr 2023 11:52:25 -0700
Message-ID: <xmqqh6t3ztee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>   3. Fall back to the ordinary object traversal if either (a) there are
>      no haves, (b) none of the haves are in the bitmapped pack or MIDX,
>      or (c) there are no wants.

Tangents.  If there are no haves, wouldn't the answer by definition
everything that are reachable from all wants?  Is there a reason why
a bitmapped walk cannot fulfill such a request?  If there are no
wants, wouldn't the answer by definition an empty set?  Again, I am
not sure what the ordinary object traversal is expected to do in
such a case.

These questions are not at all important, as this part is an
explation of what happened in the old code.

> Relaxing the bitmap traversal to allow it to produce over-counted
> results gives us the opportunity to make some significant improvements.
> Instead of the above, the new algorithm only has to walk from the
> *boundary* down to the nearest bitmap, instead of from each of the
> UNINTERESTING tips.

Is it only me, or are all readers equally confused by the use of
the term "boundary" that hasn't been given any definition?

> And is more-or-less equivalent to using the *old* algorithm with this
> invocation:
>
>     $ git rev-list --objects --boundary $WANTS --not $HAVES |

It is especially confusing because the "--boundary" (at least as I
originally had invented it), i.e. a commit that is smudged with
UNINTERESTING bit, whose parent we did not bother to dig further to
paint with the same UNINTERESTING bit, is not something we start our
computation with; it is something we learn _after_ completing the
history traversing.  So I am utterly confused X-<.


