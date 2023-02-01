Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2B2C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjBAXW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjBAXW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:22:27 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F342333D
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:22:26 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 7so96025pgh.7
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 15:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtmgajF8KYBQcNh4qvi5kJMPA6MEHarp1XaMmlXQqbE=;
        b=DR28k9mWITwePPGGbBT+C6a3iXiZoxTA9c3qIRujEHYVCPYWKsHhsPbdaoS0M/bALX
         zP0ApmE5HglpBYFIAUCsd/FKf/jMbk9bSuXZaYbN+2q7ivGL2lHxUm0b9kjpytWndQSo
         jK63XeLsb8Yf7gLLiGS+vVN5mUpatFMshE0/FuSY3J/8uPJF6ehiqxOfV9O4Jy0iEmHK
         rcvsq+bCcSowwW43V10V9r7OasZl0xmj1AeTexhpGD4GfpF7UCkhQjE9EqWYfaBTaLTl
         nnnFDOGnL4qJ57ipMOG4kr7JsjaX78sefyJ6f5FIKBU/QwhPiDekilDZRTNEenENkCHj
         VKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtmgajF8KYBQcNh4qvi5kJMPA6MEHarp1XaMmlXQqbE=;
        b=tFssBqPRvgi5mLT6lTK9MzMdVKEaH2RPQyXp0J/eaGwB2SgXa22rBjXzCIJwsxFN95
         eEbrnO6pDMOwaVUezFNsPw+wPyxskGUOGVW9uY/ths6P8pgL/gbdFQnRv8W01pby7k5n
         lp1y5AUrGjKkQB1hTUlFqGFOZxWyB7xEdCqUUFtJXfZZPfQgK9O5pjPVjZFUjq1FNwM4
         4645TE+sECsRDIttQD1BNg3pGWsDeCk/cj9nPR1qVKZnh7dtOg9/UHzOqkR1ZIeaZNNH
         ATsdn/b7cDCv5lw0btHNLYWh1YrQmpqUNRyZk1sEjVgKWLGXilhsCwNGdpPbRKRf/mlJ
         WHBw==
X-Gm-Message-State: AO0yUKWQSyJ6bXTMtcUuvesVCZXmO8MVvaq5vQukJQUAQMuPaPxHlAXa
        xXwZLj2iMeKCNQtmvNc18rEQCaqlNfU=
X-Google-Smtp-Source: AK7set9fCTVKTrWq67p+ReNuGs6DN/GRbwjezYlscSw/zZ6wTSpo+08KwqK6Em+4Dq7waTESDD4HFA==
X-Received: by 2002:a62:3855:0:b0:592:6204:b0dc with SMTP id f82-20020a623855000000b005926204b0dcmr4037131pfa.19.1675293745442;
        Wed, 01 Feb 2023 15:22:25 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id a15-20020a62d40f000000b0059275411af8sm10583621pfh.62.2023.02.01.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:22:25 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] imap-send: replace auto-probe libcurl with hard dependency
References: <20230201113133.10195-2-worldhello.net@gmail.com>
        <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
Date:   Wed, 01 Feb 2023 15:22:24 -0800
In-Reply-To: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 00:04:24 +0100")
Message-ID: <xmqqlelhx973.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change the "imap-send" command to have a hard dependency on libcurl,
> before this it had an optional dependency on both libcurl and OpenSSL,
> now only the OpenSSL dependency is optional.
>
> This simplifies our dependency matrix my getting rid of yet another

"my" -> "by", I think.

> special-case. Given the prevalence of libcurl and portability of
> libcurl it seems reasonable to say that "git imap-send" cannot be used
> without libcurl, almost everyone building git needs to be able to push
> or pull over http(s), so they'll be building with libcurl already.

OK.

> So let's remove the previous "USE_CURL_FOR_IMAP_SEND" knob. Whether we
> build git-imap-send or not is now controlled by the "NO_CURL"
> knob.

OK.

> Let's also hide the old --curl and --no-curl options, and die if
> "--no-curl" is provided.

In other words, if we are building imap-send, we sure know cURL is
there, and there is no need to tell a running imap-send not to use
cURL to talk to the IMAP service?  I am not sure the linkage of this
change with the rest of the patch.  Isn't that a totally orthogonal
issue?  Your imap-send might be cURL enabled, but unless we stop to
ship with our own IMAP routines compiled into imap-send, --no-curl
does have a purpose.

Or did you just forget to document that we stop to ship with our own
IMAP routines in the above?  If so, as long as it is made a bit more
prominent in the proposed log message in a reroll, I would be happy
with such a change rolled into the same patch.
