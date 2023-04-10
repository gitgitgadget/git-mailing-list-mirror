Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BF4C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDJXUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDJXU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:20:27 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E63A272E
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:20:22 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54ee17a659bso128544697b3.4
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681168821; x=1683760821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCwSK8/VFHk2osZXt09cF1o9OuJCM3J6vFtfVTWHvrY=;
        b=bpGGprVSuARSXyMr0vKoxYzQOl7OmuF6NdxkZwlWvi3k9yY+3csDwqxpDJ9qXECxJJ
         74cxZf6klpKjq0aYfKeXKLEfk//P5ceHojJEAhhLMuXYlKm4QzXEQuV6sZqMiHDkCBSY
         n6jJ2OC8eDk0NF9QpSkqb3rC7Nb5UT6GrelQQaU3zfjXZWdeP+udLpvu8vIkuVzZwjf+
         P4zGFPJvvElQAz8YWHoXplN6gD8AcSENugJY8OxgfOvlxCE1Fl2BieW+o8S5u7SsyUwH
         8XP40EWpI/kbJDmqHLGD9qPiokT4jD/hcsyFCahpjhBq7h+WCyAanV5y81Vee7zWAqOR
         irlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681168821; x=1683760821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCwSK8/VFHk2osZXt09cF1o9OuJCM3J6vFtfVTWHvrY=;
        b=MAMnRbSSel/HWnjp72ZuGXtLAaRsPvm7LcWitUQ8JdrX4Dc8HHVc6qqPBmn5DoAyV0
         iZQiNlf+v02mjcnCjX5ylAjhiyAbXKwpdZLa/Z9uXejvJ/3JxvaWZvw4YL8a/rLWVJ0a
         2/q0lrQoFvnWv56uzWM4AHaM4SSkqJAvElpQXI/z2pe9IVza4vBcyRtkX+UPpsZNVNnO
         z1lkEyuRRNpjFxQvmMPV5BNDHrxl28H+c68kdmHGHfh22LEZLFTRooRmXi5Erebmc+yJ
         Ozl7suWHWSZcWLCs7CYCs78lpqehx+XPZxJNJ3dqsMBsYd9Z3kvyG+TpV/HRWXAbF3Yn
         Ip6g==
X-Gm-Message-State: AAQBX9fTGMUlA2WgAMw3XINVUenQcRQFQW3YYXqMkj0piNUvpvC9rIC5
        +Ch5ox10hCq9FfPaAuHrONWQFw==
X-Google-Smtp-Source: AKy350YYjF6JCX7jvZmYCRQaXEV3GkzkhIxOTDX42CZTpREAaQ5+kJZFl9HnJJKNmn0BDN60adDrHg==
X-Received: by 2002:a81:9889:0:b0:54e:ff2f:484c with SMTP id p131-20020a819889000000b0054eff2f484cmr4809990ywg.15.1681168820716;
        Mon, 10 Apr 2023 16:20:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bo5-20020a05690c058500b00545a08184fesm3076393ywb.142.2023.04.10.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:20:20 -0700 (PDT)
Date:   Mon, 10 Apr 2023 19:20:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <ZDSZs8LgZzDLf5m1@nand.local>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
 <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local>
 <ZDIgyKDQ2rJT2YEI@nand.local>
 <ZDIiO1HMjej+rnMk@nand.local>
 <CAOLTT8TFiXG1hABFVLp_TOEZ4__s2k4+nvcG3Ax867=LJxOi_g@mail.gmail.com>
 <20230410200141.GB104097@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230410200141.GB104097@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 04:01:41PM -0400, Jeff King wrote:
> For that reason, and just for general flexibility, I think you are
> mostly better off piping cat-file through an external filter program
> (and then back to cat-file to get more data on each object).

Yeah, agreed. The convention of printing objects listed on the
command-line regardless of whether they would pass through the object
filter is confusing to me, too.

But using `rev-list --no-walk` to accomplish the same job for a filter
as trivial as the type-level one feels overkill anyway, so I agree that
just relying on `cat-file` to produce the list of objects, filtering it
yourself, and then handing it back to `cat-file` is the easiest thing to
do.

Thanks,
Taylor
