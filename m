Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E3C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A292176D
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmNopNir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfK1MFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:05:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41057 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfK1MFf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:05:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id t8so11460347plr.8
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 04:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dl8fVDkF8NTga8kGDmK5QIdQ93piv1Cx71KFYTj06Qo=;
        b=MmNopNirwaIs76QicrTwef5tGAYTxTaQeR88ciINwLKPlhqZrWR8UM/hgCtKafEiLT
         CPZLGulBvl1SWMewizw1v8pHj4G/e0itf8TRuxKQI6rv3aqtSym5HPbZd4r5GpqWzo8G
         rLNZ+9Z1d6RF7J0f3WwN+Mfp0oJI04bsucCtBuPl/mVIK9jLJhxfyjUpNX1BEX9ouGRo
         A4YQx5C087gWC4w4jD0OPDj2mJCrmwy0GG1oqdOg+F2DB+aFyGOyD5nJ1yq4wcZ/L2Gk
         Palw+RrPRJDw1JHQqrJkieDEFmn4+VNHD0YQ4SWHvJxmXY4KlnJQtcEzv1X9VRfJOMwe
         vSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dl8fVDkF8NTga8kGDmK5QIdQ93piv1Cx71KFYTj06Qo=;
        b=lvCQzAcQe00GUvJrigLECivV9ahu4Um2MtWSwq8YrY8kZhTeZOByPmPNFQTgF4DLIZ
         pswIJL1rwxkv3qkAkVU1eSsPR8RFZl+Xiyz9fQQERu7eB6X1NJNqV+IGHlG8nIJKk0h5
         LidWcd6rnxB8HpbJ4prbKCKpKyqjPAkYS4w14WPwHdlZ7F6/LGnrAMtZouI0csPVN56Q
         fRQYDaZHp1EK1oyr4lOYSI2QhHiqTwgY6BUKNSY3oRZw51QD/QUOxt6adVVtGI/r4TLX
         rJfdA0gZIKCVb0BKRcNyE1K9sU53hr3kDFkstZNnTqmpUEkzKf9bjuQr0MH5bnClpjO4
         g1iA==
X-Gm-Message-State: APjAAAXECKGKstQGeidK6gAWhsekRrZrIRc97W8qy3QqhzGrdr/C/kpX
        3+WFjf27t6OwJyxG13TPtMiWtArI
X-Google-Smtp-Source: APXvYqysID0oSVXQmliLw/TXQFaiI3sKxTot1hKEnKMIwtM/PDBiLBP0STvW8vk00JnvTNBMF5UYNQ==
X-Received: by 2002:a17:90a:5895:: with SMTP id j21mr12638587pji.129.1574942735246;
        Thu, 28 Nov 2019 04:05:35 -0800 (PST)
Received: from localhost ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id h68sm45257pfe.162.2019.11.28.04.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 04:05:34 -0800 (PST)
Date:   Thu, 28 Nov 2019 19:05:33 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/5] mingw: use {gm,local}time_s as backend for
 {gm,local}time_r
Message-ID: <20191128120533.GB9067@danh.dev>
References: <cover.1574867409.git.congdanhqx@gmail.com>
 <2c39f9a04f98fc3d365c80ce57e8edce305846fb.1574867409.git.congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.1911272038430.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911272038430.31080@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-27 20:39:27+0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Danh,
> 
> On Wed, 27 Nov 2019, Doan Tran Cong Danh wrote:
> 
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index fe609239dd..7b21f4eee5 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -1,6 +1,7 @@
> >  #include "../git-compat-util.h"
> >  #include "win32.h"
> >  #include <conio.h>
> > +#include <errno.h>
> 
> I actually overlooked this. Please drop this hunk, it should not be needed
> (and might break things in the MSVC build).

Oops, originally, I intended to reset errno after {gm,local}time_s
Found out it's unneccessary later but I forgot to drop this hunk.
I'll fix it.

-- 
Danh
