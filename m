Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00352C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 06:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B341422277
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 06:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDPIthKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKCGnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 01:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCGnp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 01:43:45 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB55C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 22:43:45 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id x13so12903759pgp.7
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 22:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3T+xcNpdnrQ5Qn0XogJgxSsbYV3O1wTgOnNnZmNPogc=;
        b=mDPIthKFoonHhsHGsk2r0vO6/gjmU8UqodcCRSfE8aSFRQFK0FHtN4Vw/Lk+25Yosc
         MYyip9jB6Z3Xacx1QpvG51fEVbys91BF7cFF44oJ4B9EVUNBv9MQYFf8taog3x8lPpp8
         lK/sYUGMJ/90K+HBVZNZ/Ph4PjeRJyWWplRrJUXSuKkqUeA56GhxS8e4V7FBmQqFdn0E
         Dgvu9OaeP3Bj6Vs5dFDNI7zJPXrxvt2UiaQBtUnzqAQ++J9Slxf7ekMj6KlWstmYVi2B
         9K/qtjWBMLOuhbZ3UWd5qH0hkhNiVwlRHZJ+klKypvuFfG86xkE2MTEkwxYjYUFN3/dM
         RB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=3T+xcNpdnrQ5Qn0XogJgxSsbYV3O1wTgOnNnZmNPogc=;
        b=I1Fa2P46HhH177Lh+j1t87+QfzzupY0lXWD/lTxLCRsgLTAxn805mrQ+8qen5vBIdx
         +TbZXUsypj+magvXtPR22PafhRuBiXNHMBnbmJTmp5cay1XzVtO/x9en2unHnEcD78pG
         mmRf9on0eLvUhbzhKuh2sIlj/Bq9HubSy5XsAUI0s0M4Yjm1E8Dh2yjzkVBjmx2asquO
         fZTy+cCjiESlBkWjlXm2ZvM3rbij+tS8Zt+MUwQLjBOqIATqQwKrCAkZfgx9U9oswtrz
         rW9Px257i1sO3pR1X/r2uUo3jPnS1QwJkyAzLXIVaFNehLNEebKWT+u1ReG/WTbU+fa4
         aDSg==
X-Gm-Message-State: AOAM5323aBo+9d/52kAAnkkXmrz4lmCrt5d2dfQ2FmJ1RymSS+VL9hqC
        H9fnGuSg3iyhSY53K7v4XE0=
X-Google-Smtp-Source: ABdhPJyYe0YuGcsn5n9PdDd/xER4H3WLTP7pzF9InwolkwiUKJnmz57Wz56usAWLpNTf+QwGRKAtkQ==
X-Received: by 2002:a63:4661:: with SMTP id v33mr16609969pgk.163.1604385824890;
        Mon, 02 Nov 2020 22:43:44 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:883:e6fa:e766:1820:6007:cfb3])
        by smtp.gmail.com with ESMTPSA id 8sm1641197pjk.20.2020.11.02.22.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 22:43:44 -0800 (PST)
Date:   Tue, 3 Nov 2020 12:10:58 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v4 04/10] commit-graph: return 64-bit generation number
Message-ID: <20201103064058.GB13228@Abhishek-Arch>
Reply-To: 85imay2z84.fsf@gmail.com
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <011b0aa497d1352bf54ac6a9e2e22ed92d409e64.1602079786.git.gitgitgadget@gmail.com>
 <85imay2z84.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85imay2z84.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 02:48:27PM +0100, Jakub Narębski wrote:
> Hi Abhishek,
> 
> Note that there are two changes that are not mentioned in the commit
> message, namely adding 'const'-ness to generation_a/b local variables in
> commit_gen_cmp() from commit-graph.c, and switching from
> GENERATION_NUMBER_ZERO to GENERATION_NUMBER_INFINITY as the default
> (initial) value for 'max_generation' in repo_in_merge_bases_many().
> 
> While the former is a simple "while-at-it" change that shouldn't affect
> correctness, the latter needs an explanation (or fixing if it is wrong).
> 

The change from GENERATION_NUMBER_ZERO to GENERATION_NUMBER_INFINITY was
incorrect. While fixing merge conflicts on rebasing to master again, I
didn't notice that repo_in_merge_bases_many() switched from using
min_generation and GENERATION_NUMBER_ZERO to max_generation and
GENERATION_NUMBER_ZERO.

Thanks for noticing!

> ...
> 
> Best,
> -- 
> Jakub Narębski
