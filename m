Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BB01F404
	for <e@80x24.org>; Mon, 16 Apr 2018 05:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDPFKl (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 01:10:41 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36823 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeDPFKk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 01:10:40 -0400
Received: by mail-wr0-f179.google.com with SMTP id q13so18719013wre.3
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4jVZpWxh+QjOck+rJLmnVM2fJlflVkdwkjaPWLLIt7g=;
        b=G6ddqMaBsHphVJbgzP8meeUKqtTq+Ile75AQi9Dq4d97fCwFNkYy4zWB7reaj0qbYQ
         SPHjbAfYN9rn89b3EIuAV+DUbtjOJz8s5dEKw8lh5aHHDlhlBU471V61jpCNVPoyN4CL
         sfGnrbPrOmb4QnLCo9FVV+MQhQoF9Sp+wpcRavhxazCe0YG5qXfh+IW50tjA2MuiGsz0
         m9MpknK2OeOIXID8I2Ftms2AMu8v0leLP+1e0nv2OgUe3z3QseehYtv6xc8PDmPpFj23
         ntWTCXTTsjhY3Ts957oKNEc6muNbltQBP3TxIOyKe0qqdGKYLjweINtmHO2uWC5tbn9d
         kdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4jVZpWxh+QjOck+rJLmnVM2fJlflVkdwkjaPWLLIt7g=;
        b=MMLAIxdwjEju+QGlzoP6rXeqJnkXh/Wnf2JUUR6x4FwFuxNDyZ02JFtXSwy4LfVIag
         q/RqVx+fUC6uZWLjqAIQiAuMm6Q1bLCSSQfFBXvRrTD/Jv9OtZhBJFa81ML+jXvLDyzH
         PTawKYaOufJFFfGDWDvvP1GG1IOKNwidrOSNaV5urpUZu10wSyqhhMTlil8rSm6+rqtu
         gVn9G+B70Rxx+OBEuqjOMXLJD4ABpG2SjqLnfdGi1JUWME4QRMrCTe2kgDp/lG12jnoy
         dWm4/P+YtEqkj+00UVUdrTtmnDPVWH5TK4S/YDtBID4xu1RHeZMdxCuGSmRRVH7vYPd7
         L0Fw==
X-Gm-Message-State: ALQs6tBTZ43BCPnvV31oOFG+wIiFzNF2Nmtr2ywnPEyk42J9l1LL6P1a
        HvsWtTheG6jCoweL6Z6otrc=
X-Google-Smtp-Source: AIpwx4/Y92pQhI+5TuMwNDc/EdEO6EyB6LmEyhVw5xV7KC50OqyxsiNRFx//tjw2G4Y9ftN3ue49LQ==
X-Received: by 10.28.120.9 with SMTP id t9mr487793wmc.110.1523855438730;
        Sun, 15 Apr 2018 22:10:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 6sm8215123wmf.31.2018.04.15.22.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 22:10:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] completion: reduce overhead of clearing cached --options
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
        <20180413103005.671-1-szeder.dev@gmail.com> <86604un5mz.fsf@gmail.com>
        <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com>
Date:   Mon, 16 Apr 2018 14:10:37 +0900
In-Reply-To: <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Sat, 14 Apr 2018 00:23:32
 +0200")
Message-ID: <xmqq7ep7ybw2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Apr 13, 2018 at 11:44 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
>>> builtin command, which lists the same variables, but without a
>>> pipeline and 'sed' it can do so with lower overhead.
>>
>> What about ZSH?
>
> Nothing, ZSH is unaffected by this patch.

OK, do we want to follow it up with [PATCH 2/1] to add the LC_ALL=C
thing to the ZSH side to help that "sed", then?
