Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE30C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 17:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjDDRVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbjDDRVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 13:21:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4DC19BC
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 10:21:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g17so43276379lfv.4
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680628880;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G7RSgAnpL01MiDwVZWeIoH/6ePNccpKuxwzlah1Rod0=;
        b=dTYVMZhki6Z1XfQAC4rW1dVnPXdXwY6vMvdaAdztqoB2Iiz7kE6g41I3P3WVQWKD2r
         aLSB2wXG2Qd43PqnNOaKJm9fo8XivcMWajq/F/cdJ6KnaL2PXbvhX4XxQOMb4Be8hKEW
         1lWSvbZE10Bt6j4Qzi4KV/es13pxXS58K5YF1zdMClmrHpSpZzTt6Hz+2TEXNO5/EKRK
         w7/v44ZfKVtF4rkBaFhHTsFwUj4q+1w9Mbd8WRr+5Jsiv4jKicqNsGC7B5qA4a5VjWP2
         CfSPdPOPvoJdQTJvLQ2aIBeBoUhr5a/YrpGcuXIjBZxiPaZM4ca4mSBpi1N9NJYUZiYZ
         A3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628880;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7RSgAnpL01MiDwVZWeIoH/6ePNccpKuxwzlah1Rod0=;
        b=aaU9xPPaV3h5udxYm84+/Y7CikTC5LYujtCspxTudNOt5EPi/Tlo4fP/8HU2Zx/xrd
         Qa9qeodwWwyxJvXr97QKuKZd0WMf7rBFg7uytF3hToxTXPxHkntk8gt16VZlsHXAguFZ
         qjAv1wN3eJ4J5xexAoqp87OHhtkpdSqY0X38mqoyk6gFpg9eJH3W8y070EoDWgbWpE+t
         SoOfwnRzGjbUyS2vT78gRMs01Oib9Yc8kv5Q0Kd29Gx1agx8O6Xwb1IgcKxtP0NmazHN
         V16SAP4PWewxPWixqEu1huccAmbiO/MRkkh07acCitMFEqmM7VPrySopNeHFmHQYliFE
         b/5A==
X-Gm-Message-State: AAQBX9fbjNOWlW5kb+3FiP/a9/q4i+CVlz+0YZlQaFjkXXP50fdaMxNo
        /tVIhZY8CxJs5A9Ke3lnRns2e0JIuAk=
X-Google-Smtp-Source: AKy350baYfWvPuTPDk+FJzn95gryYHMvb4UHItYNRayiDq2DFPxWzGBCFogfcEEz6ubGK/G5mVBtVQ==
X-Received: by 2002:ac2:4a8c:0:b0:4e9:b08c:b380 with SMTP id l12-20020ac24a8c000000b004e9b08cb380mr818476lfp.56.1680628880041;
        Tue, 04 Apr 2023 10:21:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c20-20020a197614000000b004db9dbe09c6sm2408165lff.89.2023.04.04.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:21:19 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Hongyi Zhao <hongyi.zhao@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        Git List <git@vger.kernel.org>
Subject: Re: git revert with partial commit.
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
        <87edp0ak45.fsf@vps.thesusis.net>
        <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
        <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
        <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
        <CAPx1Gvcz6f3AQJYfq7Sih0bL6pAi5mHZj8rj=kd7kRDWKLZEzw@mail.gmail.com>
Date:   Tue, 04 Apr 2023 20:21:18 +0300
In-Reply-To: <CAPx1Gvcz6f3AQJYfq7Sih0bL6pAi5mHZj8rj=kd7kRDWKLZEzw@mail.gmail.com>
        (Chris Torek's message of "Tue, 4 Apr 2023 09:19:35 -0700")
Message-ID: <87lej7zhpt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> On Tue, Apr 4, 2023 at 9:00 AM Hongyi Zhao <hongyi.zhao@gmail.com> wrote:
> [various previous conversations and methods-that-work snipped]
>> But I still wonder why the following method doesn't work:
>>
>> werner@X10DAi:~$ git revert f18fbd1e16a1ca4215621768d17858c036086608
>> --no-commit -- Public/CTAN/IDE/phonon/compile-install-phonon
>> Public/CTAN/IDE/texstudio-org/texstudio.git.sh
>> fatal: bad revision 'Public/CTAN/IDE/phonon/compile-install-phonon'

[...]

> Similarly, `git revert` means: given some commit, find its parent
> (again, singular), and use that parent/child pair to compute a
> delta.  Attempt to reverse-apply that delta to the current commit
> and working tree snapshot.
>
> This kind of operation produces a new commit, so there's no such
> thing as a partial revert or partial cherry-pick, at least in
> terms of "things Git can do by itself".  But we, as humans writing
> programs, wish to *achieve* such things.

So, why Git can't help us achieving it by supporting paths limiting in
(all) merge operations? There seems to be no absolute obstacles, just a
luck of support.

Thanks,
-- Sergey

