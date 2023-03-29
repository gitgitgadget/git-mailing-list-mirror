Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137C6C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 20:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjC2UfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2UfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 16:35:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB759ED
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 13:35:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536af432ee5so316618077b3.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680122118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hB4UXGGOpfVeyWLZZDyv9P9kBQrHmEuqngcMKepl75I=;
        b=QWx7DgOLaZZr2937HtfCdaaeoj4ayiwhkzAL9qy0YhNrU+15ZM9fIVMR/bnZYnPqJH
         w3/um3GGUKj06UPH4jcKsXNS3b7CCb4cdZ/Djwsf6Hj6SZ15HwAfF2aifJJkp4WmAk8O
         GW6dZzG5Diq8xxYCg/5JNiCuROFhxGvfmMu7phq3QvfqA07Vj1ZSPufXPekbGY7uIMPM
         TC7WR95yt55BZDEDPgEyKJ7xtRSFaqZKPICvC0xBEU/txI/liZcLUZJ0pY45zuV6orBu
         k61wED+6+eUBXqbcJAkUtMqsVFWdsFYil8s2ZVFGuii0DEN149N/nFaLSp8I3FNBkX35
         jYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680122118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hB4UXGGOpfVeyWLZZDyv9P9kBQrHmEuqngcMKepl75I=;
        b=N5onc2MGi+oPROuWj+GNENVfdaRdl/6aEDH4TSXB1oJbaQDSkvF6CdytuRwq3ChJww
         mCYhFoBuIgG1AWNZIPeVKxcdpGDHjF7gB/vXR4ChqKuckBTRwMl6WbszOuGhvZJxgJfd
         9FctSBemyPSInZGFQ7BWHc5OfGDx4qW4JFvIBXImDZ/8WcWjWhaG5uu2qz2BypE3J2yf
         fb+wZiIZNepwdzW0DHwuK27P9yOcRWJpV7o5H5eGMuRS7ZJVWOg/55s/oStp16ho7b87
         CyWq/u7/bmi4c7Ls3p62WKAQqtrFV0YQ06ggxjZKWHBT7mlvmqzfpmBE/4QOdXFI23mj
         EGSQ==
X-Gm-Message-State: AAQBX9dJ9QeBV3rMHhXXD5yaS9/dSbsgqfYVBCQRRJgCYqcvZFvkV4fB
        zdM5SiTe5g25Vhhmbe3brTxweK9RQElXhO4cfmbyew==
X-Google-Smtp-Source: AKy350aY7Ij3qrpBMb3nswMCSc8yKqMMgM1aegpo1TsMo1SWt1Wl/Gd66g4ERUhAuSYXjRklMT3EPw==
X-Received: by 2002:a0d:eb52:0:b0:541:66e6:dc41 with SMTP id u79-20020a0deb52000000b0054166e6dc41mr19583525ywe.43.1680122118295;
        Wed, 29 Mar 2023 13:35:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id df15-20020a05690c0f8f00b00545a08184b0sm3111014ywb.64.2023.03.29.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 13:35:17 -0700 (PDT)
Date:   Wed, 29 Mar 2023 16:35:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 02/17] cocci: fix incorrect & verbose "the_repository"
 rules
Message-ID: <ZCShBL5TRLnQLh0C@nand.local>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
 <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
 <patch-v2-02.17-5ac9d5b8905-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-02.17-5ac9d5b8905-20230328T110946Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 03:58:43PM +0200, Ævar Arnfjörð Bjarmason wrote:
>  .../coccinelle/the_repository.pending.cocci   | 160 +++++-------------
>  1 file changed, 46 insertions(+), 114 deletions(-)

I resonate with Elijah's "I know nothing about Coccinelle" statement in
v1 of this patch more than I am willing to admit ;-).

I am glad that Coccinelle has some better tools for us to more easily
express these macros. The end-result is very nice and has a clear
interpretation.

Thanks for cleaning these up.

Thanks,
Taylor
