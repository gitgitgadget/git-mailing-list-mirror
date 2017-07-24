Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF3A203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755993AbdGXRJV (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 13:09:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37623 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbdGXRJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 13:09:19 -0400
Received: by mail-pg0-f65.google.com with SMTP id g14so7601837pgu.4
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V/hTLiog76G+jKE5tLX+ojUf4EH7oFAirFP7dS0nGko=;
        b=nmpfRa5FqG+DypjpChW72hNM8O+R6Vxa2GMGQScb8hKRmCDgVyVHZLiXxM8l6CbAei
         LVowZ7avfyo9XOZ7ts2B1I+cynKEjVxNVlDiSypwM/jveuC1+4mv/Ttaq/ngewKFrV3d
         YwMqg5CLQ+4zZuaN4qOrqvFTdAZ4SBH89p3v+uor5dPJcPs2hZS0JX+PWKG3wdJg0o7s
         92YnnEApucqpyc5ydiPiF3W8MdIN4VQYrsWazCtcq2NZhPxM+4scjXpanSP5ChelFnBE
         RjCqOAxjLObyS7XuTNG3Hlc65CeDE45nKVxXp88A+gfKqm2Df3PtBWkD8fYJ/Rl/qXb/
         zAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V/hTLiog76G+jKE5tLX+ojUf4EH7oFAirFP7dS0nGko=;
        b=Oi/mEwQUArBMldCJzsTcxzjfWSg9wXZQ3AE/Od5vK6Uqj/aXtFY2LU3yV4aI57C1dR
         I2f8B+z6COv0ThARKsFc2IMN5VuVUFD7vWRMW1tXHKQjs2MlwRjYBRr5U+ph3x7Mq1q8
         kYRnA1OpAuBXWnabAajmINFvPGPDfEtM23X3AkhZQX7M3SalsRBihkMzeXmh4jfT/XuG
         JGJbuVYCdrqDlWNfsIrPxARgUVHFAsRhaz+vJTnW/iS3Y6bgo/wHcSaO7Lry9EOQEHq9
         RgC9OumlL+PLVW6g+PfkhD76b7+5xvvU83bna7vPn1h0ymWuHxVqK+5aR+rTTuLWjEcY
         sYWg==
X-Gm-Message-State: AIVw1102xtJ1tCTXZ+3xxptGRXMQWM4YOTBGxH+BaNIS5i/OW8RW7yu2
        QWlPlinHEALIKw==
X-Received: by 10.84.209.237 with SMTP id y100mr18200614plh.6.1500916158917;
        Mon, 24 Jul 2017 10:09:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:14ca:cb2b:befe:703a])
        by smtp.gmail.com with ESMTPSA id o7sm22175856pgf.63.2017.07.24.10.09.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 10:09:17 -0700 (PDT)
Date:   Mon, 24 Jul 2017 10:09:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 21/28] commit_packed_refs(): use a staging file separate
 from the lockfile
Message-ID: <20170724170915.GD13924@aiede.mtv.corp.google.com>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
 <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
 <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com>
 <20170720233051.GB159617@aiede.mtv.corp.google.com>
 <xmqqpocuib06.fsf@gitster.mtv.corp.google.com>
 <20170724165907.53zx657qmizgl4lb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724165907.53zx657qmizgl4lb@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> This seems like the correct path to me. If the existing behavior is to
> lock the referring symref, that seems like a violation of the lock
> procedure in the first place. Because if "A" points to "B", we take
> "A.lock" and then modify "B". But "B" may have any number of "A" links
> pointing to it, eliminating the purpose of the lock.
>
> I thought we already did this, though. And that modifying HEAD (which
> might be a symlink) required LOCK_NO_DEREF.

Yes, I believe the lockfile API already does so.  Since this patch
creates a ".new" file, not using the lockfile API, it doesn't benefit
from that, though.

Thanks,
Jonathan
