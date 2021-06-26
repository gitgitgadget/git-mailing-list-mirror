Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E12AC49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 06:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805AD6193B
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 06:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFZHBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZHBA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 03:01:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC86EC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 23:58:37 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 11so6060095oid.3
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 23:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hTSLCDTWumtFTXeE2bQyE+ch7mrA9FS3/skyInQGPyg=;
        b=mlykEl8NuBbS86FUnelT1NVQCw9Iay7J7TaqNb1eDgMDr6hPNcjCKBNsX+/Yp8X7D7
         ZqovMd7q/dC7Xq0EOxGQ6/mBQP6qTtxqXm8TZjjEOb1Xf8ucw88nc6BXk/oLZIeiVgA7
         XTv15IqKADo2qEXvfDHRTsy2v8/9QF2SgLfS/Da4oQf6YGT0CC+vRbHMUbhkyz/59/cX
         S9ViTKzGIN44XPCouZgTdcd5c4F9wVkDI9laKJxPz0NOL8H7VTCOQBB2xxk8o0F3F8/6
         pw7JnmXTmRK1KHEqsuTU82072cZwCLRCZYzVps0TMbORqe3DOGqm9HHwiaURj6sF/R/m
         lgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hTSLCDTWumtFTXeE2bQyE+ch7mrA9FS3/skyInQGPyg=;
        b=YPZbMXW6jNg1ldw673LLFVu4fkmLYKOxgXtVoUE7dQci0rd2fKIMA0op2jbFqtBSud
         g9+NTTF46n63j+H7gHVcf0si3rT0Pmwbvten54MHWQJWJPg1Eys+xlrihYGshjtsRGBP
         DdwuxBq/urxMQuCACBWhAjsMeOm9zXBlswcuFO9mSIyxslW6RoVOQt17+Hz7SMPgO+aD
         L+62YU9WLQvI3YH1g9glb4K2R2OWjjf/p/lfL7GbVJfpEa5lTY+607hFbb68r5Z3EgO/
         RGoSP/WIsHXdUSdFaILl8uQ781DO4XuM46CdaBmZXLvkihdMe3IXG81pUNfFS6T19nyS
         uaXA==
X-Gm-Message-State: AOAM53321x7fzwrOd8B5kvet22fEJVyRjxik+WsWUpuxIszv8QvLTBKS
        U3MjTug7tJ9po08UNzJMeFs=
X-Google-Smtp-Source: ABdhPJyigeBo5505jAbh9/Bl8y9FbDNSEvtmEtm9vXxpwuD7sEV0Ktq//aP7Ra2sohM88KM6YrdDZg==
X-Received: by 2002:aca:f08a:: with SMTP id o132mr13966503oih.9.1624690717165;
        Fri, 25 Jun 2021 23:58:37 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w20sm1954015otl.51.2021.06.25.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 23:58:36 -0700 (PDT)
Date:   Fri, 25 Jun 2021 23:58:34 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Barret Rhoden <brho@google.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v3 3/3] git-worktree.txt: fix typo in example path
Message-ID: <YNbQGoMP+wYZS0CA@carlos-mbp.lan>
References: <20210619112912.76136-1-rybak.a.v@gmail.com>
 <20210625193851.2233114-1-rybak.a.v@gmail.com>
 <20210625193851.2233114-4-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625193851.2233114-4-rybak.a.v@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

not sure if this patch really belongs in this specific patchset, but it
might be worth also fixing the same typo in grep as shown by :

--- >8 ---
Subject: grep: fix worktree mis spelling

1d1729caeb (grep: replace grep_read_mutex by internal obj read lock,
 2020-01-15) adds it as part of a comment

fix it to the right spelling without the extra trailing 'e'.

diff --git a/grep.c b/grep.c
index 8f91af1cb0..f40c734565 100644
--- a/grep.c
+++ b/grep.c
@@ -1510,7 +1510,7 @@ static int fill_textconv_grep(struct repository *r,
 	 *
 	 * TODO: allowing text conversion to run in parallel with object
 	 * reading operations might increase performance in the multithreaded
-	 * non-worktreee git-grep with --textconv.
+	 * non-worktree git-grep with --textconv.
 	 */
 	obj_read_lock();
 	size = fill_textconv(r, driver, df, &buf);

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
