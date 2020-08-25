Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724EEC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 05:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E662071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 05:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsjglEgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgHYFHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgHYFHF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 01:07:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB21C061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 22:07:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t9so2213771pfq.8
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 22:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HV31A2MT+8xb7PrdeXSvQiGwbwv+7fjf2vm8gWB9/Tc=;
        b=fsjglEgGX6xKfHnBIxBiydjZxlu0yBSGtU328/6fmNoaabGlXOHWqKJ16ch7FugHr9
         tHEUNoQqO1ozgu3QAfMEoLxmw373YWX4lry77vnPcETgurmZN0x8scw4yUiqJO9maGKd
         nuy3vN2f4WSYZmkmHdUJzJuHRultsFXTZq9mujw3wwkfTN0ugoJx3+bVWTPIVgOxBiwk
         rGDI8CrGChaOufAGvrGd68GHg9zdf2qaXRSrS4jKEF+H4QbQGh0sepxGQuMj3ilj+V2A
         a1dI8tei8cLIVrZmZcv6YTd/GhpgfvnbEBt+TEYPUlMns2J5VLh21V3wBklfSxue4YdK
         bYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=HV31A2MT+8xb7PrdeXSvQiGwbwv+7fjf2vm8gWB9/Tc=;
        b=sEK3JZAhrXYa6pbynAjFjsgXTOo2Lj1aANZAS1f8v4Qj7Gg1Xf5IIEooTrVOCbp/HG
         SvzmmQkXS5r2fO0mTV8Je19HJPHShSm05+eusXHdvrTHRWhiqavSV0WtN+d5m4ECqMk3
         dEi9BrZQzhkob4Bff2qHeG7YCh6eKhZHeTXcMlV2fm/ZcKrQSMHRrfEzayfcAr4CA9or
         OcqFkwAE5rtCMYRFy67jVVRF8JOXLOU0+u648NMQ+Oqol4rpASjiBkwtHWfijthPzcD7
         IRaFlm3KkEYWhu/t9ctEnfi9O5K13Oj1WIW7ELOgEBTZalx0CwEvUyLVuOkribUNQyXC
         Isnw==
X-Gm-Message-State: AOAM5323rWooc1ztqDjR0mJrhBhlAs9KBeEn4QHT638xbHk5HP+ZVA1U
        SzfBiTbH/WcH/Z9UGYbf+tMHGiEjZeXhcw==
X-Google-Smtp-Source: ABdhPJwzu6azRI5BlQB7HM/iXIt0otzDz6Lh8Lim0qTc7RWXT9E6fREbr29eKqj0T2zXh/ShfP9pUA==
X-Received: by 2002:a17:902:9888:: with SMTP id s8mr6238680plp.111.1598332024663;
        Mon, 24 Aug 2020 22:07:04 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:e90:1a28:66a3:8a14:5b8a:edc3])
        by smtp.gmail.com with ESMTPSA id jb1sm1240843pjb.9.2020.08.24.22.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 22:07:04 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:34:48 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v3 05/11] commit-graph: return 64-bit generation number
Message-ID: <20200825050448.GA21012@Abhishek-Arch>
Reply-To: 85d03km98l.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
 <85d03km98l.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85d03km98l.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 03:14:34PM +0200, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > In a preparatory step, let's return timestamp_t values from
> > commit_graph_generation(), use timestamp_t for local variables
> 
> All right, this is all good.
> 
> > and define GENERATION_NUMBER_INFINITY as (2 ^ 63 - 1) instead.
> 
> This needs more detailed examination.  There are two similar constants,
> GENERATION_NUMBER_INFINITY and GENERATION_NUMBER_MAX.  The former is
> used for newest commits outside the commit-graph, while the latter is
> maximum number that commits in the commit-graph can have (because of the
> storage limitations).  We therefore need GENERATION_NUMBER_INFINITY
> to be larger than GENERATION_NUMBER_MAX, and it is (and was).
> 
> The GENERATION_NUMBER_INFINITY is because of the above requirement
> traditionally taken as maximum value that can be represented in the data
> type used to store commit's generation number _in memory_, but it can be
> less.  For timestamp_t the maximum value that can be represented
> is (2 ^ 63 - 1).
> 
> All right then.
> 
> >

Related to this, by the end of this series we are using
GENERATION_NUMBER_MAX in just one place - compute_generation_numbers()
to make sure the topological levels fit within 30 bits.

Would it be more appropriate to rename GENERATION_NUMBER_MAX to
GENERATION_NUMBER_V1_MAX (along the lines of
GENERATION_NUMBER_V2_OFFSET_MAX)  to correctly describe that is a
limit on topological levels, rather than generation number value?

> 
> The commit message says nothing about the new symbolic constant
> GENERATION_NUMBER_V1_INFINITY, though.
> 
> I'm not sure it is even needed (see comments below).

Yes, you are correct. I tried it out with your suggestions and it wasn't
really needed.

Thanks for catching this!

> ...

Thanks
- Abhishek
