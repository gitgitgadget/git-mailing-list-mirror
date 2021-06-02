Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CF2C47092
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 08:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1EC6100A
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 08:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhFBIUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhFBIUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 04:20:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C1C061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 01:18:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so3020466pjs.2
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=niJqdNVxLF/622a2zscaXpW0zPB9nDMuQWU5Vjw3ezs=;
        b=GihsxWZIFyVRrOJ7x/sjUYmvbD7sMZ6B6TB0Fs+1ccblFphDQTVYli4JYoPc1V/8Kl
         kxDjRBB7GxlqqwXBUKvn0X3EhbTBHNB3xc3anMCY05H+cZrpYTIOYJBGzBXp/m5XQUzA
         M2e+AFgCGnSdrXilSbTGSKssooeuC/3zJDxz6IZlr4J0TexwrJ96G+XrhYswyXhY3skO
         9IZgZAQhmwJrgygjfugLvYheVp78g+88kayMIkDa9CBeHLb+sEytt6I/VQl1RcG9OlS3
         sTjCu1Icf5+JDjO62S6xDSi4QqKdgoleG6iQF79mNrv4/G4ij0sMzUa23o9hMW4I5K7H
         8/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=niJqdNVxLF/622a2zscaXpW0zPB9nDMuQWU5Vjw3ezs=;
        b=XQSHB5CcFnujnM6CsG4NkB1WmepWH94jtLX2wq6L1se8rIB0YscJBaNWnVmrTxqWFD
         M6+TG5Jx1oIApl2Epf90rcFV3rYJY4nKf3+HRz1XAVro7fMf9KMNj1KhiYQQ3dgdJD7P
         RyO/z8AGukouDSmJ16Z3pqaTCtqGU9BMT4iqq8w9nuJykilC83HGo/zu3wxmsyBNinNp
         dwmXt3RTBTm8CNqsc+7kY/UFf8P1o5XHtAhyeJU+A+FvzlPiLFzAARvWKhd87qjl03uu
         wB5cpEkAGtcm9eHUkqtFGbJ5sRsxKd9t8y57J6HipiV1keogFz4rcD2nA1NxiDX8L5RM
         Z/5g==
X-Gm-Message-State: AOAM531aScdL13rOoWAMV0tlwDAZnGKVfQDNoYrEMQieBkqqNvOxwPEs
        68H7LVsQpQsgis7XCeJlR/4=
X-Google-Smtp-Source: ABdhPJwpWp/TSSANn5kRACKELeot6X9w2uc+4PZQvQiCWlV5n2dn2xgC0oabstsXsx9QEDcAvzzATA==
X-Received: by 2002:a17:902:7d83:b029:105:8b10:629e with SMTP id a3-20020a1709027d83b02901058b10629emr12574313plm.0.1622621934301;
        Wed, 02 Jun 2021 01:18:54 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id 10sm16963394pgl.39.2021.06.02.01.18.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 01:18:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH][GSoC] submodule: introduce add-clone helper for submodule
 add
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <38AEA0B4-FCF7-4123-9412-98C1394972B0@gmail.com>
Date:   Wed, 2 Jun 2021 13:48:50 +0530
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <44C3C05A-1BA8-42BF-8614-1BA859050AEE@gmail.com>
References: <20210528081224.69163-1-raykar.ath@gmail.com>
 <CAP8UFD3SMghGb0y0jKuLScrKqqHgZFDxW1c97MwoEz+1hXt1hA@mail.gmail.com>
 <38AEA0B4-FCF7-4123-9412-98C1394972B0@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 02-Jun-2021, at 13:25, Atharva Raykar <raykar.ath@gmail.com> wrote:
> 
> [...]
> I've not yet fully developed a taste for good C style, so I wanted
> to ask, which one looks better to you in these?
> 
> /* Sample 1 */
> while (begin != end && (line = get_next_line(begin, end))) {
> 	char *name, *url, *tail;
> 	name = parse_token(&begin, next_line);
> 	url = parse_token(&begin, next_line);
> 	tail = parse_token(&begin, next_line);
> 	...
> }
> 
> /* Sample 2 */
> while (begin != end && (line = get_next_line(begin, end))) {
> 	char *name = parse_token(&begin, next_line);
> 	char *url = parse_token(&begin, next_line);
> 	char *tail = parse_token(&begin, next_line);
> 	...
> }

Also ignore the error here, assume: s/next_line/line/
(Anyway, my question was about style)
