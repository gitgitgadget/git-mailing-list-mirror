Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D3BC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5169212CC
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MnUp1s6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgJMTtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgJMTtR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:49:17 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A24AC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:49:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so1293021ioo.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k18o4njUIgGBdZCoE0kWSX0iDZGm5usliizGwJ5ulOo=;
        b=MnUp1s6E8bVOQTD/d7puRAkUMiII6GccwZtfFdtSlIC4kxoP/zkb+DF2L3Dbrqlmw1
         TWbxe8swDAM9R1NNw1u++X057he+Z7A82lASu5n/M/a8JrQkeLGska/lZw9BnBJCA41o
         JLSgEd4ctRxWn/rFtYYE1pSfgfeYmMWufws2SBrfVm6b3UrRtSE1Gm0Gjne5y7y9rvch
         tbzg9EntLF82Oz2kOyUqzdnWDGNLid1tC8dy8/Y6e2eErZUv/5lNG37mkzvEyPfufaBe
         eqaxYc3hGVa47n7NruZA8SAMrxEfjKPoEFAX4mhP6XovCJ9IJiqLHLjFJKs737mq5uYP
         qlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k18o4njUIgGBdZCoE0kWSX0iDZGm5usliizGwJ5ulOo=;
        b=fMaFYm6eovrfR3BkCnIQ9yG7RK/gFblbsbSs92Xz5UP6UAhHKZE0llues9PpI2qN74
         NTuoqHoiNYqhFPzhPmqkhMOk9kSl6RG4wuym+UUexmN0BTAqs0QBrT5t8JLVuDllEEUU
         LZaqubPt2d/BI5VA1vEcZUSWDRr5+5VNT5AtgwFdMSh20k5WUk3hEbqRJ7Gxr1ibLQ3Z
         7LXcbOyumqAOo1wypUEDKuqAhQbJHo3Wisje5bcaFc4aWZ/0XMJtXsZEDdoTSV8lBraF
         mNH7q9LGRCAko4+i+NyLRWy9EJckVgReZI/PROumO2B65kFUT+D6yj79LUauqrqybB2n
         ZE8w==
X-Gm-Message-State: AOAM532X/BlxIsskaPZt8OniGX2CCWgtfMZAfU8w6yFpnuFJjaFEg36O
        6aDt7gG5+jo6kPPv0KJ8LNAzDQ==
X-Google-Smtp-Source: ABdhPJz1+CmslLc47Q5EiGkNcXgJZI32XLW3vxxN2ZgohiOQnbogboQtFuhlhf4NdWPKPou6FLC/bQ==
X-Received: by 2002:a05:6602:148:: with SMTP id v8mr353534iot.33.1602618555968;
        Tue, 13 Oct 2020 12:49:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a4a8:cfa:3aeb:51fa])
        by smtp.gmail.com with ESMTPSA id n77sm913153ild.10.2020.10.13.12.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 12:49:15 -0700 (PDT)
Date:   Tue, 13 Oct 2020 15:49:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/3] Make test selection easier by specifying
 description substrings instead of just numeric counters
Message-ID: <20201013194913.GA1921887@nand.local>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 07:19:43PM +0000, Elijah Newren via GitGitGadget wrote:
> Changes since v1:
>
>  * Modified the documentation slightly to combine a separate sentence into
>    the previous paragraph and avoid confusion around whether negation
>    applies to substring selections (pointed out by Taylor)
>  * Simplified the output for skipped tests even further, as suggested by
>    Taylor.

Thanks, this version looks very good to me. With Junio's ack on the
changes in test-lib, I feel much better about my own suggestion. So,
this all looks good to me.

Thanks,
Taylor
