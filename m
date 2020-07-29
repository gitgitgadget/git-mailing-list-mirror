Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79C4C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3832075F
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHmZ+St/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgG2QzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2QzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 12:55:01 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E524C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 09:55:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so9638411qtp.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MeSbGaye104LqVoCmBiTGcarM+J6CjPBzBS1hzdfsPY=;
        b=YHmZ+St/euxSuJ5gT1FOqATeEG5RvNDQh49FIrXHWpZzLa+ACZYutUk9tF6NOSXc6y
         F8c7bZ8Jiq1t8UYl8y6TmVY8HWQQmPp4TM8JUMsvhCIqAeC04c4WPxCtDY9uqlhg2Tb8
         vEse/HnR2LNVZrQJSy9NXyCUUZpGoL6ad7z8jIlY87NUj+KgI1eaMVcnvtJ1pmAmoND4
         FDNEPDyPjNQ/40Rep/YRpK1V86YVEQ9+NwXdFHfg2ACGNB14MvKe5glU1MsnL54Cud3w
         FhUyTxRDg7Mat4oMpzR4li7nNreMvU5Tdr+nCLKo9R7LF8V9fVloi2dXqmQfGh/S0/cy
         Jh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MeSbGaye104LqVoCmBiTGcarM+J6CjPBzBS1hzdfsPY=;
        b=VHotrj0huikR/ViSa95CdIdxE66G49Vwk3gKl44Pj2Pe2dq286v0lID56uMfhSZ1y6
         B9zFJlDZsnLvfqXgfKYuxg4i599zXV6r+XACGDAh/ZS0GTo/sBBnugjxJCnsVII7xWAL
         aVxMrSxWg7UJtQggbJkLm/ZmS3QjN+gBcVITBpqKpa2s8DfoRZ2Q7cpBVjkf2A2O4Hht
         8X6PIwnVsUelxWKby1JCixveTHKxI+5TjjpEvTPCFnIq9Io3Lt1C4ftkg5fZM490PPSX
         ADL7OTgII3lfKRN1ChNKX+YQIVc6rmr2Gq/HeQevVUaMvgp6JV2897UrYTr8yGGnagEe
         Rj4w==
X-Gm-Message-State: AOAM531TBrrd4pso0qRF+iN5hQdIL/bVU0VPCr4mHWGzBJ7hEChyBffL
        JZ0oagGK/458EIvkf1nP4uVYLiB0oTU=
X-Google-Smtp-Source: ABdhPJw96SufMDT5bRdv4NrHlksTq19wDyP6VwS80+AOdgk7TO1KqYwVQBL+No+akk1UHvtHoozPag==
X-Received: by 2002:ac8:5218:: with SMTP id r24mr20991995qtn.300.1596041699604;
        Wed, 29 Jul 2020 09:54:59 -0700 (PDT)
Received: from Derricks-MacBook-Pro.local ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h15sm2188344qtr.2.2020.07.29.09.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 09:54:58 -0700 (PDT)
Subject: Re: [PATCH 10/11] strvec: drop argv_array compatibility layer
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <20200728202709.GJ1021513@coredump.intra.peff.net>
 <xmqq5za7cm8e.fsf@gitster.c.googlers.com>
 <20200729000430.GA1623001@coredump.intra.peff.net>
 <20200729003720.GA1653374@coredump.intra.peff.net>
 <20200729004009.GB1653374@coredump.intra.peff.net>
 <xmqqlfj3b0zy.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <30933a71-3130-5478-cbfd-0ca5bb308cf2@gmail.com>
Date:   Wed, 29 Jul 2020 12:54:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <xmqqlfj3b0zy.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/20 8:47 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> And here's a diff between your current "seen" tip and what I get by
>> merging in this updated version and then doing any necessary resolution
>> or fixups on top. I'll leave it as an exercise for how you might want to
>> pull the content across. :)
>>
>> I do note that most of the new call-sites are ones that would be better
>> off using child_process.args, and reviewers (myself and others) have
>> suggested that. So those direct uses of the "argv" member may go away
>> anyway.
> 
> Yup, I do not think we should spend too much cycles on this at this
> point, as Stolee's topic and others that add new callsites are
> likely to be rerolled at least one more time.

Yes, I immediately thought that my topic would cause some headache
for this conversion. However, I'm happy to rebase onto 'master' if
this topic is merging quickly.

> It is tempting to declare that these 11 patches are now perfect and
> we'll stop the world and fast-track it down to 'master', while
> discarding any and all topics in flight that changes anything
> related to argv-array, and then we ask authors of these discarded
> topics to send in a rebase on top of the 'master' with strvec API
> already in.  But I somehow think we do not have to take such a
> drastic measure to adjust the world around this topic ;-)

I'll keep an eye out for how you plan to resolve this.

Thanks,
-Stolee
