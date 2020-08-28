Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C1C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE7920776
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 19:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="difcOBFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgH1TDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1TDL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 15:03:11 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D64C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 12:03:11 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id x6so535321ooe.8
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cYq2GTbZBnZn44HxXy33csfslChMo5ts8bvGg7XVu4I=;
        b=difcOBFVtXB6fqn4Y1QO8jyAtSH1NIyE7jxT/Tld2PPfZYmO1NPh1UdRJVQaPgPOSq
         N01sI5jhU8CDgfCoF4k72GNtlQpaO0Dr0W6tsHh5px+mWbk4I74v7Zi9+nFFthMWfC0/
         KreoKlL32GKJd+Ig9na4/pWwDUs+2AHf197VjlfQgrbt/AC4gTTiQVD+7UIsjY25VlVl
         pY/m2clST/o+tXS+nQ2nIweH5GM6ACoL3QxUrlpawEfhefCWoZa1OKvP9mXD1wk2n0XU
         OiVZoU1+8pxxmoRg6zl9Dbue9SBJAVIN7B+QrV75t+C1KLJMfnQPLU9i8S2roV1ibXWG
         q/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cYq2GTbZBnZn44HxXy33csfslChMo5ts8bvGg7XVu4I=;
        b=aJFagSoOWbCQIUApuL9neiBvvpp3qKjq4cKJkoWGWmkoe0EV8ioA+Zn34F9ZISdEs0
         1C/wzndN9cpjW+7IweDNzTeAFvERuR4k78d16pcR1ea03cdgSeP1DQy4mL4ZqaxkdK8Q
         U7U2gyo+rbrHhHJLnraotXdfJ97aAOzbaGhFGoZYuIhh8JaDapUh3qYY8pxJyvJ/liR/
         sHhWLGXCT5IowmbtiiDruW7zUTOmQ2dly53QtxcRGudzDcQOoJKUhQD5SrNL3vUKwglH
         Jxry7t89w7OLRGLpBoRhoeQZNwZCJ/vcRZc26ldZL/8i+Gql4KMv3RilAdtywOve9o6A
         0KQA==
X-Gm-Message-State: AOAM5302FcZldYo5i5ULsLPoTJ85ckN+G62m7xRCjT3lCoZ9592swJip
        trq5xXEjt0XEwk8tFtJRTKSS9GTj7GtDag==
X-Google-Smtp-Source: ABdhPJy2A45h5FIwM93zHEcBdBhEMLwcsh/FNg3A9LjLlWOCnmYMveWQrfREwrRM3PxHShIhP6ZT6g==
X-Received: by 2002:a4a:101:: with SMTP id 1mr21957oor.16.1598641390565;
        Fri, 28 Aug 2020 12:03:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b1a6:3982:6cb3:22b6? ([2600:1700:e72:80a0:b1a6:3982:6cb3:22b6])
        by smtp.gmail.com with ESMTPSA id i10sm18677oie.42.2020.08.28.12.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 12:03:10 -0700 (PDT)
Subject: Re: [PATCH] midx: traverse the local MIDX first
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
References: <20200828180621.GA9036@nand.nand.local>
 <20200828185039.GA2171353@coredump.intra.peff.net>
 <20200828185531.GB2171353@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <80ba7515-dc6c-3acd-4b53-c60cbdab1633@gmail.com>
Date:   Fri, 28 Aug 2020 15:03:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200828185531.GB2171353@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2020 2:55 PM, Jeff King wrote:
> On Fri, Aug 28, 2020 at 02:50:39PM -0400, Jeff King wrote:
> 
>> So I'd be tempted to say that the latter callers should be using a
>> separate function that gives them what they want. That lets them avoid
>> being too intimate with the details of how we order things.
>>
>> The patch below illustrates that.  It also changes the existing function
>> name to avoid confusion and to help audit the existing callers, but
>> that's optional and maybe not worth it.
> 
> And here's the same concept as a more minimal change, suitable for
> squashing into yours. The advantage is that it keeps the "the local one
> goes first" logic in one abstracted spot.

This is nice because it is more future-proof: if we needed to
change the order of the midx list, then we could update the
implementation of this method instead of every caller.

Personally, I prefer this one (squashed).

Thanks,
-Stolee
