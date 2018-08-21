Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3A01F97E
	for <e@80x24.org>; Tue, 21 Aug 2018 20:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeHVAOU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:14:20 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50656 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHVAOU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:14:20 -0400
Received: by mail-wm0-f51.google.com with SMTP id s12-v6so123047wmc.0
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bWM4yk1gsCPEPkfPzZA3oSA7xqY8pbQqR8JBasojnlQ=;
        b=s7hlCu/ubofpcwP/5ahAiyY4is8Us9dMoM5e295Qv23T3fZ7gwYB0qucxJh2Qnz7CS
         AG1LpwCAIGzypDncYATfvRGi8Gt/a9QcyH5MoSsjT2zxAJsNtT1P536TSfHbIIKCzERG
         1Yp8lIk6x6UaqpG1B7+J0PxmqcptnaeS/9zA92gPtsVN/0m0rMoqunuslcpl/G1clZAY
         cYcU3d8iYZ4XV7IU5SShIPNqPG3rll4vwRCgNlJ28/tvE740uAzsDW+9PxP8rkJH73re
         3GvwSh2vrEl0kXCFipHibxzVeqe6RIXFqBSXHs278q+4zPNvS7ykxTdmtMgH4jsbkBvN
         UyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bWM4yk1gsCPEPkfPzZA3oSA7xqY8pbQqR8JBasojnlQ=;
        b=TNdCTITSQhkdi32Qzhepqnfv9wDWEmJA1BagPt9DkoVjW5UF1ndd9+Qrv27F6tVdOq
         pMjpIYWt2zvjdhLmqiLGuDLqpakChYzvgGQEIe0fXU+XzZyUy69pVxuz9WWWs+6tVcne
         PJRzO8nskDWGuIY5fGGKlyZRb6HH0eXJahKFAY5zHZHqE6/iwlLUlT3oiaCtJEyjrN4r
         9kIZq7mPWxIio0OnTsg2vNTTEtwvwts2sbqSTa2hY53RJVV4sXy4WFCdLCaLVMgjJ1/K
         FuQKaCt/v+oL2KNqTOOm/pwaoxidv63Q2s+kxQ89AawpKbKm1FkYqCjEgnS/Kc2BFEUJ
         qnMQ==
X-Gm-Message-State: APzg51CSQlA0u04I9C/CtYu0ma4vQPmWWZse63F0yjQt1rdlH+f0cDlD
        IYBizkCXEuCVM8F7deFqr9+DP0Yc
X-Google-Smtp-Source: ANB0VdabcJlqSejw3vffeH/Ik2xpYq4oNYYTxKmMK/ODoudIPh3ZC/acpB1p2DwS3kpJ47fE9eYcPQ==
X-Received: by 2002:a1c:b45:: with SMTP id 66-v6mr591981wml.45.1534884755075;
        Tue, 21 Aug 2018 13:52:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r30-v6sm25809031wrc.90.2018.08.21.13.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 13:52:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have" objects
References: <20180821184140.GA24165@sigill.intra.peff.net>
        <20180821190705.GF30764@sigill.intra.peff.net>
        <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
        <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
        <20180821200747.GA21955@sigill.intra.peff.net>
        <20180821201431.GA23263@sigill.intra.peff.net>
Date:   Tue, 21 Aug 2018 13:52:33 -0700
In-Reply-To: <20180821201431.GA23263@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 21 Aug 2018 16:14:31 -0400")
Message-ID: <xmqq7ekj8msu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Another is to tighten the check. Something like this seems more
> sensible:

Great minds think alike; is it a space was exactly what I was toying
with before I went to lunch.  FWIW I saw the full test suite passes
when I came back and then saw you had an identical patch ;-)

> I think there really are two bugs here, though. The find_patch_start()
> check is overly lax, but we also should not have to use it at all when
> we know there is no patch.

Yes, I was grepping for callchains, and it appeared none of them
actually expected us to feed "log plus --- plus patch" format.  The
obvious candidate to take it is "am" but we ask mailinfo to do the
splitting before the log message part even hits the rest of the
system.  So my inclination right now is to see if that is truly the
case and get rid of that bogus "patch start" thing, and if not, add
a flag to let the caller say "I know we only have message" to the
callchain.
