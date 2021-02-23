Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47656C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1764A64E83
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhBWUZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhBWUZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:25:41 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53904C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:25:01 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id q9so4571374qvo.8
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LBxsbaWlNhlEggMFtaePm9bjPIAEZi+9G/mVX2v8iZw=;
        b=hauWzJTgfrYVfOC2d7ZwbA19HbkJxrqlwUA3dKVQAuWlj0OJJ0yluOS+Nupk09QYuI
         MeEuxQtjfLvbB10hYwAQdOaG7DQVgnvaOpgmF8IgGQXkw6fqq4KxTGOeNRvjwCiwDVsn
         13tVBYDccLu3bn1iyNQQcfNMjPF8LN7Y695LY3aZQP+rhW2EzAzISkbNmYFpjkduqf0C
         Pwai2tkK0O8XJfDjACP8C3g7PH9iEoBZOsJU5jYecsHlwaHmiOoByTV0LRPIcKTnJw7i
         /F/IotJaisn0QnCiZVQS77xeKET2/OycjIBRhk+m57kTMF+OCRF5B9KBiXiBBz61ACB0
         4bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LBxsbaWlNhlEggMFtaePm9bjPIAEZi+9G/mVX2v8iZw=;
        b=Jnt+JO1TgQIKIa0ophq4TOK0Inz1LpGiy2Le71j5CLTyZ99axUYSo7oYU+4XOJ5vjB
         cvgdp536TLT/Vo1gBg8KSiz+Pq53gYmQcfB7eQguNkKnaCqVNeMhLG03NMRprRYfZQuW
         2evhfUbMFNkmoVkOBSPm+n8wnZiz44fSRK2wrnNDnZBCmo5oPiLOFC33/4chjPxg+qiY
         PVNZ3AWVFJsk0AWkyqndVdZuTnw1+vUMKYqBmuoNrq6QiT86ZDq2aPRTbWde32XZ5JYA
         Q89NQjQDy47dfmqJqUFlTByP/L8uMComxw4cXigw2fdJt7HWG3UoY4aRfs/3Pwo5lOaK
         HTVw==
X-Gm-Message-State: AOAM533Gzz2o8CSHnQMzJ7VSjJB7+n1QXPF8HFJ0brjzWHUFzOvnWoaX
        6iPe8YHu9c9XHtBPuxK0TkZdNw9TZxw=
X-Google-Smtp-Source: ABdhPJxPn9mH5MosK85t16oqg126O4Ub3tKJQgnrb3mbJtd3YGPySE25PtAkcZ7aIkFZNVRT50cUlw==
X-Received: by 2002:a05:6214:a88:: with SMTP id ev8mr26722360qvb.38.1614111900584;
        Tue, 23 Feb 2021 12:25:00 -0800 (PST)
Received: from [192.168.103.12] (cpe00fc8d50b7d3-cm00fc8d50b7d0.cpe.net.fido.ca. [72.141.221.184])
        by smtp.gmail.com with ESMTPSA id y190sm15578781qkb.133.2021.02.23.12.24.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 12:25:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] doc: `--date` in `git-commit` accepts approxidates
From:   Utku <ugultopu@gmail.com>
In-Reply-To: <xmqqpn0q1stv.fsf@gitster.g>
Date:   Tue, 23 Feb 2021 15:24:58 -0500
Cc:     Jeff King <peff@peff.net>,
        Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E2F9E8D8-0862-433D-BD20-BA3139BEC0C3@gmail.com>
References: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
 <pull.969.v2.git.git.1614106322760.gitgitgadget@gmail.com>
 <YDVSICgBwPLtDNu4@coredump.intra.peff.net> <xmqqpn0q1stv.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this case, maybe Jeff can submit a patch, since I wouldn't be adding
anything to what he suggested.
