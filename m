Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62757C7EE29
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 00:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbjFCA2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbjFCA2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 20:28:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36BE50
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 17:28:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-256e1d87998so2242366a91.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 17:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685752094; x=1688344094;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lH6UJe4POf0BJYNZS+Ak7xHySjGOBRmvx9RW0wKMxZw=;
        b=DmhYF38U5y3CXVnWq3HmGk52k9kaNjD+qW3p32vDvw/ZqlN79jvpx1I1MVTUovrLLh
         nta+i8AIZzvG4BERhxi3Bfa6thAYg5emVXhA8DAhNGqXI1he393o9ix/Pf5+1poA2O4n
         LJD1xUmb1HAIghEdJWoDakDTFv0xhRU6zdhl6zcFIVP2AGSwScNSMpeUl+wxYWWj5LMj
         B4avDe6btPHujXNJAZbELTraA12LjEeIUhNpO393LD/Ngss/NfofLIu2jVYz1kaKnOgu
         BMMEteiajZeaLNKEu8t29NklE3Ueteehr1vm5Je4xdS/j4SGscPg2A0MZoUXEQgmmGbO
         aUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685752094; x=1688344094;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lH6UJe4POf0BJYNZS+Ak7xHySjGOBRmvx9RW0wKMxZw=;
        b=E3YnAMATVkAELlY6+tiUh2uHEbO/dDxM27cQrzWeWCqoqyBNRCWkiOmGDXDWhYm1xu
         3BW1DFqzwk+dYqfbY9VeeyzWlZ0rXuNivn6VBWDMwspTUH/443Ee+MY09KQZNmBzYkfo
         yGwOrxItSYvF4Wk8tanvIkvcZ3Y/viQyhKwLWTdSJWuzwqhduOZThEbWSdVCI1xjDPpZ
         P9pwN8wSjLlCs6ID0RgU4vzDJW1LdNOi5nn6MCTztF/uAyX22/yEXYvPn707qoDrqFAA
         WGdQbDQTL9eV6EYLt7CI5YdybDxO5oIcFIwsC8ujkYVpnRjvyBs/OWqdHTx7sS76XiuK
         SKgg==
X-Gm-Message-State: AC+VfDxOVcHGVSnWapY5w85xLyAbecKv+zXuSk9kMdt3bjZ/fAXbaoTs
        VADbPVmAwMNm31hLKb+QqStqG4wD+WlWFQ==
X-Google-Smtp-Source: ACHHUZ77cBY1L1F0ezaPBXpHxkHqqKFGGHZA0eMHstRkrfd5wvPRWsnuI6am+PiywkkKtqd89gURXg==
X-Received: by 2002:a17:902:f54d:b0:1af:981b:eeff with SMTP id h13-20020a170902f54d00b001af981beeffmr1653630plf.64.1685752094318;
        Fri, 02 Jun 2023 17:28:14 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ce1100b0019aaab3f9d7sm1927069plg.113.2023.06.02.17.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 17:28:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, me@ttaylorr.com
Subject: Re: [PATCH 1/3] repository: create disable_replace_refs()
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
        <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
        <CABPp-BFzA0yVecHK1DEGMpAhewm7oyqEim7BCw7-DTKpUzWnpw@mail.gmail.com>
        <ae89feda-0a76-29d7-14ce-662214414638@github.com>
        <20230601174746.GA4165405@coredump.intra.peff.net>
Date:   Sat, 03 Jun 2023 09:28:13 +0900
In-Reply-To: <20230601174746.GA4165405@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 1 Jun 2023 13:47:46 -0400")
Message-ID: <xmqqa5xh8k4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Generally, I decided to move it after option-parsing, so it wouldn't
>> be called if we are hitting an option-parse error.
>
> Playing devil's advocate: would option parsing ever access an object? I
> think in most cases the answer is no, but I could imagine it happening
> for some special cases (e.g., update-index uses callbacks to act on
> options as we parse them, since order is important).
>
> So I think as a general principle it makes sense for commands to set
> this flag as early as possible.

I agree with the "devil's advocate" above; indeed my suggestion to
follow-on work that is enabled by introducing this function, i.e. we
can ensure that the objects already instantiated when the call is
made are not affected by the replace mechanism, was exactly for such
a "we already accessed some objects via the replace mechanism and
then try to close the door of the barn afterwards with this call"
case.

Indeed, I think "git branch --no-merged 0369cf" resolves the object
name down to a commit object in parse_opt_merge_filter() before
parse_options() call returns.

Yes.
