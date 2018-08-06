Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3731D208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbeHFR6G (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:58:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45900 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFR6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:58:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so12807554wrv.12
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=y65Fj2VFa6gn9QXmD60aLeeD5SgCOAGN+BUhSTJZPKI=;
        b=CGaDOEDVsYZGsIP7sjxwBLYaN7rFTvaGIOI1pjuz36CA+wgqE0GaybdUt2QGYomy6T
         ji5pnJxBXkOFGijL5uTecaV2kl4i3Vel9Gec+LF+dM6I+eds5Xj10QZJh4ZLSVAYsCeJ
         schctPgOB0uDlx2vBulIKUVrjxcq4jtx51e1E4JEL79C/zZl9HrPhhzx9PLfV291h/62
         ajKAxzM5dBxWwl0ki2RwSMAnInhB3uOQC9YzcSnlAFpkVsRBQGGgs48+6+r+AIucjWtG
         ZwZt+lxaEOAY9SYNAFDvlDPaiJdL+4+S6W06mvituYgxC6SFivs8pTk8DiLqdfxq95QU
         uxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=y65Fj2VFa6gn9QXmD60aLeeD5SgCOAGN+BUhSTJZPKI=;
        b=i2YFSsgysWSfuWT2tynv7BomZEt7UIjh2D9jpJQbnAMuUDAHYpDhNnyO8yFFOyilAz
         pIBp+3E6jnoIdXcd+YlCXLepZoWydBORsVYKqNcloYL2U3deuUpx2Df+6IMhiZY0r66U
         Ar7asGauI+5mqYoiScrADe9+8Zk2iU+GLE42CzrrgKr6+I0J+EYZM8HpJGdsCCCe+qTv
         WTu/uCmXF/tEh39IWkEcH6mDm37LMS9K29PgkW4GN9ZcWdZ4pdPMRbLSM5C1zJ9O2kOj
         VGnZ10+4qh9r1NLtQdGMNjXRLAZO6LHB+BK3M00PQBwu1Cei688iLZih4MCXq9bdMCXH
         +XRw==
X-Gm-Message-State: AOUpUlHPyEyMWKm5cuCkPNqcFvi4T/OTacsIYgOETNzPNpUdHmFpkPTu
        P0WjSVWOa3/YMF83y88iP9E=
X-Google-Smtp-Source: AAOMgpczEexGFpTj3UXyJKTCO2+f3ox9UG265F6hByHkVZnoNJJHQ5FZzmONNR2SByxedb0UiXBcRA==
X-Received: by 2002:adf:8362:: with SMTP id 89-v6mr10382935wrd.147.1533570502975;
        Mon, 06 Aug 2018 08:48:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8085743wmb.25.2018.08.06.08.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:48:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, peartben@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v3 0/4] Speed up unpack_trees()
References: <20180729103306.16403-1-pclouds@gmail.com>
        <20180804053723.4695-1-pclouds@gmail.com>
Date:   Mon, 06 Aug 2018 08:48:21 -0700
In-Reply-To: <20180804053723.4695-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 4 Aug 2018 07:37:19 +0200")
Message-ID: <xmqq7el3qywq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This is a minor update to address Ben's comments and add his
> measurements in the commit message of 2/4 for the record.

Yay.

> I've also checked about the lookahead thing in unpack_trees() to see
> if we accidentally break something there, which is my biggest worry.
> See [1] and [2] for context, but I believe since we can't have D/F
> conflicts, the situation where lookahead is needed will not occur. So
> we should be safe.

Isn't this about branch switching, where the currently checked out
branch may have a regular file 't' and checking out another branch
that has directory 't' in it (or vice versa, possibly with the index
having either a regular file 't' or requiring 't' to be a diretory
by having a blob 't/1' in it)?  The log messge of [1] talks about
walking three trees together with the index, but even if we limit us
to two-tree walk, I do not think that the picture fundamentally
changes.  So I am not sure how we can confidently say "we can't have
D/F".  I'd need to block a solid time to take a look at the patches.

> [1] da165f470e (unpack-trees.c: prepare for looking ahead in the index - 2010-01-07)
> [2] 730f72840c (unpack-trees.c: look ahead in the index - 2009-09-20)

Thanks.
