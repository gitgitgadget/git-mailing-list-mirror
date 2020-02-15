Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4053C3F68F
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 03:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED202084E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 03:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCA5FEjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBODIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:08:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38935 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgBODIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 22:08:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so12835272ljg.6
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 19:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:reply-to:mime-version:subject:date
         :message-id:cc:to;
        bh=dQGkAbe1jiZOwxZQten+/rwWCvIjmcBCkXClZRMA+iE=;
        b=cCA5FEjFXvA6cdcPD7uH/4y+Zxj0iqrtTVtEUaN2R/B0dOouXgbb5oG1ZIwMAnEYds
         Mm9uFuDQrlP68ggNHEeMEbPwfDzt9Z5l1Hg3i+MNMDHLiRRLmfgUrVsBhkL2V8e1py2Y
         hVdTW9MWgWngRR09J3rCyPj3qQ3UAnmBPBk4ktM+wzf3tnAwlItLu7JNiHSt7qoRoTFt
         Md6LboCMzwpumwd/4W3nra0zpeaHcCPXSUSr4cukEAwR5mo/yTn5RSaaJg+ax9c7pkNo
         RHQhLlZDuHggfvLptm62/h0L+L7XHCbNDxnFZmQrc9TMqW7ibxmo4WKvIohC0Wa19ymG
         MHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:reply-to
         :mime-version:subject:date:message-id:cc:to;
        bh=dQGkAbe1jiZOwxZQten+/rwWCvIjmcBCkXClZRMA+iE=;
        b=uGa6uqge+xj1djnnncW+Sw1K8Pe+u//KMDmmTpajHvsxL6kPX8ahS9g0DSiCqcVIzF
         QR5fm5coKlvqORBXa6qKLn1yeEaAEYxZ5yaIm+u0XifuRbQ1ye7Rs8/Eoqb1zlm96WXo
         PWu5G78Cuk3C/ayRbQiiDIwCLIqGJBXrvHrDmvAgNpfBjkfmsPRhTxGKbXCibV2jV9j6
         5zBmA2Bj+nbuR7mhpTVDsXt5u6cXiEWCGvZFWibX+tgC03VvKq6H6XTf9PlHwBmrmkzo
         jDw/awRCikR2RqlCO9fnCEGLeVNG22i9UN/qs7reif52J60GGINmz2EX0qgmf48UBHWD
         7Gfg==
X-Gm-Message-State: APjAAAW/C36YewYFIn4WMhKWsYZySrPESeARBbZKXp1cFsA7gwCOqf0T
        meSaJCPjIC0761FryX/pfocjnJUP
X-Google-Smtp-Source: APXvYqzKI2ha3QHdHm4iyOx3O01mT7uIuSh+VenB2uHHRX/Jl7JO1KIsjO5Z+2usK8S38XuQLvzmGQ==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr3860959lja.188.1581736124158;
        Fri, 14 Feb 2020 19:08:44 -0800 (PST)
Received: from [192.168.1.37] ([37.57.145.70])
        by smtp.gmail.com with ESMTPSA id s22sm4395187ljm.41.2020.02.14.19.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 19:08:43 -0800 (PST)
From:   Pavel Ivashkov <win7ie@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Reply-To: 20190604173446.2664-1-admin@in-ici.net
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] make slash-rules more readable
Date:   Sat, 15 Feb 2020 05:08:42 +0200
Message-Id: <E3407A32-F5B5-4D27-B6E1-478403627355@gmail.com>
Cc:     git@vger.kernel.org
To:     admin@in-ici.net
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a typo: `hello.*` in .gitignore will require dot in file name.

- - The pattern `hello.*` matches any file or folder
+ - The pattern `hello*` matches any file or folder


