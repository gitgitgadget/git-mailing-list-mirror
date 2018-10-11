Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5310C1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 08:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeJKPtD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 11:49:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43003 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKPtD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 11:49:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so8600963wru.9
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WfimVTVH1nvGtXHXtutdyH0RzpAiFz3w5IXhM4t03lY=;
        b=bASJ85ChtSl5VEE7XLUIYKutx8x+AgiRplsUVultQEkXojq5RrVLbQu32T2iRG5gRL
         jc5Bg3zGcRap3fjUmvrQ5o7EMxzr5t4YAtkku833G+zeGHGNeC89/tZYQDapqXHRXiFA
         eYkxD2HQkU/dzOeMg2icwNjiLVR6e0mnyfPA63d0+1u2DVx7Ma2r2+rQ+ceuH6fsgPbp
         tCZC/izW9CJdi5EUnajn8c0YxAdQNwW8dBLuZutUvh5BSGlau6emCvvSNZuTxOIaXVEl
         QyECi35Dl4G5kS5f0ZEuBfY5Q+qKfZBlsnoSDQV6O1TDMab6K60JrVbldpnioTWTStn9
         PZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WfimVTVH1nvGtXHXtutdyH0RzpAiFz3w5IXhM4t03lY=;
        b=SKLdOTrP/F5Un8GyzcBoq4Z+futxJHolQCN/IXnVZoRFlkAZAk74yQ+Wl8Tjh03lBk
         Ga4f2SQIKDkWv/G3xrTdYWZSGc93iMroXdAJ4iuQVIQZ1mR3Tosz1wSunYInf0f8d8Mf
         IpCPpS3mQa/tcd6POTQED8rtPq5sEG29g3Tr73gaUImDBZYifyu3ZnXC0scfvaa5VidG
         yGzF2Pau/6+l9Qv/21tknJE2KDrbTUX01P6VNkxyry9zm6rX5jK5LlMCyObjWR6JTKrW
         9S9SsYRjBVqxstQ+QEaWWMzKjh+sHiIdw1SozQfZ+F+0/3Z+RG8S/9SN7rNTALorRx/+
         RwEQ==
X-Gm-Message-State: ABuFfoijMzY/0V2mopOBH8azDIYrHxVsQ7tk7LmdUDxRoeWqy5utEBuZ
        mSf0koIZdvhqFgsxfpRYRBc=
X-Google-Smtp-Source: ACcGV61op6tHizuWZ4p81rHSzPa3lXJenyfSxW2YU4Gnx28Qz9g+0jU74dowPXU709yqRuIJRLwWAA==
X-Received: by 2002:a5d:4b84:: with SMTP id b4-v6mr634383wrt.168.1539246170168;
        Thu, 11 Oct 2018 01:22:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p1-v6sm19430388wrs.40.2018.10.11.01.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 01:22:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] send-email: only consider lines containing @ or <> for automatic Cc'ing
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
        <20181010111351.5045-3-rv@rasmusvillemoes.dk>
        <871s8yez74.fsf@evledraar.gmail.com>
        <7b03da07-4301-1b42-b8a2-a29e4e1f80d0@rasmusvillemoes.dk>
        <xmqqk1mpggpq.fsf@gitster-ct.c.googlers.com>
        <f5c401a6-f329-1076-ab4b-2f52915047bf@rasmusvillemoes.dk>
Date:   Thu, 11 Oct 2018 17:22:48 +0900
In-Reply-To: <f5c401a6-f329-1076-ab4b-2f52915047bf@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Thu, 11 Oct 2018 09:06:10 +0200")
Message-ID: <xmqqr2gwgaef.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> So, it seems you're ok with this tightening, but some comment on the
> non-interactive use case should be made in the commit log? Or am I
> misunderstanding?

I do not think we need any immediate action on this step.  I was
just wondering if we want two classes of "I am not running you
interactively, so assume I said 'yes' when you need to ask me any
confirmation on X and Y" and "I am not running you interactively,
so assume I said 'no' for safety when you need to ask me any
confirmation on Z" supported in the future.  Lines with both @ and
<> fall into the first class, while lines with only <> fall into the
second camp, I would guess.

