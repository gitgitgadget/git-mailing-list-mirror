Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC6C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528FD2071A
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqd7tLJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKZAnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:43:17 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:42552 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZAnR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 19:43:17 -0500
Received: by mail-pg1-f172.google.com with SMTP id q17so8056803pgt.9
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 16:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YtPYYUByF031HN2iBeFCuhkfjnjCtUK33Hw1g4upRHY=;
        b=Tqd7tLJ7my6hO/sopF8qy42VzXckFRWHaryPgd646sTYOBbuwRSNxprM2i/l2mIZYE
         SeOUz7ahq+s4IM8h0KYMncmkCAvilaCWJdveB4MTvGKrvxtxGjxf0LrklBk7McabMtAG
         zpWkRA887wyMvNLoni/Ifu7nX5tGIUhuhZFCFOY4Zr5RmKRY8/scVMhgibzEj/8cRAlY
         /wmEZLY5G5T2XfI4/zFkMhBF7e00LSRG8Rwlb/7/5xDIo/YNIAbc/8dPe1C1RFBmRZYb
         RArtOiwormXvddDz0Nf37P/siP/kVWLNK8VVB2FhMtsuqmirkqBAu5Y/q2z9wkWZ1Ob6
         KuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YtPYYUByF031HN2iBeFCuhkfjnjCtUK33Hw1g4upRHY=;
        b=PoU8IviCZtsvh7ApC33+DJwHRyeRC3/HOp4DV3mVkalpZuN18TY8+M19MdiEZfiqFA
         W8sxBLDOA4gGQJhUXj2Qcq7CANVrZ4ONUeWSQHHBymTN4z2wCU744OF/gzEI3WrULcFJ
         g5fePuOR6xikxHIJko21E/+DRFBBeir5XI/KTMENzFEjM2hFGN+ajuWhTb6m2nBAGu6C
         TjX3hfonc0p34mKaneiXAcq2u67LlS5pIGomdGub+xcacQTJw5A5QN1ZUiyNuRWQeMRK
         xga2W8CBJWnYNyPpvtBtJbEw7wyBb93w0iMW5710A2pWCY1Ti/kczRbSwvdZ2fhLBA30
         6mbg==
X-Gm-Message-State: APjAAAVJo32mhT5rfRg175Ru7KV384xJGyqHCi/2UXYtR/6akQrz8Byb
        MIPh6cUFUzV6S59BfQ0Ox5g=
X-Google-Smtp-Source: APXvYqw3mUV5gHajTfzBpbWFqP3LK5nnmkwOz+Z1Jj8NTG+l53GRS5tL/7xqpuozMKmQuKJM/mvlyg==
X-Received: by 2002:a63:3c9:: with SMTP id 192mr35405255pgd.375.1574728996087;
        Mon, 25 Nov 2019 16:43:16 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 20sm9289242pgw.71.2019.11.25.16.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 16:43:15 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:43:14 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ruud van Asseldonk <dev@veniogames.com>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
Message-ID: <20191126004314.GC14157@google.com>
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ruud van Asseldonk wrote:

> The git-request-pull.sh script invokes Perl,

Do you have more details?  From a quick glance, I wasn't able to find
any instance of perl or $PERL_PATH in git-request-pull.sh.

Thanks,
Jonathan
