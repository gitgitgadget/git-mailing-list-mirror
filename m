Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF9C7EE22
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 16:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbjD0QZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243324AbjD0QZE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 12:25:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D7D92
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 09:25:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24986c7cf2dso7500443a91.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682612703; x=1685204703;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NJFIfFgE7XpgkQPY4Zor5wxIRu1pBvGE+FOBEMXCS0=;
        b=n6LghvPNMDnWtKgzamNt3czs0m/+iyIMvFIWFsYslf7IdMbLr0fmn6uO8gdNR3j1Wv
         0PWHw0OKM6Piufru87H6+zZIfTpWPnXmHKS7z5rcDrkSEqhGKfkdSj6t4Gz7SUZ1h32N
         r7l2/yw7hoq4e8PEIQzmJAKWidK1Dam1CApMFGdquI/Xek2cWBQOF8wsc7c9I6+8zbfd
         jHSH+nUyM60ipDYBdacuX3eQFmBl5zqXmlfYoIdAeXGegzSRvKoigQnE6PrpjnJ/tZII
         JuEEJM+x5iYwYPW9WHFElVxnjPkqhGT997rPn7FUzWTClMNFAPcHtMai7XhMQLuk1mvB
         OIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682612703; x=1685204703;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+NJFIfFgE7XpgkQPY4Zor5wxIRu1pBvGE+FOBEMXCS0=;
        b=dKt35ok6ibemLJWk7aVhpChlgLoZr2/eIweVkbuRmnOJ0Zf95IjRmOMroyvaPdgKpp
         hoJommmjBGRtVxhagQFJ002d8cMh7sZUurexUiZdEbsYrisfWyFZuFv1RVsrg3lo+xgT
         GodXVsw45bZLhC0PYGYvCUgcmEeaDZ3nr5+atPd5BPSW15mYrrn3YeHiC9S137YVmM86
         KG5zhAbRYgLlt81dQirTJywXBklyhv0tvOvR9YblCORHbPDiI5RqMttPhzsn5c8IJ4Cr
         81ZcQNK2r/zYlX+JhToMfVIVR5wKnxi4mHGO7dpUTkD9VIYyWzhjfBlnNcnpbunhHwss
         uoiA==
X-Gm-Message-State: AC+VfDwLWyZ9fLMwWPvqg5/ZV8pxOjLECK/uDVChGHCKHu+C6lmBI5ZL
        4RIMGmZiZHIU+plRnMxXTvuayZ2Rkc8=
X-Google-Smtp-Source: ACHHUZ7m9hH7nK2377mvYeFQYT+Vg6GV0GirD5sBw+aakAQwUVI5lKWenK+WvaRSW4+zTum9WGl1TQ==
X-Received: by 2002:a17:90a:bc8d:b0:246:a782:d94 with SMTP id x13-20020a17090abc8d00b00246a7820d94mr2541390pjr.7.1682612703141;
        Thu, 27 Apr 2023 09:25:03 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902700100b0019a7ef5e9a8sm11895438plk.82.2023.04.27.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:25:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 3/4] parse_commit(): handle broken whitespace-only
 timestamp
References: <20230427081330.GA1461786@coredump.intra.peff.net>
        <20230427081715.GA1478467@coredump.intra.peff.net>
Date:   Thu, 27 Apr 2023 09:25:02 -0700
In-Reply-To: <20230427081715.GA1478467@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 27 Apr 2023 04:17:15 -0400")
Message-ID: <xmqqleidl2ch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In practice this can't cause us to walk off the end of an array, because
> we always add an extra NUL byte to the end of objects we load from disk
> (as a defense against exactly this kind of bug). However, you can see
> the behavior in action when "committer" is the final header (which it
> usually is, unless there's an encoding ...

... or it is a signed commit or a commit that merges a signed tag.

There is no need for us to be exhaustive here, but I just wondered
which one of these three commit object headers is more common.  I
guess the reason "encoding" came to your mind first is because it is
the oldest among the three.

