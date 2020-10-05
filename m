Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB06CC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 05:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CE42078A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 05:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgzabAK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgJEF1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 01:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEF1n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 01:27:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA5DC0613CE
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 22:27:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ds1so2077848pjb.5
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 22:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3CfjfLP/kwdY3qGsiZCgCA1vdU01OYV0cbjPP807tx4=;
        b=cgzabAK+dMb4MG1YmchKCk4LiRByPjIM6nwZIc3wgFS2u17SYuTzgmtbPWpBEqaRDi
         w64bgEzZPI75Bm6zLUCOQ8aoEI6/WxdLB+XE+kjw3z/UNGiLfDUY2yMzzimHazwl0Kw7
         OP6Wp4ySsi04gRH4K3XNdVGZXE2J5LNxKBGflpBmvg3Mn10EpbbbnoR2m6XVLmwfVcMn
         gSuoluT8t6bttIU/6Gp6ru1xw5asUt7cgEQe9cSbFAdblULB2Bx4tl4fnWkm4Er7XvkD
         rMnrqrYFaFMt/qpb5EsELipm9+qCHMF4L5v1Fe47rZuSg9rCS9OoFuRLXnTuv/z0wLf4
         v4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=3CfjfLP/kwdY3qGsiZCgCA1vdU01OYV0cbjPP807tx4=;
        b=BOoK1bBgxSd9vzhBxG+nOTmyQf9PkOvJvgH1NhTJX/oRklPaapboldUmjX74nLmtVY
         h4tL/fVx85KgD0fMSztrV89Xa4K+K9Z0Gu5jfDF1QQZshwY/NzCTDFtEmzFJ/TO2mnW6
         6CrXml0r8pL1Cd7UUQDJhENGJHBx8sYR7m9Rrm21BzGes3jBnFTCNkcp5iLu+uA/+X8l
         ln91D4qotomJg2gLG8CUtf2VZO+ph+kxuVitEVEHeM461ea18yfyQRFjhuGKZc9DyTgU
         0rL43cSw7MM6EE+WhKPb76kUqLt+lLmyyXNP3+/4AHz7kr7WkuGq/86Q/3AM2Eq8JFb3
         Y8Vw==
X-Gm-Message-State: AOAM5323VtG0ciaE4Cs3qhErkMy+wHZkNkDjs+HwKbp0qGYSQaLx4mQn
        4WRivMMzKFawrPoIsFFD5Do=
X-Google-Smtp-Source: ABdhPJw8+sZwmzARS3J61gM2xk7Y0xbHVHhWKb2iiyLkk+mQBYsYrmjAdtkizs5mQV+jPE1T2y5kmw==
X-Received: by 2002:a17:90a:de90:: with SMTP id n16mr4353216pjv.215.1601875662347;
        Sun, 04 Oct 2020 22:27:42 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:a9b:5527:2123:1958:44d5:2379])
        by smtp.gmail.com with ESMTPSA id q8sm6102297pfk.207.2020.10.04.22.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 22:27:41 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:55:00 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v3 05/11] commit-graph: return 64-bit generation number
Message-ID: <20201005052500.GA7276@Abhishek-Arch>
Reply-To: 857dsdvai2.fsf@gmail.com
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
 <85d03km98l.fsf@gmail.com>
 <20200825050448.GA21012@Abhishek-Arch>
 <85ft8adilr.fsf@gmail.com>
 <20200901120653.GA59580@Abhishek-Arch>
 <851rjjasdo.fsf@gmail.com>
 <20200905172127.GA1382@Abhishek-Arch>
 <85v9gh1yaz.fsf@gmail.com>
 <857dsdvai2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <857dsdvai2.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 11:48:05PM +0200, Jakub Narębski wrote:
> Hello,
> 
> 
> Both Taylor Blau and Junio C Hamano agree that it is better to store
> corrected commit date offsets and have overload handling to halve (to
> reduce by 50%) the size of the GDAT chunk.  I have not heard from
> Derrick Stolee.
> 
> It looks then that it is the way to go; as I said that you have
> convinced me that variant 'c' (EDGE-like) is the best solution for
> overflow handling.
> 

Great!

So I have implemented the variant 'c' and I am unsure whether my tests
are exhaustive enough. Can you preview the commit "commit-graph:
implement generation data chunk" [1] on the pull request?.

Apart from that, I am ready to publish the v4 to the mailing list.

[1]: https://github.com/gitgitgadget/git/pull/676/commits/390973da1d744cbb8a08a3b99c991f6d04ae9baf

> Best,
> -- 
> Jakub Narębski
