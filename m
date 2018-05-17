Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522421F406
	for <e@80x24.org>; Thu, 17 May 2018 01:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeEQBgu (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 21:36:50 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:52067 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeEQBgt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 21:36:49 -0400
Received: by mail-wm0-f51.google.com with SMTP id j4-v6so5614863wme.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 18:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lj+FRL6orRisiOH4+3bfdg3WWC/sLF0sM97OnFHu34s=;
        b=FSg1p9qehg+v4dOf/w1JDbNGhwxHbeE4evVD2HuxbmAjYBah/3FfVoe/sI6k+P5Haw
         +8fQfNxQPkpNslNvq8B/AIc5bls68aM8oWoojWHwrMz++tM8uR+roVBufiwWiLZmfC15
         M3l0Wxh/JUtK5UHx3SNjnusm9LYQ/Hy7Z5fa8ANjNgokDNILB5emz15Pe07R7deCLmmB
         bDW17RyjcJ+4HYzumzhGkyT/Pw/9mRoWa1zGLGd/UIPmVqukKY3ksd7KkElKxfZUDSWK
         /NO7MbrDM+p+1K1Y7+r+LIyffYt2snxxDS+IVTWrAjTmpTIphY2vg73fx9xIXb7b3pvd
         3CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lj+FRL6orRisiOH4+3bfdg3WWC/sLF0sM97OnFHu34s=;
        b=ceLEFr2PuUsAPeiSkcu1jjoSFE+WNQBZhWv7i5RlnajQBBUsqipELXtKQ3gaLa49u6
         a/gknpAqyF+leVKKb/YBUWv1AFUUm1fhHY3WpHCGca7swQ1GT+9zBuRwu1wiRkgnqYCG
         lVfQy1TX7c/Nel6EfDaXoLQomlrf+MkS2IeNcgSoCt1bvX8qwYLBgmeulWLYYuT9Qhoj
         Wne2sTxfoXqi2DYAWsTsYvFZo4B6E55z0TuqsC2YjfsJIwv9uniC9Dh3A3ELb25D4LEO
         D4M6sqXFRa7F30sXhNkLiSHiKyWYhfr+egB/B9FWHNPobk00fmNljL8hnnvntZdRa7FN
         Mspg==
X-Gm-Message-State: ALKqPwdU72GXZ4veQEJ2usrmNwvaCHHNOybR9mZOBQ069r8wI0/JiW+X
        WtXOS2CKekftgvn7cA3wNMQ=
X-Google-Smtp-Source: AB8JxZrF1tv8HolQuY03ZRbdg3BFTHi812tm+hEtInbCo5OQCPG3K5MaBcEAcOz7dxKJFW1v8Yh9tg==
X-Received: by 2002:a1c:da50:: with SMTP id r77-v6mr274894wmg.105.1526521007813;
        Wed, 16 May 2018 18:36:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v192-v6sm3798750wme.45.2018.05.16.18.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 18:36:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] grep: handle corrupt index files early
References: <20180515010425.149200-1-sbeller@google.com>
        <CACsJy8AcG6zGa9vLCwm2B4ishyJVWdFQ2YV0FOZTor_0x8Q64g@mail.gmail.com>
        <CAGZ79kYYy-r+Zs_6yg1ZVRNsBcTUdPWE=FeHrp_=0cV0Uf_GfQ@mail.gmail.com>
        <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
Date:   Thu, 17 May 2018 10:36:46 +0900
In-Reply-To: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 16 May 2018 17:24:11 +0200")
Message-ID: <xmqqbmdf6p1t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> With a majority of call sites dying like this though, I wonder if we
> should just add repo_read_index_or_die() with die() inside. Then the
> next person won't likely accidentally forget _()

Yuck.

That sounds like inviting a major code churn.  I tend to agree that
it would be a good clean-up for longer term maintenance, but I am
not sure if I can honestly say I'd look forward to such a clean-up
at this point in the cycle when there are tons of large-ish topics
in flight X-<.

