Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E714C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 18:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241934AbiKRSmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 13:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiKRSmu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 13:42:50 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD5667128
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:42:49 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r81so4485637iod.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=naUu/AfJY5y4FYH/7np1horclTUTnpFxNaP0AzCk8zA=;
        b=yRulRlEqfpPYIhI4qD3NGZEAu/bo3PiyjkP9rg9x2dwvKER0aTBQnOkh7hgHBFSXRk
         riwu0uCjEq/ATyAbNgBRtcIBGNQC3CQvdH9x5nCsWhY8yBPV3MWtvN204UJenmVcIsOi
         6NXET5Xk4PgGV4N8cAOUMeGIh7c4BCWz4gukbMLsVRXYVWeVhXzaFzgDgCWjwQ9llC2y
         7UgpPg46N1tHDAkihZtKIOkT52zaEZ61rCyN8FK04gVhJkgyOJZt2I1AIzTMepXzMnua
         ZDkI+iwiD38mYd+EjYR6/svmybc3HymS4H2Rv864mPByVE3PZ2gM5UfUF9Z0VoU4QWMs
         WfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naUu/AfJY5y4FYH/7np1horclTUTnpFxNaP0AzCk8zA=;
        b=SpMJO3TOATssoV5lR0wQtpJK2eyeoX6xOah2O3Xcr/0CviVD9MD0s4Cz9OoTB8+yJ3
         EIk3dkl/2x2mwA+RMVfhko8r+pJ8fMxl/rODQr8GbQByW4mCs2pCB0iicMRODshFxAJj
         QKdgimiad3TIzgk+80JQ+2RlFTmY+4I0P7SRugzWn/685somZS8VTVJDcwxMU2S5fNNk
         GybY7R7J1bWW6tFhAJEgdlzv9gb9he0BsHox2XGG08ogBmhplFxlfQWEDdSYJC6nEZlC
         Qw3IxiNIDwXTNENNwTXT0ZAAWN1GuK/MncS4jLtf+S/FWVbc8NciS1Ec9GRqSgucl6+C
         SmQA==
X-Gm-Message-State: ANoB5pm2fMMifk5L3KnguTImjv7pw5wmm9c0Sxc6muMMWdvtbef40b3g
        7E+NR1TLWQ6jlr7bqf7ShQY6fg==
X-Google-Smtp-Source: AA0mqf4Kp4nQAEl0aR0xbIrebZckFNgqK7SnmJbjTKGTBA4TwR3DyVaxrrZE8omII2MdgtC8to4TMQ==
X-Received: by 2002:a02:2122:0:b0:375:13ba:925 with SMTP id e34-20020a022122000000b0037513ba0925mr3652766jaa.207.1668796968815;
        Fri, 18 Nov 2022 10:42:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d8505000000b006bbddd49984sm1534773ion.9.2022.11.18.10.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:42:48 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:42:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] builtin/*: remove or amend
 "USE_THE_INDEX_COMPATIBILITY_MACROS"
Message-ID: <Y3fSJwm7qoVmvPA8@nand.local>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
 <patch-12.12-b69cf6d7600-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-12.12-b69cf6d7600-20221118T112205Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 12:31:06PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Follow-up the preceding commit and change
> "USE_THE_INDEX_COMPATIBILITY_MACROS" to the more narrow
> "USE_THE_INDEX_VARIABLE" in cases where we still use "the_index".
>
> Then remove "USE_THE_INDEX_VARIABLE" entirely in the few cases where
> we don't require any compatibility macros or variables anymore.

Could this get squashed into the previous commit? IOW, is there any
reason to keep them separate?

Thanks,
Taylor
