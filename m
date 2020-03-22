Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBBC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 14:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDB420724
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 14:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWzp5jHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCVObI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 10:31:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42840 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVObH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 10:31:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id t21so8135850lfe.9
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=fWzp5jHRmccS7yF0z11InoPpbIXIMq2x5KhsJoK8YamRyhATNYOW166d66qXSsk5eV
         JhZDfh1PY3G+MxAH1oxdncUTnCOUN1LC1emUeRl5dZh6WnfMvsyILDKjD3PLFYrmN0kC
         twnLTUPYHNELAhuPxF/C+aO90DTXrdjIPlSkQvKVjNKPLtcwgAQuisrEc1owWulFfk0F
         OwuOPma3Qanl85t3FvZGtjpNB8viOqUvVln3oFdEhsiDbN/rClC1zCvLf8vySU+Gl2H0
         Y1vnvnWE1/qlCaUX9jUmXNCpllPSq9ThAI5e1IQ6IPApmGPGiIxf6Bc1pifblsncgWvS
         l6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=EoMZZ6000g1hOTMOUAlCoG2LT0Rtw7RmmnzlO4FBl4XS7U2YjDGEht4yl2RDaFXEFd
         PY/KSZfrxmwH+YmGDCMJxDK5nsCbDDkyl7MH0p5RsKiTh7udCGNszeqyJRBbbUYVWY5U
         Us0Usjp93fJClUNhca3jgYWHMj1WGmyBmU3ZPiX8ciaAfbTe0CCzmV8Sy0+VeRggSMtu
         0Ne1UjPjyXguok8Sc8XjocEXDLlodshTnNnjUBfbeGH0RP9Zof3tCvdlMQcTFf7hMQ6H
         PxvuwDvwET4MilSEvVD4FOFX87cjGVqG72pRorcM6IuDeKU5+4fmCKd7XtJfjCuoOuKr
         Letg==
X-Gm-Message-State: ANhLgQ2waKPVuYi/RLTj56LVRrUp1zefqw3tAN3PnQKkHCecU+nGsMx1
        phU2d/4hONTXiHC1qaaSomw=
X-Google-Smtp-Source: ADFU+vs22/2DzpO7X2KGJUma90rB+nKrt+81ZWp7EcR+y//O6u5zGgf3xpr2GFmynYEgIUShT2sqwA==
X-Received: by 2002:ac2:5f75:: with SMTP id c21mr12186lfc.194.1584887465878;
        Sun, 22 Mar 2020 07:31:05 -0700 (PDT)
Received: from mehroz-HP-EliteBook-8470p.Home ([119.155.6.126])
        by smtp.gmail.com with ESMTPSA id e20sm7239854ljn.107.2020.03.22.07.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 07:31:05 -0700 (PDT)
From:   sheikh hamza <sheikhhamza012@gmail.com>
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        sheikhhamza012@gmail.com
Subject: Re: [PATCH] bisect: remove root directory restriction for git bisect
Date:   Sun, 22 Mar 2020 19:30:55 +0500
Message-Id: <1584887455-19369-1-git-send-email-sheikhhamza012@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20200322104826.GB2224@szeder.dev>
References: <20200322104826.GB2224@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

