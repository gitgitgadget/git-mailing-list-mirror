Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE06C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 00:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A4C64E30
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 00:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhBCA4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 19:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhBCA4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 19:56:19 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4DBC061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 16:55:38 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a12so30924194lfb.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 16:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57nMpSIxsYAFyCjfCwraQrOkGdvV+eO2Gs+RUQyuE34=;
        b=YO1rOriCE7dKlZ94Osskb9GcKeqDtlVTixfuaozzDUV4HxvCZe9o29t3Uu58SQn0ia
         7f2PbWJ4OrMe40wPqrPC6MaacwNN4LoiHFt6Pt5kqqezRhaaQ0OfpjCwKYD24iFBrBI9
         FK8MOyWMJ1dsFmm2/8vy2HZdsAvmPnwg8qJV4eUkv9uWa3vKcw/tzw1ZHppOaEkfmzs/
         AZPnRJALk2mrytTMNC4fPzfgkM6s5V1Dn5ZWAFY9jZaXZ3rLVUfjUYMov+Oi0svomQKy
         We+RfN4ZcjSOAGrTEzC+6jB1iibxsZ+NL/5H5MvwtFrfTAkGnb/ds7cFUOHIPfF4dJzY
         M47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57nMpSIxsYAFyCjfCwraQrOkGdvV+eO2Gs+RUQyuE34=;
        b=NaT2gkJzzjdT9V16Ifnw6OCWn3OsZm2BX7LrWThQcm9YnMZoCuLWzbxm6cKlBF0GdB
         +ddAqya05AGf/jPYJViA3DUtdh+u4U8yxrpn9pOs/pSoRAy/SFpgP8lVoZwYwlxbL5Gk
         hhLcmOGVN2zjSEEMudPhK0fl8cocbxCuR7/Lh9Bqrg/zpo9U8gDnHWnAFYFz2s4JE85s
         e0QacZX/52yh5mM6qErTkJMmlkU/XqFpST2Ds7KSxagZmo9AtCCjXNXRxQVTrCPtGpOS
         731P2UMRMifQVFSZhYmgFmz+RZvE7MPdCGU9zgsQrL+qJDBVkfR066AYd25aU1gmdxrf
         Y/NQ==
X-Gm-Message-State: AOAM530noPReTcWskw9Mq+iiyM5BqwygaG1THmospTSB6+rCmQi/XfD0
        850hlRe/wg23U2YNHz6+loFnKCnkIeKTkXJZUcjruC1somu1Pyi9
X-Google-Smtp-Source: ABdhPJzufVROfzhHXM2m9QRZUFvkLXmPBReMSvHuQAMcx07n8RqiYDsy+TDmy6pz/xDowuK0giuMXigPztXUVXe7Cv0=
X-Received: by 2002:a19:6d07:: with SMTP id i7mr356761lfc.75.1612313737380;
 Tue, 02 Feb 2021 16:55:37 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJeg4EB1Lx8NN0+PP-nxystKtLT_FH2UdQhoF13TjWvXg@mail.gmail.com> <xmqqv9bagzwb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9bagzwb.fsf@gitster.c.googlers.com>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Wed, 3 Feb 2021 08:55:26 +0800
Message-ID: <CAGP6POJ4GPDL3uTzzBDSZ1ykypA4SyVEC5sc0W=FCLOsHmOntA@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 1:09 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Hongyi Zhao <hongyi.zhao@gmail.com> writes:
>
> > On Tue, Feb 2, 2021 at 1:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> You can,  on _your_ end, filter incoming messages that are sent via
> >> vger.kernel.org and do not have your address on To or Cc.
> >
> > Thank you very much for your comment. It seems that the following
> > Gmail filter will do the trick:
> >
> > From: *@vger.kernel.org
> > To or Cc: -hongyi.zhao@gmail.com
> >
> > But I can't find the Cc field on the filter panel.
>
> Here is what I use to process messages that are sent to me without
> being sent to the mailing list:
>
>     (to:gitster@pobox.com -(to:git@vger.kernel.org))
>
> The rule is set to skip the inbox and throw it in dustbin ;-).
>
> I'd imagine something like
>
>     (-(to:hongyi.zhao@gmail.com) (to:git@vger.kernel.org))
>
> would hit what you want to filter out.  Let me swap To/Cc of this
> message so that you would appear on Cc so that you can experiment; I
> think to: would work for such a message just fine as well.

Thanks a lot for your wonderful notes. Based on my trial and error
with Gmail's filter/search toolbar, It seems that the correct filter
should be written as follows to meet my requirements:

to:(git@vger.kernel.org) -{hongyi.zhao@gmail.com}
to:(git@vger.kernel.org) -hongyi.zhao@gmail.com

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
