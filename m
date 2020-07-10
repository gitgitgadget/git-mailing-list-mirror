Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E80C433E3
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CEE20748
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfA5y9mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGJUaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgGJUaC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 16:30:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9116C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 13:30:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so3023619pfm.4
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 13:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZHG/du3aU6BUlUwT8vqHIVCEHItjNtGW5X/phkZc74Y=;
        b=kfA5y9mRd0R7a83xffTUIYM+v76Z4kDZ0T3+Vd1Uf/iiQF3qmoLa8UgwqJtCW35n6/
         FP4yck8aWElVm2R6WKETEldtrLVkQSxiRN0EQG+NHbnsluZA8Ghbzp1tLNJzUCxtDyUX
         QwTOwxhF7JHCD82GBhXXw5ti2dAAugcVHKyq45624pKvXcjxIOYGwP8W7xPdXh4vOGiv
         PM9rxDBOLZJIVA1VtbaiLCCaKhMCJ5EbLr6LxhPwcsHDk1xOIeSkRmYNo+PiyrlrHR6M
         lFEUMYQABdOMr00t1QnJjQJZFOfBxelig2voqnXo14TR2INe0F1jOOCR550HDM9UREvL
         Gt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHG/du3aU6BUlUwT8vqHIVCEHItjNtGW5X/phkZc74Y=;
        b=kTdFRsmhGBazH8FDt2MhhOoPdf3ZhZ02bTMV1dmOA9rlleGAvccfLLBGeYGxAFITul
         gZ0DHP7UYUMFtHIG6BCdpEMmK9L7aQRWDs4/jh7fG4D4V6w1tH4fThd4asshfEsjnyl2
         zioLxxzerdMh2omQYBEA9nSo0R+3v2jHQ5djayEGmPmsg2AjNlpJf9vh3jl7IDvaRXJm
         R+OjO+mKGoPH0OkNUqAAfNirAuKgdBk1heLmSk6herEz3zXSpqI4BYmsuRmQPPpliQRo
         c2J4eI7oBQFo2RDInDNoxZcMo+Eyrx0JlgirW7gwAPBA5I/dKukRRpBjJHwzkBDPwcHd
         zTdQ==
X-Gm-Message-State: AOAM533WPL9aA5XA7fCOzk6shdcJmU0vhhEpQtK2NgBjJdmd7EeGgQYy
        /JjC34S3OIVfOjKhd3Av7n52W281qm8=
X-Google-Smtp-Source: ABdhPJwzfic44WrPi+eO8yvu0eumgL/Fiw10at6WTK36/oEu8PtC4bFrjekLA7pNuT8xb1ZBRVBLTA==
X-Received: by 2002:a65:63d4:: with SMTP id n20mr62184106pgv.213.1594413000659;
        Fri, 10 Jul 2020 13:30:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id e195sm6661397pfh.218.2020.07.10.13.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 13:30:00 -0700 (PDT)
Date:   Fri, 10 Jul 2020 13:29:55 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] progress: remove redundant null-checking
Message-ID: <20200710202955.GF3189386@google.com>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-3-emilyshaffer@google.com>
 <aebbc1ca-9936-ce1b-bacc-855d353f83f9@gmail.com>
 <20200710022040.GB39052@syl.lan>
 <xmqq1rljurvj.fsf@gitster.c.googlers.com>
 <20200710192731.GE3189386@google.com>
 <xmqqpn93ta4h.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpn93ta4h.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 10, 2020 at 12:58:54PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Will it make your life easier if I base this series on the other topic?
> > Or would you rather I leave it to you?
> 
> Either is fine.  
> 
> Just don't expect any quick turnaround time for a new and involved
> change like this while we are entering the pre-release freeze.  We
> are supposed to be stablizing, not churning ;-).

Understood.

It's got a nit or two from Stolee's review so I need to reroll it
anyway; I'll send it based on the other topic.

 - Emily
