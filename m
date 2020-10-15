Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C2C43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EE122258
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1hAD+Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbgJOBUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388058AbgJOBTi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:38 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D11C004589
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 17:04:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h6so688386pgk.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 17:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7XCgWgcOgtb5ZeyKN64UmLeM5nrTuVqVzOiGROOOwUI=;
        b=D1hAD+Ru1L4e1k5ctNpPZ1rjDFFR0ZxV/+YBriTGreF+OmjMVRb+CarqOc73XHOlgX
         pzsEPQ8PpXCBNaKUS/pzPsJQGrq0xDWplldiGOPFAZ/tc9IcEQzAyTOXEskV7R6ZBIuw
         fMVeaAza5RnxeQN+TcHcb4RD+oago6kfL2O/AD0Fdg9sQZLXizNQ7Z52mbNy1tb4YR0H
         R/5/yqFTKPwifmH2w9lujk3ROG2dDA7IsCBPHYcMTIdnaW/nP8HOjeZ3CvP0J6lRYGud
         9B1yLNBJfo2ZZU8ttdqY7C3iUGIAnu4SeYj+nVbDFscFeL/5P+Ejr42qckRVDDhm3x01
         g4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7XCgWgcOgtb5ZeyKN64UmLeM5nrTuVqVzOiGROOOwUI=;
        b=MOO7j8CevTJPKgLzi4jrq59GukoI8npC1KFIHDXTEKggB3uc9n8HTFTd8QQHDhyXxg
         DwlTKUlKBRBsV90SIngXuZDrue7vluodIs2WJbRctRhcegfeSSFxvB0JrWnTkg4zy2UY
         x+811nc0FA2HZ5QZYHJ0c5HOwj+euEgOdeKAr0t027AZpRkV/507ehfXBJY6nBxvhtr8
         VVuaa8oipjmSuNTS/bNobrOl4bCFUrSq4tdDCmpNJmhmc5FrosUVv089LHHmgrvqP2Jk
         mnFsrKP9nWYmbbwJpTJcKd+5b7f3AsTgv20fj5OsTngKEALgaPVGV6HU4B25dGvBwrqF
         LTag==
X-Gm-Message-State: AOAM530Q6vXb8zYg1l172sVJHomoR2g9990Y+kKBww//fWEF8KHXQXQY
        fgl3bPC6vZoOR1yA9OLtQMdnNyGc+OY=
X-Google-Smtp-Source: ABdhPJzVCbQWhtLpAHCMXK1YvL8b56XFtTxc/hncaEvPnlawUdTOXYb7kuz+mD3MxFwF5tC2bMx+fA==
X-Received: by 2002:a63:e547:: with SMTP id z7mr1193486pgj.12.1602720253608;
        Wed, 14 Oct 2020 17:04:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id h2sm737387pjv.4.2020.10.14.17.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:04:12 -0700 (PDT)
Date:   Wed, 14 Oct 2020 17:04:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Sean McAllister <smcallis@google.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
Message-ID: <20201015000410.GB328643@google.com>
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-3-smcallis@google.com>
 <20201013211453.GB3678071@coredump.intra.peff.net>
 <CAM4o00eCKP1+f=xBw4LJfNqrstEnutAe9StxknW9qLMtPBdhKQ@mail.gmail.com>
 <CAM4o00fO++JMNdES03JKRyxmZtiLjkrJ2nux0-TZYBdH2+0ijA@mail.gmail.com>
 <20201014193456.GA365553@coredump.intra.peff.net>
 <CAM4o00eZjr2apH6WO-sTvuOfR-cuiSh1yhh3j=14ZFstXDz7bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM4o00eZjr2apH6WO-sTvuOfR-cuiSh1yhh3j=14ZFstXDz7bA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sean McAllister wrote:
> On Wed, Oct 14, 2020 at 1:34 PM Jeff King <peff@peff.net> wrote:
>> On Wed, Oct 14, 2020 at 01:10:46PM -0600, Sean McAllister wrote:

>>> I took a look, it looks like CURLINFO_RETRY_AFTER was only added in
>>> 7.66 (September, 2019),  so
>>> I don't think it's reasonable to rely on it for getting the
>>> Retry-After value in this case.
>>
>> I agree that's pretty recent.
>>
>> How important is it that we respect it? I.e., we'd have some sane retry
>> behavior if the header is missing anyway. On older curl versions, how
>> bad would it be to just use that fallback behavior all the time?
>
> Some large projects (Android, Chrome), use git with a distributed
> backend to feed changes to automated builders and such.  We can
> actually get into a case where DDOS mitigation kicks in and 429s start
> going out.  In that case I think it's pretty important that we honor
> the Retry-After field so we're good citizens and whoever's running the
> backend service has some options for traffic shaping to manage load.
> In general you're right it doesn't matter _that_ much but in at least
> the specific case I have in my head, it does.

I see.  With Peff's proposal, the backend service could still set
Retry-After, and *modern* machines with new enough libcurl would still
respect it, but older machines[*] would have to use some fallback
behavior.

I suppose that fallback behavior could be to not retry at all.  That
sounds appealing to me since it would be more maintainable (no custom
header parsing) and the fallback would be decreasingly relevant over
time as users upgrade to modern versions of libcurl and git.  What do
you think?

Thanks,
Jonathan

[*] This represents two cases: if CURLINFO_RETRY_AFTER is not defined,
meaning that libcurl-dev was too old at *build time*, and if getinfo
returned CURLE_UNKNOWN_OPTION, meaning that libcurl was too old at run
time.

You might wonder how we handle the too-old-at-build-time case.  The
usual trick is to provide a helper function with a stub
implementation:

 #ifndef CURLINFO_RETRY_AFTER
 static inline CURLcode retry_after(CURL *handle, curl_off_t *retry)
 {
 	return CURLE_UNKNOWN_OPTION;
 }
 #else
 static inline CURLcode retry_after(CURL *handle, curl_off_t *retry)
 {
 	return curl_easy_getinfo(handle, CURLINFO_RETRY_AFTER, retry);
 }
 #endif
