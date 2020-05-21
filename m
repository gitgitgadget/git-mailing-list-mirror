Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7488C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980172072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM0A5bip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgEULZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 07:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgEULZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 07:25:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4A8C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 04:25:48 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id m64so5154234qtd.4
        for <git@vger.kernel.org>; Thu, 21 May 2020 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HIemUm48lJ5yT0miIN3Ewu0ALReDwlImLUstWADT6I0=;
        b=QM0A5bip8KgRBoit9dOPaWOVAZACWx1GNapZR2A20vnsqaHPTjWxaU9FOEzfS51h62
         m+Oj4Sr3M0XD5jYG+/Dfx6mln8ljmH9xWmKSGOU/T6DgO8FYPB8duD7iCJ5nASYSdzn8
         6ein/h0/NHMoTl1EM5PB/BZIJTh9Ee3dyebHYnFKW7aDMxAnyACy0PHQW3leqnojyJ9i
         KJP0MVEU7XzMwjTT5W2nXN0NXQyRdg99QTcUIVoW9WkuGtfy4MPmTb23mq4yJbh7ysxl
         B1yebEPNcch+yEogqw3VG97sdmlvx/mjtaLcKbJTrOVJxBW/ISDdElwr85z10gpWbO2M
         oIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HIemUm48lJ5yT0miIN3Ewu0ALReDwlImLUstWADT6I0=;
        b=O3T9/9Cykm7bUoF0km6fnK+4h0qbzjObIc3NCDjPhUWhhDF3h83qNR9fRFR8PKXLif
         lMRgMJMOyUrqunJYhspwlO4nax8kxPd0oc2winOZt0+YEQ/q54hly6rwgscW9alQ0rey
         y/3SyHvoNJGiqPL2adkx8r0BmPOPU6X5DMzicwprU5qIIDCJqrGte5nY35s7dYP8jzs2
         lLGePEhR5XISO/iJO3WRFv3poQkbOfEMhCM/BV+GmyGePCthYiU/8kM+F/8IBebDKji9
         P/FIwJ6i80Ov5gL4Q8tsOmDTWKYGJqmy6oMWJ30GHzAsce4CAbXXaEcLXEqh0nHtV6u/
         MQMQ==
X-Gm-Message-State: AOAM53296IE6kZIhYjUHF5dNwkOcPNG/GSl1y4n9au24GOeyBqPTZo3G
        jjdZq5G8wHuTzWA0gJsnz8A=
X-Google-Smtp-Source: ABdhPJzJVR+vETvtvdC6G1j2dAL+3pzeAwZzoQDt1zA8e9lBAnLJkhHfzWBZMl7yRZxVu8BIBdcBmQ==
X-Received: by 2002:ac8:36a3:: with SMTP id a32mr10169581qtc.196.1590060348048;
        Thu, 21 May 2020 04:25:48 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id s33sm4942674qtc.95.2020.05.21.04.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 04:25:47 -0700 (PDT)
Date:   Thu, 21 May 2020 07:25:45 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/4] lib-submodule-update: prepend "git" to $command
Message-ID: <20200521112545.GB581643@generichostname>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <cover.1590019226.git.liu.denton@gmail.com>
 <578bab6f1af351fd3721d56bea78abec6c9ae2f9.1590019226.git.liu.denton@gmail.com>
 <1746f977-64cc-ede0-04f7-7cfd1afb1691@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1746f977-64cc-ede0-04f7-7cfd1afb1691@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Thu, May 21, 2020 at 11:39:48AM +0100, Philip Oakley wrote:
> > diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> > index bb36287803..fb6c0f3d4f 100755
> > --- a/t/lib-submodule-update.sh
> > +++ b/t/lib-submodule-update.sh
> > @@ -307,8 +307,8 @@ test_submodule_content () {
> >  # to protect the history!
> >  #
> >  
> > -# Internal function; use test_submodule_switch() or
> > -# test_submodule_forced_switch() instead.
> > +# Internal function; use test_submodule_switch_func(), test_submodule_switch_func(),
> Is this an accidental duplication of  test_submodule_switch_func(),?
> (spotted in passing)

Thanks, good catch. The second one should be test_submodule_switch().

> --
> Philip
