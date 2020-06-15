Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F55C433E1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9E3206D7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VidI001m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgFOOD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgFOODz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 10:03:55 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3202DC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:03:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so9620274lfb.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1Q2EZ+APR2D2derub9O1CmbezR+eLT4OWamKen+qTY=;
        b=VidI001mL+/1+Csv0BM4lG8cmYcYqn/SsLDZbGGd6IekYRnKCP6+Y/1XGEzAUr/OjY
         +8YvKV0WkJPRVenD3F3cfb8BfJppFiolOGJKSMrnzrfb/cOFZrCilnipena8PO5s5GTG
         2rBE6/2jrTlKFOA7VTOPTRTFLUGf7QaaN86hrOCk1kLlmlx/+wQ/Zr6k9OfvjR7gfD9r
         UvPX6rucy+VkDJbyOezwarDLPLeXpZYOhkDQPC48uK+S4fvN+DYE06b76KT8+8hbxvWB
         K5Ep87Z7wsUjqjOjE3nJ0Y1PXQ2IMdjeovGZCR7wnegHervlLK+Yle9tToivVewY3Rmj
         +f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1Q2EZ+APR2D2derub9O1CmbezR+eLT4OWamKen+qTY=;
        b=J1+ck1dwe2HQhU2NDN5WMbnZm1VKFVcU4nZ+ayOkeJzA/TefaVSlULKWXy60CYkP2E
         6DCqT7BU52ulmVDGYCyxE5xqC4w7y6b8ErYXyAGhlNHQU9/8R1mLeORclxq2EbokHy2k
         GKn6DnZKoZAZAgJ8Z6QhmwbayTh+mrk6xosr/Wb6suReY+QNGngM1RlAkp7j3Xb/55NP
         CJyjhrxgjq2/n7Dtvc3kmW/ZeN+R1iEibaqkkjiCRDBglsPYfWfnob8Ax8GHiygqd6Vg
         dvVX1ZdI5of21nd2foOHPwLShxyCDNhTgUb8zKiO7BQPSEAYIpHfEtYR0n54wvFbgzUY
         3kbg==
X-Gm-Message-State: AOAM531UxIZEePMWvfwyIko/ZUZfBf0De4J9G4JlhWyQBKjbxu3kELth
        rhH+V/7lUfLlKxNXif+/dFg=
X-Google-Smtp-Source: ABdhPJwAPSJtqRnBzKc6bNxkYogcr6dkF5/bYtEHF3ghMBJMZvgG71hdw3ZDl8Yhuz1Ou0M2Vphi8g==
X-Received: by 2002:a19:cb92:: with SMTP id b140mr14111300lfg.63.1592229833726;
        Mon, 15 Jun 2020 07:03:53 -0700 (PDT)
Received: from no92wrk-walle.osl.infront.as ([195.204.99.197])
        by smtp.gmail.com with ESMTPSA id z13sm4559394lfd.7.2020.06.15.07.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:03:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sibisiddharthan.github@gmail.com,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: Re: [PATCH v4 6/8] cmake: support for building git on windows with mingw
Date:   Mon, 15 Jun 2020 16:03:49 +0200
Message-Id: <20200615140349.1783-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <549f0cd5fffef38e8d85246a9aa2593674aad68c.1591986566.git.gitgitgadget@gmail.com>
References: <549f0cd5fffef38e8d85246a9aa2593674aad68c.1591986566.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +if(WIN32)
> +	set(EXE_EXTENSION .exe)
> +else()
> +	set(EXE_EXTENSION)
> +endif()

You can probably use CMAKE_EXECUTABLE_SUFFIX here. See:
https://cmake.org/cmake/help/latest/variable/CMAKE_EXECUTABLE_SUFFIX.html

Øsse

