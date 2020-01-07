Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8989C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DC220656
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbpVEeUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgAGNnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:43:31 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46163 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgAGNnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 08:43:31 -0500
Received: by mail-wr1-f52.google.com with SMTP id z7so53902255wrl.13
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 05:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWhljJ5uAY6BnF6rKKlWkndfXNHbWKFhJnBxPdE3Oso=;
        b=DbpVEeUVAsdWX7NIvhDbaW1IZTAgGw2GImCR85IMBPCfaFYMnsPlgRB9kfkDYTPgnI
         yAY88l3TjkGPcCwl1hLnwWBOjRN+i5vsN0K2E7Y11BWPqfatMFb46S0vmNNN7FOUVAWq
         SA1b3t2TvqDdteX42V/CMzyPlwOgmsto0xF0t6WO3ygmgb9jMzkRp7x+8pcVxfoA1MB4
         G6VHgsUURVYrWiicUUtIhFIw9HCr35HvuwKEwNsD3I8Xs1cPeCxQsMx+ECXaf68C87D7
         SvzXkjHKYaJHv1WdW/8HCL0toUFxQ8oAiFihtvXIM5F1NLDha5ubiVlQtq8ctDn/e9Bj
         C+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gWhljJ5uAY6BnF6rKKlWkndfXNHbWKFhJnBxPdE3Oso=;
        b=SyDUT3grgTHDRR10laTvFRAdHUtUY/9VPodb7VxYB1ivbo9Sj25G2EsH2tHSYST32q
         1Bf3BI0App9ER56uW2sVpVZ3DTRsd4D9qUoAcwu9JguXy8IONNuDt7ntc5Srv3JRDxhw
         /bsFMSI5Rc8y3pfwBPvKhmBUIskjQb5rsl+BOpWmwIvHCnzsvZksrlRFHcPzRPLpdjnt
         gYaSBJ/xAaydSSpd8X47BfG/jzqE2Sv8gr6AFoAwawwwfc054sxCYo68tjjvwaEEzEaU
         OsvByWn6/vK4MpB0ZJ6c/keC/CA0CweAM79IxR/yY/w1wX8z81Ih54xWM22OBfMkDmV/
         RyQA==
X-Gm-Message-State: APjAAAW9D00Ab7cZlmf4zPmu7C5tDwdu6H0mG64QBnTY36nuDDVazyaL
        HbE2TpZOSNtjyMDc+rLKy37ncdBm
X-Google-Smtp-Source: APXvYqwW+QPs7/8SzT368GCHlfniexVIgJSnVKifOgovC0wjToiI0xOPz6yusVEUx1pCj4wVEH5kzg==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr92650322wro.128.1578404609342;
        Tue, 07 Jan 2020 05:43:29 -0800 (PST)
Received: from torstenknbl.mgm-edv.de ([185.40.248.10])
        by smtp.googlemail.com with ESMTPSA id v83sm27171231wmg.16.2020.01.07.05.43.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:43:28 -0800 (PST)
Message-ID: <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
Subject: Re: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
From:   Torsten Krah <krah.tm@gmail.com>
Reply-To: krah.tm@gmail.com
To:     git@vger.kernel.org
Date:   Tue, 07 Jan 2020 14:43:27 +0100
In-Reply-To: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Dienstag, den 07.01.2020, 13:55 +0100 schrieb Torsten Krah:
> 3. git commit
> 
> Now I made my commit - had a look on that with git show and it looks
> fine.

I had a second look on this step and the result it wrong.

Although restore --staged moved my unwanted files away from the staging
area and "git status" told me that they are not "in" the commit the
commit itself did still include them.

So they are listed as unversioned now but are in the commit although
git status told me otherwise - weird.

kind regards

Torsten

