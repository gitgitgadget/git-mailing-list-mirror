Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2657CC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62112075A
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="g+6CCIxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgEDVul (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDVuk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 17:50:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE82C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 14:50:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so6238691pfw.13
        for <git@vger.kernel.org>; Mon, 04 May 2020 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZaNKfYao0aLbR9ZfawJb63vsyVNs6dN92RxkXn65BN0=;
        b=g+6CCIxoWzdtHQEO+r95sPB02MlB3acca102J21p4jrnzRCTdXz+o5F8WaIGYrAbrt
         yMWk4z+oInxXsjRg5EI3Z2syQdljSEGrGdWS6g0o0G9b3VGb8j1X4hh7qWW8+Q/7VwWp
         pZmBcdFzwJtfGMSEji9I4k4vCMnO9UwjZiDTb2C/cGMmh0Nzkmb4Cz9qVQWkavmSynYF
         ee/psCMAtdqsPPH7e/Z+EdBhrE/48bny0Cngqhz6JcNSt5r8794oxyjZbJnE8EidCStq
         pTb8zw5xg90vHzXIgcC08jTpTCPUYszy/S2acgF4YQrHfnHU5rOR9+WiOXIl4Nem8K7d
         oRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZaNKfYao0aLbR9ZfawJb63vsyVNs6dN92RxkXn65BN0=;
        b=ZW2BxsAfaX13sd5kDOZWdol6iTQz5OhG8dYAdLXZ9K3oU4eon9EG3KKA9PqUEcDt08
         C3dxPHXpJIKPPKFL01HW5Sb9l7O/Yy0LE+Aehfyg8tk5VUQ6mvxljcXgmhbXO5a+hyqW
         rK1lEJSRt5As+k1vnBuDguuz1SQEx3q8foMfInbxlD5N0KAgI1yNWosrJY1ZIxOsDzUs
         72EcyNhwT3VAzynt5LYmmrPjHKDwLzcPhSOMNXf0c7hWaem9UJftjhxwIBJ+GZOh5O9W
         AQEh7MKINiwkYzwrGgDsTVPOCUo67JMTwKlqjP6iInN7Q2OBwNROf537xiQtJJhoDeU0
         rXHQ==
X-Gm-Message-State: AGi0PuauwqlqjwRYxxZSWLqgZpTJtZekpyJPPM/xVmrKgZSVZ142gYGP
        SLG+1AerWLP3Nt9Cl1lem01roQ==
X-Google-Smtp-Source: APiQypJEKO57+dE8qNYWjf6xRsAwgoY7FPZGilfVUbSEMFR2GXkdhutQNIVm87Q8uA69x0zKjtt5nQ==
X-Received: by 2002:a63:935d:: with SMTP id w29mr282348pgm.92.1588629038563;
        Mon, 04 May 2020 14:50:38 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x12sm31713pfq.209.2020.05.04.14.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:50:37 -0700 (PDT)
Date:   Mon, 4 May 2020 15:50:36 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 12/12] line-log: integrate with changed-path Bloom filters
Message-ID: <20200504215036.GB45250@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <7e0c2871cf73dead655626442cc191d13b7bd94b.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e0c2871cf73dead655626442cc191d13b7bd94b.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:29PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>

Extremely well done. These changes all make sense to me, and the
performance improvements are all very appealing. Thanks for a most
enjoyable read.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
