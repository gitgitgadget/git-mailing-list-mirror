Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB09C43467
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F1622280
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPK484Ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389924AbgJIQPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389911AbgJIQPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 12:15:34 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A652C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 09:15:34 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id y127so2481177ooa.5
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sMEGTIJzHdJnOhwpyFqds6v34z3ggvIbdWR42Guu1B0=;
        b=GPK484Ut+LKWKY23mddNVQtvbAXuASzYC73/zZHngwz2/jLzHkBRsQUXVSbBQE56XG
         5z2fCMbCsrT0f/RbbQcsJq+9Llrzxs8i7Xzl2KgR0dYktV4yFPu2O5NHJ5fFkhaubIRD
         PUGMWhF0R3W33n2geqkAX0dNe+Q6imn3BHwhsx359c6QB4+o6lUHm5S46TE/Vq+dcHfc
         CfrXwDvpbsjIV1mk7OsdXqWdlHL/T/M+I4PuEg18YnSOQG5lGR+SUQuA5AVsu5S8mIVi
         71wJYLlFSiWMUFszi5EXDJwLPH7Yw4jbNY1Y7fFplhuIKEgQdcISZJ/EmLbB0q0EJRgU
         EHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMEGTIJzHdJnOhwpyFqds6v34z3ggvIbdWR42Guu1B0=;
        b=emCtOFv9AaNvsoAfADGwW90Ckl7HmUMMK856i54YZKwDwrDMtB6C2upiYxaqfeTm2M
         s517NlX2BUn+XXt5m80nfFJBzYYrvqBHS74nzKSkeCQgUCzQey9OwYwjt2lWylPQ/8W+
         hZJhzqhV//JVhzm3L2PFQYrBwbkMSLWbwDEqmhG2yD8nwgZuna1D0ooBt/2cvJSRT/Xl
         vV4KPKhnlA9yhaou7SSoqCLPpmIL3vWDEO8LyRwpDp+QLerj2XNeYnEJZVoAlfRkJz1O
         OwIVFAgBDwx9XEDg65CsrBZ55BxvfCIPSGRVOGfCaKTZGo7oJg2DgVFv/jH0c+DHthJo
         H/Ww==
X-Gm-Message-State: AOAM531ZUG+QpAIUCMt+TP1OSC6htVgAHhIc5pcUCoxGfa54J0BMByHq
        KLnDVnIBRdFOzRc6MIybK4HQ1uqCps3z7g==
X-Google-Smtp-Source: ABdhPJyTU+IlFujTptcPv4Y0IkvoO5amwFL2g8S0ni2XQurtezxEyTCK4YLCa8gxcY+KSTftsL8otg==
X-Received: by 2002:a4a:9b01:: with SMTP id a1mr9703528ook.51.1602260132970;
        Fri, 09 Oct 2020 09:15:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:859b:7143:ba12:a6eb? ([2600:1700:e72:80a0:859b:7143:ba12:a6eb])
        by smtp.gmail.com with UTF8SMTPSA id f13sm7360034oij.0.2020.10.09.09.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 09:15:32 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2020, #02; Fri, 9)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq362nv18o.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <512a3dc5-4937-8679-c4c8-5144ac50450b@gmail.com>
Date:   Fri, 9 Oct 2020 12:15:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <xmqq362nv18o.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2020 11:59 AM, Junio C Hamano wrote:
> * ds/commit-graph-merging-fix (2020-10-08) 1 commit
>  - commit-graph: ignore duplicates when merging layers
> 
>  When "git commit-graph" detects the same commit recorded more than
>  once while it is merging the layers, it used to die.  The code now
>  ignores all but one of them and continues.
> 
>  Shouldn't it make sure all copies match, or discard all of them, to
>  avoid random corruptions kept in the repository?

Making sure each copy matches is a bigger change than I would be
comfortable with in the rc window. If you intend for this to at
least be in a better state than before, then the current fix is
safer than doing that harder work. If we had a clear repro that
was testable, then I might have a different opinion. (I see that
Thomas updated the thread with a possible repro, I will get back
to him soon.)

As for discarding them all: we would need to add code to "reparse"
a commit from the object database. Perhaps that is doable, but we
have so far not removed data from a parsed 'struct commit'. This
is probably the easiest way forward to guarantee correct data here.
Again, let's find a way to test this before committing.

Thanks,
-Stolee

