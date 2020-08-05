Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A53C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198902086A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="vS8MDF9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHEW0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHEW0U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:26:20 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A3C061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 15:26:20 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w2so9442255qvh.12
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EABgeJnC7Zys7QyrCUc5JyCRAMRapcEYTEfDXjWjE5I=;
        b=vS8MDF9avrq9BZYshmHSgmJMJxdRwtJbj+Qz1cM2TwkBnPte1kRmqshRbkF3bcnwCY
         9sJ+aYEwxW/ZQUBTgwdVshqhQacudg5qaPK8JOn5vIq6oDPb/NsUOQVOTW02GpGkqpUN
         C99EEAjj5L7enRK7b1sbMx22Xir/9d8MdTH+BTt+sARZ/lRgI2MbyVE9AdNkB8o42aNu
         s2OFtftT0pcLxxG+Nn9YC1iWMZ9jUi7EljCu9Iknk8TnzsieD5zPWU2hdUE64vI+lDf5
         Ly3H8ZS0/BDggSwVs3AEiut2zgLrYbw5Vxof9k8SYQ+JTAVIV3pHnvLFA1JzFvnlyKok
         EYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EABgeJnC7Zys7QyrCUc5JyCRAMRapcEYTEfDXjWjE5I=;
        b=d3Zu2oz4ADafiDS/W0BI1dmdRO2j0IbrcCcngekFr2PsAoiBoliRJxguMwAo015iaW
         T5EnNiPy/hHOZr6s7b+lW5vY0KZ5Y1MPd2ABFCPdemjmLbUqFDzVCxQlQ0y8bwApJYX2
         KrExAAJ3H5KlLprH2Ae5ZDZ5hsSATphKRDh4qI7pvdesXtOATXMOSHOZFkc0HHGH1V5X
         Y6PQtdwkHMR18WvHR4C+ILDQr4eKgoX7CYbD6V5DWSO1+HPe67ObAI8Xh519KFcpebnp
         BdXIaq2FZXwNE2yLIZOAe1jzEyJFuN9CcPjBXOz79RVJ6LKRmUD8BU1mGWV0J5O5tiVU
         jMPw==
X-Gm-Message-State: AOAM532ZtiZ074KNxB1ihdB0vjRNdqav544WBv9bJlaakJxt5vj/tM9L
        O63p4PRkUrnBeon+2m1jB8q8zg==
X-Google-Smtp-Source: ABdhPJzDI0FKxdvY3rhL1cIKkOBEPJQUjtzSJXMW5+wYh1/Qc9kTgrV0moqhtVAgbRFVCXr/OsiF1A==
X-Received: by 2002:ad4:42cc:: with SMTP id f12mr6155828qvr.89.1596666379733;
        Wed, 05 Aug 2020 15:26:19 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id d26sm3354113qtc.51.2020.08.05.15.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:26:19 -0700 (PDT)
Date:   Wed, 5 Aug 2020 18:26:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] t7401: ensure uniformity in the '--for-status' test
Message-ID: <20200805222618.GB30420@syl.lan>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-4-shouryashukla.oo@gmail.com>
 <20200805210104.GH9546@syl.lan>
 <xmqqd044n31u.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd044n31u.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 03:25:17PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >>  test_expect_success '--for-status' "
> >>  	git submodule summary --for-status HEAD^ >actual &&
> >> -	test_i18ncmp actual - <<EOF
> >> +	cat >expected <<-EOF &&
> >>  * sm1 $head6...0000000:
> >>
> >>  * sm2 0000000...$head7 (2):
> >>    > Add foo9
> >>
> >>  EOF
> >> +	test_i18ncmp expected actual
> >>  "
> >
> > I think that this is on the right track, but you can use a '<<-\EOF'
> > here instead of '<<-EOF' to make the tabulation a little more flexible.
>
> You are correct that the patch could have indented the here-doc and
> the line with EOF with a tab to make it easier to read.
>
> The leading '-' after '<<' is what controls tabulation, so <<-EOF as
> written in the patch is good enough; you do not want to quote it
> further, because $head6 wants to be interpolated.

Ah, I never actually knew the difference between those two (and
apparently had been too lazy to look it up myself). Thanks for the
clarification.

Thanks,
Taylor
