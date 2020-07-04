Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA896C433E0
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 01:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B504A2075D
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 01:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="QDCFaNp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgGDBTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 21:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgGDBTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 21:19:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3434CC061794
        for <git@vger.kernel.org>; Fri,  3 Jul 2020 18:19:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r22so30224763qke.13
        for <git@vger.kernel.org>; Fri, 03 Jul 2020 18:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=1xv+0B5HNYneF+pAvjFDkFOIY384dshhvLh6Yeoo57E=;
        b=QDCFaNp/tTzOsYhdM9nRtIV+aZ+89t48CnOW9FrNDwTxJK75OXWnISFOgrLF9UEIhA
         8rk5BEvf8sGexoltUucih3FSxdC3CIT8WCM93MPoRdgX/WD4PHvMZnzuXv4dVxshQ6K9
         zNOjf9jrplm/Rql6A+OekrtS9VovoNgthsPik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=1xv+0B5HNYneF+pAvjFDkFOIY384dshhvLh6Yeoo57E=;
        b=XvbTKn0QrW1GNZ6ySfnr6wUEEz/5tx8BbSVHFdjM5UtJdrhb8FjvFiHehqfEtcgjug
         1qKzaLlD1mYa3aXhq8BdADQ6AvfWL7z/b8UPKtMC0D83ib7Lm/KPZYC0nHhvR5Zx79+j
         S/Emm3gkNug0tHGHXUb5lK73Oq+U3i5id1dyHl5GICmcOzEwuKSigfQmE3V3w6s5j/qb
         ABrSz+I10wSFJDwoN+GIpDhVihQ0J6R2ytK0SlACShywgyHDyyxPoGaXwix+eDz1kFB5
         ywoCc2dRG/aDr5K9dEZQ00Lpn40QmlxmJvJIWMxooW/B785oEfnHnOTmkJXCqbhwBKck
         FSjA==
X-Gm-Message-State: AOAM532nmo4tQJ4+Wou9IpV0P8AY4mUgk+pTA/dikonprLlllnnecx7s
        ayML4G8nmRPFbsBVMaRaOGbsUyMezGJi1PTnxX5IyBTUHCWyE9iGZTyPML83m2sXrhYc8sOWmzv
        gQh53TWzcMCQzfzH3SG5yWhp+yn36nRddx5afCboLZ6s5Fl2C9Bb8+ZZirg==
X-Google-Smtp-Source: ABdhPJwTqouKcyS9XY49c28iMEwplCJjgIf4b9v/uWDILOt37SHbD2bgyi3Ie7/UYdmkTZ+3fFifcg==
X-Received: by 2002:a37:7803:: with SMTP id t3mr37357763qkc.358.1593825545902;
        Fri, 03 Jul 2020 18:19:05 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id 125sm12215070qkg.88.2020.07.03.18.19.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2020 18:19:05 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>  <pull.781.v7.git.git.1593746805771.gitgitgadget@gmail.com> <xmqqo8oxb3rv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8oxb3rv.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v7] Support auto-merge for meld to follow the vim-diff behavior
Date:   Sat, 4 Jul 2020 09:18:59 +0800
Message-ID: <2920401d651a1$1ac3ea80$504bbf80$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHMDywQjtCwMdSCwpYqVrUTM1HyZgGcI5q0AZgY686o8YHLQA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, Doah,

To follow your comments, the new [PATCH v8] is uploaded, try to reduce =
calling `git config --bool`.
Please review again. Thank you.
https://lore.kernel.org/git/pull.781.v8.git.git.1593825400699.gitgitgadge=
t@gmail.com/

B.R.
Lin

