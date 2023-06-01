Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F2BC7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 04:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFAENC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 00:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFAEM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 00:12:58 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197E6E7
        for <git@vger.kernel.org>; Wed, 31 May 2023 21:12:57 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-19fa4346498so385388fac.1
        for <git@vger.kernel.org>; Wed, 31 May 2023 21:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685592776; x=1688184776;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KflIXNyRyVpvLe1U67R3e9fTrC7caVhoMDInfzahG5Y=;
        b=oCM61xwbDt6Iq9fJPByqutsyTYv43HfjUi6Jr1AFuCTtGWFHZ6rbik+wpiSkmarp6o
         aUjo7n2Kagb6VjHKJtNi2QN2+FzG7TM+WLgUQJyyOz0+CIHnrjpwwOFEB1YmOwe9LWLY
         zXwkYeXXhu9At9Pg7Xe+LjOmOuXWyhaCvIwe+4ZTabNHjCqIC+gTyHULVMemhSN0MRPu
         aRDsiXqaoyNM0xT/rxXzGTq98PER/PVkobnEJhgmJ2s+qoTmRy454pxPJMzeYyo9fvH7
         cM5ZbWmaFfReHctMDb5RQY192CtSapfgDtL6E4d0YastmHBrWn/NSL8/lqxVDI1IHzaq
         mVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685592776; x=1688184776;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KflIXNyRyVpvLe1U67R3e9fTrC7caVhoMDInfzahG5Y=;
        b=c74sEYchQA/D3vi3xyHnsp16qGDYpCtehhVVVg+1av8GmYI7CFIFMHYxcycQ0jyEta
         2CRkbGfovE82yBHE2viSk3cTZMNp5d+DGWpPq3Ip2ycNE9D2JmDEX2IznjDE8M9tY6oc
         Fwo5GEtAJt1IfsqjUyXuFWKClZja5/2H3f7PIPH6Fc2YCWLuB4uJftotwYYw/0rF8A0V
         qzAi7GUSVraGwF/wylpdvPD+rX5lJk5fP4u85oJpfH5xb7OVOjVEjhdzcZe/wtNAiMTr
         DeqJDk+IbcbvyuKNXAAV//BW7nzNxL3RYXNktTdToC5glNc/IkarqQVC/5DRSA/dEnam
         +xRg==
X-Gm-Message-State: AC+VfDzyrGCknLx0ECs5BHxGwTsiLb4RL+gcgc0V66cphwg38PIYlPv4
        ErrdYmxLg9c1d734YtW8+2U=
X-Google-Smtp-Source: ACHHUZ5GSoHUMGHDHEfW1nn+qi495JWpC802tvAE7T+8SOMIpgLzSbYtArazrjEl1pMpwN9aUhAzTQ==
X-Received: by 2002:a05:6808:1405:b0:389:4f7b:949d with SMTP id w5-20020a056808140500b003894f7b949dmr7269747oiv.22.1685592776231;
        Wed, 31 May 2023 21:12:56 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902714700b001a6a6169d45sm2254279plm.168.2023.05.31.21.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 21:12:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/7] sane-ctype.h: move sane-ctype macros from
 git-compat-util.h
References: <20230526211911.2291886-1-jonathantanmy@google.com>
Date:   Thu, 01 Jun 2023 13:12:55 +0900
In-Reply-To: <20230526211911.2291886-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 26 May 2023 14:19:11 -0700")
Message-ID: <xmqqjzwnes6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Any specific reason for the "sane-" prefix? I think it would make more
> sense if it was just named ctype.h: see below.

I think it is a good idea to keep the sane prefix for two reasons
that were described in 4546738b (Unlocalized isspace and friends,
2005-10-13):

    Do our own ctype.h, just to get the sane semantics: we want
    locale-independence, _and_ we want the right signed behaviour. Plus we
    only use a very small subset of ctype.h anyway (isspace, isalpha,
    isdigit and isalnum).

