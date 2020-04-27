Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A4C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 11:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD16206A4
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 11:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="RdmSsScA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgD0Lb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgD0Lbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 07:31:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2AC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 04:31:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so15732360wme.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ORerAKZa31lZ7cJE6PlkTD2DOj0UMprl58X+nuaRSNo=;
        b=RdmSsScAWCCnNaCDl3Z9bXNi9c46sHlalUlCycfJVgDsav8mOO5Q0O1d6hRGredCBd
         kzfKedfLkxDpGEM5Ap1XlXpJuaE/COCsmwza78mWZ3fVQL8U2zx1/JOskx7+KtEjs8sB
         Tq/7CJBN4Xl9PP927DfQSpBDtQLKQTMRJkWQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORerAKZa31lZ7cJE6PlkTD2DOj0UMprl58X+nuaRSNo=;
        b=TSK0dfJFfp6VSEdHZ5N0wrI/n7s9qxlTOeRQkUT86OrHB/xC/uVETbnhea1okBATQD
         M/v3ODF72x3NgcVHa7CRAUNuBZgfUEsM81j+aZNWhtS3z2gbVC/nbeXeUx/Q5U2JM4a5
         X6Zl8VnfALL5UiE6gJsEtsQ7VFciXBLmRapUXUEFU9XbMF9xPyVBArK308g+7g0kOSX6
         t7WzxBtr07JEq0bQqWhFhiaQstTFFmq4q9rf6MOQbMLnOLaFzo0zqe3/cPkhmVdxA/mB
         qtkvp/hnt0o8LtM2m//hJ0eMpbPP/sNW4b4Jl7AHyTnWUyDL4fTgyebvHE5zdksu1dqg
         7RjQ==
X-Gm-Message-State: AGi0PubqClBSYNDXGFKDeP3iP2VkOKUdRoJ4FytINE0nhhIVvEG1FVFi
        0ZoymxPADPaYd3rDf/VEqIa7FDILQZ96y6oeWgKaWEa1
X-Google-Smtp-Source: APiQypJcA3wlv+atOiPNGLhKwbTMeOj97d5m6zcqCqFJ/6j1IKMlqwEFd1keGebWchP1uvp5zUXPWgAIDWsgu5KVqQo=
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr26774276wmm.61.1587987114082;
 Mon, 27 Apr 2020 04:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
 <20200424064805.GB44448@Carlos-MBP> <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
 <20200424072049.GC44448@Carlos-MBP> <CANYt6aF1o9fmK2rwAA-LPSbd3TeW+x+6LdUj99sg_ANy3Q0kJg@mail.gmail.com>
 <CANYt6aFN0eAKEhRvNhoiOTu7jO54Kau_ayQMhrdy+7_GPAOCyw@mail.gmail.com> <20200425065250.GB5065@danh.dev>
In-Reply-To: <20200425065250.GB5065@danh.dev>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 27 Apr 2020 12:31:43 +0100
Message-ID: <CAE5ih79Chu7pguToRqmXdKh1BuvP3QGVK+8UDj=5F9_TovE86w@mail.gmail.com>
Subject: Re: p4merge no longer working after upgrade to 2.26.0
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     lars.fricke@googlemail.com,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 25 Apr 2020 at 07:53, Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-24 11:28:13+0200, Lars Fricke <lars.fricke@gmail.com> wrote:
> > Just to help anyone who runs into the same problem.
> >
> > For whatever reason (maybe broken package on SLES) the wrapper p4merge
> > was missing from $(git --exec_path)/mergetools.
>
> In openSUSE, p4merge is splited into git-p4 subpackage.
> Which make sense to me.
>
> Can you check that?

That seems kind of weird. They have nothing to do with each other.

>
>
> --
> Danh
