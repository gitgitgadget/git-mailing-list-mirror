Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ABBC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 20:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56471223EA
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 20:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eG1tyxwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgJSUZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 16:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJSUZj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 16:25:39 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8CC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 13:25:38 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w17so1653048ilg.8
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QG39mGYFZq98MzXP0YSRkCdlPGT299Z3tUimM3ILiic=;
        b=eG1tyxwKsT3RMER6vOLrNubr5c/oDzmOD79LxkXbdWsjgqMSULY5mAfHC9Z2DFKAZC
         fwzfdngSa29JCaFKQEm/ubvX3XRRbeMF4obQeKmTA8Q/ldbQjQbmXRmCcKDQlPyZLHaY
         t3oWXTldjS1BdTmcycNTog5Zl8buFoojHIgI69TU/rGatC/norozBdRaRJupxkWA2NWe
         ABld7zjIITeiIgd5wx0kCuMNIXrkVEWrpGJNyis0/UT190sadwjkwMXwnGE2jDOF9PqH
         lhJZ17EgFDxzyv63CB2IKwk0aK3U/3qjYZ1S1eneO3abxEfHnteedzUJQ8h1BPsng0AU
         o7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QG39mGYFZq98MzXP0YSRkCdlPGT299Z3tUimM3ILiic=;
        b=pY0pDT59DG04rTRCJ4oNVRrF3v4iu2quH8bf8/AOotcJVQIId0qK4guS+clOHcLe6e
         jmjbb/lRNqwQZTQMs1J2mQzLi21pjhHlZ33hKGTB2CaD2Fd6LHxA+KPHUxiERMDlS3rU
         e79MNeQn78dnxuwsZkiZ9TbPEGH996724BzD+vn0CmLmIQ8Tdplx3evZMg4MdhcjOeZO
         xvHmrUtsW48sXVReq32OlJMNaz6dGlTkNVE4kOsfA4jzydHVjTwqp5j3THOtaoJriPey
         UkqU0ftOPdFOoxSA8H1QAH+Edrcsu1nyPwXhgkJFgCeXDarON8C1/ecLLUa068sRF2Fw
         J+8w==
X-Gm-Message-State: AOAM531QUlEmIrjgS7ZfZPdkUSQdBmGoeVLBqcxBtwrUS90ezk2+/EuT
        ICd8gZPXRU3RncT86w8hCH8M08TtUE1inJP5
X-Google-Smtp-Source: ABdhPJyUg4p8taNu2a8VaHOfcoJUvAwSCQdSbUzYNp+/gGoJytafbJrW1UNhMGC4BnAnRY2QajCAsg==
X-Received: by 2002:a92:b6d8:: with SMTP id m85mr1573849ill.233.1603139138169;
        Mon, 19 Oct 2020 13:25:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:c096:f5e9:cd72:773e])
        by smtp.gmail.com with ESMTPSA id b2sm758822ila.62.2020.10.19.13.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:25:37 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:25:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of
 subshells
Message-ID: <20201019202456.GC42778@nand.local>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-5-charvi077@gmail.com>
 <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
 <CAPSFM5ejRWUc2mCtqTPH4a6Q-WWUC4mQHU=bsHkjJOdG4kwW0g@mail.gmail.com>
 <3b501a3a-b675-3eb7-975a-cc9206f15057@gmail.com>
 <CAPSFM5fvBt+x840XOwzwPBvXK7_1qB-sb+_M3LoPuKv_P=VvDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPSFM5fvBt+x840XOwzwPBvXK7_1qB-sb+_M3LoPuKv_P=VvDA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi,

On Mon, Oct 19, 2020 at 10:54:57PM +0530, Charvi Mendiratta wrote:
> Yes, thanks a lot Philip I understood the reason. I will do the corrections in
> commit message and commit body as below :
> t7201: using 'git -C' to avoid subshell
>
> Using 'git-C' instead of 'cd' inside of subshell, to avoid the extra process
> of starting a new subshell
>
> Please confirm, if any other changes are required .

Usually it never hurts to just send the patch, since any feedback that a
reviewer has now is equally good even after you have sent a patch. Plus,
it's easier to review the concrete patch you want applied, instead of a
hypothetical of what you might send.

That said, a couple of notes:

  - Your subject message is good. It is concise, to-the-point, and
    accurately describes the change. Good.

  - The body is similarly short, but could be rewritten to use the
    imperative mood. But, it is redundant with the subject. The subject
    says "we are using 'git -C' to avoid creating a subshell", and the
    patch says exactly the same.

...So, you can do one of two things. Either you can abbreviate the
subject, adding the additional detail in the patch message, or you could
leave the subject as-is and delete the patch message entirely.

Either would be fine with me, but certainly Phillip or others could
chime in, too.

Thanks,
Taylor
