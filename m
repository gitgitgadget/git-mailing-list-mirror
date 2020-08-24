Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8711C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 02:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C426A20768
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 02:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZNECDLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgHXCva (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHXCv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 22:51:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD0C061573
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 19:51:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q3so2201396pls.11
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 19:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8BQJSOrcPhnaA9FaWQgM6rVOrIK/6t42gK5ewN9fwbI=;
        b=CZNECDLOUA3F6A9zNnVXBcvf3pSTE7Kr8HOhs2D89bxmPn2M+UeWMIQPcDi5eYOzHQ
         RmO5wCwV/b6SY8sbiNvGVNhbLZE4ma3zouKH+HOqZSVSoEhJjmaIeF3JAMLntfoLcXWW
         PQKX1X1donGeV59aiV3uuMz1bsNjj+Yj/GEW9/KLfkr11bcq0X3GoFunXszmzvhKIj8E
         S1mwiuHIs6EJ2czMImz85xZKZGlMIy/Oo98+bSCcNvMrR08ztiQcvL4cL2MnUR4udU0T
         xCrqHY+zPrn50vA3xVQqZp8+NWGZxERjT6AY0eVAlJypH2EbNz+pMVwFIHV5kJbvrwki
         No0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=8BQJSOrcPhnaA9FaWQgM6rVOrIK/6t42gK5ewN9fwbI=;
        b=hLr+SPHUs2jDzsrTnG7Gm7qS9pODyu8pPP/33ZF+ctEG9rGxsmAZ1BN7/s1bc5l+MD
         0nDT2F1O8cnd1FTG3FCcPB4XVWrtjeAkD35ASyiBukim8erlK2vw//at3NOM4AKm3lB5
         1G3OfvvWEMQzI8KGkL1ppyyg6Xvirdw93/n2hFJAgTQrdjn+e9+CDb6V+UlHyEd3KkRp
         RkZJ6G8dbR1PJzgkLZaFlwyI0o+n+IOIb2+coHo9xDA6n6eRbIhtbCtFmwnvv7sJ7Z4Z
         Vm6wd/8ZH3h8dH7q8cmFZh331d5/VkoiBZiWISuGdtaUv7ibZJOxIx7L08zQVlmEKNRL
         7XSQ==
X-Gm-Message-State: AOAM532SY6jf8vh6StYTNv38WGo1kqaCnSZEhH4DRZjKJUUDz3rnTMVw
        aLBC9j96Oa3CKAM4NJAbYsU=
X-Google-Smtp-Source: ABdhPJxYehTfpH9AD4yvyC+N6fEtmzRBgZt/j0tcvnRf8BGsaTtS48zU4Q/C2pREqZC+1kb8t4wMaA==
X-Received: by 2002:a17:90a:ec11:: with SMTP id l17mr2665042pjy.152.1598237486669;
        Sun, 23 Aug 2020 19:51:26 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:e83:7648:5c5d:1390:8185:5dd5])
        by smtp.gmail.com with ESMTPSA id 78sm1175400pfv.200.2020.08.23.19.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 19:51:26 -0700 (PDT)
Date:   Mon, 24 Aug 2020 08:19:09 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, me@ttaylorr.com, stolee@gmail.com
Subject: Re: [PATCH v3 00/11] [GSoC] Implement Corrected Commit Date
Message-ID: <20200824024909.GA38636@Abhishek-Arch>
Reply-To: 85blj1e619.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <85zh6uxh7l.fsf@gmail.com>
 <85blj1e619.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85blj1e619.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Sun, Aug 23, 2020 at 05:27:46PM +0200, Jakub Narębski wrote:
> Hello,
> 
> Here is a summary of my comments and thoughts after carefully reviewing
> all patches in the series.
> 

Thanks for the detailed review. It must have taken you a lot of time and
focus to go through the patches, so I have really appreciate the effort.

I have been going over the comments and they are reasonable and very
much needed. I will respond to the mails in the specific threads (to
keep the discussion locally scoped and thus manageable), with doubts
and comments that I have as I try to follow through the suggestions.

> Best regards,
> --
> Jakub Narębski

Thanks
- Abhishek
