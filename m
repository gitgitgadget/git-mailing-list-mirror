Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ACBC54EAA
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 22:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjAZW1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 17:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAZW1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 17:27:10 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757345618E
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 14:27:05 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g68so2060261pgc.11
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLn1yoECvnfWOnj6adWbW6VI5XL1B0vQq/bxEp0vWQI=;
        b=I1981EAMRkQ4BrjoQRxoK3OTQJb1l/TrVCP/EbG/UfPfuh9UV8l4kPwsmDsBQDNEcG
         egsI433l3/epqAVnhz3m6ConjNlnr4jshPIOGVgirBTOUB/uhKOuZsbAn1S2IG5Lc9Wx
         CBKRi5gMKUOu6l5FiSqDGP+6ebjQz6VSnAtlgo0qp7H5ilwvNjsElH1XMCK8o/sOLcew
         aFpYRucQC2NIzQqcH0GXKNHFMpKFkDYNhgqkPu9hwOaNSWKk+7hijFXWGsvKx9XdGGPe
         af+tKlicxL+OFRgNapT6IV5mtMBUCmRBARdV8R91SxGupwaoZj4ofQ2tQubBhqYuE5oU
         e1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OLn1yoECvnfWOnj6adWbW6VI5XL1B0vQq/bxEp0vWQI=;
        b=IKyPaPXptWW6h+XJGQWI25y1EZqPiCrQTMrT2pTAD1b0/op2QWmNHdvFxnkZusBk5u
         zaAJkqcLGQCqg4h5AsDK5F1yP007P47Z01Oy+388TqG82ZAVkDqU5JCumjm1FTDvGJ/s
         0GOYh5zmJ+Er1TWMjOpm/9+nJnMPlRg6eDV6CGDR2Mer4HxnCYGo4+tmpzOF+RyDRioD
         QP25+ZFaJB/W5ms0kgLZwoX/chLWpKsOKXmHWB2tXgY9eDppG2vLcemBcdGbKU08JajZ
         /3Mv3h/IRkvWG7WPFnq/A/dviozbIi6a0B+PGLinD8bS+ojG22lREvhLl6xLwO/i1VmC
         FdpQ==
X-Gm-Message-State: AO0yUKULgbXceuMIHCOkrhDmmsSnYi4EJfGYzr58tUSHtGZXmYrUoPIX
        yoVPLtLHzyiEQqzCblQBaMqbYz8/EK0=
X-Google-Smtp-Source: AK7set+W6yRNup9kS8b5GSRPMh57IQL07FdPs3+zerZIavQIB1tcvuIbMnSGzSNDBKx1rAEecrq2MA==
X-Received: by 2002:a62:1502:0:b0:58d:f20b:5f2e with SMTP id 2-20020a621502000000b0058df20b5f2emr3295919pfv.1.1674772024864;
        Thu, 26 Jan 2023 14:27:04 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id q19-20020a62ae13000000b0058e1b55391esm1341493pff.178.2023.01.26.14.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:27:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 08/12] test-http-server: add simple authentication
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
        <b8d3e81b5534148359c7e92807cf1e2795480ddf.1674252531.git.gitgitgadget@gmail.com>
        <Y9JPslSoEayaCJ3n@coredump.intra.peff.net>
        <Y9LvFMzriAWUsS58@coredump.intra.peff.net>
Date:   Thu, 26 Jan 2023 14:27:04 -0800
In-Reply-To: <Y9LvFMzriAWUsS58@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 26 Jan 2023 16:22:28 -0500")
Message-ID: <xmqqwn599bk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I suspect this could all be done as a CGI wrapping git-http-backend. You
>> can influence the HTTP response code by sending:
> ...
> And here's a minimally worked-out example of that approach. It's on top
> of your patches so I could use your credential-helper infrastructure in
> the test, but the intent is that it would replace all of the test-tool
> server patches and be rolled into t5556 as appropriate.

Thanks for helping Matthew's topic move forward.  I very much like
seeing apache used for tests in this sample approach, like all the
other http tests we do with apache, instead of a custom server that
we need to ensure that it mimics the real-world use cases and we
have to maintain.
