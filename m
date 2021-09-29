Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3D7C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEA2613A7
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 19:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbhI2TwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345636AbhI2TwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 15:52:08 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE5C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 12:50:26 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n71so4696178iod.0
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xNMifSRysc/x4lz3DECY3zIrjOBxsjiurZ5a3gBzrRU=;
        b=Z3eEwbSPYUvJXXnMUHeO2yl5qVP2gi80nSOh+IDCsSqWIT67seqasrHSZArnosGP3g
         9s15cdD0b64g/UAeSeE8jZqq21X83rk47Mwpwjl9Tz+fJpKStV4NMv6KQqKYStgWlXsx
         0jus6fJ3v3uy0g6nDwfV99T16uPp9cyNjnf/P4KyyNlJeJT9UsDnXHVCsGhOOIY0ZZDU
         ibhj1qf1nANhtkDIxpzhnLTcV7RdPy5Qan1gJ242WACTBIUX9xxrlmmbsqTzs0Acf1cg
         n0yoosYxvNyz01fwsH3vpiDSwWUEtnle9Yr1nV2sPBCPAChEVS4Y0xtzWcCLQOYLY20i
         BxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xNMifSRysc/x4lz3DECY3zIrjOBxsjiurZ5a3gBzrRU=;
        b=EHE357QTfMTOigkrZxHUQB87T27HeCNrTQTLvd6O3sqsW5FKDpgu6f+32Grb1Kpvt+
         bks2WxSfdlqYBlNIKQGb4OCUQser2uxRfqJzoeS4SCNTuC2O7H46m/c9cd93a4dkOtpE
         cLVtKOjH+GUVvFe2Ujii8nN0Om/8q7/ynS/iv+yzExfU3mElgs4jelow8jfWgKL72y+h
         cfO7yclhoCNCFdOAkizySCSnX7MXS3RXL36274+3kwiqOZEqrZXrjoSH7AzTkdSvt/LP
         TBROF2zc+RmQ/ju8dIwYPnwjLY0RvhmdHnBOcNeo+FXvUkMzxx8cqkTlU7ECuLRZ9z71
         ouMw==
X-Gm-Message-State: AOAM532UHxXuANsmdpiWbl5yhwe8EGJsgwPQNSJsjPAkxNojl0XyK3LU
        UGLEFA5BDe6UAndJk6gsjCVZ2Q==
X-Google-Smtp-Source: ABdhPJzadB4Wc0752cE66TfKOmT3cQb5uZdC6XXmRG2rxns5TM1p9H1UeIeAfJ13wEGEidJMfFgKHw==
X-Received: by 2002:a5d:8b17:: with SMTP id k23mr1203107ion.17.1632945025973;
        Wed, 29 Sep 2021 12:50:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x13sm498734ila.29.2021.09.29.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:50:25 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:50:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v8 00/17] fsck: lib-ify object-file.c & better fsck
 "invalid object" error reporting
Message-ID: <YVTDgJ7wFl9DCjS+@nand.local>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
 <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 04:18:41AM +0200, Ævar Arnfjörð Bjarmason wrote:
> This improves fsck error reporting, see the examples in the commit
> messages of 16/17 and 17/17. To get there I've lib-ified more things
> in object-file.c and the general object APIs, i.e. now we'll return
> error codes instead of calling die() in these cases.
>
> v6 of this got a very detailed review from Taylor Blau (thanks a
> lot!), for the v6 see:
> https://lore.kernel.org/git/cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com/
>
> The v7 had a couple of trivial shellscripting issues, a typo'd
> test_oid variable, and a warning on a "test" comparison. For v7 see
> https://lore.kernel.org/git/cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com/

Thanks; I looked at the range-diff and it addresses both of my comments.

This series looks good to me.

Thanks,
Taylor
